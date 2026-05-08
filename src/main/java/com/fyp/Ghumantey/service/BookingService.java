package com.fyp.Ghumantey.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fyp.Ghumantey.dao.AdventureBookingDao;
import com.fyp.Ghumantey.dao.GuideBookingDao;
import com.fyp.Ghumantey.dao.HotelBookingDao;
import com.fyp.Ghumantey.entity.AdventureBooking;
import com.fyp.Ghumantey.entity.GuideBooking;
import com.fyp.Ghumantey.entity.HotelBooking;

@Service
@Transactional
public class BookingService {

    @Autowired private GuideBookingDao guideRepo;
    @Autowired private HotelBookingDao hotelRepo;
    @Autowired private AdventureBookingDao adventureRepo;

    // ================= SAVE METHODS =================

    public void saveAdventureBooking(AdventureBooking booking) {
        if (booking.getBookingDate() == null) {
            booking.setBookingDate(java.time.LocalDate.now());
        }
        adventureRepo.save(booking);
    }

    public void saveGuideBooking(GuideBooking booking) {
        if (booking.getBookingDate() == null) {
            booking.setBookingDate(java.time.LocalDate.now());
        }
        guideRepo.save(booking);
    }

    public void saveHotelBooking(HotelBooking booking) {
        if (booking.getBookingDate() == null) {
            booking.setBookingDate(java.time.LocalDate.now());
        }
        hotelRepo.save(booking);
    }

    // ================= 🔥 FIXED STATUS UPDATE (Corrected Method Names) =================

    public void updateStatusByUuid(String uuid, String status) {

        System.out.println("=== UPDATING STATUS ===");
        System.out.println("UUID: " + uuid);
        System.out.println("STATUS: " + status);

        // GUIDE - Removed "List" suffix to match Repository standard
        List<GuideBooking> guides = guideRepo.findByTransactionUuid(uuid);
        for (GuideBooking g : guides) {
            g.setStatus(status);
        }

        // HOTEL - Changed findByTransactionUuidList to findByTransactionUuid
        List<HotelBooking> hotels = hotelRepo.findByTransactionUuid(uuid);
        for (HotelBooking h : hotels) {
            h.setStatus(status);
        }

        // ADVENTURE - Changed findByTransactionUuidList to findByTransactionUuid
        List<AdventureBooking> adventures = adventureRepo.findByTransactionUuid(uuid);
        for (AdventureBooking a : adventures) {
            a.setStatus(status);
        }

        System.out.println("=== STATUS UPDATED SUCCESSFULLY ===");
    }

    // ================= FIND METHODS =================

    public List<GuideBooking> findGuideByUuid(String uuid) {
        return guideRepo.findByTransactionUuid(uuid);
    }

    public List<HotelBooking> findHotelByUuid(String uuid) {
        return hotelRepo.findByTransactionUuid(uuid);
    }

    public List<AdventureBooking> findAdventureByUuid(String uuid) {
        return adventureRepo.findByTransactionUuid(uuid);
    }

    // ================= HISTORY =================

    public List<GuideBooking> getGuideHistory(Long userId) {
        return guideRepo.findByUserId(userId);
    }

    public List<HotelBooking> getHotelHistory(Long userId) {
        return hotelRepo.findByUserId(userId);
    }

    public List<AdventureBooking> getAdventureHistory(Long userId) {
        return adventureRepo.findByUserId(userId);
    }

    public List<GuideBooking> getGuideHistoryByStatus(Long userId, String status) {
        return guideRepo.findByUserIdAndStatus(userId, status);
    }

    public List<HotelBooking> getHotelHistoryByStatus(Long userId, String status) {
        return hotelRepo.findByUserIdAndStatus(userId, status);
    }

    public List<AdventureBooking> getAdventureHistoryByStatus(Long userId, String status) {
        return adventureRepo.findByUserIdAndStatus(userId, status);
    }
 // ================= GUIDE DASHBORD METHODS =================

 // Add this to your existing BookingService.java

    public List<GuideBooking> getBookingsByGuide(Integer guideId) {
        List<GuideBooking> bookings = guideRepo.findByGuide_Id(guideId);
        
        // Debugging: Check your console/terminal to see if this triggers
        System.out.println("--- DB FETCH ---");
        System.out.println("Guide ID: " + guideId + " | Bookings Found: " + bookings.size());
        
        return bookings;
    }
}