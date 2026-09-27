package vn.mershker.spring.HoangVuPCBasic.service;

import jakarta.transaction.Transactional;

import org.springframework.stereotype.Service;

import vn.mershker.spring.HoangVuPCBasic.domain.Order;
import vn.mershker.spring.HoangVuPCBasic.domain.OrderDetail;
import vn.mershker.spring.HoangVuPCBasic.domain.Product;
import vn.mershker.spring.HoangVuPCBasic.domain.User;

import vn.mershker.spring.HoangVuPCBasic.dto.CartItem;

import vn.mershker.spring.HoangVuPCBasic.repository.OrderDetailRepository;
import vn.mershker.spring.HoangVuPCBasic.repository.OrderRepository;
import vn.mershker.spring.HoangVuPCBasic.repository.ProductRepository;
import vn.mershker.spring.HoangVuPCBasic.repository.UserRepository;

import java.math.BigDecimal;

import java.util.List;
import java.util.Set;


@Service
public class OrderService
{
    private final OrderRepository orderRepository;

    private final OrderDetailRepository orderDetailRepository;

    private final ProductRepository productRepository;

    private final UserRepository userRepository;


    private static final Set<String> VALID_STATUSES =
            Set.of(
                    "PENDING",
                    "CONFIRMED",
                    "SHIPPING",
                    "COMPLETED",
                    "CANCELLED"
            );


    public OrderService(
            OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository,
            ProductRepository productRepository,
            UserRepository userRepository)
    {
        this.orderRepository =
                orderRepository;

        this.orderDetailRepository =
                orderDetailRepository;

        this.productRepository =
                productRepository;

        this.userRepository =
                userRepository;
    }


    // ==========================================
    // PLACE ORDER
    // ==========================================

    @Transactional
    public Order placeOrder(

            String email,

            List<CartItem> cartItems)
    {
        if (cartItems == null ||
                cartItems.isEmpty())
        {
            throw new IllegalStateException(
                    "Giỏ hàng đang trống."
            );
        }


        User user =
                userRepository
                        .findByEmail(email)
                        .orElseThrow(() ->
                                new IllegalStateException(
                                        "Không tìm thấy tài khoản."
                                )
                        );


        BigDecimal totalPrice =
                BigDecimal.ZERO;


        // ======================================
        // KIỂM TRA TỒN KHO
        // ======================================

        for (CartItem item : cartItems)
        {
            Product product =
                    productRepository
                            .findById(
                                    item.getProduct().getId()
                            )
                            .orElseThrow(() ->
                                    new IllegalStateException(
                                            "Sản phẩm không tồn tại."
                                    )
                            );


            if (item.getQuantity() <= 0)
            {
                throw new IllegalStateException(
                        "Số lượng sản phẩm không hợp lệ."
                );
            }


            if (product.getQuantity()
                    < item.getQuantity())
            {
                throw new IllegalStateException(
                        "Sản phẩm "
                                + product.getName()
                                + " không đủ hàng."
                );
            }


            BigDecimal subtotal =
                    product
                            .getPrice()
                            .multiply(
                                    BigDecimal.valueOf(
                                            item.getQuantity()
                                    )
                            );


            totalPrice =
                    totalPrice.add(
                            subtotal
                    );
        }


        // ======================================
        // TẠO ORDER
        // ======================================

        Order order =
                new Order();


        order.setUser(
                user
        );


        order.setTotalPrice(
                totalPrice
        );


        order.setStatus(
                "PENDING"
        );


        Order savedOrder =
                orderRepository.save(
                        order
                );


        // ======================================
        // ORDER DETAIL
        // + TRỪ STOCK
        // ======================================

        for (CartItem item : cartItems)
        {
            Product product =
                    productRepository
                            .findById(
                                    item.getProduct().getId()
                            )
                            .orElseThrow(() ->
                                    new IllegalStateException(
                                            "Sản phẩm không tồn tại."
                                    )
                            );


            // Trừ tồn kho
            product.setQuantity(
                    product.getQuantity()
                            - item.getQuantity()
            );


            productRepository.save(
                    product
            );


            // Tạo OrderDetail
            OrderDetail detail =
                    new OrderDetail();


            detail.setOrder(
                    savedOrder
            );


            detail.setProduct(
                    product
            );


            detail.setQuantity(
                    item.getQuantity()
            );


            /*
             * Lưu giá tại thời điểm đặt hàng.
             *
             * Sau này Product đổi giá thì
             * đơn cũ vẫn giữ giá cũ.
             */
            detail.setPrice(
                    product.getPrice()
            );


            orderDetailRepository.save(
                    detail
            );
        }


        return savedOrder;
    }


