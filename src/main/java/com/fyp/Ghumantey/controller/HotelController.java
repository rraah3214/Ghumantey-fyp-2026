package com.fyp.Ghumantey.controller;

import java.security.Principal;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fyp.Ghumantey.dao.HotelDao;
import com.fyp.Ghumantey.dao.UserDetailDao;
import com.fyp.Ghumantey.entity.Hotels;
import com.fyp.Ghumantey.entity.UserDetails;
import com.fyp.Ghumantey.service.HotelService;

@Controller
public class HotelController {

    @Autowired
    private HotelService hotelService;

    @Autowired
    private HotelDao hotelDao;

    @Autowired
    private UserDetailDao userDetailDao;

    @Autowired
    private AdminController adminController;

    // ==========================================
    // USER FACING METHODS (hotel.jsp)
    // ==========================================

    @GetMapping("/user/hotel")
    public String viewHotelsForUser(@RequestParam(value = "search", required = false) String search, Model model) {
        List<Hotels> hotelList;

        if (search != null && !search.trim().isEmpty()) {
            hotelList = hotelService.searchHotels(search);
        } else {
            hotelList = hotelService.getAllHotels();
        }

        model.addAttribute("hotels", hotelList);
        model.addAttribute("searchQuery", search);

        return "hotel";
    }

    // ==========================================
    // ADMIN FACING METHODS
    // ==========================================

    @GetMapping("/admin/hotel/edit/{id}")
    public String editHotel(@PathVariable("id") int id, Model model, Principal principal) {
        Hotels hotel = hotelService.getHotelById(id);

        if (hotel != null) {
            model.addAttribute("hotelToEdit", hotel);
        } else {
            return "redirect:/admin/dashbord?error=HotelNotFound&activeTab=hotels";
        }

        // Reusing AdminController logic to keep the dashbord view consistent
        return adminController.openDashbord(model, principal, "hotels", null);
    }

    @PostMapping("/admin/hotel/add")
    public String saveHotel(@ModelAttribute Hotels hotel, 
                            @RequestParam("user_id") Integer userId,
                            @RequestParam("imageFile") MultipartFile file,
                            RedirectAttributes ra) {
        
        UserDetails owner = userDetailDao.findById(userId).orElse(null);
        if (owner == null) {
            ra.addFlashAttribute("error", "Owner User ID not found.");
            return "redirect:/admin/dashbord?activeTab=hotels";
        }

        try {
            hotel.setUser(owner);
            if (hotel.getStatus() == null) {
                hotel.setStatus("APPROVED");
            }

            // Using service for unified image handling
            hotelService.saveHotels(hotel, file);
            ra.addFlashAttribute("success", "Hotel Registered Successfully");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Failed to save hotel: " + e.getMessage());
        }

        return "redirect:/admin/dashbord?activeTab=hotels";
    }

    @PostMapping("/admin/hotel/update")
    public String updateHotel(@ModelAttribute Hotels hotel, 
                              @RequestParam("user_id") Integer userId,
                              @RequestParam(value = "imageFile", required = false) MultipartFile file,
                              RedirectAttributes ra) {
        
        UserDetails owner = userDetailDao.findById(userId).orElse(null);
        if (owner == null) {
            ra.addFlashAttribute("error", "Update failed: Owner not found.");
            return "redirect:/admin/dashbord?activeTab=hotels";
        }

        try {
            hotel.setUser(owner);
            // Service method handles checking if file is empty to preserve old image
            hotelService.updateHotels(hotel, file);
            ra.addFlashAttribute("success", "Hotel details updated successfully.");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Update failed: " + e.getMessage());
        }

        return "redirect:/admin/dashbord?activeTab=hotels";
    }

    @GetMapping("/admin/hotel/delete/{id}")
    public String deleteHotel(@PathVariable("id") int id, RedirectAttributes ra) {
        try {
            hotelService.deleteHotels(id);
            ra.addFlashAttribute("success", "Hotel record removed.");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Delete failed: " + e.getMessage());
        }
        return "redirect:/admin/dashbord?activeTab=hotels";
    }
}