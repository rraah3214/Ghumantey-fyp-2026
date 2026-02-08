package com.fyp.Ghumantey.controller;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

    @GetMapping("/admin/dashbord")
    public String openDashbord(Model model, Principal principal) {
        model.addAttribute("username", principal.getName());
        return "admin/dashbord";
    }
}