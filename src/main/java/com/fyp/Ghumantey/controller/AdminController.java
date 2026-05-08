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

import com.fyp.Ghumantey.dao.AdventureDao;
import com.fyp.Ghumantey.dao.GuideBookingDao;
import com.fyp.Ghumantey.dao.GuideDao;
import com.fyp.Ghumantey.dao.HotelBookingDao;
import com.fyp.Ghumantey.dao.HotelDao;
import com.fyp.Ghumantey.dao.NotificationDao;
import com.fyp.Ghumantey.dao.UserDetailDao;
import com.fyp.Ghumantey.dao.UserRoleDao;
import com.fyp.Ghumantey.entity.Adventure;
import com.fyp.Ghumantey.entity.Notification;
import com.fyp.Ghumantey.entity.UserDetails;

@Controller
public class AdminController {

    @Autowired private NotificationDao notificationDao;
    @Autowired private UserDetailDao userDetailDao;
    @Autowired private GuideDao guideDao;
    @Autowired private HotelDao hotelDao;
    @Autowired private UserRoleDao userRoleDao;
    @Autowired private GuideBookingDao guideBookingDao;
    @Autowired private HotelBookingDao hotelBookingDao;
    @Autowired private AdventureDao adventureDao;

    // ================= DASHBOARD =================
    @GetMapping("/admin/dashbord")
    public String openDashbord(Model model, Principal principal,
                               @RequestParam(value = "activeTab", required = false, defaultValue = "guides") String activeTab,
                               @RequestParam(value = "editAdventureId", required = false) Long editAdventureId) {

        if (principal == null) {
            return "redirect:/login";
        }

        UserDetails admin = userDetailDao.findByUsername(principal.getName());

        List<Notification> notifications = notificationDao.findByAdminAndSeenFalse(admin);
        model.addAttribute("notifications", notifications);
        model.addAttribute("unreadCount", notifications.size());

        model.addAttribute("guides", guideDao.findAll());
        model.addAttribute("hotels", hotelDao.findAll());
        model.addAttribute("users", userDetailDao.findAll());
        model.addAttribute("roles", userRoleDao.findAll());
        model.addAttribute("adventures", adventureDao.findAll());

        if (editAdventureId != null) {
            model.addAttribute("adventureToEdit", adventureDao.findById(editAdventureId).orElse(null));
            activeTab = "adventures";
        }

        model.addAttribute("guideBookingsHistory", guideBookingDao.findAll());
        model.addAttribute("hotelBookingsHistory", hotelBookingDao.findAll());

        model.addAttribute("pendingGuides", guideDao.findByStatus("PENDING"));
        model.addAttribute("pendingHotels", hotelDao.countByStatus("PENDING"));

        model.addAttribute("username", principal.getName());
        model.addAttribute("activeTab", activeTab);

        return "admin/dashbord";
    }
    
    
    

    // ================= ADVENTURE =================
    @PostMapping("/admin/adventure/add")
    public String addAdventure(@ModelAttribute Adventure adventure) {
        adventureDao.save(adventure);
        return "redirect:/admin/dashbord?activeTab=adventures&success=Adventure Added Successfully";
    }

    @PostMapping("/admin/adventure/update")
    public String updateAdventure(@ModelAttribute Adventure adventure) {
        adventureDao.save(adventure);
        return "redirect:/admin/dashbord?activeTab=adventures&success=Adventure Updated Successfully";
    }

    @GetMapping("/admin/adventure/delete/{id}")
    public String deleteAdventure(@PathVariable("id") Long id) {
        adventureDao.deleteById(id);
        return "redirect:/admin/dashbord?activeTab=adventures&success=Adventure Deleted Successfully";
    }
}