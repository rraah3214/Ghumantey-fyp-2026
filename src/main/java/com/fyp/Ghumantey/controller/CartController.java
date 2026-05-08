package com.fyp.Ghumantey.controller;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fyp.Ghumantey.dao.CartRepository;
import com.fyp.Ghumantey.entity.CartItem;
import com.fyp.Ghumantey.entity.UserDetails;
import com.fyp.Ghumantey.service.UserDetailsService;

@Controller
@RequestMapping("/user/cart")
public class CartController {

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private UserDetailsService userDetailsService;

    @GetMapping({"", "/", "/view"})
    public String viewCart(Authentication auth, Model model) {
        if (auth == null || !auth.isAuthenticated()) {
            return "redirect:/login";
        }

        UserDetails user = userDetailsService.getUserByUsername(auth.getName());
        List<CartItem> cartItems = cartRepository.findByUser(user);

        double grandTotal = cartItems.stream()
                                     .mapToDouble(CartItem::getTotalAmount)
                                     .sum();

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("grandTotal", grandTotal);

        return "cart";
    }

    @PostMapping("/add")
    public String addToCart(@RequestParam Long itemId,
                            @RequestParam String itemName,
                            @RequestParam String itemType,
                            @RequestParam Double price,
                            @RequestParam String startDate,
                            @RequestParam String endDate,
                            Authentication auth) {

        UserDetails user = userDetailsService.getUserByUsername(auth.getName());
        LocalDate start = LocalDate.parse(startDate);
        LocalDate end = LocalDate.parse(endDate);

        long days = ChronoUnit.DAYS.between(start, end) + 1;
        if (days <= 0) {
			days = 1;
		}

        double total = days * price;

        CartItem item = new CartItem(user, itemId, itemName, itemType, price, start, end, (int)days, total);
        cartRepository.save(item);

        return "redirect:/user/cart/view";
    }

    /**
     * FIXED: Matches the form action /user/cart/remove with @RequestParam
     */
    @PostMapping("/remove")
    public String removeItem(@RequestParam("itemId") Long id, RedirectAttributes ra) {
        if (cartRepository.existsById(id)) {
            cartRepository.deleteById(id);
            ra.addFlashAttribute("success", "Item removed from cart.");
        }
        return "redirect:/user/cart/view";
    }

    /**
     * NEW: Update feature to change booking dates
     */
    @PostMapping("/update")
    public String updateItem(@RequestParam("itemId") Long id,
                             @RequestParam("startDate") String startDate,
                             @RequestParam("endDate") String endDate,
                             RedirectAttributes ra) {

        Optional<CartItem> itemOpt = cartRepository.findById(id);
        if (itemOpt.isPresent()) {
            CartItem item = itemOpt.get();
            LocalDate start = LocalDate.parse(startDate);
            LocalDate end = LocalDate.parse(endDate);

            long days = ChronoUnit.DAYS.between(start, end) + 1;
            if (days > 0) {
                item.setStartDate(start);
                item.setEndDate(end);

                item.setTotalAmount(days * item.getPricePerDay());
                cartRepository.save(item);
                ra.addFlashAttribute("success", "Cart updated successfully.");
            }
        }
        return "redirect:/user/cart/view";
    }
}