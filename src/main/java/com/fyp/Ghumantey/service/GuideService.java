package com.fyp.Ghumantey.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fyp.Ghumantey.entity.Guide;

public interface GuideService {

    // ------------------ ADD OR UPDATE GUIDE ------------------
    // Updated to potentially handle the MultipartFile for the photo
    void saveGuide(Guide guide, MultipartFile photoFile);

    // ------------------ GET GUIDE BY ID ------------------
    Guide getGuideById(int id);

    // ------------------ EDIT GUIDE ------------------
    default Guide editGuide(int id) {
        return getGuideById(id);
    }

    // ------------------ GET GUIDE BY USER ID ------------------
    Guide getGuideByUserId(Integer userId);

    // ------------------ GET ALL GUIDES ------------------
    List<Guide> getAllGuides();

    // ------------------ DELETE GUIDE BY ID ------------------
    void deleteGuideById(int id);

    // ------------------ GET APPROVED GUIDES ------------------
    List<Guide> getApprovedGuides();

    // ------------------ SEARCH GUIDES ------------------
    List<Guide> searchGuides(String query);

    // ------------------ VALIDATION ------------------
    // NEW: Check if license number is already registered
    boolean isLicenseRegistered(String licenseNo);

	void saveGuide(Guide guide);
}