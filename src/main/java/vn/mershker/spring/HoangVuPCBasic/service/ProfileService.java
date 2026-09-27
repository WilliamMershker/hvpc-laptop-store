package vn.mershker.spring.HoangVuPCBasic.service;

import jakarta.transaction.Transactional;

import org.springframework.stereotype.Service;

import vn.mershker.spring.HoangVuPCBasic.domain.User;
import vn.mershker.spring.HoangVuPCBasic.repository.UserRepository;


@Service
public class ProfileService
{
    private final UserRepository userRepository;


    public ProfileService(
            UserRepository userRepository)
    {
        this.userRepository =
                userRepository;
    }


    public User getUserByEmail(
            String email)
    {
        return userRepository
                .findByEmail(email)
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "Không tìm thấy tài khoản."
                        )
                );
    }


    // ==========================================
    // UPDATE THÔNG TIN CÁ NHÂN
    // ==========================================

    @Transactional
    public void updateProfile(

            String email,

            String fullName,

            String phone,

            String address)
    {
        if (fullName == null ||
                fullName.isBlank())
        {
            throw new IllegalArgumentException(
                    "Họ tên không được để trống."
            );
        }


        User user =
                getUserByEmail(
                        email
                );


        user.setFullName(
                fullName.trim()
        );


        user.setPhone(
                phone == null
                        ? ""
                        : phone.trim()
        );


        user.setAddress(
                address == null
                        ? ""
                        : address.trim()
        );


        userRepository.save(
                user
        );
    }


    // ==========================================
    // UPDATE AVATAR FILENAME
    // ==========================================

    @Transactional
    public void updateAvatar(

            String email,

            String filename)
    {
        User user =
                getUserByEmail(
                        email
                );


        user.setAvatar(
                filename
        );


        userRepository.save(
                user
        );
    }
}