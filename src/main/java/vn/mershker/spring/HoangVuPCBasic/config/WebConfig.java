package vn.mershker.spring.HoangVuPCBasic.config;

import org.springframework.context.annotation.Configuration;

import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.nio.file.Path;
import java.nio.file.Paths;


@Configuration
public class WebConfig
        implements WebMvcConfigurer
{

    @Override
    public void addResourceHandlers(
            ResourceHandlerRegistry registry)
    {
        Path productUploadDirectory =
                Paths.get(
                                "uploads",
                                "products"
                        )
                        .toAbsolutePath()
                        .normalize();


        String productUploadLocation =
                productUploadDirectory
                        .toUri()
                        .toString();


        registry
                .addResourceHandler(
                        "/images/product/**"
                )
                .addResourceLocations(
                        productUploadLocation
                );
    }
}