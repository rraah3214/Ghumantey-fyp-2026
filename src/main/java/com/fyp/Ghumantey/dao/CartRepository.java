package com.fyp.Ghumantey.dao;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.fyp.Ghumantey.entity.CartItem;
import com.fyp.Ghumantey.entity.UserDetails;

public interface CartRepository extends JpaRepository<CartItem, Long> {
    List<CartItem> findByUser(UserDetails user);
    void deleteByUser(UserDetails user); // Useful for clearing cart after payment
}