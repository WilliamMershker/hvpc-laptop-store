package vn.mershker.spring.HoangVuPCBasic.controller;

import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;

import vn.mershker.spring.HoangVuPCBasic.repository.ProductRepository;
import vn.mershker.spring.HoangVuPCBasic.repository.UserRepository;

import vn.mershker.spring.HoangVuPCBasic.service.OrderService;


@Controller
public class DashboardController
{
    private final ProductRepository productRepository;

    private final UserRepository userRepository;

    private final OrderService orderService;


    public DashboardController(
            ProductRepository productRepository,
            UserRepository userRepository,
            OrderService orderService)
    {
        this.productRepository =
                productRepository;

        this.userRepository =
                userRepository;

        this.orderService =
                orderService;
    }


    @GetMapping("/admin/dashboard")
    public String dashboard(
            Model model)
    {
        model.addAttribute(
                "productCount",
                productRepository.count()
        );


        model.addAttribute(
                "userCount",
                userRepository.count()
        );


        model.addAttribute(
                "orderCount",
                orderService.countOrders()
        );


        model.addAttribute(
                "revenue",
                orderService.getTotalRevenue()
        );


        return "admin/dashboard";
    }
}