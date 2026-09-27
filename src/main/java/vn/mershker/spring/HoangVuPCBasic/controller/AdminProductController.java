package vn.mershker.spring.HoangVuPCBasic.controller;

import jakarta.validation.Valid;

import org.springframework.dao.DataIntegrityViolationException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.validation.BindingResult;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.multipart.MultipartFile;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.mershker.spring.HoangVuPCBasic.domain.Product;
import vn.mershker.spring.HoangVuPCBasic.service.ProductService;

import java.io.IOException;
import java.io.InputStream;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import java.util.Locale;
import java.util.Set;
import java.util.UUID;


@Controller
@RequestMapping("/admin/product")
public class AdminProductController
{
    private final ProductService productService;


    private static final Set<String> ALLOWED_IMAGE_TYPES =
            Set.of(
                    "image/jpeg",
                    "image/png",
                    "image/webp"
            );


    private final Path productUploadDirectory =
            Paths.get(
                            "uploads",
                            "products"
                    )
                    .toAbsolutePath()
                    .normalize();


    public AdminProductController(
            ProductService productService)
    {
        this.productService =
                productService;


        try
        {
            Files.createDirectories(
                    productUploadDirectory
            );
        }
        catch (IOException e)
        {
            throw new IllegalStateException(
                    "Không thể tạo thư mục upload sản phẩm.",
                    e
            );
        }
    }


    // ==========================================
    // LIST
    // ==========================================

    @GetMapping
    public String showProducts(
            Model model)
    {
        model.addAttribute(
                "products",
                productService.getAllProducts()
        );


        return "admin/product/show";
    }


    // ==========================================
    // CREATE PAGE
    // ==========================================

    @GetMapping("/create")
    public String showCreatePage(
            Model model)
    {
        model.addAttribute(
                "product",
                new Product()
        );


        return "admin/product/create";
    }


    // ==========================================
    // CREATE PRODUCT
    // ==========================================

    @PostMapping("/create")
    public String createProduct(

            @Valid
            @ModelAttribute("product")
            Product product,

            BindingResult bindingResult,

            @RequestParam(
                    value = "imageFile",
                    required = false
            )
            MultipartFile imageFile,

            Model model,

            RedirectAttributes redirectAttributes)
    {
        if (bindingResult.hasErrors())
        {
            return "admin/product/create";
        }


        try
        {
            product.setId(
                    null
            );


            // Nếu Admin có chọn ảnh
            if (imageFile != null &&
                    !imageFile.isEmpty())
            {
                String filename =
                        saveProductImage(
                                imageFile
                        );


                product.setImage(
                        filename
                );
            }


            productService.saveProduct(
                    product
            );


            redirectAttributes
                    .addFlashAttribute(
                            "success",
                            "Thêm sản phẩm thành công."
                    );


            return "redirect:/admin/product";
        }
        catch (IllegalArgumentException |
               IllegalStateException e)
        {
            model.addAttribute(
                    "imageError",
                    e.getMessage()
            );


            return "admin/product/create";
        }
    }


    // ==========================================
    // UPDATE PAGE
    // ==========================================

