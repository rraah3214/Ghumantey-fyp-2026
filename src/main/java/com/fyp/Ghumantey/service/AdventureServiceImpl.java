package com.fyp.Ghumantey.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fyp.Ghumantey.dao.AdventureDao;
import com.fyp.Ghumantey.entity.Adventure;

@Service
public class AdventureServiceImpl implements AdventureService {

    @Autowired
    private AdventureDao adventureDao;

    @Override
    public List<Adventure> getAllAdventures() {
        return adventureDao.findAll();
    }

    @Override
    public Adventure getAdventureById(Long id) {
        return adventureDao.findById(id).orElse(null);
    }

    @Override
    public void saveAdventure(Adventure adventure) {
        adventureDao.save(adventure);

    }
    @Override
    public void deleteAdventure(Long id) {
        adventureDao.deleteById(id);
    }
}