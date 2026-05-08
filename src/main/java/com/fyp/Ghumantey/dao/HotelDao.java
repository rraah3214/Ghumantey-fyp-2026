package com.fyp.Ghumantey.dao;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.fyp.Ghumantey.entity.Hotels;

@Repository
public interface HotelDao extends JpaRepository<Hotels, Integer> {

    // ✅ Finds by exact Name
    Hotels findByHotelName(String hotelName);

    // ✅ Search by Status (Used to only show APPROVED hotels to users)
    List<Hotels> findByStatus(String status);

    // ✅ MULTI-FIELD SEARCH (v2): Checks name, location, description, or phone number
    // This is the primary method for your search bar in the Controller
    List<Hotels> findByHotelNameContainingIgnoreCaseOrLocationContainingIgnoreCaseOrDescriptionContainingIgnoreCaseOrPhoneNumberContainingIgnoreCase(
            String name, String location, String description, String phoneNumber);

    // ✅ Count for Admin Dashboard
    long countByStatus(String status);

    // ✅ Specific Field Lookups
    List<Hotels> findByLocation(String location);
    
    List<Hotels> findByRatings(int ratings);
    
    List<Hotels> findByPhoneNumber(String phoneNumber);

    List<Hotels> findByDescriptionContaining(String description);

    // ✅ Legacy Multi-Field Search (Optional: Keep if still used by older service methods)
    List<Hotels> findByHotelNameContainingIgnoreCaseOrLocationContainingIgnoreCaseOrDescriptionContainingIgnoreCase(
            String name, String location, String description);
}