package com.fyp.Ghumantey.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fyp.Ghumantey.dao.GuideDao;
import com.fyp.Ghumantey.dao.HotelDao;
import com.fyp.Ghumantey.entity.Guide;
@Controller
public class HomeController {

    @Autowired
    private GuideDao guideDao;

    @Autowired
    private HotelDao hotelDao;

    // Landing page (after payment redirect also comes here)
    @GetMapping({"/", "/home", "/user/home"})
    public String landingPage(Model model) {

        model.addAttribute("guides", guideDao.findByStatus("APPROVED"));
        model.addAttribute("hotels", hotelDao.findByStatus("APPROVED")); // ✅ FIXED

        return "home";
    }

    // Guide page
    @GetMapping("/user/guide")
    public String showGuides(@RequestParam(value="search", required=false) String search, Model model) {

        List<Guide> guides;

        if (search != null && !search.trim().isEmpty()) {
            guides = guideDao.searchApprovedGuides("APPROVED", search);
        } else {
            guides = guideDao.findByStatus("APPROVED");
        }

        model.addAttribute("guides", guides);
        model.addAttribute("searchQuery", search);

        return "guide";
    }
}