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
        Quản lý đơn hàng - HVPC Tech
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


        .order-page {
            padding: 42px 16px 70px;
        }


        .order-container {
            width: min(1120px, 100%);
            margin: 0 auto;
        }


        /* ============================== */
        /* PAGE HEADER */
        /* ============================== */

        .page-header {
            margin-bottom: 22px;
        }


        .page-title {
            margin-bottom: 5px;

            color: #0f172a;

            font-size: 1.8rem;
            font-weight: 800;
        }


        .page-description {
            color: #64748b;

            font-size: 0.9rem;
        }


        /* ============================== */
        /* ALERT */
        /* ============================== */

        .order-alert {
            margin-bottom: 16px;

            border-radius: 10px;
        }


        /* ============================== */
        /* TABLE CARD */
        /* ============================== */

        .order-card {
            overflow: hidden;

            background: #ffffff;

            border: 1px solid #e2e8f0;

            border-radius: 14px;

            box-shadow:
                    0 5px 20px
                    rgba(15, 23, 42, 0.06);
        }


        .order-table {
            width: 100%;

            margin: 0;

            table-layout: fixed;
        }


        /* ============================== */
        /* TABLE HEADER */
        /* ============================== */

        .order-table thead th {
            padding: 14px 10px;

            background: #111827;

            color: #ffffff;

            border-color: #374151;

            text-align: center;

            vertical-align: middle;

            font-size: 0.84rem;
            font-weight: 700;

            white-space: nowrap;
        }


        /* ============================== */
        /* TABLE BODY */
        /* ============================== */

        .order-table tbody td {
            padding: 14px 10px;

            vertical-align: middle;

            border-color: #e2e8f0;

            font-size: 0.84rem;
        }


        .order-table tbody tr:hover {
            background: #f8fafc;
        }


        .center-cell {
            text-align: center;
        }


        /* ============================== */
        /* ORDER ID */
        /* ============================== */

        .order-id {
            display: inline-flex;

            align-items: center;
            justify-content: center;

            padding: 5px 9px;

            color: #1d4ed8;
            background: #eff6ff;

            border-radius: 8px;

            font-weight: 750;
        }


        /* ============================== */
        /* CUSTOMER */
        /* ============================== */

        .customer-name {
            color: #0f172a;

            font-weight: 700;
        }


        .customer-email {
            display: block;

            margin-top: 3px;

            color: #64748b;

            font-size: 0.76rem;

            overflow: hidden;

            text-overflow: ellipsis;

            white-space: nowrap;
        }


        /* ============================== */
        /* PRICE */
        /* ============================== */

        .order-price {
            color: #dc2626;

            font-weight: 750;

            white-space: nowrap;
        }


        /* ============================== */
        /* STATUS */
        /* ============================== */

        .status-badge {
            display: inline-flex;

            align-items: center;
            justify-content: center;

            min-width: 92px;

            padding: 6px 10px;

            border-radius: 999px;

            font-size: 0.7rem;
            font-weight: 750;
        }


        /* ============================== */
        /* ACTION */
        /* ============================== */

        .action-cell {
            text-align: center;

            white-space: nowrap;
        }


        .action-box {
            display: flex;

            align-items: center;
            justify-content: center;

            flex-wrap: nowrap;

            gap: 7px;
        }


        .action-box form {
            display: inline-flex;

            margin: 0;
        }


        .action-btn {
            min-width: 55px;

            min-height: 34px;

            display: inline-flex;

            align-items: center;
            justify-content: center;

            padding: 6px 10px;

            border-radius: 7px;

            font-size: 0.76rem;
            font-weight: 650;

            white-space: nowrap;
        }


        /* ============================== */
        /* EMPTY */
        /* ============================== */

        .empty-box {
            padding: 20px;

            border: 1px solid #bae6fd;

            border-radius: 12px;

            background: #e0f2fe;

            color: #075985;
        }


        /* ============================== */
        /* RESPONSIVE */
        /* ============================== */

        @media (max-width: 850px) {

            .order-table {
                min-width: 900px;
            }

        }

    </style>

