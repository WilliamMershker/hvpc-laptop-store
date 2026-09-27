package vn.mershker.spring.HoangVuPCBasic.controller;

import org.springframework.security.core.Authentication;

import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import vn.mershker.spring.HoangVuPCBasic.domain.Order;
import vn.mershker.spring.HoangVuPCBasic.domain.User;

import vn.mershker.spring.HoangVuPCBasic.service.CartService;
import vn.mershker.spring.HoangVuPCBasic.service.OrderService;
import vn.mershker.spring.HoangVuPCBasic.service.UserService;


@Controller
public class CheckoutController
{
    private final CartService cartService;

    private final OrderService orderService;

    private final UserService userService;


    public CheckoutController(CartService cartService, OrderService orderService, UserService userService)
    {
        this.cartService = cartService;
        this.orderService = orderService;
        this.userService = userService;
    }

    // ==========================================
    // CHECKOUT PAGE
    // ==========================================

    @GetMapping("/checkout")
    public String checkoutPage(

            Authentication authentication,

            Model model)
    {
        if (cartService.isEmpty())
        {
            return "redirect:/cart";
        }


        User user =
                userService
                        .getUserByEmail(
                                authentication.getName()
                        );


        model.addAttribute(
                "user",
                user
        );


        model.addAttribute(
                "cartItems",
                cartService.getItems()
        );


        model.addAttribute(
                "totalPrice",
                cartService.getTotalPrice()
        );


        return "client/checkout";
    }


    // ==========================================
    // PLACE ORDER
    // ==========================================

    @PostMapping("/checkout")
    public String checkout(

            Authentication authentication,

            Model model)
    {
        if (cartService.isEmpty())
        {
            return "redirect:/cart";
        }


        try
        {
            Order order =
                    orderService.placeOrder(
                            authentication.getName(),
                            cartService.getItems()
                    );


            /*
             * Chỉ clear sau khi order thành công.
             */
            cartService.clear();


            model.addAttribute(
                    "order",
                    order
            );


            return "client/order-success";
        }
        catch (IllegalStateException e)
        {
            model.addAttribute(
                    "error",
                    e.getMessage()
            );


            model.addAttribute(
                    "cartItems",
                    cartService.getItems()
            );


            model.addAttribute(
                    "totalPrice",
                    cartService.getTotalPrice()
            );


            return "client/cart";
        }
    }
}