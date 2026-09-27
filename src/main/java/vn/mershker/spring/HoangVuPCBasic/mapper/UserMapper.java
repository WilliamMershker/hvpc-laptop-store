package vn.mershker.spring.HoangVuPCBasic.mapper;

import org.springframework.stereotype.Component;

import vn.mershker.spring.HoangVuPCBasic.domain.User;
import vn.mershker.spring.HoangVuPCBasic.dto.RegisterDTO;


@Component
public class UserMapper
{
    public User toUser(
            RegisterDTO dto)
    {
        User user =
                new User();


        user.setFullName(
                dto.getFullName()
        );


        user.setEmail(
                dto.getEmail()
        );


        /*
         * Mapper KHÔNG encode password.
         *
         * Encode để UserService xử lý.
         */
        user.setPassword(
                dto.getPassword()
        );


        user.setPhone(
                dto.getPhone()
        );


        user.setAddress(
                dto.getAddress()
        );


        return user;
    }
}