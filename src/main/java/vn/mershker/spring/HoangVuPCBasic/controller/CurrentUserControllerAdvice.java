package vn.mershker.spring.HoangVuPCBasic.controller;

import org.springframework.security.authentication.AnonymousAuthenticationToken;

import org.springframework.security.core.Authentication;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import vn.mershker.spring.HoangVuPCBasic.domain.User;

import vn.mershker.spring.HoangVuPCBasic.service.ProfileService;


@ControllerAdvice
public class CurrentUserControllerAdvice
{
    private final ProfileService profileService;


    public CurrentUserControllerAdvice(
            ProfileService profileService)
    {
        this.profileService =
                profileService;
    }


    @ModelAttribute("currentUser")
    public User currentUser(
            Authentication authentication)
    {
        if (authentication == null ||
                !authentication.isAuthenticated() ||
                authentication
                        instanceof AnonymousAuthenticationToken)
        {
            return null;
        }


        try
        {
            return profileService
                    .getUserByEmail(
                            authentication.getName()
                    );
        }
        catch (IllegalArgumentException e)
        {
            return null;
        }
    }
}