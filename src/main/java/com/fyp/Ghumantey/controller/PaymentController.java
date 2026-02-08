package com.fyp.Ghumantey.controller;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.UUID;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fyp.Ghumantey.DTO.PaymentDTO;

@Controller
public class PaymentController {

    private static final String PRODUCT_CODE = "EPAYTEST";
    private static final String SECRET_KEY = "8gBm/:&EnhH.1/q";

    // ================= GUIDE =================
    @GetMapping("/book-guide")
    public String bookGuide(Model model) {
        return preparePayment(model, 1500, "Guide Booking");
    }

    // ================= HOTEL =================
    @GetMapping("/book-hotel")
    public String bookHotel(
            @RequestParam double price,
            @RequestParam int nights,
            Model model) {

        double amount = price * nights;
        return preparePayment(model, amount, "Hotel Booking");
    }

    // ================= TRAVEL PACKAGE =================
    @GetMapping("/book-package")
    public String bookPackage(
            @RequestParam double price,
            @RequestParam int people,
            Model model) {

        double amount = price * people;
        return preparePayment(model, amount, "Travel Package");
    }

    // ================= COMMON PAYMENT =================
    private String preparePayment(Model model, double amount, String bookingType) {

        PaymentDTO payment = new PaymentDTO();
        payment.setAmount(amount);
        payment.setTax_amount(0);
        payment.setPsc(0);
        payment.setPdc(0);
        payment.setTotal_amount(amount);

        payment.setTransaction_uuid(UUID.randomUUID().toString());
        payment.setProduct_code(PRODUCT_CODE);

        payment.setSuccess_url("http://localhost:8080/Ghumantey/payment-success");
        payment.setFailure_url("http://localhost:8080/Ghumantey/payment-failure");

        payment.setSigned_field_names("total_amount,transaction_uuid,product_code");

        String data =
                "total_amount=" + payment.getTotal_amount() +
                ",transaction_uuid=" + payment.getTransaction_uuid() +
                ",product_code=" + payment.getProduct_code();

        payment.setSignature(generateSignature(data, SECRET_KEY));

        model.addAttribute("payment", payment);
        model.addAttribute("bookingType", bookingType);

        return "e-sewa";
    }

    private String generateSignature(String data, String secret) {
        try {
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8), "HmacSHA256"));
            return Base64.getEncoder().encodeToString(mac.doFinal(data.getBytes(StandardCharsets.UTF_8)));
        } catch (Exception e) {
            throw new RuntimeException("Signature generation failed", e);
        }
    }
}
