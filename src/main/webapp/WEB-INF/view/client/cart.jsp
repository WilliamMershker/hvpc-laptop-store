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

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>Giỏ hàng - Hoàng Vũ PC</title>

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


    <div class="d-flex justify-content-between align-items-center">

        <h2 class="fw-bold">
            Giỏ hàng
        </h2>


        <a
                href="${pageContext.request.contextPath}/"
                class="btn btn-outline-secondary">

            Tiếp tục mua hàng

        </a>

    </div>


    <hr>


    <!-- ============================== -->
    <!-- ERROR -->
    <!-- ============================== -->

    <c:if test="${not empty error}">

        <div class="alert alert-danger">

            <c:out value="${error}"/>

        </div>

    </c:if>


    <!-- ============================== -->
    <!-- CART EMPTY -->
    <!-- ============================== -->

    <c:if test="${empty cartItems}">

        <div class="alert alert-info">

            Giỏ hàng của bạn đang trống.

        </div>


        <a
                href="${pageContext.request.contextPath}/"
                class="btn btn-primary">

            Mua sản phẩm

        </a>

    </c:if>


    <!-- ============================== -->
    <!-- CART HAS PRODUCT -->
    <!-- ============================== -->

    <c:if test="${not empty cartItems}">


        <div class="table-responsive">

            <table class="table table-bordered table-hover align-middle">


                <thead class="table-dark">

                <tr>

                    <th style="width: 70px;">
                        STT
                    </th>

                    <th>
                        Sản phẩm
                    </th>

                    <th style="width: 160px;">
                        Giá
                    </th>

                    <th style="width: 190px;">
                        Số lượng
                    </th>

                    <th style="width: 180px;">
                        Thành tiền
                    </th>

                    <th style="width: 100px;">
                        Thao tác
                    </th>

                </tr>

                </thead>


                <tbody>


                <c:forEach
                        var="item"
                        items="${cartItems}"
                        varStatus="status">


                    <tr>


                        <!-- STT -->

                        <td>
                                ${status.count}
                        </td>


                        <!-- PRODUCT -->

                        <td>

                            <div class="fw-bold">

                                <c:out value="${item.product.name}"/>

                            </div>


                            <small class="text-muted">

                                <c:out value="${item.product.manufacturer}"/>

                            </small>

                        </td>


                        <!-- PRICE -->

                        <td>

                            <fmt:formatNumber
                                    value="${item.product.price}"
                                    type="number"
                                    maxFractionDigits="0"/>

                            VNĐ

                        </td>


                        <!-- QUANTITY -->

                        <td>

                            <div class="d-flex align-items-center gap-2">


                                <!-- DECREASE -->

                                <form
                                        method="post"
                                        action="${pageContext.request.contextPath}/cart/decrease/${item.product.id}"
                                        style="margin:0;">


                                    <input
                                            type="hidden"
                                            name="${_csrf.parameterName}"
                                            value="${_csrf.token}">


                                    <button
                                            type="submit"
                                            class="btn btn-outline-secondary btn-sm">

                                        -

                                    </button>

                                </form>


                                <span class="fw-bold px-2">

                                        ${item.quantity}

                                </span>


                                <!-- INCREASE -->

                                <form
                                        method="post"
                                        action="${pageContext.request.contextPath}/cart/increase/${item.product.id}"
                                        style="margin:0;">


                                    <input
                                            type="hidden"
                                            name="${_csrf.parameterName}"
                                            value="${_csrf.token}">


                                    <button
                                            type="submit"
                                            class="btn btn-outline-primary btn-sm">

                                        +

                                    </button>

                                </form>


                            </div>

                        </td>


                        <!-- SUBTOTAL -->

                        <td>

                            <strong class="text-danger">

                                <fmt:formatNumber
                                        value="${item.subtotal}"
                                        type="number"
                                        maxFractionDigits="0"/>

                                VNĐ

                            </strong>

                        </td>


                        <!-- REMOVE -->

                        <td>

                            <form
                                    method="post"
                                    action="${pageContext.request.contextPath}/cart/remove/${item.product.id}"
                                    style="margin:0;"
                                    onsubmit="return confirm('Xóa sản phẩm này khỏi giỏ hàng?');">


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

                        </td>


                    </tr>


                </c:forEach>


                </tbody>


            </table>

        </div>


        <!-- ============================== -->
        <!-- TOTAL -->
        <!-- ============================== -->

        <div class="row mt-4">


            <div class="col-md-6">

            </div>


            <div class="col-md-6">


                <div class="card shadow-sm">

                    <div class="card-body">


                        <div class="d-flex justify-content-between align-items-center">

                            <h4 class="mb-0">
                                Tổng tiền:
                            </h4>


                            <h4 class="mb-0 text-danger fw-bold">

                                <fmt:formatNumber
                                        value="${totalPrice}"
                                        type="number"
                                        maxFractionDigits="0"/>

                                VNĐ

                            </h4>

                        </div>


                        <hr>

                        <!--
                            BƯỚC 6:
                            Không POST /checkout ở Cart nữa.

                            Đi tới GET /checkout
                            để hiển thị trang xác nhận đơn hàng.
                        -->

                        <div class="d-grid">

                            <a
                                    href="${pageContext.request.contextPath}/checkout"
                                    class="btn btn-success btn-lg">

                                Thanh toán

                            </a>

                        </div>


                    </div>

                </div>


            </div>

        </div>


    </c:if>


</div>


<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


</body>

</html>