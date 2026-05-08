package com.fyp.Ghumantey.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.fyp.Ghumantey.dao.HotelDao;
import com.fyp.Ghumantey.dao.NotificationDao;
import com.fyp.Ghumantey.dao.UserDetailDao;
import com.fyp.Ghumantey.entity.Hotels;
import com.fyp.Ghumantey.entity.Notification;
import com.fyp.Ghumantey.entity.UserDetails;

@Service
@Transactional
public class HotelServiceImpl implements HotelService {

    @Autowired 
    private HotelDao hotelDao;
    
    @Autowired 
    private NotificationDao notificationDao;
    
    @Autowired 
    private UserDetailDao userDetailDao;

    /**
     * Using project root directory for persistent storage.
     * This matches the Guide service implementation.
     */
    private final String UPLOAD_DIR = System.getProperty("user.dir") + File.separator + "uploads" + File.separator + "hotels" + File.separator;

    @Override
    public void saveHotels(Hotels hotels) {
        if (hotels.getStatus() == null) {
            hotels.setStatus("PENDING");
        }
        Hotels savedHotel = hotelDao.save(hotels);

        // Notify Admin of new registration
        List<UserDetails> admins = userDetailDao.findUserDetailsByUserRoleRole("ROLE_ADMIN");
        if (admins != null && !admins.isEmpty()) {
            Notification n = new Notification();
            n.setTitle("New Hotel Registration");
            n.setMessage("Hotel \"" + savedHotel.getHotelName() + "\" is waiting for approval.");
            n.setType("HOTEL");
            n.setAdmin(admins.get(0));
            n.setCreatedAt(LocalDateTime.now());
            n.setSeen(false);
            notificationDao.save(n);
        }
    }

    @Override
    public void saveHotels(Hotels hotels, MultipartFile imageFile) {
        if (imageFile != null && !imageFile.isEmpty()) {
            hotels.setImage(saveImage(imageFile));
        }
        saveHotels(hotels);
    }

    @Override
    public void updateHotels(Hotels hotels) {
        hotelDao.save(hotels);
    }

    @Override
    public void updateHotels(Hotels hotels, MultipartFile imageFile) {
        if (imageFile != null && !imageFile.isEmpty()) {
            hotels.setImage(saveImage(imageFile));
        } else {
            // Logic to keep existing image if no new file is uploaded
            hotelDao.findById(hotels.getId()).ifPresent(existing -> {
                if (hotels.getImage() == null || hotels.getImage().isEmpty()) {
                    hotels.setImage(existing.getImage());
                }
            });
        }
        hotelDao.save(hotels);
    }

    private String saveImage(MultipartFile file) {
        try {
            Path uploadPath = Paths.get(UPLOAD_DIR);
            
            // Ensure directory exists
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // Generate unique filename to prevent conflicts
            String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
            Path filePath = uploadPath.resolve(fileName);
            
            Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
            return fileName;
            
        } catch (IOException e) {
            throw new RuntimeException("Critical: Could not store hotel image. " + e.getMessage());
        }
    }

    // --- Data Retrieval & Search Methods ---

    @Override
    public List<Hotels> getHotelsByStatus(String status) { 
        return hotelDao.findByStatus(status); 
    }
    
    @Override
    public Hotels getHotelById(int id) { 
        return hotelDao.findById(id).orElse(null); 
    }

    @Override
    public Hotels getHotelsByHotelName(String hotelName) { 
        return hotelDao.findByHotelName(hotelName); 
    }

    @Override
    public List<Hotels> getHotelsByLocation(String location) { 
        return hotelDao.findByLocation(location); 
    }

    @Override
    public List<Hotels> getHotelsByRatings(int ratings) { 
        return hotelDao.findByRatings(ratings); 
    }

    @Override
    public List<Hotels> getHotelsByDescription(String description) { 
        return hotelDao.findByDescriptionContaining(description); 
    }

    @Override
    public void deleteHotels(int id) { 
        hotelDao.deleteById(id); 
    }

    @Override
    public List<Hotels> getAllHotels() { 
        return hotelDao.findAll(); 
    }
    
    @Override
    public List<Hotels> searchHotels(String query) {
        return hotelDao.findByHotelNameContainingIgnoreCaseOrLocationContainingIgnoreCaseOrDescriptionContainingIgnoreCaseOrPhoneNumberContainingIgnoreCase(
            query, query, query, query
        );
    }

    @Override
    public List<Hotels> getHotelsByPhoneNumber(String phoneNumber) { 
        return hotelDao.findByPhoneNumber(phoneNumber); 
    }
}