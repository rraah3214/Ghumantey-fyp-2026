package com.fyp.Ghumantey.service;

import java.util.List;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.client.advisor.QuestionAnswerAdvisor;
import org.springframework.ai.vectorstore.SearchRequest;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.stereotype.Service;

import com.fyp.Ghumantey.DTO.ResponseDto;
import com.fyp.Ghumantey.dao.GuideDao;
import com.fyp.Ghumantey.dao.HotelDao;
import com.fyp.Ghumantey.entity.Guide;
import com.fyp.Ghumantey.entity.Hotels;

@Service
public class ChatService {

    private final ChatClient chatClient;
    private final GuideDao guideDao;
    private final HotelDao hotelDao;

    public ChatService(ChatClient.Builder builder, VectorStore vectorStore,
                       GuideDao guideDao, HotelDao hotelDao) {

        this.guideDao = guideDao;
        this.hotelDao = hotelDao;

        // ✅ SAFER INITIALIZATION (still keeps your AI + vector search)
        this.chatClient = builder
                .defaultAdvisors(
                        new QuestionAnswerAdvisor(vectorStore, SearchRequest.builder().build())
                )
                .build();
    }

    public ResponseDto getResponse(String message) {

        // ✅ 1. NULL / EMPTY SAFETY
        if (message == null || message.trim().isEmpty()) {
            return new ResponseDto("Namaste! How can I help you today?", null, null);
        }

        String msg = message.toLowerCase().trim();

        // ✅ 2. FAST GREETING (NO AI CALL)
        if (msg.matches("^(hi|hello|namaste|hey|hola|hello ghumantey)$")) {
            return new ResponseDto(
                    "Namaste! Welcome to Ghumantey. How can I assist you with your Nepal travel plans today?",
                    null, null
            );
        }

        // ✅ 3. GUIDES FROM DATABASE
        if (msg.contains("guide")) {
            try {
                List<Guide> guides = guideDao.findByStatus("APPROVED");

                if (guides == null || guides.isEmpty()) {
                    return new ResponseDto("No approved guides found at the moment.", null, null);
                }

                return new ResponseDto(
                        "I found some verified Ghumantey guides for your trip:",
                        guides,
                        null
                );

            } catch (Exception e) {
                System.err.println("Guide DB Error: " + e.getMessage());
                return new ResponseDto("I'm having trouble accessing the guide database.", null, null);
            }
        }

        // ✅ 4. HOTELS FROM DATABASE
        if (msg.contains("hotel") || msg.contains("stay") || msg.contains("room")) {
            try {
                List<Hotels> hotels = hotelDao.findByStatus("APPROVED");

                if (hotels == null || hotels.isEmpty()) {
                    return new ResponseDto("No approved hotels available right now.", null, null);
                }

                return new ResponseDto(
                        "Here are some approved stays in Nepal:",
                        null,
                        hotels
                );

            } catch (Exception e) {
                System.err.println("Hotel DB Error: " + e.getMessage());
                return new ResponseDto("I couldn't fetch hotel listings right now.", null, null);
            }
        }

        // ✅ 5. AI RESPONSE (SAFE HANDLING)
        try {
            String aiResponse = chatClient.prompt()
                    .user(message)
                    .call()
                    .content();

            // ✅ CRITICAL FIX: NEVER RETURN NULL
            if (aiResponse == null || aiResponse.isBlank()) {
                aiResponse = "I'm here to help you plan your Nepal adventure. Try asking about guides, hotels, or trekking routes!";
            }

            return new ResponseDto(aiResponse, null, null);

        } catch (Exception e) {
            System.err.println("AI Service Error: " + e.getMessage());

            // ✅ FALLBACK (NEVER BREAK FRONTEND)
            return new ResponseDto(
                    "⚠️ I'm currently having trouble connecting to my AI brain. You can still ask about guides or hotels!",
                    null,
                    null
            );
        }
    }
}