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

    <title>
        Quản lý sản phẩm - HVPC Tech
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
            background: #f8fafc;
            color: #0f172a;
        }


        .product-admin-page {
            padding:
                    42px 16px
                    70px;
        }


        .product-admin-container {
            width: min(1120px, 100%);
            margin: 0 auto;
        }


        /* ====================================== */
        /* HEADER */
        /* ====================================== */

        .page-header {
            display: flex;

            align-items: center;
            justify-content: space-between;

            gap: 20px;

            margin-bottom: 18px;
        }


        .page-title {
            margin: 0;

            font-size: 1.8rem;
            font-weight: 800;
        }


        .add-product-btn {
            min-height: 40px;

            display: inline-flex;

            align-items: center;
            justify-content: center;

            padding: 8px 16px;

            border-radius: 9px;

            font-size: 0.86rem;
            font-weight: 650;
        }


        /* ====================================== */
        /* TABLE CARD */
        /* ====================================== */

        .table-card {
            overflow: hidden;

            background: #ffffff;

            border: 1px solid #e2e8f0;
            border-radius: 14px;

            box-shadow:
                    0 5px 20px
                    rgba(15, 23, 42, 0.06);
        }


        .product-table {
            width: 100%;

            margin: 0;

            table-layout: auto;
        }


        /* ====================================== */
        /* HEADER TABLE */
        /* ====================================== */

        .product-table thead th {
            padding: 15px 10px;

            vertical-align: middle;

            text-align: center;

            background: #212529;

            color: #ffffff;

            border-color: #374151;

            font-size: 0.85rem;
            font-weight: 700;

            white-space: nowrap;
        }


        /* ====================================== */
        /* BODY TABLE */
        /* ====================================== */

        .product-table tbody td {
            padding: 14px 10px;

            vertical-align: middle;

            border-color: #e2e8f0;

            font-size: 0.85rem;
        }


        .stt-cell {
            width: 55px;

            text-align: center;

            font-weight: 650;
        }


        .name-cell {
            min-width: 390px;

            text-align: left;

            line-height: 1.45;
        }


        .manufacturer-cell {
            width: 90px;

            text-align: center;

            white-space: nowrap;
        }


        .price-cell {
            width: 135px;

            text-align: center;

            color: #dc2626;

            font-weight: 700;

            white-space: nowrap;
        }


        .quantity-cell {
            width: 100px;

            text-align: center;

            white-space: nowrap;
        }


        .action-cell {
            width: 210px;

            text-align: center;

            white-space: nowrap;
        }


        /* ====================================== */
        /* ACTION BUTTONS */
        /* ====================================== */

        .action-group {
            display: flex;

            align-items: center;
            justify-content: center;

            flex-wrap: nowrap;

            gap: 6px;
        }


        .action-group form {
            display: inline-flex;

            margin: 0;
        }


        .action-btn {
            min-width: 52px;

            min-height: 34px;

            display: inline-flex;

            align-items: center;
            justify-content: center;

            padding: 6px 10px;

            border-radius: 7px;

            font-size: 0.78rem;
            font-weight: 650;

            white-space: nowrap;
        }


        /* ====================================== */
        /* ALERT */
        /* ====================================== */

        .admin-alert {
            margin-bottom: 14px;

            border-radius: 10px;
        }


        /* ====================================== */
        /* RESPONSIVE */
        /* ====================================== */

        @media (max-width: 900px) {

            .name-cell {
                min-width: 300px;
            }


            .action-cell {
                min-width: 190px;
            }

        }


        @media (max-width: 600px) {

            .page-header {
                align-items: stretch;

                flex-direction: column;
            }


            .add-product-btn {
                width: 100%;
            }

        }

    </style>

</head>


<body>


<jsp:include page="/WEB-INF/view/shared/navbar.jsp"/>


<div class="product-admin-page">

    <div class="product-admin-container">


        <div class="page-header">


            <h1 class="page-title">

                Quản lý sản phẩm

            </h1>


            <a
                    href="${pageContext.request.contextPath}/admin/product/create"
                    class="btn btn-primary add-product-btn">

                + Thêm sản phẩm

            </a>


        </div>


        <hr>


        <c:if test="${not empty success}">

            <div class="alert alert-success admin-alert">

                <c:out value="${success}"/>

            </div>

        </c:if>


        <c:if test="${not empty error}">

            <div class="alert alert-danger admin-alert">

                <c:out value="${error}"/>

            </div>

        </c:if>


        <div class="table-card">

            <div class="table-responsive">


                <table class="table table-bordered table-hover product-table">


                    <thead>

                    <tr>

                        <th>
                            STT
                        </th>

                        <th>
                            Tên
                        </th>

                        <th>
                            Hãng
                        </th>

                        <th>
                            Giá
                        </th>

                        <th>
                            Số lượng
                        </th>

                        <th>
                            Thao tác
                        </th>

                    </tr>

                    </thead>


                    <tbody>


                    <c:forEach
                            var="product"
                            items="${products}"
                            varStatus="status">


                        <tr>


                            <td class="stt-cell">

                                    ${status.count}

                            </td>


                            <td class="name-cell">

                                <c:out value="${product.name}"/>

                            </td>


                            <td class="manufacturer-cell">

                                <c:out value="${product.manufacturer}"/>

                            </td>


                            <td class="price-cell">

                                <fmt:formatNumber
                                        value="${product.price}"
                                        type="number"
                                        maxFractionDigits="0"/>

                                VNĐ

                            </td>


                            <td class="quantity-cell">

                                    ${product.quantity}

                            </td>


                            <td class="action-cell">


                                <div class="action-group">


                                    <a
                                            href="${pageContext.request.contextPath}/product/${product.id}"
                                            class="btn btn-info action-btn">

                                        Xem

                                    </a>


                                    <a
                                            href="${pageContext.request.contextPath}/admin/product/update/${product.id}"
                                            class="btn btn-warning action-btn">

                                        Sửa

                                    </a>


                                    <form
                                            method="post"
                                            action="${pageContext.request.contextPath}/admin/product/delete/${product.id}"
                                            onsubmit="return confirm('M có chắc muốn xóa sản phẩm này?');">


                                        <input
                                                type="hidden"
                                                name="${_csrf.parameterName}"
                                                value="${_csrf.token}">


                                        <button
                                                type="submit"
                                                class="btn btn-danger action-btn">

                                            Xóa

                                        </button>


                                    </form>


                                </div>


                            </td>


                        </tr>


                    </c:forEach>


                    </tbody>


                </table>


            </div>

        </div>


    </div>

</div>


</body>

</html>