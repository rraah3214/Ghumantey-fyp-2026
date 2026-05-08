package com.fyp.Ghumantey.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.fyp.Ghumantey.entity.Adventure;

@Repository
public interface AdventureDao extends JpaRepository<Adventure, Long> {


    // Basic CRUD operations are automatically included


}