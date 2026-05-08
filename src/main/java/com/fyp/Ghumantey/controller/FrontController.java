package com.fyp.Ghumantey.controller;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fyp.Ghumantey.entity.UserDetails;
import com.fyp.Ghumantey.entity.UserRole;
import com.fyp.Ghumantey.service.EmailService;
import com.fyp.Ghumantey.service.UserDetailsService;

import jakarta.servlet.http.HttpSession;

@Controller
public class FrontController {

    @Autowired private UserDetailsService userDetailsService;
    @Autowired private PasswordEncoder passwordEncoder;
    @Autowired private EmailService emailService;

    @GetMapping("/signup")
    public String showSignupPage(Authentication auth, Model model) {
        // If user is already logged in, redirect them away from signup
        if (auth != null && auth.isAuthenticated()) {
            return getRedirectRoute(auth);
        }

        if (!model.containsAttribute("user")) {
            model.addAttribute("user", new UserDetails());
        }
        return "signup";
    }

    @GetMapping("/login")
    public String showLoginPage(Authentication auth,
                                @RequestParam(required = false) String failed,
                                @RequestParam(required = false) String logout,
                                @RequestParam(required = false) String signupSuccess,
                                Model model) {
        // If user is already logged in, redirect them away from login
        if (auth != null && auth.isAuthenticated()) {
            return getRedirectRoute(auth);
        }

        if (failed != null) {
			model.addAttribute("error", "Invalid credentials!");
		}
        if (logout != null) {
			model.addAttribute("msg", "Logged out successfully!");
		}
        if (signupSuccess != null) {
			model.addAttribute("successMsg", "Signup successful! Please login.");
		}
        return "login";
    }

    /**
     * Helper method to determine where to send an already authenticated user
     */
    private String getRedirectRoute(Authentication auth) {
        String roles = auth.getAuthorities().toString();
        if (roles.contains("ROLE_GUIDE")) {
			return "redirect:/guide/dashbord";
		}
        if (roles.contains("ROLE_HOTEL")) {
			return "redirect:/hotel/dashbord";
		}
        if (roles.contains("ROLE_ADMIN")) {
			return "redirect:/admin/dashbord";
		}
        return "redirect:/user/home";
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute("user") UserDetails userDetails, RedirectAttributes redirectAttributes) {
        if (userDetailsService.getUserByEmail(userDetails.getEmail()) != null) {
            redirectAttributes.addFlashAttribute("error", "Email is already registered!");
            return "redirect:/signup";
        }
        userDetails.setPassword(passwordEncoder.encode(userDetails.getPassword()));
        userDetails.setActive("1");

        UserRole role = new UserRole();
        String assignedRole = userDetails.getAuthority() != null ? userDetails.getAuthority() : "USER";
        if (!assignedRole.startsWith("ROLE_")) {
			assignedRole = "ROLE_" + assignedRole;
		}

        role.setRole(assignedRole);
        role.setUserDetails(userDetails);
        userDetails.setUserRole(role);

        userDetailsService.saveUser(userDetails);
        return "redirect:/login?signupSuccess=true";
    }

    // ==========================================
    // OTP LOGIC
    // ==========================================

    @GetMapping("/verify-otp")
    public String showOtpPage(Authentication auth, HttpSession session, Model model) {
        if (auth == null) {
			return "redirect:/login";
		}

        UserDetails user = userDetailsService.getUserByUsername(auth.getName());
        String userEmail = user.getEmail();

        // Only send OTP if one doesn't exist in session to avoid spamming on refresh
        if (session.getAttribute("serverOtp") == null) {
            String otp = String.format("%06d", new Random().nextInt(999999));
            session.setAttribute("serverOtp", otp);
            emailService.sendSimpleMessage(userEmail, "Verification Code", "Code: " + otp);
        }

        model.addAttribute("email", userEmail);
        return "verifyOtp";
    }

    @PostMapping("/verify-otp")
    public String verifyOtp(@RequestParam("otp") String userOtp, HttpSession session, Authentication auth) {
        String serverOtp = (String) session.getAttribute("serverOtp");

        if (serverOtp != null && serverOtp.equals(userOtp)) {
            session.removeAttribute("serverOtp");
            return getRedirectRoute(auth);
        }

        return "redirect:/verify-otp?error=true";
    }

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
}