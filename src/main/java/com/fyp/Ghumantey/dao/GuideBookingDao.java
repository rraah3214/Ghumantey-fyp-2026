package com.fyp.Ghumantey.dao;

import java.time.LocalDate;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.fyp.Ghumantey.entity.GuideBooking;

@Repository
public interface GuideBookingDao extends JpaRepository<GuideBooking, Long> {

    // Using the underscore ensures JPA looks for the 'id' property inside the 'guide' entity
    List<GuideBooking> findByGuide_Id(Integer guideId);

    List<GuideBooking> findByUserId(Long userId);

    List<GuideBooking> findByTransactionUuid(String transactionUuid);

    @Query("SELECT b FROM GuideBooking b WHERE b.guide.id = :guideId " +
           "AND b.status = 'PAID' " +
           "AND ((b.startDate <= :endDate AND b.endDate >= :startDate))")
    List<GuideBooking> findOverlappingBookings(@Param("guideId") Integer guideId,
                                               @Param("startDate") LocalDate startDate,
                                               @Param("endDate") LocalDate endDate);

    List<GuideBooking> findByUserIdAndStatus(Long userId, String status);
}