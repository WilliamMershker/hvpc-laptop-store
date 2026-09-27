<%@ page contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="fmt"
           uri="jakarta.tags.fmt" %>


<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>Mua hàng thành công - Hoàng Vũ PC</title>

    <link
            rel="icon"
            type="image/png"
            href="${pageContext.request.contextPath}/favicon.png?v=2">

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>

<body>


<jsp:include page="/WEB-INF/view/shared/navbar.jsp"/>


<div class="container mt-5">

    <div class="row justify-content-center">

        <div class="col-md-7">


            <div class="card shadow-sm">

                <div class="card-body p-5 text-center">


                    <h1 class="text-success fw-bold">

                        ✓ Mua hàng thành công

                    </h1>


                    <p class="mt-4">

                        Mã đơn hàng:

                        <strong>
                            #${order.id}
                        </strong>

                    </p>


                    <p>

                        Tổng tiền:

                        <strong class="text-danger">

                            <fmt:formatNumber
                                    value="${order.totalPrice}"
                                    type="number"
                                    maxFractionDigits="0"/>

                            VNĐ

                        </strong>

                    </p>


                    <p>

                        Trạng thái:

                        <strong>
                            ${order.status}
                        </strong>

                    </p>


                    <a
                            href="${pageContext.request.contextPath}/"
                            class="btn btn-primary mt-3">

                        Tiếp tục mua hàng

                    </a>


                </div>

            </div>

        </div>

    </div>

</div>


</body>

</html>