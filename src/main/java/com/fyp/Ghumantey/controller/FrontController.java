package com.fyp.Ghumantey.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.fyp.Ghumantey.entity.UserDetails;
import com.fyp.Ghumantey.entity.UserRole;

import com.fyp.Ghumantey.service.UserDetailsService;




@Controller
public class FrontController {

    @Autowired
    private UserDetailsService userDetailsService;

 

    @Autowired
    private PasswordEncoder passwordEncoder;

    // ====================== AUTH & HOME ======================

    @GetMapping("/signup")
    public String showSignupPage(Model model, @RequestParam(required = false) String signupSuccess) {
        model.addAttribute("user", new UserDetails());
        model.addAttribute("signupSuccess", signupSuccess);
        return "signup";
    }

    @GetMapping("/login")
    public String showLoginPage(@RequestParam(required = false) String failed,
                                @RequestParam(required = false) String logout,
                                Model model) {
        if (failed != null) model.addAttribute("error", "Invalid username or password!");
        if (logout != null) model.addAttribute("msg", "Logged out successfully!");
        return "login";
    }

    @GetMapping("/home")
    public String home() {
        return "home";
    }

    // ====================== USER REGISTRATION ======================

    @PostMapping("/register")
    public String registerUser(@ModelAttribute("user") UserDetails userDetails) {

        // Encode password
        userDetails.setPassword(passwordEncoder.encode(userDetails.getPassword()));
        userDetails.setActive("1");

        // Assign role properly
        UserRole role = new UserRole();
        String assignedRole = userDetails.getAuthority() != null ? userDetails.getAuthority() : "USER";
        if (!assignedRole.startsWith("ROLE_")) {
            assignedRole = "ROLE_" + assignedRole;
        }

        role.setRole(assignedRole);
        role.setUserDetails(userDetails);
        userDetails.setUserRole(role);

        userDetailsService.saveUser(userDetails);

        return "redirect:/signup?signupSuccess=true";
    }

    // ====================== DASHBOARDS ======================

    @GetMapping("/guide/dashbord")
    public String guideDashbord(Authentication auth, Model model) {
        model.addAttribute("username", auth.getName());
        return "guideDashbord";
    }

    @GetMapping("/hotel/dashbord")
    public String hotelDashbord(Authentication auth, Model model) {
        model.addAttribute("username", auth.getName());
        return "hotelDashbord";
    }

    // ====================== HOTEL MANAGEMENT ======================

   
   
   

    
   


    

    


   
    // ====================== USER PROFILE & LOGOUT ======================

    @GetMapping("/profile")
    public String userProfile(Authentication auth, Model model) {
        UserDetails user = userDetailsService.getUserByUsername(auth.getName());
        model.addAttribute("user", user);
        return "userprofile";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/login?logout=true";
    }
}
