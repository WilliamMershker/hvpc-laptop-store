<%@ page contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c"
           uri="jakarta.tags.core" %>

<%@ taglib prefix="fmt"
           uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng</title>

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

    <h2>
        Đơn hàng #${order.id}
    </h2>

    <hr>


    <p>
        <strong>Khách hàng:</strong>
        <c:out value="${order.user.fullName}"/>
    </p>


    <p>
        <strong>Email:</strong>
        <c:out value="${order.user.email}"/>
    </p>


    <p>
        <strong>Ngày đặt:</strong>
        ${order.createdAt}
    </p>


    <p>
        <strong>Trạng thái:</strong>
        <c:out value="${order.status}"/>
    </p>


    <table class="table table-bordered">

        <thead class="table-dark">

        <tr>

            <th>Sản phẩm</th>

            <th>Giá</th>

            <th>Số lượng</th>

            <th>Thành tiền</th>

        </tr>

        </thead>


        <tbody>

        <c:forEach
                var="detail"
                items="${orderDetails}">

            <tr>

                <td>
                    <c:out value="${detail.product.name}"/>
                </td>


                <td>

                    <fmt:formatNumber
                            value="${detail.price}"
                            type="number"
                            maxFractionDigits="0"/>

                    VNĐ

                </td>


                <td>
                        ${detail.quantity}
                </td>


                <td>

                    <fmt:formatNumber
                            value="${detail.price * detail.quantity}"
                            type="number"
                            maxFractionDigits="0"/>

                    VNĐ

                </td>

            </tr>

        </c:forEach>

        </tbody>

    </table>


    <h4 class="text-end">

        Tổng:

        <fmt:formatNumber
                value="${order.totalPrice}"
                type="number"
                maxFractionDigits="0"/>

        VNĐ

    </h4>


    <hr>


    <form
            method="post"
            action="${pageContext.request.contextPath}/admin/order/${order.id}/status">


        <input
                type="hidden"
                name="${_csrf.parameterName}"
                value="${_csrf.token}">


        <div class="row">

            <div class="col-md-5">

                <select
                        name="status"
                        class="form-select">

                    <option value="PENDING">
                        PENDING
                    </option>

                    <option value="CONFIRMED">
                        CONFIRMED
                    </option>

                    <option value="SHIPPING">
                        SHIPPING
                    </option>

                    <option value="COMPLETED">
                        COMPLETED
                    </option>

                    <option value="CANCELLED">
                        CANCELLED
                    </option>

                </select>

            </div>


            <div class="col-md-3">

                <button
                        class="btn btn-warning"
                        type="submit">

                    Cập nhật trạng thái

                </button>

            </div>

        </div>

    </form>

    <a
            href="${pageContext.request.contextPath}/admin/order"
            class="btn btn-secondary mt-4">

        Quay lại

    </a>

</div>


</body>
</html>