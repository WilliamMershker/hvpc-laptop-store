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
        HVPC Tech
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
            margin: 0;

            background: #f8fafc;

            color: #0f172a;
        }


        .home-page {
            padding:
                    42px 16px
                    70px;
        }


        .home-container {
            width:
                    min(
                            1120px,
                            100%
                    );

            margin: 0 auto;
        }


        /* ===================================== */
        /* HEADER */
        /* ===================================== */

        .home-header {
            margin-bottom: 28px;

            text-align: center;
        }


        .home-title {
            margin: 0;

            color: #111827;

            font-size: 2.1rem;

            font-weight: 850;
        }


        .home-subtitle {
            margin-top: 5px;

            color: #64748b;

            font-size: 0.95rem;
        }


        /* ===================================== */
        /* FILTER */
        /* ===================================== */

        .filter-card {
            padding: 20px;

            background: #ffffff;

            border:
                    1px solid #e2e8f0;

            border-radius: 16px;

            box-shadow:
                    0 5px 20px
                    rgba(15, 23, 42, 0.05);
        }


        .filter-grid {
            display: grid;

            grid-template-columns:
                    2fr
                    1fr
                    1fr
                    1fr
                    1fr;

            gap: 13px;

            align-items: end;
        }


        .filter-label {
            display: block;

            margin-bottom: 6px;

            color: #334155;

            font-size: 0.84rem;

            font-weight: 700;
        }


        .filter-card .form-control,
        .filter-card .form-select {
            min-height: 43px;

            border:
                    1px solid #cbd5e1;

            border-radius: 9px;

            box-shadow: none;
        }


        .filter-card .form-control:focus,
        .filter-card .form-select:focus {
            border-color: #2563eb;

            box-shadow:
                    0 0 0 3px
                    rgba(37, 99, 235, 0.10);
        }


        .filter-actions {
            display: flex;

            flex-wrap: wrap;

            gap: 8px;

            margin-top: 15px;
        }


        .filter-actions .btn {
            min-height: 40px;

            padding:
                    7px 15px;

            border-radius: 9px;

            font-size: 0.86rem;

            font-weight: 650;
        }


        /* ===================================== */
        /* TOOLBAR */
        /* ===================================== */

        .product-toolbar {
            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 15px;

            margin:
                    30px 0
                    18px;
        }


        .product-count {
            color: #64748b;

            font-size: 0.9rem;
        }


        .product-count strong {
            color: #0f172a;
        }


        .sort-form {
            display: flex;

            align-items: center;

            gap: 9px;
        }


        .sort-label {
            margin: 0;

            color: #475569;

            font-size: 0.84rem;

            font-weight: 650;

            white-space: nowrap;
        }


        .sort-select {
            width: 190px;

            min-height: 40px;

            border-radius: 9px;
        }


        /* ===================================== */
        /* EMPTY */
        /* ===================================== */

        .empty-result {
            margin-top: 22px;

            padding: 18px;

            border:
                    1px solid #fde68a;

            border-radius: 12px;

            background: #fef3c7;

            color: #92400e;

            font-size: 0.9rem;
        }


        /* ===================================== */
        /* PRODUCT GRID */
        /* ===================================== */

        .product-grid {
            display: grid;

            grid-template-columns:
                    repeat(
                            auto-fill,
                            minmax(260px, 1fr)
                    );

            gap: 24px;
        }


        /* ===================================== */
        /* PRODUCT CARD */
        /* ===================================== */

        .product-card {
            min-width: 0;

            display: flex;

            flex-direction: column;

            overflow: hidden;

            background: #ffffff;

            border:
                    1px solid #e2e8f0;

            border-radius: 18px;

            box-shadow:
                    0 7px 24px
                    rgba(15, 23, 42, 0.07);

            transition:
                    transform 0.20s ease,
                    box-shadow 0.20s ease,
                    border-color 0.20s ease;
        }


        .product-card:hover {
            transform:
                    translateY(-5px);

            border-color: #cbd5e1;

            box-shadow:
                    0 18px 42px
                    rgba(15, 23, 42, 0.12);
        }


        /* ===================================== */
        /* IMAGE */
        /* ===================================== */

        .product-image-box {
            position: relative;

            width: 100%;

            height: 220px;

            display: flex;

            align-items: center;

            justify-content: center;

            overflow: hidden;

            background:
                    linear-gradient(
                            180deg,
                            #ffffff,
                            #f8fafc
                    );

            border-bottom:
                    1px solid #f1f5f9;
        }


        .product-image {
            width: 100%;

            height: 100%;

            object-fit: contain;

            padding: 15px;

            transition:
                    transform 0.25s ease;
        }


        .product-card:hover
        .product-image {
            transform:
                    scale(1.035);
        }


        .product-no-image {
            display: flex;

            width: 100%;

            height: 100%;

            align-items: center;

            justify-content: center;

            color: #94a3b8;

            font-size: 0.85rem;
        }


        /* ===================================== */
        /* BODY */
        /* ===================================== */

        .product-body {
            display: flex;

            flex: 1;

            flex-direction: column;

            padding: 18px;
        }


        .product-manufacturer {
            width: fit-content;

            margin-bottom: 10px;

            padding:
                    5px 9px;

            color: #2563eb;

            background: #eff6ff;

            border-radius: 999px;

            font-size: 0.68rem;

            font-weight: 800;

            letter-spacing: 0.4px;

            text-transform: uppercase;
        }


        .product-name {
            min-height: 68px;

            margin-bottom: 8px;

            color: #0f172a;

            font-size: 1rem;

            font-weight: 780;

            line-height: 1.42;
        }


        .product-description {
            display: -webkit-box;

            min-height: 42px;

            margin-bottom: 15px;

            overflow: hidden;

            color: #64748b;

            font-size: 0.82rem;

            line-height: 1.5;

            -webkit-box-orient: vertical;

            -webkit-line-clamp: 2;
        }


        /* ===================================== */
        /* PRICE */
        /* ===================================== */

        .product-price {
            margin-top: auto;

            color: #dc2626;

            font-size: 1.25rem;

            font-weight: 850;
        }


        /* ===================================== */
        /* STOCK */
        /* ===================================== */

        .product-stock-row {
            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 10px;

            margin-top: 9px;
        }


        .stock-label {
            color: #64748b;

            font-size: 0.8rem;
        }


        .stock-available {
            display: inline-flex;

            align-items: center;

            justify-content: center;

            padding:
                    4px 9px;

            color: #15803d;

            background: #dcfce7;

            border-radius: 999px;

            font-size: 0.72rem;

            font-weight: 750;
        }


        .stock-empty {
            display: inline-flex;

            align-items: center;

            justify-content: center;

            padding:
                    4px 9px;

            color: #b91c1c;

            background: #fee2e2;

            border-radius: 999px;

            font-size: 0.72rem;

            font-weight: 750;
        }


        /* ===================================== */
        /* ACTION */
        /* ===================================== */

        .product-actions {
            display: grid;

            grid-template-columns:
                    1fr
                    1fr;

            gap: 9px;

            margin-top: 18px;
        }


        .product-actions form {
            width: 100%;

            margin: 0;
        }


        .product-detail-btn,
        .product-cart-btn,
        .product-login-btn,
        .product-out-btn {
            width: 100%;

            min-height: 43px;

            display: flex;

            align-items: center;

            justify-content: center;

            padding:
                    8px 10px;

            border-radius: 10px;

            font-family: inherit;

            font-size: 0.8rem;

            font-weight: 700;

            text-decoration: none;

            white-space: nowrap;

            cursor: pointer;

            transition:
                    transform 0.15s ease,
                    box-shadow 0.15s ease,
                    background 0.15s ease;
        }


        .product-detail-btn {
            color: #334155;

            background: #ffffff;

            border:
                    1px solid #cbd5e1;
        }


        .product-detail-btn:hover {
            color: #0f172a;

            background: #f8fafc;

            border-color: #94a3b8;

            transform:
                    translateY(-1px);
        }


        .product-cart-btn {
            color: #ffffff;

            background:
                    linear-gradient(
                            135deg,
                            #2563eb,
                            #1d4ed8
                    );

            border: none;

            box-shadow:
                    0 5px 14px
                    rgba(37, 99, 235, 0.23);
        }


        .product-cart-btn:hover {
            color: #ffffff;

            background:
                    linear-gradient(
                            135deg,
                            #1d4ed8,
                            #1e40af
                    );

            transform:
                    translateY(-1px);

            box-shadow:
                    0 8px 20px
                    rgba(37, 99, 235, 0.28);
        }


        .product-login-btn {
            color: #ffffff;

            background: #2563eb;

            border: none;
        }


        .product-login-btn:hover {
            color: #ffffff;

            background: #1d4ed8;
        }


        .product-out-btn {
            color: #94a3b8;

            background: #f1f5f9;

            border:
                    1px solid #e2e8f0;

            cursor: not-allowed;
        }


        /* ===================================== */
        /* PAGINATION */
        /* ===================================== */

        .pagination-wrapper {
            display: flex;

            justify-content: center;

            margin-top: 36px;
        }


        .pagination {
            gap: 5px;
        }


        .page-link {
            min-width: 40px;

            border-radius:
                    9px !important;

            text-align: center;
        }


        /* ===================================== */
        /* RESPONSIVE */
        /* ===================================== */

        @media (max-width: 991px) {

            .filter-grid {
                grid-template-columns:
                        repeat(
                                2,
                                minmax(0, 1fr)
                        );
            }


            .product-grid {
                grid-template-columns:
                        repeat(
                                2,
                                minmax(0, 1fr)
                        );
            }

        }


        @media (max-width: 600px) {

            .home-page {
                padding:
                        25px 10px
                        50px;
            }


            .home-title {
                font-size: 1.7rem;
            }


            .filter-grid {
                grid-template-columns: 1fr;
            }


            .product-toolbar {
                align-items: stretch;

                flex-direction: column;
            }


            .sort-form {
                justify-content: space-between;
            }


            .sort-select {
                flex: 1;

                width: auto;
            }


            .product-grid {
                grid-template-columns: 1fr;
            }


            .product-image-box {
                height: 240px;
            }

        }

    </style>

