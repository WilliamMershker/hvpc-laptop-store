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

    <title>Thanh toán - Hoàng Vũ PC</title>

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

    <h2 class="fw-bold">
        Thanh toán
    </h2>

    <hr>


    <div class="row">


        <div class="col-md-5">

            <div class="card mb-4">

                <div class="card-body">

                    <h4>
                        Thông tin người mua
                    </h4>

                    <hr>


                    <p>
                        <strong>Họ tên:</strong>
                        <c:out value="${user.fullName}"/>
                    </p>


                    <p>
                        <strong>Email:</strong>
                        <c:out value="${user.email}"/>
                    </p>


                    <p>
                        <strong>Số điện thoại:</strong>
                        <c:out value="${user.phone}"/>
                    </p>


                    <p>
                        <strong>Địa chỉ:</strong>
                        <c:out value="${user.address}"/>
                    </p>

                </div>

            </div>

        </div>


        <div class="col-md-7">

            <div class="card">

                <div class="card-body">

                    <h4>
                        Đơn hàng
                    </h4>

                    <hr>


                    <table class="table">

                        <thead>

                        <tr>
                            <th>Sản phẩm</th>
                            <th>SL</th>
                            <th>Giá</th>
                            <th>Thành tiền</th>
                        </tr>

                        </thead>


                        <tbody>

                        <c:forEach
                                var="item"
                                items="${cartItems}">

                            <tr>

                                <td>
                                    <c:out value="${item.product.name}"/>
                                </td>

                                <td>
                                        ${item.quantity}
                                </td>

                                <td>

                                    <fmt:formatNumber
                                            value="${item.product.price}"
                                            type="number"
                                            maxFractionDigits="0"/>

                                    VNĐ

                                </td>

                                <td>

                                    <fmt:formatNumber
                                            value="${item.subtotal}"
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

                        <span class="text-danger">

                            <fmt:formatNumber
                                    value="${totalPrice}"
                                    type="number"
                                    maxFractionDigits="0"/>

                            VNĐ

                        </span>

                    </h4>


                    <div class="d-flex justify-content-end gap-2 mt-4">

                        <a
                                href="${pageContext.request.contextPath}/cart"
                                class="btn btn-secondary">

                            Quay lại

                        </a>


                        <form
                                method="post"
                                action="${pageContext.request.contextPath}/checkout">


                            <input
                                    type="hidden"
                                    name="${_csrf.parameterName}"
                                    value="${_csrf.token}">


                            <button
                                    type="submit"
                                    class="btn btn-success">

                                Đặt hàng

                            </button>

                        </form>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>


</body>
</html>