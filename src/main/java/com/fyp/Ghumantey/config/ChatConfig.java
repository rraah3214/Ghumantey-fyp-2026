package com.fyp.Ghumantey.config;

import org.springframework.ai.embedding.EmbeddingModel;
import org.springframework.ai.vectorstore.SimpleVectorStore;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ChatConfig {

    @Bean
    public VectorStore vectorStore(EmbeddingModel embeddingModel) {
        // Using the builder is the safest way to avoid 'Constructor Undefined' errors
        return SimpleVectorStore.builder(embeddingModel).build();
    }
}