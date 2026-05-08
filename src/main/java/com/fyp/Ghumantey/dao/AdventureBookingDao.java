package com.fyp.Ghumantey.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.fyp.Ghumantey.entity.AdventureBooking;

@Repository
public interface AdventureBookingDao extends JpaRepository<AdventureBooking, Long> {

    // ✅ FIXED
    List<AdventureBooking> findByTransactionUuid(String uuid);

    List<AdventureBooking> findByUserId(Long userId);

    List<AdventureBooking> findByUserIdAndStatus(Long userId, String status);
}