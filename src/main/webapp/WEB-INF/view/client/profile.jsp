<%@ page contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c"
           uri="jakarta.tags.core" %>


<!DOCTYPE html>

<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>
        Trang cá nhân - Hoàng Vũ PC
    </title>

    <link
            rel="icon"
            type="image/png"
            href="${pageContext.request.contextPath}/favicon.png?v=2">


    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">


    <style>

        body {
            margin: 0;

            background: #f4f7fb;

            color: #0f172a;
        }


        /* ======================================== */
        /* WRAPPER */
        /* ======================================== */

        .profile-page {
            width: 100%;

            padding:
                    38px 16px
                    60px;
        }


        .profile-wrapper {
            width: min(
                    900px,
                    100%
            );

            margin: 0 auto;
        }


        /* ======================================== */
        /* ALERT */
        /* ======================================== */

        .profile-alert {
            margin-bottom: 18px;

            border-radius: 12px;
        }


        /* ======================================== */
        /* CARD */
        /* ======================================== */

        .profile-card {
            background: #ffffff;

            border:
                    1px solid #e2e8f0;

            border-radius: 22px;

            overflow: hidden;

            box-shadow:
                    0 18px 50px
                    rgba(15, 23, 42, 0.10);
        }


        /* ======================================== */
        /* COVER */
        /* ======================================== */

        .profile-cover {
            height: 190px;

            background:
                    linear-gradient(
                            135deg,
                            #0f172a 0%,
                            #1e3a8a 42%,
                            #2563eb 100%
                    );
        }


        /* ======================================== */
        /* PROFILE HEADER */
        /* ======================================== */

        .profile-header {
            position: relative;

            padding:
                    0 34px
                    28px;
        }


        .profile-header-content {
            display: flex;

            align-items: flex-start;

            gap: 22px;
        }


        /* ======================================== */
        /* AVATAR */
        /* ======================================== */

        .profile-avatar-area {
            flex-shrink: 0;

            margin-top: -72px;
        }


        .profile-avatar,
        .avatar-fallback {
            width: 145px;

            height: 145px;

            border-radius: 50%;

            border:
                    6px solid #ffffff;

            box-shadow:
                    0 10px 30px
                    rgba(15, 23, 42, 0.18);
        }


        .profile-avatar {
            object-fit: cover;

            background: #e2e8f0;
        }


        .avatar-fallback {
            display: flex;

            align-items: center;

            justify-content: center;

            background:
                    linear-gradient(
                            135deg,
                            #fb923c,
                            #f97316
                    );

            color: #ffffff;

            font-size: 3rem;

            font-weight: 800;
        }


        /* ======================================== */
        /* USER INFO */
        /* ======================================== */

        .profile-user-info {
            min-width: 0;

            padding-top: 22px;
        }


        .profile-name {
            margin: 0;

            color: #0f172a;

            font-size: 1.7rem;

            font-weight: 800;

            line-height: 1.2;
        }


        .profile-email {
            margin-top: 5px;

            color: #64748b;

            font-size: 0.95rem;

            word-break: break-word;
        }


        .profile-role-list {
            display: flex;

            flex-wrap: wrap;

            gap: 7px;

            margin-top: 12px;
        }


        .role-badge {
            display: inline-flex;

            align-items: center;

            justify-content: center;

            padding:
                    5px 11px;

            border-radius: 999px;

            background: #111827;

            color: #ffffff;

            font-size: 0.72rem;

            font-weight: 700;

            letter-spacing: 0.2px;
        }


        /* ======================================== */
        /* CONTENT */
        /* ======================================== */

        .profile-content {
            padding:
                    0 34px
                    34px;
        }


        .profile-section {
            margin-top: 24px;

            padding: 24px;

            background: #ffffff;

            border:
                    1px solid #e2e8f0;

            border-radius: 16px;
        }


        .section-title {
            margin: 0 0 6px;

            color: #0f172a;

            font-size: 1.15rem;

            font-weight: 750;
        }


        .section-description {
            margin-bottom: 20px;

            color: #64748b;

            font-size: 0.87rem;
        }


        /* ======================================== */
        /* AVATAR UPLOAD */
        /* ======================================== */

        .avatar-upload-layout {
            display: flex;

            align-items: flex-start;

            gap: 22px;
        }


        .avatar-preview-box {
            flex-shrink: 0;
        }


        .avatar-preview {
            display: none;

            width: 120px;

            height: 120px;

            object-fit: cover;

            border-radius: 50%;

            border:
                    4px solid #ffffff;

            box-shadow:
                    0 5px 20px
                    rgba(15, 23, 42, 0.16);
        }


        .avatar-form-area {
            flex: 1;

            min-width: 0;
        }


        .file-note {
            margin-top: 8px;

            color: #64748b;

            font-size: 0.8rem;
        }


        .avatar-actions {
            display: flex;

            flex-wrap: wrap;

            gap: 10px;

            margin-top: 14px;
        }


        /* ======================================== */
        /* FORM */
        /* ======================================== */

        .form-label {
            color: #334155;

            font-size: 0.88rem;

            font-weight: 650;
        }


        .form-control {
            min-height: 43px;

            border:
                    1px solid #cbd5e1;

            border-radius: 10px;

            box-shadow: none;
        }


        .form-control:focus {
            border-color: #2563eb;

            box-shadow:
                    0 0 0 3px
                    rgba(37, 99, 235, 0.10);
        }


        textarea.form-control {
            min-height: 100px;

            resize: vertical;
        }


        .readonly-email {
            background: #f1f5f9;
        }


        /* ======================================== */
        /* BUTTON */
        /* ======================================== */

        .profile-btn {
            display: inline-flex;

            align-items: center;

            justify-content: center;

            min-height: 40px;

            padding:
                    8px 16px;

            border-radius: 9px;

            font-size: 0.86rem;

            font-weight: 650;

            cursor: pointer;

            transition: 0.18s ease;
        }


        /* ======================================== */
        /* MOBILE */
        /* ======================================== */

        @media (max-width: 768px) {

            .profile-page {
                padding:
                        20px 10px
                        40px;
            }


            .profile-cover {
                height: 150px;
            }


            .profile-header {
                padding:
                        0 20px
                        24px;
            }


            .profile-header-content {
                flex-direction: column;

                align-items: center;

                gap: 0;
            }


            .profile-avatar-area {
                margin-top: -65px;
            }


            .profile-avatar,
            .avatar-fallback {
                width: 130px;

                height: 130px;
            }


            .profile-user-info {
                width: 100%;

                padding-top: 14px;

                text-align: center;
            }


            .profile-role-list {
                justify-content: center;
            }


            .profile-content {
                padding:
                        0 16px
                        24px;
            }


            .profile-section {
                padding: 20px;
            }


            .avatar-upload-layout {
                flex-direction: column;
            }


            .avatar-preview-box {
                width: 100%;

                display: flex;

                justify-content: center;
            }


            .avatar-form-area {
                width: 100%;
            }

        }

    </style>

