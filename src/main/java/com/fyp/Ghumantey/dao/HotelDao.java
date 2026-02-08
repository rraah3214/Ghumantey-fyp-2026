package com.fyp.Ghumantey.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.fyp.Ghumantey.entity.Hotels;

@Repository
public interface HotelDao extends JpaRepository<Hotels, Integer> {

    Hotels findByUsername(String username);
    
    Hotels findById(int id);
    List<Hotels> findByLocation(String location);

    List<Hotels> findByRatings(int ratings);

    List<Hotels> findByDiscriptionContaining(String discription);
}
