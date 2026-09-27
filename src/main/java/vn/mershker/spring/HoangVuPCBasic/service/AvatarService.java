package vn.mershker.spring.HoangVuPCBasic.service;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;

import org.springframework.stereotype.Service;

import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;

import java.io.IOException;
import java.io.InputStream;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import java.util.Set;
import java.util.UUID;


@Service
public class AvatarService
{
    private static final long MAX_FILE_SIZE =
            5 * 1024 * 1024;


    private static final Set<String> ALLOWED_TYPES =
            Set.of(
                    "image/jpeg",
                    "image/png"
            );


    private final Path avatarDirectory =
            Paths.get(
                            "uploads",
                            "avatars"
                    )
                    .toAbsolutePath()
                    .normalize();


    public AvatarService()
    {
        try
        {
            Files.createDirectories(
                    avatarDirectory
            );
        }
        catch (IOException e)
        {
            throw new IllegalStateException(
                    "Không thể tạo thư mục avatar.",
                    e
            );
        }
    }


    // ==========================================
    // SAVE AVATAR
    // ==========================================

    public String saveAvatar(
            MultipartFile file)
    {
        if (file == null ||
                file.isEmpty())
        {
            throw new IllegalArgumentException(
                    "Vui lòng chọn ảnh."
            );
        }


        if (file.getSize() > MAX_FILE_SIZE)
        {
            throw new IllegalArgumentException(
                    "Ảnh đại diện tối đa 5MB."
            );
        }


        String contentType =
                file.getContentType();


        if (contentType == null ||
                !ALLOWED_TYPES.contains(
                        contentType
                ))
        {
            throw new IllegalArgumentException(
                    "Chỉ chấp nhận ảnh JPG hoặc PNG."
            );
        }


        /*
         * Kiểm tra file thực sự là ảnh.
         */
        try (InputStream inputStream =
                     file.getInputStream())
        {
            if (ImageIO.read(
                    inputStream
            ) == null)
            {
                throw new IllegalArgumentException(
                        "File được chọn không phải ảnh hợp lệ."
                );
            }
        }
        catch (IOException e)
        {
            throw new IllegalStateException(
                    "Không thể đọc file ảnh.",
                    e
            );
        }


        String extension =
                contentType.equals(
                        "image/png"
                )
                        ? ".png"
                        : ".jpg";


        String filename =
                UUID.randomUUID()
                        + extension;


        Path destination =
                avatarDirectory
                        .resolve(
                                filename
                        )
                        .normalize();


        try (InputStream inputStream =
                     file.getInputStream())
        {
            Files.copy(
                    inputStream,
                    destination,
                    StandardCopyOption.REPLACE_EXISTING
            );
        }
        catch (IOException e)
        {
            throw new IllegalStateException(
                    "Không thể lưu avatar.",
                    e
            );
        }


        return filename;
    }


    // ==========================================
    // LOAD AVATAR
    // ==========================================

    public Resource loadAvatar(
            String filename)
    {
        try
        {
            Path file =
                    avatarDirectory
                            .resolve(filename)
                            .normalize();


            /*
             * Chống ../ traversal
             */
            if (!file.startsWith(
                    avatarDirectory
            ))
            {
                throw new IllegalArgumentException(
                        "Tên file không hợp lệ."
                );
            }


            Resource resource =
                    new UrlResource(
                            file.toUri()
                    );


            if (!resource.exists() ||
                    !resource.isReadable())
            {
                throw new IllegalArgumentException(
                        "Không tìm thấy avatar."
                );
            }


            return resource;
        }
        catch (IOException e)
        {
            throw new IllegalStateException(
                    "Không thể đọc avatar.",
                    e
            );
        }
    }


    // ==========================================
    // DELETE OLD AVATAR
    // ==========================================

    public void deleteAvatar(
            String filename)
    {
        if (filename == null ||
                filename.isBlank())
        {
            return;
        }


        try
        {
            Path file =
                    avatarDirectory
                            .resolve(filename)
                            .normalize();


            if (!file.startsWith(
                    avatarDirectory
            ))
            {
                return;
            }


            Files.deleteIfExists(
                    file
            );
        }
        catch (IOException ignored)
        {
        }
    }
}