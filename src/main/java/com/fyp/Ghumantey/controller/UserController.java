package com.fyp.Ghumantey.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fyp.Ghumantey.entity.UserDetails;
import com.fyp.Ghumantey.service.UserDetailsService;

@Controller
public class UserController {

    @Autowired
    private UserDetailsService userDetailsService;

    @GetMapping("/user/home")
    public String userHome(Model model, Principal principal) {
        UserDetails userDetails = userDetailsService.getUserByUsername(principal.getName());
        model.addAttribute("user", userDetails);
        return "home";
    }
    @GetMapping("/user/userprofile")
    public String userProfile(Model model, Principal principal) {
        UserDetails userDetails = userDetailsService.getUserByUsername(principal.getName());
        model.addAttribute("user", userDetails);
        return "userprofile";
    }
    @GetMapping("/user/treck")
    public String userTreck(Model model, Principal principal) {
    	
    	
    	 UserDetails userDetails =
                 userDetailsService.getUserByUsername(principal.getName());
         model.addAttribute("user", userDetails);
         return "treck";
    	
    }
    
    @GetMapping("/user/travelpackages")
    public String userTravelPackages(Model model, Principal principal) {
    	
    	
    	 UserDetails userDetails =
                 userDetailsService.getUserByUsername(principal.getName());
         model.addAttribute("user", userDetails);
         return "travelpackages";
    	
    }
    
    
    
    
    
    
    
    
    
}