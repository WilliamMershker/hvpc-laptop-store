package vn.mershker.spring.HoangVuPCBasic.controller;

import org.springframework.core.io.Resource;

import org.springframework.http.MediaType;
import org.springframework.http.MediaTypeFactory;
import org.springframework.http.ResponseEntity;

import org.springframework.security.core.Authentication;

import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.multipart.MultipartFile;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.mershker.spring.HoangVuPCBasic.domain.User;

import vn.mershker.spring.HoangVuPCBasic.service.AvatarService;
import vn.mershker.spring.HoangVuPCBasic.service.ProfileService;


@Controller
@RequestMapping("/profile")
public class ProfileController
{
    private final ProfileService profileService;

    private final AvatarService avatarService;


    public ProfileController(

            ProfileService profileService,

            AvatarService avatarService)
    {
        this.profileService =
                profileService;

        this.avatarService =
                avatarService;
    }


    // ==========================================
    // PROFILE PAGE
    // ==========================================

    @GetMapping
    public String profile(

            Authentication authentication,

            Model model)
    {
        User user =
                profileService
                        .getUserByEmail(
                                authentication.getName()
                        );


        model.addAttribute(
                "profileUser",
                user
        );


        return "client/profile";
    }


    // ==========================================
    // UPDATE PROFILE INFO
    // ==========================================

    @PostMapping("/update")
    public String updateProfile(

            Authentication authentication,

            @RequestParam String fullName,

            @RequestParam(
                    required = false
            )
            String phone,

            @RequestParam(
                    required = false
            )
            String address,

            RedirectAttributes redirectAttributes)
    {
        try
        {
            profileService.updateProfile(
                    authentication.getName(),
                    fullName,
                    phone,
                    address
            );


            redirectAttributes
                    .addFlashAttribute(
                            "success",
                            "Cập nhật thông tin thành công."
                    );
        }
        catch (IllegalArgumentException e)
        {
            redirectAttributes
                    .addFlashAttribute(
                            "error",
                            e.getMessage()
                    );
        }


        return "redirect:/profile";
    }


    // ==========================================
    // UPDATE AVATAR
    // ==========================================

    @PostMapping("/avatar")
    public String updateAvatar(

            Authentication authentication,

            @RequestParam("avatarFile")
            MultipartFile avatarFile,

            RedirectAttributes redirectAttributes)
    {
        User user =
                profileService
                        .getUserByEmail(
                                authentication.getName()
                        );


        String oldAvatar =
                user.getAvatar();


        String newAvatar =
                null;


        try
        {
            newAvatar =
                    avatarService
                            .saveAvatar(
                                    avatarFile
                            );


            profileService.updateAvatar(
                    authentication.getName(),
                    newAvatar
            );


            /*
             * DB update thành công
             * mới xóa avatar cũ.
             */
            avatarService.deleteAvatar(
                    oldAvatar
            );


            redirectAttributes
                    .addFlashAttribute(
                            "success",
                            "Đổi ảnh đại diện thành công."
                    );
        }
        catch (RuntimeException e)
        {
            /*
             * Nếu lưu file thành công nhưng
             * DB lỗi thì xóa file mới.
             */
            if (newAvatar != null)
            {
                avatarService.deleteAvatar(
                        newAvatar
                );
            }


            redirectAttributes
                    .addFlashAttribute(
                            "error",
                            e.getMessage()
                    );
        }


        return "redirect:/profile";
    }


    // ==========================================
    // DELETE AVATAR
    // ==========================================

    @PostMapping("/avatar/delete")
    public String deleteAvatar(

            Authentication authentication,

            RedirectAttributes redirectAttributes)
    {
        User user =
                profileService
                        .getUserByEmail(
                                authentication.getName()
                        );


        String oldAvatar =
                user.getAvatar();


        profileService.updateAvatar(
                authentication.getName(),
                null
        );


        avatarService.deleteAvatar(
                oldAvatar
        );


        redirectAttributes
                .addFlashAttribute(
                        "success",
                        "Đã xóa ảnh đại diện."
                );


        return "redirect:/profile";
    }


    // ==========================================
    // HIỂN THỊ FILE AVATAR
    // ==========================================

    @GetMapping("/avatar/{filename:.+}")
    public ResponseEntity<Resource> avatar(

            @PathVariable String filename)
    {
        Resource resource =
                avatarService
                        .loadAvatar(
                                filename
                        );


        MediaType mediaType =
                MediaTypeFactory
                        .getMediaType(resource)
                        .orElse(
                                MediaType.APPLICATION_OCTET_STREAM
                        );


        return ResponseEntity
                .ok()
                .contentType(
                        mediaType
                )
                .body(
                        resource
                );
    }
}