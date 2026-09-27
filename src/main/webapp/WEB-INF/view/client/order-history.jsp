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

    <title>Lịch sử mua hàng - Hoàng Vũ PC</title>

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


<div class="container mt-5">

    <h2 class="fw-bold">
        Lịch sử mua hàng
    </h2>

    <hr>


    <c:if test="${empty orders}">

        <div class="alert alert-info">

            Bạn chưa có đơn hàng nào.

        </div>

    </c:if>


    <c:if test="${not empty orders}">

        <table class="table table-bordered table-hover">

            <thead class="table-dark">

            <tr>

                <th>Mã đơn</th>

                <th>Ngày đặt</th>

                <th>Tổng tiền</th>

                <th>Trạng thái</th>

            </tr>

            </thead>


            <tbody>

            <c:forEach
                    var="order"
                    items="${orders}">

                <tr>

                    <td>
                        #${order.id}
                    </td>


                    <td>
                            ${order.createdAt}
                    </td>


                    <td>

                        <fmt:formatNumber
                                value="${order.totalPrice}"
                                type="number"
                                maxFractionDigits="0"/>

                        VNĐ

                    </td>


                    <td>

                        <span class="badge bg-secondary">

                            <c:out value="${order.status}"/>

                        </span>

                    </td>

                </tr>

            </c:forEach>

            </tbody>

        </table>

    </c:if>

</div>


</body>
</html>