    @GetMapping("/update/{id}")
    public String showUpdatePage(

            @PathVariable Long id,

            Model model,

            RedirectAttributes redirectAttributes)
    {
        try
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


            return "admin/product/update";
        }
        catch (IllegalArgumentException e)
        {
            redirectAttributes
                    .addFlashAttribute(
                            "error",
                            e.getMessage()
                    );


            return "redirect:/admin/product";
        }
    }


    // ==========================================
    // UPDATE PRODUCT
    // ==========================================

    @PostMapping("/update/{id}")
    public String updateProduct(

            @PathVariable Long id,

            @Valid
            @ModelAttribute("product")
            Product product,

            BindingResult bindingResult,

            @RequestParam(
                    value = "imageFile",
                    required = false
            )
            MultipartFile imageFile,

            Model model,

            RedirectAttributes redirectAttributes)
    {
        Product oldProduct;


        try
        {
            oldProduct =
                    productService
                            .getProductById(
                                    id
                            );
        }
        catch (IllegalArgumentException e)
        {
            redirectAttributes
                    .addFlashAttribute(
                            "error",
                            e.getMessage()
                    );


            return "redirect:/admin/product";
        }


        if (bindingResult.hasErrors())
        {
            product.setId(
                    id
            );


            product.setImage(
                    oldProduct.getImage()
            );


            return "admin/product/update";
        }


        String oldImage =
                oldProduct.getImage();


        String newImage =
                null;


        try
        {
            oldProduct.setName(
                    product.getName()
            );


            oldProduct.setPrice(
                    product.getPrice()
            );


            oldProduct.setQuantity(
                    product.getQuantity()
            );


            oldProduct.setManufacturer(
                    product.getManufacturer()
            );


            oldProduct.setShortDescription(
                    product.getShortDescription()
            );


            // Nếu Admin chọn ảnh mới
            if (imageFile != null &&
                    !imageFile.isEmpty())
            {
                newImage =
                        saveProductImage(
                                imageFile
                        );


                oldProduct.setImage(
                        newImage
                );
            }


            productService.saveProduct(
                    oldProduct
            );


            // DB save thành công rồi mới xóa ảnh cũ
            if (newImage != null)
            {
                deleteProductImage(
                        oldImage
                );
            }


            redirectAttributes
                    .addFlashAttribute(
                            "success",
                            "Cập nhật sản phẩm thành công."
                    );


            return "redirect:/admin/product";
        }
        catch (IllegalArgumentException |
               IllegalStateException e)
        {
            // Nếu vừa lưu file mới nhưng DB fail
            if (newImage != null)
            {
                deleteProductImage(
                        newImage
                );
            }


            product.setId(
                    id
            );


            product.setImage(
                    oldImage
            );


            model.addAttribute(
                    "imageError",
                    e.getMessage()
            );


            return "admin/product/update";
        }
    }


    // ==========================================
    // DELETE PRODUCT
    // ==========================================

    @PostMapping("/delete/{id}")
    public String deleteProduct(

            @PathVariable Long id,

            RedirectAttributes redirectAttributes)
    {
        try
        {
            Product product =
                    productService
                            .getProductById(
                                    id
                            );


            String image =
                    product.getImage();


            /*
             * Xóa DB trước.
             *
             * Nếu FK order_details còn giữ Product
             * thì delete sẽ fail và ảnh vẫn được giữ.
             */
            productService.deleteProduct(
                    id
            );


            deleteProductImage(
                    image
            );


            redirectAttributes
                    .addFlashAttribute(
                            "success",
                            "Xóa sản phẩm thành công."
                    );
        }
        catch (DataIntegrityViolationException e)
        {
            redirectAttributes
                    .addFlashAttribute(
                            "error",
                            "Không thể xóa sản phẩm vì sản phẩm đã tồn tại trong đơn hàng."
                    );
        }
        catch (IllegalArgumentException e)
        {
            redirectAttributes
                    .addFlashAttribute(
                            "error",
                            e.getMessage()
                    );
        }


        return "redirect:/admin/product";
    }


    // ==========================================
    // SAVE PRODUCT IMAGE
    // ==========================================

    private String saveProductImage(
            MultipartFile imageFile)
    {
        String contentType =
                imageFile.getContentType();


        if (contentType == null ||
                !ALLOWED_IMAGE_TYPES.contains(
                        contentType.toLowerCase(
                                Locale.ROOT
                        )
                ))
        {
            throw new IllegalArgumentException(
                    "Chỉ chấp nhận ảnh JPG, PNG hoặc WEBP."
            );
        }


        String originalFilename =
                imageFile.getOriginalFilename();


        String extension =
                getExtension(
                        originalFilename
                );


        String filename =
                UUID.randomUUID()
                        + extension;


        Path target =
                productUploadDirectory
                        .resolve(
                                filename
                        )
                        .normalize();


        if (!target.startsWith(
                productUploadDirectory
        ))
        {
            throw new IllegalArgumentException(
                    "Tên file ảnh không hợp lệ."
            );
        }


        try (InputStream inputStream =
                     imageFile.getInputStream())
        {
            Files.copy(
                    inputStream,
                    target,
                    StandardCopyOption.REPLACE_EXISTING
            );
        }
        catch (IOException e)
        {
            throw new IllegalStateException(
                    "Không thể lưu ảnh sản phẩm.",
                    e
            );
        }


        return filename;
    }


    // ==========================================
    // DELETE PRODUCT IMAGE
    // ==========================================

    private void deleteProductImage(
            String filename)
    {
        if (filename == null ||
                filename.isBlank())
        {
            return;
        }


        try
        {
            Path file =
                    productUploadDirectory
                            .resolve(
                                    filename
                            )
                            .normalize();


            if (!file.startsWith(
                    productUploadDirectory
            ))
            {
                return;
            }


            Files.deleteIfExists(
                    file
            );
        }
        catch (IOException ignored)
        {
        }
    }


    // ==========================================
    // GET EXTENSION
    // ==========================================

    private String getExtension(
            String filename)
    {
        if (filename == null ||
                !filename.contains("."))
        {
            return ".jpg";
        }


        String extension =
                filename.substring(
                                filename.lastIndexOf(".")
                        )
                        .toLowerCase(
                                Locale.ROOT
                        );


        if (extension.equals(".jpeg"))
        {
            return ".jpg";
        }


        if (!extension.equals(".jpg") &&
                !extension.equals(".png") &&
                !extension.equals(".webp"))
        {
            return ".jpg";
        }


        return extension;
    }
}