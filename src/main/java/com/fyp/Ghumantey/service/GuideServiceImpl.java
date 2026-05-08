package com.fyp.Ghumantey.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.fyp.Ghumantey.dao.GuideDao;
import com.fyp.Ghumantey.entity.Guide;


@Service
@Transactional
public class GuideServiceImpl implements GuideService {

    @Autowired
    private GuideDao guideDao;

    @Override
    public void saveGuide(Guide guide) {
        guideDao.save(guide);
    }

    @Override
    public void saveGuide(Guide guide, MultipartFile photoFile) {
        if (photoFile != null && !photoFile.isEmpty()) {
            try {
                // 1. Define the upload directory relative to project root
                String uploadDir = System.getProperty("user.dir") + "/uploads/guides/";

                // 2. Create directory if it doesn't exist
                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                // 3. Get filename and define the full path
                String filename = photoFile.getOriginalFilename();
                Path path = Paths.get(uploadDir + filename);

                // 4. Write the file bytes to the filesystem
                Files.write(path, photoFile.getBytes());

                // 5. Set the filename in the guide entity
                guide.setPhoto(filename);

            } catch (IOException e) {
                throw new RuntimeException("Could not save image file: " + e.getMessage());
            }
        }
        // 6. Save the guide details to the database
        guideDao.save(guide);
    }

    @Override
    public boolean isLicenseRegistered(String licenseNo) {
        return guideDao.existsByLicenseNo(licenseNo);
    }

    @Override
    public Guide getGuideById(int id) {
        return guideDao.findById(id).orElse(null);
    }

    @Override
    public Guide getGuideByUserId(Integer userId) {
        if (userId == null) {
            return null;
        }
        // Using your existing DAO method for user relationship
        return guideDao.findByUserDetailsId(userId);
    }

    @Override
    public List<Guide> getAllGuides() {
        return guideDao.findAll();
    }

    @Override
    public void deleteGuideById(int id) {
        guideDao.deleteById(id);
    }

    @Override
    public List<Guide> getApprovedGuides() {
        return guideDao.findByStatus("APPROVED");
    }

    @Override
    public List<Guide> searchGuides(String query) {
        if (query != null && !query.trim().isEmpty()) {
            return guideDao.searchApprovedGuides("APPROVED", query);
        }
        return getApprovedGuides();
    }
}