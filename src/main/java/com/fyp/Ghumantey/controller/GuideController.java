package com.fyp.Ghumantey.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fyp.Ghumantey.entity.Guide;
import com.fyp.Ghumantey.entity.UserDetails;
import com.fyp.Ghumantey.service.GuideService;
import com.fyp.Ghumantey.service.UserDetailsService;

@Controller
public class GuideController {

    @Autowired
    private GuideService guideService;

    @Autowired
    private UserDetailsService userDetailsService;

    @GetMapping("/guide/dashboard")
    public String openGuideDashboard(Model model, Principal principal) {

        UserDetails user =
            userDetailsService.getUserByUsername(principal.getName());

        Guide guide =
            guideService.getGuideById(user.getId());

        model.addAttribute("guide", guide);
        return "guideDashboard";
    }

    @GetMapping("/user/guide")
    public String showGuide(Model model) {
        model.addAttribute("guidesList", guideService.getAllGuides());
        return "guide";
    }
}