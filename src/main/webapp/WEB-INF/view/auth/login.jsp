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

    <title>Đăng nhập - Hoàng Vũ PC</title>
    <link
            rel="icon"
            type="image/png"
            href="${pageContext.request.contextPath}/favicon.png?v=2">

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>

<body class="bg-light">


<div class="container mt-5">

    <div class="row justify-content-center">

        <div class="col-md-5">

            <div class="card shadow-sm">

                <div class="card-body p-4">


                    <h2 class="text-center fw-bold mb-4">
                        Đăng nhập
                    </h2>


                    <!-- ============================== -->
                    <!-- REGISTER SUCCESS -->
                    <!-- ============================== -->

                    <c:if test="${param.registerSuccess != null}">

                        <div class="alert alert-success">

                            Đăng ký thành công.
                            Bạn có thể đăng nhập.

                        </div>

                    </c:if>


                    <!-- ============================== -->
                    <!-- LOGIN ERROR -->
                    <!-- ============================== -->

                    <c:if test="${param.error != null}">

                        <div class="alert alert-danger">

                            Email hoặc mật khẩu không chính xác.

                        </div>

                    </c:if>


                    <!-- ============================== -->
                    <!-- LOGOUT SUCCESS -->
                    <!-- ============================== -->

                    <c:if test="${param.logout != null}">

                        <div class="alert alert-success">

                            Đăng xuất thành công.

                        </div>

                    </c:if>


                    <!-- ============================== -->
                    <!-- LOGIN FORM -->
                    <!-- ============================== -->

                    <form
                            method="post"
                            action="${pageContext.request.contextPath}/login">


                        <input
                                type="hidden"
                                name="${_csrf.parameterName}"
                                value="${_csrf.token}">


                        <!-- EMAIL -->

                        <div class="mb-3">

                            <label class="form-label">
                                Email
                            </label>

                            <input
                                    type="email"
                                    name="email"
                                    class="form-control"
                                    placeholder="example@gmail.com"
                                    required>

                        </div>


                        <!-- PASSWORD -->

                        <div class="mb-3">

                            <label class="form-label">
                                Mật khẩu
                            </label>

                            <input
                                    type="password"
                                    name="password"
                                    class="form-control"
                                    placeholder="Nhập mật khẩu"
                                    required>

                        </div>


                        <!-- REMEMBER ME -->

                        <div class="form-check mb-3">

                            <input
                                    type="checkbox"
                                    name="remember-me"
                                    id="remember-me"
                                    class="form-check-input">

                            <label
                                    for="remember-me"
                                    class="form-check-label">

                                Ghi nhớ đăng nhập

                            </label>

                        </div>


                        <div class="d-grid">

                            <button
                                    type="submit"
                                    class="btn btn-primary">

                                Đăng nhập

                            </button>

                        </div>


                    </form>


                    <hr>


                    <div class="text-center">

                        Chưa có tài khoản?

                        <a
                                href="${pageContext.request.contextPath}/register">

                            Đăng ký

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