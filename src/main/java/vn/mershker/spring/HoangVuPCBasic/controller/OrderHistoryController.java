package vn.mershker.spring.HoangVuPCBasic.controller;

import org.springframework.security.core.Authentication;

import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;

import vn.mershker.spring.HoangVuPCBasic.service.OrderService;


@Controller
public class OrderHistoryController
{
    private final OrderService orderService;


    public OrderHistoryController(
            OrderService orderService)
    {
        this.orderService =
                orderService;
    }


    // ==========================================
    // USER ORDER HISTORY
    // ==========================================

    @GetMapping("/orders")
    public String orderHistory(

            Authentication authentication,

            Model model)
    {
        model.addAttribute(
                "orders",

                orderService
                        .getOrdersByUserEmail(
                                authentication.getName()
                        )
        );


        return "client/order-history";
    }
}