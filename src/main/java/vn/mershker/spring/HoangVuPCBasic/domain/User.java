package vn.mershker.spring.HoangVuPCBasic.domain;

import jakarta.persistence.*;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

import java.util.HashSet;
import java.util.Set;


@Entity
@Table(
        name = "users",
        uniqueConstraints = {
                @UniqueConstraint(
                        columnNames = "email"
                )
        }
)
public class User
{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    @NotBlank(
            message = "Email không được để trống"
    )
    @Email(
            message = "Email không đúng định dạng"
    )
    @Column(
            nullable = false,
            unique = true,
            length = 150
    )
    private String email;

    @Column(length = 255)
    private String avatar;


    /*
     * Không đặt @NotBlank ở đây.
     *
     * Vì khi ADMIN update User,
     * password để trống nghĩa là giữ mật khẩu cũ.
     */
    @Column(
            nullable = false,
            length = 255
    )
    private String password;


    @NotBlank(
            message = "Họ tên không được để trống"
    )
    @Column(
            name = "full_name",
            nullable = false,
            length = 150
    )
    private String fullName;


    @Column(length = 20)
    private String phone;


    @Column(length = 255)
    private String address;


    // ==========================================
    // USER N - N ROLE
    // ==========================================

    @ManyToMany(
            fetch = FetchType.EAGER
    )
    @JoinTable(
            name = "user_roles",

            joinColumns =
            @JoinColumn(
                    name = "user_id"
            ),

            inverseJoinColumns =
            @JoinColumn(
                    name = "role_id"
            )
    )
    private Set<Role> roles =
            new HashSet<>();


    public User()
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


    public String getEmail()
    {
        return email;
    }


    public void setEmail(String email)
    {
        this.email = email;
    }


    public String getPassword()
    {
        return password;
    }


    public void setPassword(String password)
    {
        this.password = password;
    }


    public String getFullName()
    {
        return fullName;
    }


    public void setFullName(
            String fullName)
    {
        this.fullName = fullName;
    }


    public String getPhone()
    {
        return phone;
    }


    public void setPhone(String phone)
    {
        this.phone = phone;
    }


    public String getAddress()
    {
        return address;
    }


    public void setAddress(String address)
    {
        this.address = address;
    }


    public Set<Role> getRoles()
    {
        return roles;
    }


    public void setRoles(
            Set<Role> roles)
    {
        this.roles = roles;
    }

    public String getAvatar()
    {
        return avatar;
    }

    public void setAvatar(String avatar)
    {
        this.avatar = avatar;
    }
}