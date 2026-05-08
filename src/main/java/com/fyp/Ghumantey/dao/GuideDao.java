package com.fyp.Ghumantey.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.fyp.Ghumantey.entity.Guide;

@Repository
public interface GuideDao extends JpaRepository<Guide, Integer> {

    List<Guide> findByStatus(String status);

    /**
     * Finds the Guide record associated with a specific UserDetails ID.
     * Spring Data JPA navigates the UserDetails relationship automatically.
     */
    Guide findByUserDetailsId(Integer userId);

    /**
     * SEARCH UPDATE: Added support for searching by License Number
     * in addition to names and addresses.
     */
    @Query("SELECT g FROM Guide g WHERE g.status = :status AND (" +
           "LOWER(g.firstname) LIKE LOWER(CONCAT('%', :search, '%')) OR " +
           "LOWER(g.lastname) LIKE LOWER(CONCAT('%', :search, '%')) OR " +
           "LOWER(g.address) LIKE LOWER(CONCAT('%', :search, '%')) OR " +
           "LOWER(g.licenseNo) LIKE LOWER(CONCAT('%', :search, '%')))")
    List<Guide> searchApprovedGuides(@Param("status") String status, @Param("search") String search);

    /**
     * Optional: Quick check to see if a license number already exists
     * (Useful for registration validation)
     */
    boolean existsByLicenseNo(String licenseNo);
}