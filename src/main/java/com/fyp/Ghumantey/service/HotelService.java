package com.fyp.Ghumantey.service;

import java.util.List;
import com.fyp.Ghumantey.entity.Hotels;

public interface HotelService {

    void saveHotels(Hotels hotels);

    Hotels getHotelsById(int id);

    Hotels getHotelsByUsername(String username);

    List<Hotels> getHotelsByLocation(String location);

    List<Hotels> getHotelsByRatings(int ratings);

    List<Hotels> getHotelsByDiscription(String discription);

    void updateHotels(Hotels hotels);

    void deleteHotels(Hotels hotels);

    // ✅ NOT static
    List<Hotels> getAllHotels();
}
