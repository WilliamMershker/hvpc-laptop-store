package vn.mershker.spring.HoangVuPCBasic.service;

import jakarta.transaction.Transactional;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import vn.mershker.spring.HoangVuPCBasic.domain.Role;
import vn.mershker.spring.HoangVuPCBasic.domain.User;

import vn.mershker.spring.HoangVuPCBasic.repository.RoleRepository;
import vn.mershker.spring.HoangVuPCBasic.repository.UserRepository;

import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


@Service
public class UserService
{
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, RoleRepository roleRepository, PasswordEncoder passwordEncoder)
    {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
    }

    // ==========================================
    // READ ALL
    // ==========================================

    public List<User> getAllUsers()
    {
        return userRepository.findAll();
    }

    // ==========================================
    // READ BY ID
    // ==========================================

    public User getUserById(
            Long id)
    {
        return userRepository
                .findById(id)
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "Không tìm thấy tài khoản ID = "
                                        + id
                        )
                );
    }


    // ==========================================
    // READ BY EMAIL
    // ==========================================

    public User getUserByEmail(
            String email)
    {
        return userRepository
                .findByEmail(email)
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "Không tìm thấy tài khoản: "
                                        + email
                        )
                );
    }


    // ==========================================
    // CHECK EMAIL
    // ==========================================

    public boolean emailExists(
            String email)
    {
        return userRepository
                .existsByEmail(email);
    }


    // ==========================================
    // GET ROLES
    // ==========================================

    public List<Role> getAllRoles()
    {
        return roleRepository.findAll();
    }


    // ==========================================
    // REGISTER USER THÔNG THƯỜNG
    // ==========================================

    @Transactional
    public void registerUser(
            User user)
    {
        if (userRepository.existsByEmail(
                user.getEmail()
        ))
        {
            throw new IllegalArgumentException(
                    "Email đã được sử dụng."
            );
        }


        if (user.getPassword() == null ||
                user.getPassword().isBlank())
        {
            throw new IllegalArgumentException(
                    "Mật khẩu không được để trống."
            );
        }


        user.setPassword(
                passwordEncoder.encode(
                        user.getPassword()
                )
        );


        Role userRole =
                getRoleByName(
                        "USER"
                );


        user.getRoles().clear();

        user.getRoles().add(
                userRole
        );


        userRepository.save(
                user
        );
    }


    // ==========================================
    // ADMIN CREATE USER
    // ==========================================

    @Transactional
    public void createUserByAdmin(

            User user,

            Collection<String> roleNames)
    {
        if (userRepository.existsByEmail(
                user.getEmail()
        ))
        {
            throw new IllegalArgumentException(
                    "Email đã tồn tại."
            );
        }


        if (user.getPassword() == null ||
                user.getPassword().isBlank())
        {
            throw new IllegalArgumentException(
                    "Mật khẩu không được để trống."
            );
        }


        user.setPassword(
                passwordEncoder.encode(
                        user.getPassword()
                )
        );


        user.setRoles(
                resolveRoles(
                        roleNames
                )
        );


        userRepository.save(
                user
        );
    }


    // ==========================================
    // ADMIN UPDATE USER
    // ==========================================

    @Transactional
    public void updateUserByAdmin(

            Long id,

            User formUser,

            Collection<String> roleNames)
    {
        User existingUser =
                getUserById(id);


        if (userRepository
                .existsByEmailAndIdNot(
                        formUser.getEmail(),
                        id
                ))
        {
            throw new IllegalArgumentException(
                    "Email đã được tài khoản khác sử dụng."
            );
        }


        existingUser.setEmail(
                formUser.getEmail()
        );


        existingUser.setFullName(
                formUser.getFullName()
        );


        existingUser.setPhone(
                formUser.getPhone()
        );


        existingUser.setAddress(
                formUser.getAddress()
        );


        /*
         * Có nhập password mới
         * → encode + đổi.
         *
         * Để trống
         * → giữ password cũ.
         */
        if (formUser.getPassword() != null &&
                !formUser.getPassword().isBlank())
        {
            existingUser.setPassword(
                    passwordEncoder.encode(
                            formUser.getPassword()
                    )
            );
        }


        existingUser.setRoles(
                resolveRoles(
                        roleNames
                )
        );


        userRepository.save(
                existingUser
        );
    }


    // ==========================================
    // DELETE USER
    // ==========================================

    @Transactional
    public void deleteUser(
            Long id)
    {
        User user =
                getUserById(id);


        /*
         * Xóa liên kết user_roles trước.
         */
        user.getRoles().clear();

        userRepository.save(user);


        userRepository.delete(
                user
        );


        /*
         * Ép SQL DELETE chạy ngay để
         * foreign key error xuất hiện tại đây.
         */
        userRepository.flush();
    }


    // ==========================================
    // ROLE BY NAME
    // ==========================================

    private Role getRoleByName(
            String roleName)
    {
        return roleRepository
                .findByName(roleName)
                .orElseThrow(() ->
                        new IllegalStateException(
                                "Không tìm thấy ROLE "
                                        + roleName
                        )
                );
    }


    // ==========================================
    // ROLE NAMES -> ROLE ENTITIES
    // ==========================================

    private Set<Role> resolveRoles(
            Collection<String> roleNames)
    {
        Set<Role> roles =
                new HashSet<>();


        if (roleNames != null)
        {
            for (String roleName : roleNames)
            {
                Role role =
                        roleRepository
                                .findByName(
                                        roleName
                                )
                                .orElseThrow(() ->
                                        new IllegalArgumentException(
                                                "Role không tồn tại: "
                                                        + roleName
                                        )
                                );


                roles.add(
                        role
                );
            }
        }


        /*
         * Admin không chọn role nào
         * → mặc định USER.
         */
        if (roles.isEmpty())
        {
            roles.add(
                    getRoleByName(
                            "USER"
                    )
            );
        }


        return roles;
    }
}