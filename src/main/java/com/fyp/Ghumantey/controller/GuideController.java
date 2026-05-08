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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fyp.Ghumantey.dao.GuideBookingDao;
import com.fyp.Ghumantey.entity.Guide;
import com.fyp.Ghumantey.entity.GuideBooking;
import com.fyp.Ghumantey.entity.UserDetails;
import com.fyp.Ghumantey.service.GuideService;
import com.fyp.Ghumantey.service.UserDetailsService;

@Controller
@RequestMapping("/admin/guide")
public class GuideController {

    @Autowired
    private GuideService guideService;

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private GuideBookingDao guideBookingRepository;

    // ------------------ ADD NEW GUIDE ------------------
    @PostMapping("/add")
    public String saveGuide(@ModelAttribute Guide guide,
                            @RequestParam(name = "user_id", required = false) Integer userId,
                            @RequestParam("photoFile") MultipartFile photoFile,
                            RedirectAttributes redirectAttributes) {
        try {
            if (guideService.isLicenseRegistered(guide.getLicenseNo())) {
                redirectAttributes.addFlashAttribute("error", "License number already registered!");
                return "redirect:/admin/dashbord?activeTab=guides";
            }

            if (userId != null) {
                UserDetails user = userDetailsService.getUserById(userId);
                if (user != null) {
                    guide.setUserDetails(user);
                } else {
                    redirectAttributes.addFlashAttribute("error", "Error: User ID " + userId + " does not exist!");
                    return "redirect:/admin/dashbord?activeTab=guides";
                }
            }
            guideService.saveGuide(guide, photoFile);
            redirectAttributes.addFlashAttribute("success", "Guide added successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Database Error: " + e.getMessage());
        }
        return "redirect:/admin/dashbord?activeTab=guides";
    }

