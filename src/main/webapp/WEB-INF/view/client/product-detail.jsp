<%@ page contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c"
           uri="jakarta.tags.core" %>

<%@ taglib prefix="fmt"
           uri="jakarta.tags.fmt" %>

<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>


<!DOCTYPE html>

<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>
        Chi tiết laptop - Hoàng Vũ PC
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
            background: #ffffff;

            color: #0f172a;
        }


        .detail-page {
            padding:
                    42px 16px
                    70px;
        }


        .detail-container {
            width:
                    min(
                            1120px,
                            100%
                    );

            margin: 0 auto;
        }


        .product-detail-grid {
            display: grid;

            grid-template-columns:
                    0.9fr
                    1.3fr;

            gap: 22px;

            align-items: start;
        }


        /* ====================================== */
        /* IMAGE CARD */
        /* ====================================== */

        .image-card {
            min-height: 420px;

            display: flex;

            align-items: center;

            justify-content: center;

            overflow: hidden;

            background: #ffffff;

            border:
                    1px solid #e2e8f0;

            border-radius: 14px;

            box-shadow:
                    0 4px 14px
                    rgba(15, 23, 42, 0.06);
        }


        .product-image {
            width: 100%;

            height: 410px;

            object-fit: contain;

            padding: 24px;
        }


        .no-image {
            width: 100%;

            min-height: 410px;

            display: flex;

            align-items: center;

            justify-content: center;

            color: #94a3b8;

            background: #f8fafc;

            font-size: 0.95rem;
        }


        /* ====================================== */
        /* INFO CARD */
        /* ====================================== */

        .info-card {
            padding: 26px;

            background: #ffffff;

            border:
                    1px solid #e2e8f0;

            border-radius: 14px;

            box-shadow:
                    0 4px 14px
                    rgba(15, 23, 42, 0.06);
        }


        .product-title {
            margin: 0;

            color: #111827;

            font-size: 1.85rem;

            font-weight: 800;

            line-height: 1.22;
        }


        .divider {
            height: 1px;

            margin:
                    18px 0;

            background: #e2e8f0;
        }


        .manufacturer {
            margin-bottom: 15px;

            color: #334155;

            font-size: 0.95rem;
        }


        .product-price {
            margin-bottom: 13px;

            color: #dc2626;

            font-size: 1.65rem;

            font-weight: 800;
        }


        .stock {
            margin-bottom: 18px;

            color: #334155;

            font-size: 0.95rem;
        }


        .description-title {
            margin-bottom: 7px;

            color: #0f172a;

            font-weight: 700;
        }


        .description {
            margin: 0;

            color: #64748b;

            line-height: 1.65;
        }


        /* ====================================== */
        /* ACTION */
        /* ====================================== */

        .action-area {
            display: flex;

            flex-wrap: wrap;

            gap: 8px;
        }


        .action-area form {
            margin: 0;
        }


        .action-area .btn {
            min-height: 40px;

            border-radius: 8px;

            font-size: 0.88rem;

            font-weight: 600;
        }


        /* ====================================== */
        /* MOBILE */
        /* ====================================== */

        @media (max-width: 800px) {

            .product-detail-grid {
                grid-template-columns: 1fr;
            }


            .image-card {
                min-height: 320px;
            }


            .product-image {
                height: 310px;
            }


            .no-image {
                min-height: 310px;
            }


            .product-title {
                font-size: 1.5rem;
            }

        }

    </style>

</head>


<body>


<jsp:include page="/WEB-INF/view/shared/navbar.jsp"/>


<div class="detail-page">

    <div class="detail-container">


        <div class="product-detail-grid">


            <div class="image-card">


                <c:choose>

                    <c:when test="${not empty product.image}">

                        <img
                                src="${pageContext.request.contextPath}/images/product/${product.image}"
                                alt="${product.name}"
                                class="product-image"
                                onerror="this.style.display='none'; document.getElementById('imageErrorBox').style.display='flex';">


                        <div
                                id="imageErrorBox"
                                class="no-image"
                                style="display:none;">

                            Không thể tải ảnh sản phẩm

                        </div>

                    </c:when>

                    <c:otherwise>

                        <div class="no-image">

                            Chưa có ảnh sản phẩm

                        </div>

                    </c:otherwise>

                </c:choose>


            </div>


            <div class="info-card">


                <h1 class="product-title">

                    <c:out value="${product.name}"/>

                </h1>


                <div class="divider"></div>


                <div class="manufacturer">

                    <strong>
                        Hãng:
                    </strong>

                    <c:out value="${product.manufacturer}"/>

                </div>


                <div class="product-price">

                    <fmt:formatNumber
                            value="${product.price}"
                            type="number"
                            maxFractionDigits="0"/>

                    VNĐ

                </div>


                <div class="stock">

                    <strong>
                        Số lượng còn lại:
                    </strong>

                    ${product.quantity}

                </div>


                <div class="description-title">

                    Mô tả:

                </div>


                <p class="description">

                    <c:out value="${product.shortDescription}"/>

                </p>


                <div class="divider"></div>


                <div class="action-area">


                    <a
                            href="${pageContext.request.contextPath}/"
                            class="btn btn-secondary">

                        Quay lại

                    </a>


                    <sec:authorize access="isAuthenticated()">


                        <c:choose>

                            <c:when test="${product.quantity > 0}">

                                <form
                                        method="post"
                                        action="${pageContext.request.contextPath}/cart/add/${product.id}">


                                    <input
                                            type="hidden"
                                            name="${_csrf.parameterName}"
                                            value="${_csrf.token}">


                                    <button
                                            type="submit"
                                            class="btn btn-success">

                                        Thêm vào giỏ

                                    </button>


                                </form>

                            </c:when>

                            <c:otherwise>

                                <button
                                        type="button"
                                        class="btn btn-secondary"
                                        disabled>

                                    Hết hàng

                                </button>

                            </c:otherwise>

                        </c:choose>


                    </sec:authorize>


                    <sec:authorize access="!isAuthenticated()">

                        <a
                                href="${pageContext.request.contextPath}/login"
                                class="btn btn-primary">

                            Đăng nhập để mua

                        </a>

                    </sec:authorize>


                </div>


            </div>


        </div>


    </div>

</div>


</body>

</html>