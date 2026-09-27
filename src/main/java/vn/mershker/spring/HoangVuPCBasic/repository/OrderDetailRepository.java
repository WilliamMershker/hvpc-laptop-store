package vn.mershker.spring.HoangVuPCBasic.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.mershker.spring.HoangVuPCBasic.domain.OrderDetail;

import java.util.List;


public interface OrderDetailRepository
        extends JpaRepository<OrderDetail, Long>
{
    // ==========================================
    // LẤY CHI TIẾT CỦA MỘT ORDER
    // ==========================================

    List<OrderDetail> findByOrderId(
            Long orderId
    );


    // ==========================================
    // XÓA TẤT CẢ DETAIL CỦA MỘT ORDER
    // ==========================================

    void deleteByOrderId(
            Long orderId
    );
}