    // ------------------ UPDATE EXISTING GUIDE ------------------
    @PostMapping("/update")
    public String updateGuide(@ModelAttribute Guide guide,
                              @RequestParam("id") Integer id,
                              @RequestParam(name = "user_id", required = false) Integer userId,
                              @RequestParam(value = "photoFile", required = false) MultipartFile photoFile,
                              RedirectAttributes redirectAttributes) {
        try {
            if (id == null) {
                redirectAttributes.addFlashAttribute("error", "Invalid guide ID!");
                return "redirect:/admin/dashbord?activeTab=guides";
            }

            Guide existingGuide = guideService.getGuideById(id);
            if (existingGuide != null) {
                existingGuide.setFirstname(guide.getFirstname());
                existingGuide.setLastname(guide.getLastname());
                existingGuide.setAddress(guide.getAddress());
                existingGuide.setEmail(guide.getEmail());
                existingGuide.setNumber(guide.getNumber());
                existingGuide.setStatus(guide.getStatus());
                existingGuide.setPrice(guide.getPrice());
                existingGuide.setLicenseNo(guide.getLicenseNo());

                if (userId != null) {
                    UserDetails user = userDetailsService.getUserById(userId);
                    if (user != null) {
                        existingGuide.setUserDetails(user);
                    }
                }

                guideService.saveGuide(existingGuide, photoFile);
                redirectAttributes.addFlashAttribute("success", "Guide updated successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Guide not found!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Update failed: " + e.getMessage());
        }
        return "redirect:/admin/dashbord?activeTab=guides";
    }

    // ------------------ EDIT GUIDE ------------------
    @GetMapping("/edit/{id}")
    public String editGuide(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        Guide guide = guideService.getGuideById(id);
        if (guide == null) {
            redirectAttributes.addFlashAttribute("error", "Guide not found!");
            return "redirect:/admin/dashbord?activeTab=guides";
        }
        redirectAttributes.addFlashAttribute("guideToEdit", guide);
        return "redirect:/admin/dashbord?activeTab=guides";
    }

    // ------------------ DELETE GUIDE ------------------
    @GetMapping("/delete/{id}")
    public String deleteGuide(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        try {
            guideService.deleteGuideById(id);
            redirectAttributes.addFlashAttribute("success", "Guide deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Could not delete: " + e.getMessage());
        }
        return "redirect:/admin/dashbord?activeTab=guides";
    }

    // ------------------ GUIDE SPECIFIC DASHBORD (FIXED DISPLAY) ------------------
    @GetMapping("/dashbord")
    public String showGuideDashbord(Model model, Principal principal) {
        if (principal == null) {
            return "redirect:/login";
        }

        try {
            // 1. Get the current User Details from the principal
            UserDetails user = userDetailsService.getUserByUsername(principal.getName());
            if (user == null) {
                return "redirect:/login?error=userNotFound";
            }

            // 2. Fetch the Guide profile linked to this specific User ID
            Guide guide = guideService.getGuideByUserId(user.getId());
            
            if (guide != null) {
                // 3. Fetch bookings using the Guide's Integer ID
                List<GuideBooking> bookings = guideBookingRepository.findByGuide_Id(guide.getId());
                
                // 4. Pass exact variables required by the JSP
                model.addAttribute("guide", guide);
                model.addAttribute("notificationsList", bookings);
                model.addAttribute("notifyCount", (bookings != null) ? bookings.size() : 0);
                
                // Debug to console to verify data flow
                System.out.println("Guide Dashbord accessed by: " + guide.getFirstname());
                System.out.println("Found " + (bookings != null ? bookings.size() : 0) + " bookings.");
                
            } else {
                model.addAttribute("error", "Guide profile not found. Please contact admin.");
            }
        } catch (Exception e) {
            System.err.println("Dashboard Error: " + e.getMessage());
            return "redirect:/login?error=sessionError";
        }

        return "guideDashbord";
    }

    // ------------------ UPDATE BOOKING STATUS ------------------
    @PostMapping("/updateStatus")
    public String updateBookingStatus(@RequestParam("id") Long bookingId,
                                      @RequestParam("status") String status,
                                      RedirectAttributes redirectAttributes) {
        try {
            GuideBooking booking = guideBookingRepository.findById(bookingId).orElse(null);
            if (booking != null) {
                booking.setStatus(status);
                guideBookingRepository.save(booking);
                redirectAttributes.addFlashAttribute("success", "Booking " + status + " successfully!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating status: " + e.getMessage());
        }
        return "redirect:/admin/guide/dashbord";
    }

    // ------------------ SELF-SERVICE PROFILE PHOTO UPLOAD ------------------
    @PostMapping("/upload-profile")
    public String handleFileUpload(@RequestParam("photoFile") MultipartFile file,
                                   Principal principal,
                                   RedirectAttributes redirectAttributes) {
        if (principal == null) {
            return "redirect:/login";
        }

        if (file.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Please select a file to upload.");
            return "redirect:/admin/guide/dashbord";
        }

        try {
            UserDetails user = userDetailsService.getUserByUsername(principal.getName());
            Guide guide = guideService.getGuideByUserId(user.getId());

            if (guide != null) {
                guideService.saveGuide(guide, file);
                redirectAttributes.addFlashAttribute("success", "Profile photo updated successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Guide profile not found.");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Upload failed: " + e.getMessage());
        }

        return "redirect:/admin/guide/dashbord";
    }

    // ------------------ NOTIFY GUIDE ------------------
    @PostMapping("/notify")
    public String notifyGuide(@RequestParam("guideId") int guideId, Principal principal) {
        if (principal == null) {
            return "redirect:/login";
        }

        Guide guide = guideService.getGuideById(guideId);
        if (guide == null) {
            return "redirect:/user/travelpackages?error=noGuide";
        }

        String message = "System: New activity for " + principal.getName();
        String currentNotifications = guide.getNotifications();

        if (currentNotifications == null || currentNotifications.isEmpty()) {
            guide.setNotifications(message);
        } else {
            guide.setNotifications(currentNotifications + "###" + message);
        }

        guideService.saveGuide(guide, null);
        return "redirect:/user/travelpackages?success=notified";
    }
}