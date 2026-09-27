package vn.mershker.spring.HoangVuPCBasic.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import vn.mershker.spring.HoangVuPCBasic.domain.Role;
import vn.mershker.spring.HoangVuPCBasic.domain.User;

import vn.mershker.spring.HoangVuPCBasic.repository.RoleRepository;
import vn.mershker.spring.HoangVuPCBasic.repository.UserRepository;

@Configuration
public class DataInitializer
{
    @Bean
    public CommandLineRunner initData(

            RoleRepository roleRepository,

            UserRepository userRepository,

            PasswordEncoder passwordEncoder,

            @Value("${app.admin.email:admin@hvpc.local}")
            String adminEmail,

            @Value("${app.admin.password:}")
            String adminPassword)
    {
        return args ->
        {
            /*
             * =====================================
             * CREATE USER ROLE
             * =====================================
             */

            Role userRole =
                    roleRepository
                            .findByName("USER")
                            .orElseGet(() ->
                            {
                                Role role = new Role();

                                role.setName("USER");

                                role.setDescription(
                                        "Người dùng thông thường"
                                );

                                return roleRepository.save(role);
                            });


            /*
             * =====================================
             * CREATE ADMIN ROLE
             * =====================================
             */

            Role adminRole =
                    roleRepository
                            .findByName("ADMIN")
                            .orElseGet(() ->
                            {
                                Role role = new Role();

                                role.setName("ADMIN");

                                role.setDescription(
                                        "Quản trị viên"
                                );

                                return roleRepository.save(role);
                            });


            /*
             * =====================================
             * ASSIGN USER ROLE TO OLD USERS
             * =====================================
             */

            for (User user : userRepository.findAll())
            {
                if (user.getRoles().isEmpty())
                {
                    user.getRoles().add(userRole);

                    userRepository.save(user);
                }
            }


            /*
             * =====================================
             * FIND ADMIN
             * =====================================
             */

            User admin =
                    userRepository
                            .findByEmail(adminEmail)
                            .orElse(null);


            /*
             * =====================================
             * ADMIN ALREADY EXISTS
             * =====================================
             *
             * Không reset password mỗi lần
             * application khởi động.
             */

            if (admin != null)
            {
                admin.getRoles().add(userRole);

                admin.getRoles().add(adminRole);

                userRepository.save(admin);

                return;
            }


            /*
             * =====================================
             * NO ADMIN PASSWORD
             * =====================================
             *
             * Nếu người clone project chưa cấu hình
             * password thì bỏ qua việc tạo admin.
             */

            if (adminPassword == null ||
                    adminPassword.isBlank())
            {
                System.out.println(
                        "======================================"
                );

                System.out.println(
                        "ADMIN account was not created."
                );

                System.out.println(
                        "Configure app.admin.password first."
                );

                System.out.println(
                        "======================================"
                );

                return;
            }


            /*
             * =====================================
             * CREATE ADMIN
             * =====================================
             */

            admin = new User();

            admin.setEmail(adminEmail);

            admin.setPassword(
                    passwordEncoder.encode(
                            adminPassword
                    )
            );

            admin.setFullName(
                    "HVPC Tech Admin"
            );

            admin.setPhone("");

            admin.setAddress("");


            admin.getRoles().add(
                    userRole
            );

            admin.getRoles().add(
                    adminRole
            );


            userRepository.save(
                    admin
            );


            System.out.println(
                    "======================================"
            );

            System.out.println(
                    "ADMIN account created: " +
                            adminEmail
            );

            System.out.println(
                    "======================================"
            );
        };
    }
}