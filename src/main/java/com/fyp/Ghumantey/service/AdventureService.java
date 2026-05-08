package com.fyp.Ghumantey.service;

import java.util.List;

import com.fyp.Ghumantey.entity.Adventure;

public interface AdventureService {
    List<Adventure> getAllAdventures();
    Adventure getAdventureById(Long id);
    void saveAdventure(Adventure adventure);
    void deleteAdventure(Long id); // Added for full CRUD support

}