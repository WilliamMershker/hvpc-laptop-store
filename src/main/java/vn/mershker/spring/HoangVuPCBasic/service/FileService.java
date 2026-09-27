package vn.mershker.spring.HoangVuPCBasic.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import java.util.Set;
import java.util.UUID;

@Service
public class FileService
{
    @Value("${app.upload-dir:uploads}")
    private String uploadDir;


    private static final Set<String> ALLOWED_EXTENSIONS =
            Set.of(
                    "jpg",
                    "jpeg",
                    "png",
                    "webp"
            );


    // ==========================================
    // SAVE PRODUCT IMAGE
    // ==========================================

    public String saveProductImage(
            MultipartFile file)
    {
        if (file == null || file.isEmpty())
        {
            return null;
        }


        String originalFilename =
                StringUtils.cleanPath(
                        file.getOriginalFilename() == null
                                ? ""
                                : file.getOriginalFilename()
                );


        if (originalFilename.isBlank())
        {
            throw new IllegalArgumentException(
                    "Tên file ảnh không hợp lệ."
            );
        }


        if (originalFilename.contains(".."))
        {
            throw new IllegalArgumentException(
                    "Tên file ảnh không hợp lệ."
            );
        }


        String extension =
                getExtension(
                        originalFilename
                )
                        .toLowerCase();


        if (!ALLOWED_EXTENSIONS.contains(
                extension
        ))
        {
            throw new IllegalArgumentException(
                    "Chỉ cho phép JPG, JPEG, PNG hoặc WEBP."
            );
        }


        String contentType =
                file.getContentType();


        if (contentType == null ||
                !contentType.startsWith("image/"))
        {
            throw new IllegalArgumentException(
                    "File upload phải là hình ảnh."
            );
        }


        String newFilename =
                UUID.randomUUID()
                        + "."
                        + extension;


        Path productDirectory =
                Paths.get(
                                uploadDir,
                                "products"
                        )
                        .toAbsolutePath()
                        .normalize();


        try
        {
            Files.createDirectories(
                    productDirectory
            );


            Path destination =
                    productDirectory.resolve(
                            newFilename
                    );


            Files.copy(
                    file.getInputStream(),
                    destination,
                    StandardCopyOption.REPLACE_EXISTING
            );


            return newFilename;
        }
        catch (IOException e)
        {
            throw new IllegalStateException(
                    "Không thể lưu ảnh sản phẩm.",
                    e
            );
        }
    }


    // ==========================================
    // DELETE PRODUCT IMAGE
    // ==========================================

    public void deleteProductImage(
            String filename)
    {
        if (filename == null ||
                filename.isBlank())
        {
            return;
        }


        Path productDirectory =
                Paths.get(
                                uploadDir,
                                "products"
                        )
                        .toAbsolutePath()
                        .normalize();


        Path imagePath =
                productDirectory
                        .resolve(filename)
                        .normalize();


        /*
         * Không cho đường dẫn chạy ra ngoài
         * uploads/products.
         */
        if (!imagePath.startsWith(
                productDirectory
        ))
        {
            return;
        }


        try
        {
            Files.deleteIfExists(
                    imagePath
            );
        }
        catch (IOException ignored)
        {
        }
    }


    private String getExtension(
            String filename)
    {
        int index =
                filename.lastIndexOf('.');


        if (index < 0 ||
                index == filename.length() - 1)
        {
            throw new IllegalArgumentException(
                    "File ảnh không có phần mở rộng."
            );
        }


        return filename.substring(
                index + 1
        );
    }
}