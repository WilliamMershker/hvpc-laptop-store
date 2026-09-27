package vn.mershker.spring.HoangVuPCBasic.domain;

import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
@Table(name = "order_details")
public class OrderDetail
{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // ==========================================
    // N ORDER DETAIL -> 1 ORDER
    // ==========================================

    @ManyToOne(fetch = FetchType.LAZY)

    @JoinColumn(name = "order_id", nullable = false)

    private Order order;


    // ==========================================
    // N ORDER DETAIL -> 1 PRODUCT
    // ==========================================

    @ManyToOne(fetch = FetchType.LAZY)

    @JoinColumn(name = "product_id", nullable = false)

    private Product product;

    @Column(nullable = false)
    private int quantity;

    /*
        Đây là giá tại thời điểm đặt hàng.

        Không lấy trực tiếp Product.price sau này,
        vì Product có thể thay đổi giá.
     */

    @Column(nullable = false, precision = 15, scale = 2)
    private BigDecimal price;

    public OrderDetail()
    {

    }

    public Long getId()
    {
        return id;
    }


    public void setId(Long id)
    {
        this.id = id;
    }


    public Order getOrder()
    {
        return order;
    }


    public void setOrder(Order order)
    {
        this.order = order;
    }


    public Product getProduct()
    {
        return product;
    }


    public void setProduct(Product product)
    {
        this.product = product;
    }


    public int getQuantity()
    {
        return quantity;
    }


    public void setQuantity(int quantity)
    {
        this.quantity = quantity;
    }


    public BigDecimal getPrice()
    {
        return price;
    }

    public void setPrice(BigDecimal price)
    {
        this.price = price;
    }
}