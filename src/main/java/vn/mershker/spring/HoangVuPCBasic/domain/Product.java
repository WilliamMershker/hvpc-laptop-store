package vn.mershker.spring.HoangVuPCBasic.domain;

import jakarta.persistence.*;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.math.BigDecimal;

@Entity
@Table(name = "products")
public class Product
{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    // ==========================================
    // NAME
    // ==========================================

    @NotBlank(
            message = "Tên sản phẩm không được để trống"
    )
    @Size(
            min = 2,
            max = 200,
            message = "Tên sản phẩm phải từ 2 đến 200 ký tự"
    )
    @Column(
            nullable = false,
            length = 200
    )
    private String name;


    // ==========================================
    // PRICE
    // ==========================================

    @NotNull(
            message = "Giá sản phẩm không được để trống"
    )
    @DecimalMin(
            value = "0.01",
            message = "Giá sản phẩm phải lớn hơn 0"
    )
    @Column(
            nullable = false,
            precision = 15,
            scale = 2
    )
    private BigDecimal price;


    // ==========================================
    // QUANTITY
    // ==========================================

    @Min(
            value = 0,
            message = "Số lượng không được âm"
    )
    @Column(nullable = false)
    private int quantity;


    // ==========================================
    // MANUFACTURER
    // ==========================================

    @NotBlank(
            message = "Hãng sản xuất không được để trống"
    )
    @Size(
            max = 100,
            message = "Tên hãng tối đa 100 ký tự"
    )
    @Column(
            nullable = false,
            length = 100
    )
    private String manufacturer;


    // ==========================================
    // DESCRIPTION
    // ==========================================

    @Size(
            max = 500,
            message = "Mô tả tối đa 500 ký tự"
    )
    @Column(
            name = "short_description",
            length = 500
    )
    private String shortDescription;


    // ==========================================
    // IMAGE
    // Chỉ lưu tên file
    // ==========================================

    @Column(length = 255)
    private String image;


    public Product()
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


    public String getName()
    {
        return name;
    }


    public void setName(String name)
    {
        this.name = name;
    }


    public BigDecimal getPrice()
    {
        return price;
    }


    public void setPrice(BigDecimal price)
    {
        this.price = price;
    }


    public int getQuantity()
    {
        return quantity;
    }


    public void setQuantity(int quantity)
    {
        this.quantity = quantity;
    }


    public String getManufacturer()
    {
        return manufacturer;
    }


    public void setManufacturer(String manufacturer)
    {
        this.manufacturer = manufacturer;
    }


    public String getShortDescription()
    {
        return shortDescription;
    }


    public void setShortDescription(
            String shortDescription)
    {
        this.shortDescription =
                shortDescription;
    }


    public String getImage()
    {
        return image;
    }


    public void setImage(String image)
    {
        this.image = image;
    }
}