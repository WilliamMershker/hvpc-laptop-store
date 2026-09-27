package vn.mershker.spring.HoangVuPCBasic.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import vn.mershker.spring.HoangVuPCBasic.validator.PasswordMatches;


@PasswordMatches
public class RegisterDTO
{
    @NotBlank(
            message = "Họ tên không được để trống"
    )
    @Size(
            min = 2,
            max = 150,
            message = "Họ tên phải từ 2 đến 150 ký tự"
    )
    private String fullName;


    @NotBlank(
            message = "Email không được để trống"
    )
    @Email(
            message = "Email không đúng định dạng"
    )
    private String email;


    @NotBlank(
            message = "Mật khẩu không được để trống"
    )
    @Size(
            min = 6,
            max = 100,
            message = "Mật khẩu phải có ít nhất 6 ký tự"
    )
    private String password;


    @NotBlank(
            message = "Vui lòng xác nhận mật khẩu"
    )
    private String confirmPassword;


    @Size(
            max = 20,
            message = "Số điện thoại tối đa 20 ký tự"
    )
    private String phone;


    @Size(
            max = 255,
            message = "Địa chỉ tối đa 255 ký tự"
    )
    private String address;


    public RegisterDTO()
    {

    }

    public String getFullName()
    {
        return fullName;
    }


    public void setFullName(String fullName)
    {
        this.fullName = fullName;
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


    public String getConfirmPassword()
    {
        return confirmPassword;
    }


    public void setConfirmPassword(
            String confirmPassword)
    {
        this.confirmPassword =
                confirmPassword;
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
}