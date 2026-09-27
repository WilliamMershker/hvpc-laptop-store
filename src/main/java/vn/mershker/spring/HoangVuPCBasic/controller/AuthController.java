package vn.mershker.spring.HoangVuPCBasic.controller;

import jakarta.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.validation.BindingResult;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import vn.mershker.spring.HoangVuPCBasic.domain.User;

import vn.mershker.spring.HoangVuPCBasic.dto.RegisterDTO;

import vn.mershker.spring.HoangVuPCBasic.mapper.UserMapper;

import vn.mershker.spring.HoangVuPCBasic.service.UserService;


@Controller
public class AuthController
{
    private final UserService userService;
    private final UserMapper userMapper;


    public AuthController(UserService userService, UserMapper userMapper)
    {
        this.userService = userService;
        this.userMapper = userMapper;
    }

    // ==========================================
    // REGISTER PAGE
    // ==========================================

    @GetMapping("/register")
    public String registerPage(Model model)
    {
        model.addAttribute("registerDTO", new RegisterDTO());
        return "auth/register";
    }


    // ==========================================
    // REGISTER
    // ==========================================

    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("registerDTO") RegisterDTO registerDTO, BindingResult bindingResult)
    {
        /*
         * Check email duplicate.
         */
        if (userService.emailExists(registerDTO.getEmail()))
        {
            bindingResult.rejectValue("email", "email.exists", "Email đã được sử dụng.");
        }

        /*
         * DTO validation hoặc
         * PasswordMatches lỗi.
         */
        if (bindingResult.hasErrors())
        {
            return "auth/register";
        }

        try
        {
            User user = userMapper.toUser(registerDTO);
            userService.registerUser(user);
            return "redirect:/login?registerSuccess";
        }
        catch (IllegalArgumentException | IllegalStateException e)
        {
            bindingResult.reject("register.error", e.getMessage());

            return "auth/register";
        }
    }

    // ==========================================
    // LOGIN PAGE
    // ==========================================

    @GetMapping("/login")
    public String loginPage()
    {
        return "auth/login";
    }
}