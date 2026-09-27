package vn.mershker.spring.HoangVuPCBasic.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import org.springframework.data.jpa.domain.Specification;

import org.springframework.stereotype.Service;

import vn.mershker.spring.HoangVuPCBasic.domain.Product;
import vn.mershker.spring.HoangVuPCBasic.repository.ProductRepository;
import vn.mershker.spring.HoangVuPCBasic.specification.ProductSpecification;

import java.math.BigDecimal;

import java.util.List;


@Service
public class ProductService
{
    private final ProductRepository productRepository;


    public ProductService(
            ProductRepository productRepository)
    {
        this.productRepository =
                productRepository;
    }


    // ==========================================
    // ADMIN
    // GET ALL PRODUCTS
    // ==========================================

    public List<Product> getAllProducts()
    {
        return productRepository.findAll();
    }


    // ==========================================
    // GET PRODUCT BY ID
    // ==========================================

    public Product getProductById(
            Long id)
    {
        return productRepository
                .findById(id)
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "Không tìm thấy sản phẩm ID = "
                                        + id
                        )
                );
    }


    // ==========================================
    // CREATE PRODUCT
    // ==========================================

    public Product createProduct(
            Product product)
    {
        product.setId(
                null
        );


        return productRepository.save(
                product
        );
    }


    // ==========================================
    // UPDATE PRODUCT
    // ==========================================

    public Product updateProduct(
            Product product)
    {
        if (product.getId() == null)
        {
            throw new IllegalArgumentException(
                    "ID sản phẩm không hợp lệ."
            );
        }


        if (!productRepository.existsById(
                product.getId()
        ))
        {
            throw new IllegalArgumentException(
                    "Không tìm thấy sản phẩm ID = "
                            + product.getId()
            );
        }


        return productRepository.save(
                product
        );
    }


    // ==========================================
    // SAVE PRODUCT
    // ==========================================

    public Product saveProduct(
            Product product)
    {
        return productRepository.save(
                product
        );
    }


    // ==========================================
    // DELETE PRODUCT
    // ==========================================

    public void deleteProduct(
            Long id)
    {
        Product product =
                getProductById(
                        id
                );


        productRepository.delete(
                product
        );


        productRepository.flush();
    }


    // ==========================================
    // COUNT PRODUCTS
    // DASHBOARD
    // ==========================================

    public long countProducts()
    {
        return productRepository.count();
    }


    // ==========================================
    // LẤY TẤT CẢ HÃNG
    // ==========================================

    public List<String> getAllManufacturers()
    {
        return productRepository
                .findDistinctManufacturers();
    }


    // ==========================================
    // CLIENT PRODUCT PAGINATION
    // ==========================================

    public Page<Product> getProducts(

            int page,

            int size,

            String sort)
    {
        Pageable pageable =
                createPageable(
                        page,
                        size,
                        sort
                );


        return productRepository.findAll(
                pageable
        );
    }


    // ==========================================
    // FILTER PRODUCTS
    // ==========================================

    public Page<Product> filterProducts(

            String keyword,

            String manufacturer,

            BigDecimal minPrice,

            BigDecimal maxPrice,

            Integer minQuantity,

            int page,

            int size,

            String sort)
    {
        /*
         * Không dùng Specification.where(null)
         * vì bản Spring hiện tại của m từng
         * gặp warning/type issue.
         */
        Specification<Product> specification =
                (root, query, criteriaBuilder) ->
                        criteriaBuilder.conjunction();


        // ======================================
        // KEYWORD
        // ======================================

        if (keyword != null &&
                !keyword.isBlank())
        {
            specification =
                    specification.and(
                            ProductSpecification
                                    .nameContains(
                                            keyword
                                    )
                    );
        }


        // ======================================
        // MANUFACTURER
        // ======================================

        if (manufacturer != null &&
                !manufacturer.isBlank())
        {
            specification =
                    specification.and(
                            ProductSpecification
                                    .manufacturerEquals(
                                            manufacturer
                                    )
                    );
        }


        // ======================================
        // MIN PRICE
        // ======================================

        if (minPrice != null)
        {
            specification =
                    specification.and(
                            ProductSpecification
                                    .priceGreaterThanOrEqual(
                                            minPrice
                                    )
                    );
        }


        // ======================================
        // MAX PRICE
        // ======================================

        if (maxPrice != null)
        {
            specification =
                    specification.and(
                            ProductSpecification
                                    .priceLessThanOrEqual(
                                            maxPrice
                                    )
                    );
        }


        // ======================================
        // MIN QUANTITY
        // ======================================

        if (minQuantity != null)
        {
            specification =
                    specification.and(
                            ProductSpecification
                                    .quantityGreaterThanOrEqual(
                                            minQuantity
                                    )
                    );
        }


        Pageable pageable =
                createPageable(
                        page,
                        size,
                        sort
                );


        return productRepository.findAll(
                specification,
                pageable
        );
    }


    // ==========================================
    // PAGEABLE + SORT
    // ==========================================

    private Pageable createPageable(

            int page,

            int size,

            String sort)
    {
        /*
         * URL dùng page=1,2,3...
         *
         * Spring Data lại dùng:
         * 0,1,2...
         */
        int safePage =
                Math.max(
                        page,
                        1
                );


        int safeSize =
                Math.max(
                        1,
                        Math.min(
                                size,
                                50
                        )
                );


        Sort sorting =
                buildSort(
                        sort
                );


        return PageRequest.of(
                safePage - 1,
                safeSize,
                sorting
        );
    }


    // ==========================================
    // SORT
    // ==========================================

    private Sort buildSort(
            String sort)
    {
        if (sort == null ||
                sort.isBlank())
        {
            return Sort.by(
                    Sort.Direction.DESC,
                    "id"
            );
        }


        return switch (sort)
        {
            case "priceAsc" ->
                    Sort.by(
                            Sort.Direction.ASC,
                            "price"
                    );


            case "priceDesc" ->
                    Sort.by(
                            Sort.Direction.DESC,
                            "price"
                    );


            case "nameAsc" ->
                    Sort.by(
                            Sort.Direction.ASC,
                            "name"
                    );


            case "nameDesc" ->
                    Sort.by(
                            Sort.Direction.DESC,
                            "name"
                    );


            case "quantityAsc" ->
                    Sort.by(
                            Sort.Direction.ASC,
                            "quantity"
                    );


            case "quantityDesc" ->
                    Sort.by(
                            Sort.Direction.DESC,
                            "quantity"
                    );


            case "oldest" ->
                    Sort.by(
                            Sort.Direction.ASC,
                            "id"
                    );


            case "newest" ->
                    Sort.by(
                            Sort.Direction.DESC,
                            "id"
                    );


            default ->
                    Sort.by(
                            Sort.Direction.DESC,
                            "id"
                    );
        };
    }
}