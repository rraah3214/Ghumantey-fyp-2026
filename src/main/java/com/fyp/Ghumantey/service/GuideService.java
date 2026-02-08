package com.fyp.Ghumantey.service;

import java.util.List;
import com.fyp.Ghumantey.entity.Guide;

public interface GuideService {
    List<Guide> getAllGuides();
    Guide getGuideById(int id);
    Guide saveGuide(Guide guide);
    void deleteGuideById(int id);
}