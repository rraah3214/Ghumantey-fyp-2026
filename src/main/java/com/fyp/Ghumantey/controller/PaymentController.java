package com.fyp.Ghumantey.controller;

import java.nio.charset.StandardCharsets;
import java.security.Principal;
import java.time.LocalDate;
import java.util.Base64;
import java.util.List;
import java.util.UUID;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fyp.Ghumantey.DTO.PaymentDTO;
import com.fyp.Ghumantey.dao.CartRepository;
import com.fyp.Ghumantey.entity.AdventureBooking;
import com.fyp.Ghumantey.entity.CartItem;
import com.fyp.Ghumantey.entity.GuideBooking;
import com.fyp.Ghumantey.entity.HotelBooking;
import com.fyp.Ghumantey.entity.UserDetails;
import com.fyp.Ghumantey.service.AdventureService;
import com.fyp.Ghumantey.service.BookingService;
import com.fyp.Ghumantey.service.EmailService;
import com.fyp.Ghumantey.service.GuideService;
import com.fyp.Ghumantey.service.HotelService;
import com.fyp.Ghumantey.service.UserDetailsService;

@Controller
public class PaymentController {

    @Autowired private BookingService bookingService;
    @Autowired private UserDetailsService userDetailsService;
    @Autowired private GuideService guideService;
    @Autowired private HotelService hotelService;
    @Autowired private AdventureService adventureService;
    @Autowired private EmailService emailService;
    @Autowired private CartRepository cartRepository;

    private final ObjectMapper objectMapper = new ObjectMapper();

    private static final String PRODUCT_CODE = "EPAYTEST";
    private static final String SECRET_KEY = "8gBm/:&EnhH.1/q";

    // ==========================================
    // CHECKOUT
    // ==========================================
    @GetMapping("/user/payment/checkoutCart")
    @Transactional
    public String checkoutFromCart(@RequestParam("totalAmount") double totalAmount,
                                   Principal principal,
                                   Model model) {

        String uuid = UUID.randomUUID().toString();
        UserDetails user = userDetailsService.getUserByUsername(principal.getName());
        List<CartItem> items = cartRepository.findByUser(user);

        for (CartItem item : items) {
            switch (item.getItemType().toUpperCase()) {
                case "GUIDE":
                    GuideBooking gb = new GuideBooking();
                    gb.setUser(user);
                    gb.setGuide(guideService.getGuideById(item.getItemId().intValue()));
                    gb.setAmount(item.getTotalAmount());
                    gb.setBookingDate(LocalDate.now());
                    gb.setStatus("PENDING");
                    gb.setTransactionUuid(uuid);
                    bookingService.saveGuideBooking(gb);
                    break;

                case "HOTEL":
                    HotelBooking hb = new HotelBooking();
                    hb.setUser(user);
                 // Change getHotelsById -> getHotelById
                    hb.setHotels(hotelService.getHotelById(item.getItemId().intValue()));
                    hb.setTotalAmount(item.getTotalAmount());
                    hb.setCheckInDate(item.getStartDate());
                    hb.setCheckOutDate(item.getEndDate());
                    hb.setStatus("PENDING");
                    hb.setTransactionUuid(uuid);
                    bookingService.saveHotelBooking(hb);
                    break;

                case "ADVENTURE":
                    AdventureBooking ab = new AdventureBooking();
                    ab.setUser(user);
                    ab.setAdventure(adventureService.getAdventureById(item.getItemId()));
                    ab.setAmount(item.getTotalAmount());
                    ab.setPersons(1);
                    ab.setBookingDate(LocalDate.now());
                    ab.setStatus("PENDING");
                    ab.setTransactionUuid(uuid);
                    bookingService.saveAdventureBooking(ab);
                    break;
            }
        }

        return preparePayment(model, totalAmount, uuid);
    }

