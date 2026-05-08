package com.fyp.Ghumantey.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.fyp.Ghumantey.DTO.ResponseDto;
import com.fyp.Ghumantey.service.ChatService;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class ChatController {

    @Autowired
    private ChatService chatService;

    @PostMapping("/chat")
    public ResponseDto chat(@RequestBody Map<String, String> request) {

        String message = request.get("message");

        System.out.println("Incoming message: " + message); // DEBUG

        ResponseDto response = chatService.getResponse(message);

        System.out.println("Response: " + response.getMessage()); // DEBUG

        return response;
    }
}