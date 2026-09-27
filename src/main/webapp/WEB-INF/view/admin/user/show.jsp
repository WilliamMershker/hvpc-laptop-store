<%@ page contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c"
           uri="jakarta.tags.core" %>

<!DOCTYPE html>

<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Quản lý người dùng - Hoàng Vũ PC</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>

<body>

<jsp:include page="/WEB-INF/view/shared/navbar.jsp"/>


<div class="container mt-5 mb-5">


    <div class="d-flex justify-content-between align-items-center">

        <h2 class="fw-bold">
            Quản lý người dùng
        </h2>


        <a
                href="${pageContext.request.contextPath}/admin/user/create"
                class="btn btn-primary">

            + Thêm người dùng

        </a>

    </div>


    <hr>


    <c:if test="${not empty success}">

        <div class="alert alert-success">

            <c:out value="${success}"/>

        </div>

    </c:if>


    <c:if test="${not empty error}">

        <div class="alert alert-danger">

            <c:out value="${error}"/>

        </div>

    </c:if>


    <div class="table-responsive">

        <table class="table table-bordered table-hover align-middle">

            <thead class="table-dark">

            <tr>

                <th>STT</th>

                <th>Email</th>

                <th>Họ tên</th>

                <th>Điện thoại</th>

                <th>Địa chỉ</th>

                <th>Role</th>

                <th>Thao tác</th>

            </tr>

            </thead>


            <tbody>


            <c:forEach
                    var="user"
                    items="${users}"
                    varStatus="status">

                <tr>

                    <td>
                            ${status.count}
                    </td>


                    <td>
                        <c:out value="${user.email}"/>
                    </td>


                    <td>
                        <c:out value="${user.fullName}"/>
                    </td>


                    <td>
                        <c:out value="${user.phone}"/>
                    </td>


                    <td>
                        <c:out value="${user.address}"/>
                    </td>


                    <td>

                        <c:forEach
                                var="role"
                                items="${user.roles}">

                            <span class="badge bg-dark">

                                <c:out value="${role.name}"/>

                            </span>

                        </c:forEach>

                    </td>


                    <td>

                        <div class="d-flex gap-2">

                            <a
                                    href="${pageContext.request.contextPath}/admin/user/update/${user.id}"
                                    class="btn btn-warning btn-sm">

                                Sửa

                            </a>


                            <form
                                    method="post"
                                    action="${pageContext.request.contextPath}/admin/user/delete/${user.id}"
                                    style="display:inline;"
                                    onsubmit="return confirm('Bạn có chắc muốn xóa tài khoản này?');">


                                <input
                                        type="hidden"
                                        name="${_csrf.parameterName}"
                                        value="${_csrf.token}">


                                <button
                                        type="submit"
                                        class="btn btn-danger btn-sm">

                                    Xóa

                                </button>

                            </form>

                        </div>

                    </td>

                </tr>

            </c:forEach>


            <c:if test="${empty users}">

                <tr>

                    <td
                            colspan="7"
                            class="text-center text-muted">

                        Chưa có tài khoản.

                    </td>

                </tr>

            </c:if>

            </tbody>

        </table>

    </div>

</div>


</body>
</html>