package com.fyp.Ghumantey.service;

import java.util.List;
import org.springframework.ai.document.Document;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.stereotype.Service;

/**
 * Service to handle data ingestion for the Ghumantey AI Knowledge Base.
 * This allows the local Llama 3.2 model to "know" specific trekking 
 * itineraries that weren't in its original training data.
 */
@Service
public class IngestionService {

    private final VectorStore vectorStore;

    public IngestionService(VectorStore vectorStore) {
        this.vectorStore = vectorStore;
    }

    /**
     * Loads trekking data into the vector store.
     * Uses Java 21 .toList() and method references for better performance.
     */
    public void loadTrekkingData(List<String> trekkingItineraries) {
        if (trekkingItineraries == null || trekkingItineraries.isEmpty()) {
            System.out.println(">>> [Ghumantey AI] No data provided for ingestion.");
            return;
        }

        // Convert the String list into AI-readable Documents using Java 21 syntax
        List<Document> documents = trekkingItineraries.stream()
                .filter(text -> text != null && !text.isBlank()) // Ensure we don't index empty strings
                .map(Document::new) 
                .toList(); 

        try {
            // This converts text to embeddings (vectors) and saves it
            vectorStore.add(documents);
            System.out.println(">>> [Ghumantey AI] Knowledge Base Updated with " + documents.size() + " itineraries.");
        } catch (Exception e) {
            System.err.println(">>> [Ghumantey AI] Critical Error during ingestion: " + e.getMessage());
        }
    }
    
    /**
     * Helper to clear the vector store if you need to refresh data 
     * (Useful during development of Ghumantey)
     */
    public void clearKnowledgeBase(List<String> documentIds) {
        vectorStore.delete(documentIds);
        System.out.println(">>> [Ghumantey AI] Knowledge Base cleared.");
    }
}