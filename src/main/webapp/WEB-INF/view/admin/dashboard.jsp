<%@ page contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="fmt"
           uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Dashboard - Hoàng Vũ PC</title>

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
        Dashboard
    </h2>

    <hr>


    <div class="row g-4">

        <div class="col-md-3">

            <div class="card shadow-sm">

                <div class="card-body">

                    <h5>Sản phẩm</h5>

                    <h2>
                        ${productCount}
                    </h2>

                </div>

            </div>

        </div>


        <div class="col-md-3">

            <div class="card shadow-sm">

                <div class="card-body">

                    <h5>Người dùng</h5>

                    <h2>
                        ${userCount}
                    </h2>

                </div>

            </div>

        </div>


        <div class="col-md-3">

            <div class="card shadow-sm">

                <div class="card-body">

                    <h5>Đơn hàng</h5>

                    <h2>
                        ${orderCount}
                    </h2>

                </div>

            </div>

        </div>


        <div class="col-md-3">

            <div class="card shadow-sm">

                <div class="card-body">

                    <h5>Doanh thu</h5>

                    <h4 class="text-danger">

                        <fmt:formatNumber
                                value="${revenue}"
                                type="number"
                                maxFractionDigits="0"/>

                        VNĐ

                    </h4>

                </div>

            </div>

        </div>

    </div>

</div>


</body>
</html>