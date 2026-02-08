package com.fyp.Ghumantey.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.fyp.Ghumantey.entity.Guide;

@Repository
public interface GuideDao extends JpaRepository<Guide, Integer> {

    // Find guide by email (useful for checking duplicates or login)
    Optional<Guide> findByEmail(String email);

    // Find all guides with a given first name
    List<Guide> findByFirstname(String firstname);

    // Find all guides with a given last name
    List<Guide> findByLastname(String lastname);

    
}
