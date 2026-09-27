package vn.mershker.spring.HoangVuPCBasic.controller;

import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.*;

import vn.mershker.spring.HoangVuPCBasic.domain.Product;

import vn.mershker.spring.HoangVuPCBasic.service.CartService;
import vn.mershker.spring.HoangVuPCBasic.service.ProductService;

@Controller
@RequestMapping("/cart")
public class CartController
{
    private final CartService cartService;
    private final ProductService productService;

    public CartController(CartService cartService, ProductService productService)
    {
        this.cartService = cartService;
        this.productService = productService;
    }

    @GetMapping
    public String cart(Model model)
    {
        loadCart(model);
        return "client/cart";
    }


    @PostMapping("/add/{productId}")
    public String addProduct(@PathVariable Long productId)
    {
        Product product = productService.getProductById(productId);
        cartService.addProduct(product);
        return "redirect:/cart";
    }

    @PostMapping("/increase/{productId}")
    public String increase(@PathVariable Long productId)
    {
        cartService.increase(productId);
        return "redirect:/cart";
    }

    @PostMapping("/decrease/{productId}")
    public String decrease(@PathVariable Long productId)
    {
        cartService.decrease(productId);
        return "redirect:/cart";
    }


    @PostMapping("/remove/{productId}")
    public String remove(@PathVariable Long productId)
    {
        cartService.remove(productId);
        return "redirect:/cart";
    }


    private void loadCart(Model model)
    {
        model.addAttribute("cartItems", cartService.getItems());
        model.addAttribute("totalPrice", cartService.getTotalPrice()
        );
    }
}