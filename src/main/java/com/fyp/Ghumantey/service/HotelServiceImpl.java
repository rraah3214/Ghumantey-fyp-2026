package com.fyp.Ghumantey.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fyp.Ghumantey.dao.HotelDao;
import com.fyp.Ghumantey.entity.Hotels;

@Service
public class HotelServiceImpl implements HotelService {

    @Autowired
    private HotelDao hotelDao;

    @Override
    public void saveHotels(Hotels hotels) {
        hotelDao.save(hotels);
    }

  
    public Hotels getHotelsById(int id) {
        return hotelDao.findById(id);
    }

    @Override
    public Hotels getHotelsByUsername(String username) {
        return hotelDao.findByUsername(username);
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
    public List<Hotels> getHotelsByDiscription(String discription) {
        return hotelDao.findByDiscriptionContaining(discription);
    }

    @Override
    public void updateHotels(Hotels hotels) {
        // save() updates if ID exists
        hotelDao.save(hotels);
    }

    @Override
    public void deleteHotels(Hotels hotels) {
        hotelDao.delete(hotels);
    }

    @Override
    public List<Hotels> getAllHotels() {
        return hotelDao.findAll();
    }
}
