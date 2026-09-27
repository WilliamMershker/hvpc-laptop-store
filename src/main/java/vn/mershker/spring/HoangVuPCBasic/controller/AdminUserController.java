package vn.mershker.spring.HoangVuPCBasic.controller;

import jakarta.validation.Valid;

import org.springframework.dao.DataIntegrityViolationException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.validation.BindingResult;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.mershker.spring.HoangVuPCBasic.domain.User;
import vn.mershker.spring.HoangVuPCBasic.service.UserService;

import java.util.List;


@Controller
@RequestMapping("/admin/user")
public class AdminUserController
{
    private final UserService userService;

    public AdminUserController(UserService userService)
    {
        this.userService = userService;
    }

    // ==========================================
    // READ
    // GET /admin/user
    // ==========================================

    @GetMapping
    public String showUsers(
            Model model)
    {
        model.addAttribute(
                "users",
                userService.getAllUsers()
        );


        return "admin/user/show";
    }


    // ==========================================
    // CREATE PAGE
    // ==========================================

    @GetMapping("/create")
    public String createPage(
            Model model)
    {
        model.addAttribute(
                "newUser",
                new User()
        );


        model.addAttribute(
                "allRoles",
                userService.getAllRoles()
        );


        return "admin/user/create";
    }


    // ==========================================
    // CREATE
    // ==========================================

    @PostMapping("/create")
    public String createUser(

            @Valid
            @ModelAttribute("newUser")
            User user,

            BindingResult bindingResult,

            @RequestParam(
                    name = "roleNames",
                    required = false
            )
            List<String> roleNames,

            Model model)
    {
        /*
         * Password của Entity không dùng
         * @NotBlank vì UPDATE được phép để trống.
         *
         * CREATE kiểm tra thủ công.
         */
        if (user.getPassword() == null ||
                user.getPassword().isBlank())
        {
            bindingResult.rejectValue(
                    "password",
                    "password.empty",
                    "Mật khẩu không được để trống."
            );
        }


        if (user.getEmail() != null &&
                !user.getEmail().isBlank() &&
                userService.emailExists(
                        user.getEmail()
                ))
        {
            bindingResult.rejectValue(
                    "email",
                    "email.exists",
                    "Email đã tồn tại."
            );
        }


        if (bindingResult.hasErrors())
        {
            model.addAttribute(
                    "allRoles",
                    userService.getAllRoles()
            );


            return "admin/user/create";
        }


        try
        {
            userService.createUserByAdmin(
                    user,
                    roleNames
            );


            return "redirect:/admin/user";
        }
        catch (IllegalArgumentException |
               IllegalStateException e)
        {
            model.addAttribute(
                    "error",
                    e.getMessage()
            );


            model.addAttribute(
                    "allRoles",
                    userService.getAllRoles()
            );


            return "admin/user/create";
        }
    }


    // ==========================================
    // UPDATE PAGE
    // ==========================================

    @GetMapping("/update/{id}")
    public String updatePage(

            @PathVariable Long id,

            Model model,

            RedirectAttributes redirectAttributes)
    {
        try
        {
            User user =
                    userService
                            .getUserById(id);


            /*
             * Tuyệt đối không gửi BCrypt hash
             * ra ô password.
             */
            user.setPassword("");


            model.addAttribute(
                    "user",
                    user
            );


            model.addAttribute(
                    "allRoles",
                    userService.getAllRoles()
            );


            return "admin/user/update";
        }
        catch (IllegalArgumentException e)
        {
            redirectAttributes
                    .addFlashAttribute(
                            "error",
                            e.getMessage()
                    );


            return "redirect:/admin/user";
        }
    }


    // ==========================================
    // UPDATE
    // ==========================================

    @PostMapping("/update/{id}")
    public String updateUser(

            @PathVariable Long id,

            @Valid
            @ModelAttribute("user")
            User user,

            BindingResult bindingResult,

            @RequestParam(
                    name = "roleNames",
                    required = false
            )
            List<String> roleNames,

            Model model)
    {
        if (bindingResult.hasErrors())
        {
            model.addAttribute(
                    "allRoles",
                    userService.getAllRoles()
            );


            return "admin/user/update";
        }


        try
        {
            userService.updateUserByAdmin(
                    id,
                    user,
                    roleNames
            );


            return "redirect:/admin/user";
        }
        catch (IllegalArgumentException |
               IllegalStateException e)
        {
            model.addAttribute(
                    "error",
                    e.getMessage()
            );


            model.addAttribute(
                    "allRoles",
                    userService.getAllRoles()
            );


            return "admin/user/update";
        }
    }


    // ==========================================
    // DELETE
    // ==========================================

    @PostMapping("/delete/{id}")
    public String deleteUser(

            @PathVariable Long id,

            RedirectAttributes redirectAttributes)
    {
        try
        {
            userService.deleteUser(
                    id
            );


            redirectAttributes
                    .addFlashAttribute(
                            "success",
                            "Xóa tài khoản thành công."
                    );
        }
        catch (DataIntegrityViolationException e)
        {
            redirectAttributes
                    .addFlashAttribute(
                            "error",
                            "Không thể xóa tài khoản vì tài khoản đã có dữ liệu liên quan."
                    );
        }
        catch (IllegalArgumentException |
               IllegalStateException e)
        {
            redirectAttributes
                    .addFlashAttribute(
                            "error",
                            e.getMessage()
                    );
        }


        return "redirect:/admin/user";
    }
}