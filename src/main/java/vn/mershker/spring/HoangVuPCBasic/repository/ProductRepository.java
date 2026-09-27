package vn.mershker.spring.HoangVuPCBasic.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import vn.mershker.spring.HoangVuPCBasic.domain.Product;

import java.util.List;


public interface ProductRepository
        extends JpaRepository<Product, Long>,
        JpaSpecificationExecutor<Product>
{

    // ==========================================
    // LẤY DANH SÁCH HÃNG KHÔNG TRÙNG
    // ==========================================

    @Query("""
            SELECT DISTINCT p.manufacturer
            FROM Product p
            WHERE p.manufacturer IS NOT NULL
              AND p.manufacturer <> ''
            ORDER BY p.manufacturer ASC
            """)
    List<String> findDistinctManufacturers();
}