package vn.mershker.spring.HoangVuPCBasic.domain;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "orders")
public class Order
{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // ==========================================
    // N ORDER -> 1 USER
    // ==========================================

    @ManyToOne(fetch = FetchType.LAZY)

    @JoinColumn(name = "user_id", nullable = false)

    private User user;

    @Column(name = "total_price", nullable = false, precision = 15, scale = 2)
    private BigDecimal totalPrice;

    @Column(nullable = false, length = 30)
    private String status;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    // ==========================================
    // 1 ORDER -> N ORDER DETAIL
    // ==========================================

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)

    private List<OrderDetail> orderDetails = new ArrayList<>();

    public Order()
    {

    }

    @PrePersist
    public void prePersist()
    {
        if (createdAt == null)
        {
            createdAt = LocalDateTime.now();
        }

        if (status == null || status.isBlank())
        {
            status = "PENDING";
        }

        if (totalPrice == null)
        {
            totalPrice = BigDecimal.ZERO;
        }
    }

    public void addOrderDetail(OrderDetail orderDetail)
    {
        orderDetails.add(orderDetail);

        orderDetail.setOrder(this);
    }

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public User getUser()
    {
        return user;
    }

    public void setUser(User user)
    {
        this.user = user;
    }

    public BigDecimal getTotalPrice()
    {
        return totalPrice;
    }

    public void setTotalPrice(
            BigDecimal totalPrice)
    {
        this.totalPrice =
                totalPrice;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public LocalDateTime getCreatedAt()
    {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt)
    {
        this.createdAt = createdAt;
    }

    public List<OrderDetail> getOrderDetails()
    {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails)
    {
        this.orderDetails = orderDetails;
    }
}