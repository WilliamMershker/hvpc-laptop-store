package vn.mershker.spring.HoangVuPCBasic.controller;

import org.springframework.data.domain.Page;

import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import vn.mershker.spring.HoangVuPCBasic.domain.Product;
import vn.mershker.spring.HoangVuPCBasic.service.ProductService;

import java.math.BigDecimal;


@Controller
public class HomeController
{
    private final ProductService productService;


    public HomeController(
            ProductService productService)
    {
        this.productService =
                productService;
    }


    // ==========================================
    // HOME
    // ==========================================

    @GetMapping("/")
    public String home(

            @RequestParam(
                    defaultValue = "1"
            )
            int page,

            @RequestParam(
                    defaultValue = "8"
            )
            int size,

            @RequestParam(
                    defaultValue = "newest"
            )
            String sort,

            Model model)
    {
        Page<Product> productPage =
                productService
                        .getProducts(
                                page,
                                size,
                                sort
                        );


        // ======================================
        // PRODUCTS
        // ======================================

        model.addAttribute(
                "products",
                productPage.getContent()
        );


        // ======================================
        // MANUFACTURERS
        // ĐÂY LÀ PHẦN M ĐANG THIẾU
        // ======================================

        model.addAttribute(
                "manufacturers",
                productService
                        .getAllManufacturers()
        );


        // ======================================
        // PAGINATION
        // ======================================

        model.addAttribute(
                "currentPage",
                page
        );


        model.addAttribute(
                "totalPages",
                productPage
                        .getTotalPages()
        );


        model.addAttribute(
                "totalItems",
                productPage
                        .getTotalElements()
        );


        model.addAttribute(
                "pageSize",
                size
        );


        // ======================================
        // SORT
        // ======================================

        model.addAttribute(
                "sort",
                sort
        );


        // ======================================
        // FILTER DEFAULT VALUES
        // ======================================

        model.addAttribute(
                "keyword",
                ""
        );


        model.addAttribute(
                "manufacturer",
                ""
        );


        model.addAttribute(
                "minPrice",
                null
        );


        model.addAttribute(
                "maxPrice",
                null
        );


        model.addAttribute(
                "minQuantity",
                null
        );


        model.addAttribute(
                "searchMode",
                false
        );


        return "client/home";
    }


    // ==========================================
    // PRODUCT DETAIL
    // ==========================================

    @GetMapping("/product/{id}")
    public String productDetail(

            @PathVariable Long id,

            Model model)
    {
        Product product =
                productService
                        .getProductById(
                                id
                        );


        model.addAttribute(
                "product",
                product
        );


        return "client/product-detail";
    }


    // ==========================================
    // SEARCH + FILTER
    // ==========================================

    @GetMapping("/search")
    public String search(

            @RequestParam(
                    required = false
            )
            String keyword,

            @RequestParam(
                    required = false
            )
            String manufacturer,

            @RequestParam(
                    required = false
            )
            BigDecimal minPrice,

            @RequestParam(
                    required = false
            )
            BigDecimal maxPrice,

            @RequestParam(
                    required = false
            )
            Integer minQuantity,

            @RequestParam(
                    defaultValue = "1"
            )
            int page,

            @RequestParam(
                    defaultValue = "8"
            )
            int size,

            @RequestParam(
                    defaultValue = "newest"
            )
            String sort,

            Model model)
    {
        Page<Product> productPage =
                productService
                        .filterProducts(
                                keyword,
                                manufacturer,
                                minPrice,
                                maxPrice,
                                minQuantity,
                                page,
                                size,
                                sort
                        );


        // ======================================
        // PRODUCTS
        // ======================================

        model.addAttribute(
                "products",
                productPage
                        .getContent()
        );


        // ======================================
        // MANUFACTURERS
        //
        // CỰC KỲ QUAN TRỌNG:
        // /search CŨNG PHẢI LOAD LẠI HÃNG
        // ======================================

        model.addAttribute(
                "manufacturers",
                productService
                        .getAllManufacturers()
        );


        // ======================================
        // FILTER VALUES
        // ======================================

        model.addAttribute(
                "keyword",
                keyword
        );


        model.addAttribute(
                "manufacturer",
                manufacturer
        );


        model.addAttribute(
                "minPrice",
                minPrice
        );


        model.addAttribute(
                "maxPrice",
                maxPrice
        );


        model.addAttribute(
                "minQuantity",
                minQuantity
        );


        // ======================================
        // PAGINATION
        // ======================================

        model.addAttribute(
                "currentPage",
                page
        );


        model.addAttribute(
                "totalPages",
                productPage
                        .getTotalPages()
        );


        model.addAttribute(
                "totalItems",
                productPage
                        .getTotalElements()
        );


        model.addAttribute(
                "pageSize",
                size
        );


        // ======================================
        // SORT
        // ======================================

        model.addAttribute(
                "sort",
                sort
        );


        model.addAttribute(
                "searchMode",
                true
        );


        return "client/home";
    }
}