</head>


<body>


<jsp:include page="/WEB-INF/view/shared/navbar.jsp"/>


<c:set
        var="listPath"
        value="/"/>


<c:if test="${searchMode}">

    <c:set
            var="listPath"
            value="/search"/>

</c:if>


<div class="home-page">

    <div class="home-container">


        <div class="home-header">

            <h1 class="home-title">

                HVPC Tech

            </h1>


            <div class="home-subtitle">

                Laptop &amp; Technology

            </div>

        </div>


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


        <div class="filter-card">


            <form
                    method="get"
                    action="${pageContext.request.contextPath}/search">


                <div class="filter-grid">


                    <div>

                        <label
                                for="keyword"
                                class="filter-label">

                            Tên laptop

                        </label>


                        <input
                                type="text"
                                id="keyword"
                                name="keyword"
                                class="form-control"
                                value="${keyword}"
                                placeholder="Dell XPS...">

                    </div>


                    <div>

                        <label
                                for="manufacturer"
                                class="filter-label">

                            Hãng

                        </label>


                        <select
                                id="manufacturer"
                                name="manufacturer"
                                class="form-select">


                            <option value="">

                                Tất cả

                            </option>


                            <c:forEach
                                    var="m"
                                    items="${manufacturers}">


                                <option
                                        value="${m}"
                                    ${manufacturer == m ? 'selected' : ''}>

                                    <c:out value="${m}"/>

                                </option>


                            </c:forEach>


                        </select>

                    </div>


                    <div>

                        <label
                                for="minPrice"
                                class="filter-label">

                            Giá từ

                        </label>


                        <input
                                type="number"
                                id="minPrice"
                                name="minPrice"
                                class="form-control"
                                value="${minPrice}"
                                min="0"
                                step="1000">

                    </div>


                    <div>

                        <label
                                for="maxPrice"
                                class="filter-label">

                            Giá đến

                        </label>


                        <input
                                type="number"
                                id="maxPrice"
                                name="maxPrice"
                                class="form-control"
                                value="${maxPrice}"
                                min="0"
                                step="1000">

                    </div>


                    <div>

                        <label
                                for="minQuantity"
                                class="filter-label">

                            SL tối thiểu

                        </label>


                        <input
                                type="number"
                                id="minQuantity"
                                name="minQuantity"
                                class="form-control"
                                value="${minQuantity}"
                                min="0">

                    </div>


                </div>


                <input
                        type="hidden"
                        name="size"
                        value="${pageSize}">


                <input
                        type="hidden"
                        name="sort"
                        value="${sort}">


                <div class="filter-actions">


                    <button
                            type="submit"
                            class="btn btn-primary">

                        Tìm kiếm

                    </button>


                    <a
                            href="${pageContext.request.contextPath}/"
                            class="btn btn-secondary">

                        Xóa bộ lọc

                    </a>


                </div>


            </form>


        </div>


        <c:choose>

            <c:when test="${empty products}">

                <div class="empty-result">

                    Không tìm thấy sản phẩm phù hợp.

                </div>

            </c:when>


            <c:otherwise>


                <div class="product-toolbar">


                    <div class="product-count">

                        Tìm thấy

                        <strong>

                                ${totalItems}

                        </strong>

                        sản phẩm

                    </div>


                    <form
                            method="get"
                            action="${pageContext.request.contextPath}${listPath}"
                            class="sort-form">


                        <c:if test="${searchMode}">

                            <input
                                    type="hidden"
                                    name="keyword"
                                    value="${keyword}">


                            <input
                                    type="hidden"
                                    name="manufacturer"
                                    value="${manufacturer}">


                            <c:if test="${minPrice != null}">

                                <input
                                        type="hidden"
                                        name="minPrice"
                                        value="${minPrice}">

                            </c:if>


                            <c:if test="${maxPrice != null}">

                                <input
                                        type="hidden"
                                        name="maxPrice"
                                        value="${maxPrice}">

                            </c:if>


                            <c:if test="${minQuantity != null}">

                                <input
                                        type="hidden"
                                        name="minQuantity"
                                        value="${minQuantity}">

                            </c:if>

                        </c:if>


                        <input
                                type="hidden"
                                name="page"
                                value="1">


                        <input
                                type="hidden"
                                name="size"
                                value="${pageSize}">


                        <label
                                for="sort"
                                class="sort-label">

                            Sắp xếp:

                        </label>


                        <select
                                id="sort"
                                name="sort"
                                class="form-select sort-select"
                                onchange="this.form.submit()">


                            <option
                                    value="newest"
                                ${sort == 'newest' ? 'selected' : ''}>

                                Mới nhất

                            </option>


                            <option
                                    value="oldest"
                                ${sort == 'oldest' ? 'selected' : ''}>

                                Cũ nhất

                            </option>


                            <option
                                    value="priceAsc"
                                ${sort == 'priceAsc' ? 'selected' : ''}>

                                Giá tăng dần

                            </option>


                            <option
                                    value="priceDesc"
                                ${sort == 'priceDesc' ? 'selected' : ''}>

                                Giá giảm dần

                            </option>


                            <option
                                    value="nameAsc"
                                ${sort == 'nameAsc' ? 'selected' : ''}>

                                Tên A → Z

                            </option>


                            <option
                                    value="nameDesc"
                                ${sort == 'nameDesc' ? 'selected' : ''}>

                                Tên Z → A

                            </option>


                            <option
                                    value="quantityDesc"
                                ${sort == 'quantityDesc' ? 'selected' : ''}>

                                Tồn kho nhiều nhất

                            </option>


                            <option
                                    value="quantityAsc"
                                ${sort == 'quantityAsc' ? 'selected' : ''}>

                                Tồn kho ít nhất

                            </option>


                        </select>


                    </form>


                </div>


                <div class="product-grid">


                    <c:forEach
                            var="product"
                            items="${products}">


                        <div class="product-card">


                            <div class="product-image-box">


                                <c:choose>

                                    <c:when test="${not empty product.image}">

                                        <img
                                                src="${pageContext.request.contextPath}/images/product/${product.image}"
                                                alt="${product.name}"
                                                class="product-image">

                                    </c:when>

                                    <c:otherwise>

                                        <div class="product-no-image">

                                            Chưa có hình ảnh

                                        </div>

                                    </c:otherwise>

                                </c:choose>


                            </div>


                            <div class="product-body">


                                <c:if test="${not empty product.manufacturer}">

                                    <div class="product-manufacturer">

                                        <c:out value="${product.manufacturer}"/>

                                    </div>

                                </c:if>


                                <div class="product-name">

                                    <c:out value="${product.name}"/>

                                </div>


                                <div class="product-description">

                                    <c:out value="${product.shortDescription}"/>

                                </div>


                                <div class="product-price">

                                    <fmt:formatNumber
                                            value="${product.price}"
                                            type="number"
                                            maxFractionDigits="0"/>

                                    VNĐ

                                </div>


                                <div class="product-stock-row">


                                    <span class="stock-label">

                                        Tồn kho

                                    </span>


                                    <c:choose>

                                        <c:when test="${product.quantity > 0}">

                                            <span class="stock-available">

                                                Còn ${product.quantity}

                                            </span>

                                        </c:when>

                                        <c:otherwise>

                                            <span class="stock-empty">

                                                Hết hàng

                                            </span>

                                        </c:otherwise>

                                    </c:choose>


                                </div>


                                <div class="product-actions">


                                    <a
                                            href="${pageContext.request.contextPath}/product/${product.id}"
                                            class="product-detail-btn">

                                        Xem chi tiết

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
                                                            class="product-cart-btn">

                                                        Thêm vào giỏ

                                                    </button>


                                                </form>


                                            </c:when>

                                            <c:otherwise>


                                                <button
                                                        type="button"
                                                        class="product-out-btn"
                                                        disabled>

                                                    Hết hàng

                                                </button>


                                            </c:otherwise>

                                        </c:choose>


                                    </sec:authorize>


                                    <sec:authorize access="!isAuthenticated()">


                                        <a
                                                href="${pageContext.request.contextPath}/login"
                                                class="product-login-btn">

                                            Đăng nhập để mua

                                        </a>


                                    </sec:authorize>


                                </div>


                            </div>


                        </div>


                    </c:forEach>


                </div>


                <c:if test="${totalPages > 1}">


                    <div class="pagination-wrapper">


                        <nav aria-label="Phân trang sản phẩm">


                            <ul class="pagination">


                                <c:if test="${currentPage > 1}">


                                    <c:url
                                            var="previousUrl"
                                            value="${listPath}">


                                        <c:param
                                                name="page"
                                                value="${currentPage - 1}"/>


                                        <c:param
                                                name="size"
                                                value="${pageSize}"/>


                                        <c:param
                                                name="sort"
                                                value="${sort}"/>


                                        <c:if test="${searchMode}">


                                            <c:param
                                                    name="keyword"
                                                    value="${keyword}"/>


                                            <c:param
                                                    name="manufacturer"
                                                    value="${manufacturer}"/>


                                            <c:if test="${minPrice != null}">

                                                <c:param
                                                        name="minPrice"
                                                        value="${minPrice}"/>

                                            </c:if>


                                            <c:if test="${maxPrice != null}">

                                                <c:param
                                                        name="maxPrice"
                                                        value="${maxPrice}"/>

                                            </c:if>


                                            <c:if test="${minQuantity != null}">

                                                <c:param
                                                        name="minQuantity"
                                                        value="${minQuantity}"/>

                                            </c:if>


                                        </c:if>


                                    </c:url>


                                    <li class="page-item">

                                        <a
                                                href="${previousUrl}"
                                                class="page-link">

                                            ‹

                                        </a>

                                    </li>


                                </c:if>


                                <c:forEach
                                        begin="1"
                                        end="${totalPages}"
                                        var="pageNumber">


                                    <c:url
                                            var="pageUrl"
                                            value="${listPath}">


                                        <c:param
                                                name="page"
                                                value="${pageNumber}"/>


                                        <c:param
                                                name="size"
                                                value="${pageSize}"/>


                                        <c:param
                                                name="sort"
                                                value="${sort}"/>


                                        <c:if test="${searchMode}">


                                            <c:param
                                                    name="keyword"
                                                    value="${keyword}"/>


                                            <c:param
                                                    name="manufacturer"
                                                    value="${manufacturer}"/>


                                            <c:if test="${minPrice != null}">

                                                <c:param
                                                        name="minPrice"
                                                        value="${minPrice}"/>

                                            </c:if>


                                            <c:if test="${maxPrice != null}">

                                                <c:param
                                                        name="maxPrice"
                                                        value="${maxPrice}"/>

                                            </c:if>


                                            <c:if test="${minQuantity != null}">

                                                <c:param
                                                        name="minQuantity"
                                                        value="${minQuantity}"/>

                                            </c:if>


                                        </c:if>


                                    </c:url>


                                    <li
                                            class="page-item ${pageNumber == currentPage ? 'active' : ''}">


                                        <a
                                                href="${pageUrl}"
                                                class="page-link">

                                                ${pageNumber}

                                        </a>


                                    </li>


                                </c:forEach>


                                <c:if test="${currentPage < totalPages}">


                                    <c:url
                                            var="nextUrl"
                                            value="${listPath}">


                                        <c:param
                                                name="page"
                                                value="${currentPage + 1}"/>


                                        <c:param
                                                name="size"
                                                value="${pageSize}"/>


                                        <c:param
                                                name="sort"
                                                value="${sort}"/>


                                        <c:if test="${searchMode}">


                                            <c:param
                                                    name="keyword"
                                                    value="${keyword}"/>


                                            <c:param
                                                    name="manufacturer"
                                                    value="${manufacturer}"/>


                                            <c:if test="${minPrice != null}">

                                                <c:param
                                                        name="minPrice"
                                                        value="${minPrice}"/>

                                            </c:if>


                                            <c:if test="${maxPrice != null}">

                                                <c:param
                                                        name="maxPrice"
                                                        value="${maxPrice}"/>

                                            </c:if>


                                            <c:if test="${minQuantity != null}">

                                                <c:param
                                                        name="minQuantity"
                                                        value="${minQuantity}"/>

                                            </c:if>


                                        </c:if>


                                    </c:url>


                                    <li class="page-item">

                                        <a
                                                href="${nextUrl}"
                                                class="page-link">

                                            ›

                                        </a>

                                    </li>


                                </c:if>


                            </ul>


                        </nav>


                    </div>


                </c:if>


            </c:otherwise>

        </c:choose>


    </div>

</div>


</body>

</html>