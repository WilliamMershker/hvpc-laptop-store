<%@ page contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="form"
           uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="c"
           uri="jakarta.tags.core" %>


<!DOCTYPE html>

<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>
        Thêm sản phẩm - Hoàng Vũ PC
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
            background: #f6f8fb;
        }


        .create-wrapper {
            max-width: 820px;

            margin:
                    45px auto
                    70px;
        }


        .create-card {
            background: #ffffff;

            border:
                    1px solid #e2e8f0;

            border-radius: 18px;

            box-shadow:
                    0 12px 35px
                    rgba(15, 23, 42, 0.08);
        }


        .create-card-body {
            padding: 30px;
        }


        .page-title {
            margin-bottom: 5px;

            color: #0f172a;

            font-size: 1.6rem;

            font-weight: 800;
        }


        .page-description {
            margin-bottom: 25px;

            color: #64748b;
        }


        .form-label {
            color: #334155;

            font-weight: 650;
        }


        .form-control {
            min-height: 43px;

            border-radius: 9px;
        }


        textarea.form-control {
            min-height: 110px;
        }


        .field-error {
            display: block;

            margin-top: 5px;

            color: #dc2626;

            font-size: 0.82rem;
        }


        .image-preview {
            display: none;

            width: 220px;

            height: 160px;

            margin-top: 14px;

            object-fit: contain;

            background: #f8fafc;

            border:
                    1px solid #e2e8f0;

            border-radius: 10px;
        }


        .button-area {
            display: flex;

            gap: 8px;

            margin-top: 25px;
        }

    </style>

</head>


<body>


<jsp:include page="/WEB-INF/view/shared/navbar.jsp"/>


<div class="container">

    <div class="create-wrapper">


        <div class="create-card">

            <div class="create-card-body">


                <h1 class="page-title">
                    Thêm sản phẩm
                </h1>


                <div class="page-description">
                    Thêm laptop mới vào hệ thống Hoàng Vũ PC.
                </div>


                <!--
                    QUAN TRỌNG:

                    method="post"
                    enctype="multipart/form-data"

                    Không được đổi thành GET.
                -->

                <form:form
                        method="post"
                        action="${pageContext.request.contextPath}/admin/product/create"
                        modelAttribute="product"
                        enctype="multipart/form-data">


                    <input
                            type="hidden"
                            name="${_csrf.parameterName}"
                            value="${_csrf.token}">


                    <div class="mb-3">

                        <label
                                for="name"
                                class="form-label">

                            Tên laptop

                        </label>


                        <form:input
                                path="name"
                                id="name"
                                cssClass="form-control"
                                placeholder="Ví dụ: Acer Aspire Lite 14"/>


                        <form:errors
                                path="name"
                                cssClass="field-error"/>

                    </div>


                    <div class="row">


                        <div class="col-md-6 mb-3">

                            <label
                                    for="price"
                                    class="form-label">

                                Giá

                            </label>


                            <form:input
                                    path="price"
                                    id="price"
                                    type="number"
                                    min="0"
                                    step="1000"
                                    cssClass="form-control"
                                    placeholder="15000000"/>


                            <form:errors
                                    path="price"
                                    cssClass="field-error"/>

                        </div>


                        <div class="col-md-6 mb-3">

                            <label
                                    for="quantity"
                                    class="form-label">

                                Số lượng

                            </label>


                            <form:input
                                    path="quantity"
                                    id="quantity"
                                    type="number"
                                    min="0"
                                    cssClass="form-control"
                                    placeholder="10"/>


                            <form:errors
                                    path="quantity"
                                    cssClass="field-error"/>

                        </div>


                    </div>


                    <div class="mb-3">

                        <label
                                for="manufacturer"
                                class="form-label">

                            Hãng

                        </label>


                        <form:input
                                path="manufacturer"
                                id="manufacturer"
                                cssClass="form-control"
                                placeholder="Acer, ASUS, Dell, Lenovo, HP, Apple..."/>


                        <form:errors
                                path="manufacturer"
                                cssClass="field-error"/>

                    </div>


                    <div class="mb-3">

                        <label
                                for="shortDescription"
                                class="form-label">

                            Mô tả ngắn

                        </label>


                        <form:textarea
                                path="shortDescription"
                                id="shortDescription"
                                cssClass="form-control"
                                rows="4"
                                placeholder="Nhập mô tả sản phẩm..."/>

                    </div>


                    <div class="mb-3">

                        <label
                                for="imageFile"
                                class="form-label">

                            Ảnh sản phẩm

                        </label>


                        <input
                                type="file"
                                id="imageFile"
                                name="imageFile"
                                class="form-control"
                                accept="image/jpeg,image/png,image/webp">


                        <div class="form-text">
                            Hỗ trợ JPG, PNG và WEBP.
                        </div>


                        <c:if test="${not empty imageError}">

                            <span class="field-error">

                                <c:out value="${imageError}"/>

                            </span>

                        </c:if>


                        <img
                                id="imagePreview"
                                class="image-preview"
                                alt="Xem trước ảnh">

                    </div>


                    <div class="button-area">


                        <button
                                type="submit"
                                class="btn btn-primary">

                            Lưu sản phẩm

                        </button>


                        <a
                                href="${pageContext.request.contextPath}/admin/product"
                                class="btn btn-secondary">

                            Quay lại

                        </a>


                    </div>


                </form:form>


            </div>

        </div>


    </div>

</div>


<script>

    (function ()
    {
        const imageFile =
            document.getElementById(
                "imageFile"
            );


        const imagePreview =
            document.getElementById(
                "imagePreview"
            );


        let currentPreviewUrl =
            null;


        if (imageFile &&
            imagePreview)
        {
            imageFile.addEventListener(
                "change",
                function ()
                {
                    const file =
                        this.files &&
                        this.files.length > 0
                            ? this.files[0]
                            : null;


                    if (currentPreviewUrl)
                    {
                        URL.revokeObjectURL(
                            currentPreviewUrl
                        );

                        currentPreviewUrl =
                            null;
                    }


                    if (!file)
                    {
                        imagePreview
                            .removeAttribute(
                                "src"
                            );


                        imagePreview.style.display =
                            "none";


                        return;
                    }


                    currentPreviewUrl =
                        URL.createObjectURL(
                            file
                        );


                    imagePreview.src =
                        currentPreviewUrl;


                    imagePreview.style.display =
                        "block";
                }
            );
        }

    })();

</script>


</body>

</html>