    // ==========================================
    // ADMIN
    // GET ALL ORDERS
    // ==========================================

    public List<Order> getAllOrders()
    {
        return orderRepository.findAll();
    }


    // ==========================================
    // GET ORDER BY ID
    // ==========================================

    public Order getOrderById(
            Long id)
    {
        return orderRepository
                .findById(id)
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "Không tìm thấy đơn hàng ID = "
                                        + id
                        )
                );
    }


    // ==========================================
    // GET ORDER DETAILS
    // ==========================================

    public List<OrderDetail> getOrderDetails(
            Long orderId)
    {
        /*
         * Kiểm tra Order tồn tại trước.
         */
        getOrderById(
                orderId
        );


        return orderDetailRepository
                .findByOrderId(
                        orderId
                );
    }


    // ==========================================
    // USER ORDER HISTORY
    // ==========================================

    public List<Order> getOrdersByUserEmail(
            String email)
    {
        return orderRepository
                .findByUserEmailOrderByCreatedAtDesc(
                        email
                );
    }


    // ==========================================
    // ADMIN
    // UPDATE ORDER STATUS
    // ==========================================

    @Transactional
    public void updateOrderStatus(

            Long orderId,

            String status)
    {
        if (status == null ||
                status.isBlank())
        {
            throw new IllegalArgumentException(
                    "Trạng thái đơn hàng không hợp lệ."
            );
        }


        String normalizedStatus =
                status
                        .trim()
                        .toUpperCase();


        if (!VALID_STATUSES.contains(
                normalizedStatus
        ))
        {
            throw new IllegalArgumentException(
                    "Trạng thái đơn hàng không hợp lệ."
            );
        }


        Order order =
                getOrderById(
                        orderId
                );


        order.setStatus(
                normalizedStatus
        );


        orderRepository.save(
                order
        );
    }


    // ==========================================
    // ADMIN
    // DELETE ORDER HISTORY
    // ==========================================

    @Transactional
    public void deleteOrder(
            Long orderId)
    {
        /*
         * Kiểm tra Order tồn tại.
         */
        Order order =
                getOrderById(
                        orderId
                );


        /*
         * QUAN TRỌNG:
         *
         * order_details.order_id
         * đang giữ FOREIGN KEY tới orders.id
         *
         * Vì vậy:
         *
         * OrderDetail phải xóa trước.
         */
        orderDetailRepository
                .deleteByOrderId(
                        orderId
                );


        /*
         * Ép Hibernate chạy DELETE
         * OrderDetail xuống DB ngay.
         */
        orderDetailRepository.flush();


        /*
         * Sau khi OrderDetail đã hết,
         * mới xóa Order.
         */
        orderRepository.delete(
                order
        );


        orderRepository.flush();


        /*
         * KHÔNG:
         *
         * - xóa Product
         * - xóa User
         * - cộng lại quantity
         *
         * Đây là chức năng ADMIN
         * xóa lịch sử DB.
         */
    }


    // ==========================================
    // DASHBOARD
    // COUNT ORDERS
    // ==========================================

    public long countOrders()
    {
        return orderRepository.count();
    }


    // ==========================================
    // DASHBOARD
    // TOTAL REVENUE
    // ==========================================

    public BigDecimal getTotalRevenue()
    {
        BigDecimal revenue =
                orderRepository
                        .sumTotalRevenue();


        if (revenue == null)
        {
            return BigDecimal.ZERO;
        }


        return revenue;
    }
}