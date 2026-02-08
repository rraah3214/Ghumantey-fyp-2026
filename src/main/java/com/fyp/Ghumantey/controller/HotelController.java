package com.fyp.Ghumantey.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fyp.Ghumantey.entity.Hotels;
import com.fyp.Ghumantey.entity.UserDetails;
import com.fyp.Ghumantey.service.HotelService;
import com.fyp.Ghumantey.service.UserDetailsService;

@Controller
public class HotelController {

    @Autowired
    private HotelService hotelService;
    @Autowired
    private UserDetailsService userDetailsService;
    
    @GetMapping("/hotel/dashboard")
    public String hotelDashboard(Model model, Principal principal) {

    	UserDetails user =
                userDetailsService.getUserByUsername(principal.getName());

        Hotels hotel =
            hotelService.getHotelsById(user.getId());

        model.addAttribute("hotel", hotel);
        return "hotelDashboard";
    }

    @GetMapping("/user/hotel")
    public String showHotels(Model model) {
        model.addAttribute("hotelsList", hotelService.getAllHotels());
        return "hotel";
    }
   
    
    
    
    
}
