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

    <title>
        Cập nhật sản phẩm - Hoàng Vũ PC
    </title>

    <link
            rel="icon"
            type="image/png"
            href="${pageContext.request.contextPath}/favicon.png?v=2">

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>

<body>

<jsp:include page="/WEB-INF/view/shared/navbar.jsp"/>


<div class="container mt-5 mb-5">

    <div class="row justify-content-center">

        <div class="col-md-8">

            <div class="card shadow-sm">

                <div class="card-body p-4">

                    <h2 class="fw-bold">
                        Cập nhật sản phẩm
                    </h2>

                    <hr>


                    <form:form

                            method="post"

                            action="${pageContext.request.contextPath}/admin/product/update/${product.id}?${_csrf.parameterName}=${_csrf.token}"

                            modelAttribute="product"

                            enctype="multipart/form-data">


                        <input
                                type="hidden"

                                name="${_csrf.parameterName}"

                                value="${_csrf.token}">


                        <div class="mb-3">

                            <label class="form-label">
                                Tên laptop
                            </label>

                            <form:input
                                    path="name"
                                    cssClass="form-control"/>

                        </div>


                        <div class="mb-3">

                            <label class="form-label">
                                Giá
                            </label>

                            <form:input
                                    path="price"
                                    type="number"
                                    min="1"
                                    step="0.01"
                                    cssClass="form-control"/>

                        </div>


                        <div class="mb-3">

                            <label class="form-label">
                                Số lượng
                            </label>

                            <form:input
                                    path="quantity"
                                    type="number"
                                    min="0"
                                    cssClass="form-control"/>

                        </div>


                        <div class="mb-3">

                            <label class="form-label">
                                Hãng
                            </label>

                            <form:input
                                    path="manufacturer"
                                    cssClass="form-control"/>

                        </div>


                        <div class="mb-3">

                            <label class="form-label">
                                Mô tả
                            </label>

                            <form:textarea
                                    path="shortDescription"
                                    cssClass="form-control"
                                    rows="4"/>

                        </div>


                        <c:if test="${not empty product.image}">

                            <div class="mb-3">

                                <label class="form-label">
                                    Ảnh hiện tại
                                </label>

                                <br>

                                <img

                                        src="${pageContext.request.contextPath}/uploads/products/${product.image}"

                                        alt="${product.name}"

                                        class="img-thumbnail"

                                        style="max-width: 300px;">

                            </div>

                        </c:if>


                        <div class="mb-3">

                            <label class="form-label">
                                Chọn ảnh mới
                            </label>

                            <input
                                    type="file"

                                    id="imageFile"

                                    name="imageFile"

                                    class="form-control"

                                    accept="image/*">

                            <small class="text-muted">

                                Không chọn thì giữ ảnh hiện tại.

                            </small>

                        </div>


                        <div class="mb-3">

                            <img
                                    id="imagePreview"

                                    class="img-thumbnail"

                                    alt="Preview"

                                    style="
                                        max-width: 300px;
                                        display: none;
                                    ">

                        </div>


                        <button
                                type="submit"
                                class="btn btn-warning">

                            Cập nhật

                        </button>


                        <a
                                href="${pageContext.request.contextPath}/admin/product"
                                class="btn btn-secondary">

                            Quay lại

                        </a>


                    </form:form>

                </div>

            </div>

        </div>

    </div>

</div>


<script>

    const imageFile =
        document.getElementById("imageFile");

    const imagePreview =
        document.getElementById("imagePreview");


    imageFile.addEventListener(
        "change",

        function ()
        {
            const file =
                this.files[0];

            if (file)
            {
                imagePreview.src =
                    URL.createObjectURL(file);

                imagePreview.style.display =
                    "block";
            }
            else
            {
                imagePreview.style.display =
                    "none";
            }
        }
    );
</script>


</body>

</html>