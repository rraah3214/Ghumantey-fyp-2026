package com.fyp.Ghumantey.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.fyp.Ghumantey.dao.AdventureDao;
import com.fyp.Ghumantey.entity.Adventure;
import com.fyp.Ghumantey.entity.Guide;
import com.fyp.Ghumantey.entity.UserDetails;
import com.fyp.Ghumantey.service.AdventureService;
import com.fyp.Ghumantey.service.BookingService;
import com.fyp.Ghumantey.service.GuideService;
import com.fyp.Ghumantey.service.UserDetailsService;

@Controller
public class UserController {

    @Autowired private AdventureDao adventureDao;
    @Autowired private AdventureService adventureService;
    @Autowired private UserDetailsService userDetailsService;
    @Autowired private BookingService bookingService;
    @Autowired private GuideService guideService;

    @ModelAttribute
    public void addCommonAttributes(Model model, Principal principal) {
        if (principal != null) {
            UserDetails userDetails = userDetailsService.getUserByUsername(principal.getName());
            model.addAttribute("user", userDetails);
        }
    }

    @GetMapping("/user/userprofile")
    public String userProfile(Model model, Principal principal) {

        if (principal != null) {
            UserDetails userDetails = userDetailsService.getUserByUsername(principal.getName());

            if (userDetails != null) {

                Long userId = (long) userDetails.getId();

                // Existing data
                model.addAttribute("guideBookings", bookingService.getGuideHistory(userId));
                model.addAttribute("hotelBookings", bookingService.getHotelHistory(userId));

                // ✅ NEW: Only PAID bookings (for payment history)
                model.addAttribute("paidGuideBookings",
                        bookingService.getGuideHistoryByStatus(userId, "PAID"));

                model.addAttribute("paidHotelBookings",
                        bookingService.getHotelHistoryByStatus(userId, "PAID"));
            }
        }

        return "userprofile";
    }

    @GetMapping("/user/about")
    public String showAboutPage() {
        return "about";
    }

    @GetMapping("/user/adventure")
    public String showUserAdventures(Model model) {
        // Matches the plural 'adventures' expected by your display loops
        model.addAttribute("adventures", adventureDao.findAll());
        return "adventure";
    }

    @GetMapping("/user/adventure-detail/{id}")
    public String showAdventureDetail(@PathVariable("id") Long id, Model model) {
        Adventure adventure = adventureService.getAdventureById(id);
        if (adventure == null) {
            return "redirect:/user/adventure";
        }
        // Matches the singular 'adventure' expected by your detail page
        model.addAttribute("adventure", adventure);
        return "adventure-detail";
    }

    @GetMapping("/user/treck")
    public String userTreck() {
        return "treck";
    }

    @GetMapping("/explore-treks")
    public String showTreks(Model model) {
        model.addAttribute("guides", guideService.getApprovedGuides());
        return "treck";
    }

    @GetMapping("/search")
    public String searchGuides(@RequestParam(value = "search", required = false) String query, Model model) {
        List<Guide> results = (query != null && !query.trim().isEmpty())
            ? guideService.searchGuides(query) : guideService.getApprovedGuides();
        model.addAttribute("guides", results);
        model.addAttribute("searchQuery", query);
        return "guide";
    }

    @GetMapping("/user/travelpackages")
    public String userTravelPackages() {
        return "travelpackages";
    }
}