</head>


<body>


<jsp:include page="/WEB-INF/view/shared/navbar.jsp"/>


<div class="profile-page">

    <div class="profile-wrapper">


        <c:if test="${not empty success}">

            <div class="alert alert-success profile-alert">

                <c:out value="${success}"/>

            </div>

        </c:if>


        <c:if test="${not empty error}">

            <div class="alert alert-danger profile-alert">

                <c:out value="${error}"/>

            </div>

        </c:if>


        <div class="profile-card">


            <div class="profile-cover"></div>


            <div class="profile-header">

                <div class="profile-header-content">


                    <div class="profile-avatar-area">


                        <c:choose>

                            <c:when test="${not empty profileUser.avatar}">

                                <img
                                        src="${pageContext.request.contextPath}/profile/avatar/${profileUser.avatar}"
                                        alt="Avatar"
                                        class="profile-avatar">

                            </c:when>

                            <c:otherwise>

                                <div class="avatar-fallback">

                                    U

                                </div>

                            </c:otherwise>

                        </c:choose>


                    </div>


                    <div class="profile-user-info">


                        <h1 class="profile-name">

                            <c:out value="${profileUser.fullName}"/>

                        </h1>


                        <div class="profile-email">

                            <c:out value="${profileUser.email}"/>

                        </div>


                        <div class="profile-role-list">

                            <c:forEach
                                    var="role"
                                    items="${profileUser.roles}">

                                <span class="role-badge">

                                    <c:out value="${role.name}"/>

                                </span>

                            </c:forEach>

                        </div>


                    </div>


                </div>

            </div>


            <div class="profile-content">


                <div class="profile-section">


                    <h2 class="section-title">

                        Ảnh đại diện

                    </h2>


                    <div class="section-description">

                        Chọn ảnh JPG hoặc PNG để sử dụng làm avatar tài khoản.

                    </div>


                    <div class="avatar-upload-layout">


                        <div class="avatar-preview-box">

                            <img
                                    id="avatarPreview"
                                    class="avatar-preview"
                                    alt="Ảnh xem trước">

                        </div>


                        <div class="avatar-form-area">


                            <form
                                    method="post"
                                    enctype="multipart/form-data"
                                    action="${pageContext.request.contextPath}/profile/avatar">


                                <input
                                        type="hidden"
                                        name="${_csrf.parameterName}"
                                        value="${_csrf.token}">


                                <div class="mb-3">

                                    <label
                                            for="avatarFile"
                                            class="form-label">

                                        Chọn ảnh mới

                                    </label>


                                    <input
                                            type="file"
                                            id="avatarFile"
                                            name="avatarFile"
                                            class="form-control"
                                            accept="image/jpeg,image/png"
                                            required>


                                    <div class="file-note">

                                        Dung lượng tối đa 5MB. Hỗ trợ JPG và PNG.

                                    </div>

                                </div>


                                <div class="avatar-actions">


                                    <button
                                            type="submit"
                                            class="btn btn-primary profile-btn">

                                        Đổi ảnh đại diện

                                    </button>


                                </div>


                            </form>


                            <c:if test="${not empty profileUser.avatar}">


                                <form
                                        method="post"
                                        action="${pageContext.request.contextPath}/profile/avatar/delete"
                                        class="mt-2">


                                    <input
                                            type="hidden"
                                            name="${_csrf.parameterName}"
                                            value="${_csrf.token}">


                                    <button
                                            type="submit"
                                            class="btn btn-outline-danger profile-btn"
                                            onclick="return confirm('M muốn xóa ảnh đại diện hiện tại?');">

                                        Xóa ảnh đại diện

                                    </button>


                                </form>


                            </c:if>


                        </div>


                    </div>


                </div>


                <div class="profile-section">


                    <h2 class="section-title">

                        Thông tin cá nhân

                    </h2>


                    <div class="section-description">

                        Cập nhật thông tin hiển thị của tài khoản.

                    </div>


                    <form
                            method="post"
                            action="${pageContext.request.contextPath}/profile/update">


                        <input
                                type="hidden"
                                name="${_csrf.parameterName}"
                                value="${_csrf.token}">


                        <div class="mb-3">


                            <label class="form-label">

                                Email

                            </label>


                            <input
                                    type="email"
                                    class="form-control readonly-email"
                                    value="${profileUser.email}"
                                    readonly>


                        </div>


                        <div class="mb-3">


                            <label
                                    for="fullName"
                                    class="form-label">

                                Họ và tên

                            </label>


                            <input
                                    type="text"
                                    id="fullName"
                                    name="fullName"
                                    class="form-control"
                                    value="${profileUser.fullName}"
                                    required>


                        </div>


                        <div class="mb-3">


                            <label
                                    for="phone"
                                    class="form-label">

                                Số điện thoại

                            </label>


                            <input
                                    type="text"
                                    id="phone"
                                    name="phone"
                                    class="form-control"
                                    value="${profileUser.phone}"
                                    placeholder="Nhập số điện thoại">


                        </div>


                        <div class="mb-3">


                            <label
                                    for="address"
                                    class="form-label">

                                Địa chỉ

                            </label>


                            <textarea
                                    id="address"
                                    name="address"
                                    class="form-control"
                                    placeholder="Nhập địa chỉ"><c:out value="${profileUser.address}"/></textarea>


                        </div>


                        <button
                                type="submit"
                                class="btn btn-dark profile-btn">

                            Lưu thay đổi

                        </button>


                    </form>


                </div>


            </div>


        </div>


    </div>

</div>


<script>

    (function ()
    {

        const avatarFile =
            document.getElementById(
                "avatarFile"
            );


        const avatarPreview =
            document.getElementById(
                "avatarPreview"
            );


        let previewUrl =
            null;


        if (avatarFile &&
            avatarPreview)
        {
            avatarFile.addEventListener(
                "change",
                function ()
                {
                    const file =
                        this.files &&
                        this.files.length > 0
                            ? this.files[0]
                            : null;


                    if (previewUrl)
                    {
                        URL.revokeObjectURL(
                            previewUrl
                        );

                        previewUrl = null;
                    }


                    if (!file)
                    {
                        avatarPreview
                            .removeAttribute(
                                "src"
                            );

                        avatarPreview
                            .style
                            .display =
                            "none";

                        return;
                    }


                    previewUrl =
                        URL.createObjectURL(
                            file
                        );


                    avatarPreview.src =
                        previewUrl;


                    avatarPreview
                        .style
                        .display =
                        "block";
                }
            );
        }

    })();

</script>


</body>

</html>