</head>


<body>


<jsp:include page="/WEB-INF/view/shared/navbar.jsp"/>


<div class="order-page">

    <div class="order-container">


        <div class="page-header">

            <h1 class="page-title">

                Quản lý đơn hàng

            </h1>


            <div class="page-description">

                Theo dõi, cập nhật và quản lý lịch sử mua hàng của hệ thống.

            </div>

        </div>


        <c:if test="${not empty success}">

            <div class="alert alert-success order-alert">

                <c:out value="${success}"/>

            </div>

        </c:if>


        <c:if test="${not empty error}">

            <div class="alert alert-danger order-alert">

                <c:out value="${error}"/>

            </div>

        </c:if>


        <c:if test="${empty orders}">

            <div class="empty-box">

                Hiện tại chưa có đơn hàng nào.

            </div>

        </c:if>


        <c:if test="${not empty orders}">


            <div class="order-card">


                <div class="table-responsive">


                    <table class="table table-hover order-table">


                        <colgroup>

                            <col style="width: 9%;">

                            <col style="width: 25%;">

                            <col style="width: 18%;">

                            <col style="width: 16%;">

                            <col style="width: 17%;">

                            <col style="width: 15%;">

                        </colgroup>


                        <thead>

                        <tr>

                            <th>
                                Mã đơn
                            </th>

                            <th>
                                Khách hàng
                            </th>

                            <th>
                                Ngày đặt
                            </th>

                            <th>
                                Tổng tiền
                            </th>

                            <th>
                                Trạng thái
                            </th>

                            <th>
                                Thao tác
                            </th>

                        </tr>

                        </thead>


                        <tbody>


                        <c:forEach
                                var="order"
                                items="${orders}">


                            <tr>


                                <td class="center-cell">

                                    <span class="order-id">

                                        #${order.id}

                                    </span>

                                </td>


                                <td>

                                    <div class="customer-name">

                                        <c:out value="${order.user.fullName}"/>

                                    </div>


                                    <span class="customer-email">

                                        <c:out value="${order.user.email}"/>

                                    </span>

                                </td>


                                <td class="center-cell">

                                        ${order.createdAt}

                                </td>


                                <td class="center-cell">

                                    <span class="order-price">

                                        <fmt:formatNumber
                                                value="${order.totalPrice}"
                                                type="number"
                                                maxFractionDigits="0"/>

                                        VNĐ

                                    </span>

                                </td>


                                <td class="center-cell">


                                    <c:choose>

                                        <c:when test="${order.status == 'COMPLETED'}">

                                            <span class="badge bg-success status-badge">

                                                COMPLETED

                                            </span>

                                        </c:when>

                                        <c:when test="${order.status == 'SHIPPING'}">

                                            <span class="badge bg-primary status-badge">

                                                SHIPPING

                                            </span>

                                        </c:when>

                                        <c:when test="${order.status == 'CONFIRMED'}">

                                            <span class="badge bg-info text-dark status-badge">

                                                CONFIRMED

                                            </span>

                                        </c:when>

                                        <c:when test="${order.status == 'CANCELLED'}">

                                            <span class="badge bg-danger status-badge">

                                                CANCELLED

                                            </span>

                                        </c:when>

                                        <c:otherwise>

                                            <span class="badge bg-warning text-dark status-badge">

                                                PENDING

                                            </span>

                                        </c:otherwise>

                                    </c:choose>


                                </td>


                                <td class="action-cell">


                                    <div class="action-box">


                                        <a
                                                href="${pageContext.request.contextPath}/admin/order/${order.id}"
                                                class="btn btn-info action-btn">

                                            Xem

                                        </a>


                                        <form
                                                method="post"
                                                action="${pageContext.request.contextPath}/admin/order/delete/${order.id}"
                                                onsubmit="return confirm('Bạn có chắc muốn xóa vĩnh viễn đơn hàng #${order.id}? Lịch sử của user cũng sẽ bị xóa.');">


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


        </c:if>


    </div>

</div>


</body>

</html>