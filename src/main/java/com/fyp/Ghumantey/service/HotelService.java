package com.fyp.Ghumantey.service;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import com.fyp.Ghumantey.entity.Hotels;

public interface HotelService {

    void saveHotels(Hotels hotels);
    void saveHotels(Hotels hotels, MultipartFile imageFile);

    void updateHotels(Hotels hotels);
    void updateHotels(Hotels hotels, MultipartFile imageFile);

    void deleteHotels(int id);

    // Retrieval Methods
    Hotels getHotelById(int id); // Standardized name
    Hotels getHotelsByHotelName(String hotelName);

    List<Hotels> getAllHotels();
    List<Hotels> getHotelsByLocation(String location);
    List<Hotels> getHotelsByRatings(int ratings);
    List<Hotels> getHotelsByPhoneNumber(String phoneNumber);
    List<Hotels> getHotelsByDescription(String description);

    List<Hotels> getHotelsByStatus(String status);
    List<Hotels> searchHotels(String query);
}