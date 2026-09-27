package vn.mershker.spring.HoangVuPCBasic.config;

import jakarta.servlet.DispatcherType;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.security.config.annotation.web.builders.HttpSecurity;

import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import org.springframework.security.web.SecurityFilterChain;

import vn.mershker.spring.HoangVuPCBasic.domain.User;

import vn.mershker.spring.HoangVuPCBasic.repository.UserRepository;


@Configuration
public class SecurityConfig
{
    // ==========================================
    // PASSWORD ENCODER
    // ==========================================

    @Bean
    public PasswordEncoder passwordEncoder()
    {
        return new BCryptPasswordEncoder();
    }


    // ==========================================
    // LOAD USER FROM MYSQL
    // ==========================================

    @Bean
    public UserDetailsService userDetailsService(
            UserRepository userRepository)
    {
        return email ->
        {
            User user =
                    userRepository
                            .findByEmail(
                                    email
                            )
                            .orElseThrow(() ->
                                    new UsernameNotFoundException(
                                            "Không tìm thấy tài khoản: "
                                                    + email
                                    )
                            );


            String[] roles =
                    user.getRoles()
                            .stream()
                            .map(
                                    role ->
                                            role.getName()
                            )
                            .toArray(
                                    String[]::new
                            );


            return org.springframework.security
                    .core.userdetails.User
                    .withUsername(
                            user.getEmail()
                    )
                    .password(
                            user.getPassword()
                    )
                    .roles(
                            roles
                    )
                    .build();
        };
    }


    // ==========================================
    // SECURITY
    // ==========================================

    @Bean
    public SecurityFilterChain securityFilterChain(

            HttpSecurity http,

            UserDetailsService userDetailsService)

            throws Exception
    {
        http

                // ==================================
                // AUTHORIZE
                // ==================================

                .authorizeHttpRequests(auth ->
                        auth

                                /*
                                 * JSP forward.
                                 *
                                 * Giữ cái này.
                                 * Project m từng bị redirect loop.
                                 */
                                .dispatcherTypeMatchers(
                                        DispatcherType.FORWARD,
                                        DispatcherType.INCLUDE,
                                        DispatcherType.ERROR
                                )
                                .permitAll()


                                /*
                                 * PUBLIC
                                 */
                                .requestMatchers(
                                        "/",
                                        "/login",
                                        "/register",

                                        "/product/**",
                                        "/search",

                                        "/css/**",
                                        "/js/**",

                                        "/images/**",
                                        "/uploads/**",

                                        "/favicon.ico",

                                        "/error",
                                        "/error/**"
                                )
                                .permitAll()


                                /*
                                 * ADMIN
                                 */
                                .requestMatchers("/admin/**")
                                .hasRole("ADMIN")

                                /*
                                 * Các URL còn lại
                                 * cần login.
                                 */
                                .anyRequest()
                                .authenticated()
                )

                // ==================================
                // CUSTOM LOGIN
                // ==================================

                .formLogin(form ->
                        form
                                .loginPage(
                                        "/login"
                                )

                                .loginProcessingUrl(
                                        "/login"
                                )

                                /*
                                 * Spring Security mặc định
                                 * dùng username.
                                 *
                                 * Project này login bằng email.
                                 */
                                .usernameParameter("email")

                                .passwordParameter("password")

                                .defaultSuccessUrl(
                                        "/",
                                        true
                                )
                                .failureUrl(
                                        "/login?error"
                                )
                                .permitAll()
                )

                // ==================================
                // REMEMBER ME
                // ==================================

                .rememberMe(remember ->
                        remember

                                .userDetailsService(
                                        userDetailsService
                                )

                                .key(
                                        "HoangVuPCBasicRememberMeKey"
                                )

                                /*
                                 * 7 ngày
                                 */
                                .tokenValiditySeconds(
                                        7 * 24 * 60 * 60
                                )
                )

                // ==================================
                // LOGOUT
                // ==================================

                .logout(logout ->
                        logout

                                .logoutUrl("/logout")

                                .logoutSuccessUrl("/login?logout")

                                .invalidateHttpSession(true)
                                .deleteCookies("JSESSIONID", "remember-me")
                                .permitAll()
                );


        return http.build();
    }
}