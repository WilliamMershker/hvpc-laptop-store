package vn.mershker.spring.HoangVuPCBasic.validator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

import vn.mershker.spring.HoangVuPCBasic.dto.RegisterDTO;


public class PasswordMatchesValidator
        implements ConstraintValidator<
        PasswordMatches,
        RegisterDTO>
{
    @Override
    public boolean isValid(
            RegisterDTO dto,
            ConstraintValidatorContext context)
    {
        if (dto == null)
        {
            return true;
        }


        String password =
                dto.getPassword();

        String confirmPassword =
                dto.getConfirmPassword();


        /*
         * @NotBlank xử lý trường hợp null/rỗng.
         */
        if (password == null ||
                confirmPassword == null)
        {
            return true;
        }


        if (password.equals(
                confirmPassword
        ))
        {
            return true;
        }


        /*
         * Đưa lỗi vào field confirmPassword
         * thay vì lỗi chung cả object.
         */
        context
                .disableDefaultConstraintViolation();


        context
                .buildConstraintViolationWithTemplate(
                        "Mật khẩu xác nhận không khớp"
                )
                .addPropertyNode(
                        "confirmPassword"
                )
                .addConstraintViolation();


        return false;
    }
}