package vn.mershker.spring.HoangVuPCBasic.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import vn.mershker.spring.HoangVuPCBasic.domain.Order;

import java.math.BigDecimal;
import java.util.List;


public interface OrderRepository
        extends JpaRepository<Order, Long>
{
    // Lịch sử mua hàng của user
    List<Order> findByUserEmailOrderByCreatedAtDesc(
            String email
    );


    // Dashboard
    @Query("""
            SELECT SUM(o.totalPrice)
            FROM Order o
            """)
    BigDecimal sumTotalRevenue();
}