package com.fyp.Ghumantey.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.fyp.Ghumantey.entity.HotelBooking;

@Repository
public interface HotelBookingDao extends JpaRepository<HotelBooking, Long> {

    List<HotelBooking> findByUserId(Long userId);

    // ✅ FIXED
    List<HotelBooking> findByTransactionUuid(String transactionUuid);

    List<HotelBooking> findByUserIdAndStatus(Long userId, String status);
    
}