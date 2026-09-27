<%@ page contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="form"
           uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>Đăng ký - Hoàng Vũ PC</title>

    <link
            rel="icon"
            type="image/png"
            href="${pageContext.request.contextPath}/favicon.png?v=2">

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>

<body class="bg-light">


<div class="container mt-5 mb-5">

    <div class="row justify-content-center">

        <div class="col-md-6">

            <div class="card shadow-sm">

                <div class="card-body p-4">


                    <h2 class="text-center fw-bold mb-4">
                        Đăng ký tài khoản
                    </h2>


                    <form:form
                            method="post"
                            action="${pageContext.request.contextPath}/register"
                            modelAttribute="registerDTO">


                        <input
                                type="hidden"
                                name="${_csrf.parameterName}"
                                value="${_csrf.token}">


                        <!-- ============================== -->
                        <!-- GLOBAL ERROR -->
                        <!-- ============================== -->

                        <form:errors
                                path="*"
                                cssClass="alert alert-danger"
                                element="div"/>


                        <!-- ============================== -->
                        <!-- FULL NAME -->
                        <!-- ============================== -->

                        <div class="mb-3">

                            <label class="form-label">
                                Họ và tên
                            </label>

                            <form:input
                                    path="fullName"
                                    cssClass="form-control"
                                    placeholder="Nhập họ và tên"/>

                            <form:errors
                                    path="fullName"
                                    cssClass="text-danger"/>

                        </div>


                        <!-- ============================== -->
                        <!-- EMAIL -->
                        <!-- ============================== -->

                        <div class="mb-3">

                            <label class="form-label">
                                Email
                            </label>

                            <form:input
                                    path="email"
                                    type="email"
                                    cssClass="form-control"
                                    placeholder="example@gmail.com"/>

                            <form:errors
                                    path="email"
                                    cssClass="text-danger"/>

                        </div>


                        <!-- ============================== -->
                        <!-- PASSWORD -->
                        <!-- ============================== -->

                        <div class="mb-3">

                            <label class="form-label">
                                Mật khẩu
                            </label>

                            <form:password
                                    path="password"
                                    cssClass="form-control"
                                    placeholder="Nhập mật khẩu"/>

                            <form:errors
                                    path="password"
                                    cssClass="text-danger"/>

                        </div>


                        <!-- ============================== -->
                        <!-- CONFIRM PASSWORD -->
                        <!-- ============================== -->

                        <div class="mb-3">

                            <label class="form-label">
                                Xác nhận mật khẩu
                            </label>

                            <form:password
                                    path="confirmPassword"
                                    cssClass="form-control"
                                    placeholder="Nhập lại mật khẩu"/>

                            <form:errors
                                    path="confirmPassword"
                                    cssClass="text-danger"/>

                        </div>


                        <!-- ============================== -->
                        <!-- PHONE -->
                        <!-- ============================== -->

                        <div class="mb-3">

                            <label class="form-label">
                                Số điện thoại
                            </label>

                            <form:input
                                    path="phone"
                                    cssClass="form-control"
                                    placeholder="Nhập số điện thoại"/>

                            <form:errors
                                    path="phone"
                                    cssClass="text-danger"/>

                        </div>


                        <!-- ============================== -->
                        <!-- ADDRESS -->
                        <!-- ============================== -->

                        <div class="mb-3">

                            <label class="form-label">
                                Địa chỉ
                            </label>

                            <form:input
                                    path="address"
                                    cssClass="form-control"
                                    placeholder="Nhập địa chỉ"/>

                            <form:errors
                                    path="address"
                                    cssClass="text-danger"/>

                        </div>


                        <div class="d-grid">

                            <button
                                    type="submit"
                                    class="btn btn-primary">

                                Đăng ký

                            </button>

                        </div>


                    </form:form>


                    <hr>


                    <div class="text-center">

                        Đã có tài khoản?

                        <a
                                href="${pageContext.request.contextPath}/login">

                            Đăng nhập

                        </a>

                    </div>


                    <div class="text-center mt-2">

                        <a
                                href="${pageContext.request.contextPath}/">

                            Quay lại trang chủ

                        </a>

                    </div>


                </div>

            </div>

        </div>

    </div>

</div>


</body>
</html>