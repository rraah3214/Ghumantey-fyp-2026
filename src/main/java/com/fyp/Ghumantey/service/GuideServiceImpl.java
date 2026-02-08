package com.fyp.Ghumantey.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fyp.Ghumantey.dao.GuideDao;
import com.fyp.Ghumantey.entity.Guide;


@Service
public class GuideServiceImpl implements GuideService {

    @Autowired
    private GuideDao guideDao;

    @Override
    public List<Guide> getAllGuides() {
        return guideDao.findAll();
    }

    @Override
    public Guide getGuideById(int id) {
        return guideDao.findById(id).orElse(null);
    }

    @Override
    public Guide saveGuide(Guide guide) {
        return guideDao.save(guide);
    }

    @Override
    public void deleteGuideById(int id) {
        guideDao.deleteById(id);
    }
}