    // ==========================================
    // SUCCESS HANDLER
    // ==========================================
    @GetMapping("/payment-success")
    @Transactional
    public String paymentSuccess(@RequestParam(value = "data", required = false) String data,
                                 @RequestParam(value = "signature", required = false) String signature,
                                 Principal principal,
                                 Model model) {
        try {
            if (data == null) return "redirect:/payment-failure";

            String decoded = new String(Base64.getDecoder().decode(data), StandardCharsets.UTF_8);
            JsonNode json = objectMapper.readTree(decoded);

            String uuid = json.get("transaction_uuid").asText();
            String status = json.get("status").asText();
            String totalAmount = json.get("total_amount").asText();

            // eSewa usually returns 'COMPLETE'
            if ("COMPLETE".equalsIgnoreCase(status) || "SUCCESS".equalsIgnoreCase(status)) {
                
                bookingService.updateStatusByUuid(uuid, "PAID");

                if (principal != null) {
                    UserDetails user = userDetailsService.getUserByUsername(principal.getName());
                    cartRepository.deleteByUser(user);
                }

                processAllEmails(uuid);
            }

            model.addAttribute("transactionId", json.get("transaction_code").asText());
            model.addAttribute("amount", totalAmount);

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/payment-failure";
        }

        return "paymentsuccess";
    }

    @GetMapping("/payment-failure")
    public String paymentFailure() {
        return "paymentfaliure";
    }

    // ==========================================
    // PREPARE E-SEWA DATA
    // ==========================================
    private String preparePayment(Model model, double amount, String uuid) {
        String amt = String.valueOf((long) amount);

        PaymentDTO payment = new PaymentDTO();
        payment.setAmount(Double.parseDouble(amt));
        payment.setTotal_amount(Double.parseDouble(amt));
        payment.setTransaction_uuid(uuid);
        payment.setProduct_code(PRODUCT_CODE);
        payment.setSuccess_url("http://localhost:9090/payment-success");
        payment.setFailure_url("http://localhost:9090/payment-failure");
        payment.setSigned_field_names("total_amount,transaction_uuid,product_code");

        // Format string for signature (no spaces after commas)
        String data = "total_amount=" + amt + ",transaction_uuid=" + uuid + ",product_code=" + PRODUCT_CODE;
        payment.setSignature(generateSignature(data, SECRET_KEY));

        model.addAttribute("payment", payment);
        model.addAttribute("formattedAmount", amt);

        return "e-sewa";
    }

    private String generateSignature(String data, String secret) {
        try {
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8), "HmacSHA256"));
            return Base64.getEncoder().encodeToString(mac.doFinal(data.getBytes(StandardCharsets.UTF_8)));
        } catch (Exception e) {
            throw new RuntimeException("Signature Generation Failed", e);
        }
    }

    // ==========================================
    // EMAIL LOGIC (FIXED CASTING 🔥)
    // ==========================================
    private void processAllEmails(String uuid) {
        try {
            // 1. Guide Bookings
            List<GuideBooking> gbs = bookingService.findGuideByUuid(uuid);
            if (gbs != null && !gbs.isEmpty()) {
                String email = gbs.get(0).getUser().getEmail();
                emailService.sendSimpleMessage(email, "Booking Confirmed", "Your Guide booking is now PAID.");
            }

            // 2. Hotel Bookings
            List<HotelBooking> hbs = bookingService.findHotelByUuid(uuid);
            if (hbs != null && !hbs.isEmpty()) {
                String email = hbs.get(0).getUser().getEmail();
                emailService.sendSimpleMessage(email, "Booking Confirmed", "Your Hotel booking is now PAID.");
            }

            // 3. Adventure Bookings
            List<AdventureBooking> abs = bookingService.findAdventureByUuid(uuid);
            if (abs != null && !abs.isEmpty()) {
                String email = abs.get(0).getUser().getEmail();
                emailService.sendSimpleMessage(email, "Booking Confirmed", "Your Adventure booking is now PAID.");
            }

        } catch (Exception e) {
            System.err.println("Email processing failed: " + e.getMessage());
        }
    }
}