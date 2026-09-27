package vn.mershker.spring.HoangVuPCBasic.specification;

import org.springframework.data.jpa.domain.Specification;

import vn.mershker.spring.HoangVuPCBasic.domain.Product;

import java.math.BigDecimal;


public class ProductSpecification
{

    private ProductSpecification()
    {
    }


    // ==========================================
    // TÌM THEO TÊN
    // ==========================================

    public static Specification<Product> nameContains(
            String keyword)
    {
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.like(
                        criteriaBuilder.lower(
                                root.get("name")
                        ),
                        "%"
                                + keyword
                                .trim()
                                .toLowerCase()
                                + "%"
                );
    }


    // ==========================================
    // HÃNG
    // ==========================================

    public static Specification<Product> manufacturerEquals(
            String manufacturer)
    {
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.equal(
                        criteriaBuilder.lower(
                                root.get("manufacturer")
                        ),
                        manufacturer
                                .trim()
                                .toLowerCase()
                );
    }


    // ==========================================
    // GIÁ TỪ
    // ==========================================

    public static Specification<Product> priceGreaterThanOrEqual(
            BigDecimal minPrice)
    {
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.greaterThanOrEqualTo(
                        root.get("price"),
                        minPrice
                );
    }


    // ==========================================
    // GIÁ ĐẾN
    // ==========================================

    public static Specification<Product> priceLessThanOrEqual(
            BigDecimal maxPrice)
    {
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.lessThanOrEqualTo(
                        root.get("price"),
                        maxPrice
                );
    }


    // ==========================================
    // SỐ LƯỢNG TỐI THIỂU
    // ==========================================

    public static Specification<Product> quantityGreaterThanOrEqual(
            Integer minQuantity)
    {
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.greaterThanOrEqualTo(
                        root.get("quantity"),
                        minQuantity
                );
    }
}