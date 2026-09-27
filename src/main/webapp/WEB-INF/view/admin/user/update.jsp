<%@ page contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="form"
           uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="c"
           uri="jakarta.tags.core" %>

<%@ taglib prefix="fn"
           uri="jakarta.tags.functions" %>

<!DOCTYPE html>

<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Cập nhật người dùng - Hoàng Vũ PC</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>

<body>

<jsp:include page="/WEB-INF/view/shared/navbar.jsp"/>


<div class="container mt-5">

    <div class="row justify-content-center">

        <div class="col-md-7">

            <div class="card shadow-sm">

                <div class="card-body p-4">


                    <h2 class="fw-bold">
                        Cập nhật người dùng
                    </h2>

                    <hr>


                    <c:if test="${not empty error}">

                        <div class="alert alert-danger">

                            <c:out value="${error}"/>

                        </div>

                    </c:if>


                    <form:form
                            method="post"
                            modelAttribute="user"
                            action="${pageContext.request.contextPath}/admin/user/update/${user.id}">


                        <input
                                type="hidden"
                                name="${_csrf.parameterName}"
                                value="${_csrf.token}">


                        <div class="mb-3">

                            <label class="form-label">
                                Email
                            </label>

                            <form:input
                                    path="email"
                                    type="email"
                                    cssClass="form-control"/>

                            <form:errors
                                    path="email"
                                    cssClass="text-danger"/>

                        </div>


                        <div class="mb-3">

                            <label class="form-label">
                                Mật khẩu mới
                            </label>

                            <form:password
                                    path="password"
                                    cssClass="form-control"/>

                            <small class="text-muted">
                                Để trống nếu không muốn đổi mật khẩu.
                            </small>

                        </div>


                        <div class="mb-3">

                            <label class="form-label">
                                Họ tên
                            </label>

                            <form:input
                                    path="fullName"
                                    cssClass="form-control"/>

                            <form:errors
                                    path="fullName"
                                    cssClass="text-danger"/>

                        </div>


                        <div class="mb-3">

                            <label class="form-label">
                                Số điện thoại
                            </label>

                            <form:input
                                    path="phone"
                                    cssClass="form-control"/>

                        </div>


                        <div class="mb-3">

                            <label class="form-label">
                                Địa chỉ
                            </label>

                            <form:input
                                    path="address"
                                    cssClass="form-control"/>

                        </div>


                        <div class="mb-3">

                            <label class="form-label">
                                Quyền
                            </label>


                            <c:forEach
                                    var="role"
                                    items="${allRoles}">

                                <div class="form-check">

                                    <input
                                            type="checkbox"
                                            class="form-check-input"
                                            name="roleNames"
                                            value="${role.name}"
                                            id="role_${role.id}">


                                    <label
                                            class="form-check-label"
                                            for="role_${role.id}">

                                        <c:out value="${role.name}"/>

                                    </label>

                                </div>

                            </c:forEach>

                        </div>


                        <button
                                type="submit"
                                class="btn btn-warning">

                            Cập nhật

                        </button>


                        <a
                                href="${pageContext.request.contextPath}/admin/user"
                                class="btn btn-secondary">

                            Quay lại

                        </a>


                    </form:form>

                </div>

            </div>

        </div>

    </div>

</div>


</body>
</html>