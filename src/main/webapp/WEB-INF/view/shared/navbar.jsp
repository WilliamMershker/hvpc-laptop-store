<%@ page contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c"
           uri="jakarta.tags.core" %>

<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>


<nav class="hv-navbar">

    <div class="hv-container">


        <a
                class="hv-brand"
                href="${pageContext.request.contextPath}/">

            <span class="hv-brand-logo">
                HV
            </span>

            <span class="hv-brand-name">
                HVPC Tech
            </span>

        </a>


        <button
                type="button"
                class="hv-mobile-button"
                id="hvMobileButton"
                aria-label="Mở menu">

            ☰

        </button>


        <div
                class="hv-menu"
                id="hvMainMenu">


            <div class="hv-nav">


                <a
                        href="${pageContext.request.contextPath}/"
                        class="hv-nav-link"
                        data-nav-link>

                    Trang chủ

                </a>


                <sec:authorize access="isAuthenticated()">


                    <a
                            href="${pageContext.request.contextPath}/cart"
                            class="hv-nav-link"
                            data-nav-link>

                        Giỏ hàng

                    </a>


                    <a
                            href="${pageContext.request.contextPath}/orders"
                            class="hv-nav-link"
                            data-nav-link>

                        Đơn hàng

                    </a>


                </sec:authorize>


                <sec:authorize access="hasRole('ADMIN')">


                    <div
                            class="hv-admin"
                            id="hvAdminMenu">


                        <button
                                type="button"
                                class="hv-nav-link hv-admin-button"
                                id="hvAdminButton">

                            Quản trị

                            <span class="hv-arrow">
                                ▾
                            </span>

                        </button>


                        <div class="hv-admin-dropdown">


                            <div class="hv-dropdown-title">

                                QUẢN TRỊ HỆ THỐNG

                            </div>


                            <a
                                    href="${pageContext.request.contextPath}/admin/dashboard"
                                    class="hv-dropdown-item">

                                <span class="hv-dropdown-icon">
                                    D
                                </span>

                                Dashboard

                            </a>


                            <div class="hv-divider"></div>


                            <a
                                    href="${pageContext.request.contextPath}/admin/product"
                                    class="hv-dropdown-item">

                                <span class="hv-dropdown-icon">
                                    P
                                </span>

                                Quản lý sản phẩm

                            </a>


                            <a
                                    href="${pageContext.request.contextPath}/admin/user"
                                    class="hv-dropdown-item">

                                <span class="hv-dropdown-icon">
                                    U
                                </span>

                                Quản lý người dùng

                            </a>


                            <a
                                    href="${pageContext.request.contextPath}/admin/order"
                                    class="hv-dropdown-item">

                                <span class="hv-dropdown-icon">
                                    O
                                </span>

                                Quản lý đơn hàng

                            </a>


                        </div>

                    </div>


                </sec:authorize>


            </div>


            <div class="hv-right">


                <sec:authorize access="!isAuthenticated()">


                    <a
                            href="${pageContext.request.contextPath}/login"
                            class="hv-login-button">

                        Đăng nhập

                    </a>


                    <a
                            href="${pageContext.request.contextPath}/register"
                            class="hv-register-button">

                        Đăng ký

                    </a>


                </sec:authorize>


                <sec:authorize access="isAuthenticated()">


                    <a
                            href="${pageContext.request.contextPath}/profile"
                            class="hv-account">


                        <c:choose>

                            <c:when test="${currentUser != null and not empty currentUser.avatar}">

                                <img
                                        src="${pageContext.request.contextPath}/profile/avatar/${currentUser.avatar}"
                                        alt="Avatar"
                                        class="hv-avatar-image">

                            </c:when>

                            <c:otherwise>

                                <div class="hv-avatar-fallback">

                                    U

                                </div>

                            </c:otherwise>

                        </c:choose>


                        <div class="hv-account-info">


                            <span class="hv-account-label">

                                Tài khoản

                            </span>


                            <strong class="hv-account-email">

                                <sec:authentication
                                        property="principal.username"/>

                            </strong>


                        </div>


                    </a>


                    <form
                            method="post"
                            action="${pageContext.request.contextPath}/logout"
                            class="hv-logout-form">


                        <input
                                type="hidden"
                                name="${_csrf.parameterName}"
                                value="${_csrf.token}">


                        <button
                                type="submit"
                                class="hv-logout-button">

                            Đăng xuất

                        </button>


                    </form>


                </sec:authorize>


            </div>


        </div>


    </div>

</nav>


<style>

    .hv-navbar,
    .hv-navbar * {
        box-sizing: border-box;
    }


    .hv-navbar {
        position: relative;

        width: 100%;

        background:
                linear-gradient(
                        135deg,
                        #0f172a,
                        #111827
                );

        border-bottom:
                1px solid
                rgba(255, 255, 255, 0.06);

        box-shadow:
                0 5px 20px
                rgba(15, 23, 42, 0.16);

        z-index: 5000;
    }


    .hv-container {
        width:
                min(
                        1120px,
                        calc(100% - 32px)
                );

        min-height: 68px;

        margin: 0 auto;

        display: flex;

        align-items: center;

        gap: 28px;
    }


    .hv-brand {
        display: flex;

        align-items: center;

        gap: 10px;

        flex-shrink: 0;

        text-decoration: none;
    }


    .hv-brand-logo {
        width: 35px;

        height: 35px;

        display: flex;

        align-items: center;

        justify-content: center;

        border-radius: 10px;

        background:
                linear-gradient(
                        135deg,
                        #fb923c,
                        #f97316
                );

        color: #ffffff;

        font-size: 0.78rem;

        font-weight: 850;

        letter-spacing: -0.3px;

        box-shadow:
                0 5px 16px
                rgba(249, 115, 22, 0.28);
    }


    .hv-brand-name {
        color: #ffffff;

        font-size: 1.05rem;

        font-weight: 800;

        letter-spacing: 0.1px;

        white-space: nowrap;
    }


    .hv-menu {
        flex: 1;

        display: flex;

        align-items: center;

        justify-content: space-between;

        min-width: 0;
    }


    .hv-nav {
        display: flex;

        align-items: center;

        gap: 4px;
    }


    .hv-nav-link {
        display: inline-flex;

        align-items: center;

        justify-content: center;

        gap: 5px;

        padding: 9px 12px;

        color:
                rgba(255, 255, 255, 0.74);

        background: transparent;

        border: none;

        border-radius: 8px;

        text-decoration: none;

        font-family: inherit;

        font-size: 0.9rem;

        font-weight: 550;

        cursor: pointer;

        white-space: nowrap;

        transition:
                background 0.18s ease,
                color 0.18s ease;
    }


    .hv-nav-link:hover {
        color: #ffffff;

        background:
                rgba(255, 255, 255, 0.07);
    }


    .hv-nav-link.hv-active {
        color: #ffffff;

        background:
                rgba(249, 115, 22, 0.15);

        box-shadow:
                inset 0 0 0 1px
                rgba(249, 115, 22, 0.25);
    }


    .hv-admin {
        position: relative;
    }


    .hv-admin-button {
        margin: 0;
    }


    .hv-arrow {
        display: inline-block;

        font-size: 0.72rem;

        transition:
                transform 0.18s ease;
    }


    .hv-admin.hv-open
    .hv-arrow {
        transform: rotate(180deg);
    }


    .hv-admin-dropdown {
        position: absolute;

        top: calc(100% + 12px);

        left: 0;

        width: 235px;

        padding: 8px;

        background: #ffffff;

        border:
                1px solid #e2e8f0;

        border-radius: 13px;

        box-shadow:
                0 18px 45px
                rgba(15, 23, 42, 0.20);

        opacity: 0;

        visibility: hidden;

        transform:
                translateY(-6px);

        pointer-events: none;

        transition:
                opacity 0.16s ease,
                transform 0.16s ease,
                visibility 0.16s ease;

        z-index: 99999;
    }


    .hv-admin.hv-open
    .hv-admin-dropdown {
        opacity: 1;

        visibility: visible;

        transform: translateY(0);

        pointer-events: auto;
    }


    .hv-dropdown-title {
        padding: 6px 10px 8px;

        color: #94a3b8;

        font-size: 0.66rem;

        font-weight: 750;

        letter-spacing: 0.7px;
    }


    .hv-dropdown-item {
        display: flex;

        align-items: center;

        gap: 10px;

        padding: 9px 10px;

        color: #1e293b;

        border-radius: 8px;

        text-decoration: none;

        font-size: 0.88rem;

        transition:
                background 0.15s ease;
    }


    .hv-dropdown-item:hover {
        color: #0f172a;

        background: #f1f5f9;
    }


    .hv-dropdown-icon {
        width: 28px;

        height: 28px;

        display: flex;

        align-items: center;

        justify-content: center;

        flex-shrink: 0;

        background: #f1f5f9;

        border-radius: 7px;

        color: #475569;

        font-size: 0.7rem;

        font-weight: 800;
    }


    .hv-divider {
        height: 1px;

        margin: 5px 6px;

        background: #e2e8f0;
    }


    .hv-right {
        display: flex;

        align-items: center;

        gap: 8px;

        flex-shrink: 0;
    }


    .hv-account {
        display: flex;

        align-items: center;

        gap: 8px;

        padding:
                5px 10px 5px 5px;

        background:
                rgba(255, 255, 255, 0.06);

        border:
                1px solid
                rgba(255, 255, 255, 0.09);

        border-radius: 10px;

        text-decoration: none;

        transition:
                background 0.18s ease,
                transform 0.18s ease;
    }


    .hv-account:hover {
        background:
                rgba(255, 255, 255, 0.10);

        transform: translateY(-1px);
    }


    .hv-avatar-image {
        width: 35px;

        height: 35px;

        object-fit: cover;

        border-radius: 50%;

        flex-shrink: 0;

        border:
                2px solid
                rgba(255, 255, 255, 0.25);
    }


    .hv-avatar-fallback {
        width: 35px;

        height: 35px;

        display: flex;

        align-items: center;

        justify-content: center;

        flex-shrink: 0;

        border-radius: 50%;

        background:
                linear-gradient(
                        135deg,
                        #fb923c,
                        #f97316
                );

        color: #ffffff;

        font-size: 0.75rem;

        font-weight: 800;
    }


    .hv-account-info {
        display: flex;

        flex-direction: column;

        line-height: 1.15;

        min-width: 0;
    }


    .hv-account-label {
        color:
                rgba(255, 255, 255, 0.45);

        font-size: 0.61rem;
    }


    .hv-account-email {
        max-width: 160px;

        overflow: hidden;

        color: #ffffff;

        font-size: 0.75rem;

        font-weight: 650;

        text-overflow: ellipsis;

        white-space: nowrap;
    }


    .hv-login-button,
    .hv-register-button,
    .hv-logout-button {
        display: inline-flex;

        align-items: center;

        justify-content: center;

        min-height: 34px;

        padding: 6px 12px;

        border-radius: 8px;

        font-family: inherit;

        font-size: 0.78rem;

        font-weight: 550;

        text-decoration: none;

        cursor: pointer;

        transition: 0.18s ease;
    }


    .hv-login-button {
        color: #ffffff;

        background: transparent;

        border:
                1px solid
                rgba(255, 255, 255, 0.20);
    }


    .hv-login-button:hover {
        color: #ffffff;

        background:
                rgba(255, 255, 255, 0.08);
    }


    .hv-register-button {
        color: #ffffff;

        background: #f97316;

        border: 1px solid #f97316;
    }


    .hv-register-button:hover {
        color: #ffffff;

        background: #ea580c;
    }


    .hv-logout-form {
        margin: 0;
    }


    .hv-logout-button {
        color: #fb7185;

        background: transparent;

        border:
                1px solid
                rgba(251, 113, 133, 0.42);
    }


    .hv-logout-button:hover {
        color: #ffffff;

        background: #e11d48;

        border-color: #e11d48;
    }


    .hv-mobile-button {
        display: none;

        width: 39px;

        height: 37px;

        margin-left: auto;

        color: #ffffff;

        background:
                rgba(255, 255, 255, 0.06);

        border:
                1px solid
                rgba(255, 255, 255, 0.13);

        border-radius: 8px;

        font-size: 1.05rem;

        cursor: pointer;
    }


    @media (max-width: 991px) {

        .hv-container {
            min-height: 64px;

            flex-wrap: wrap;

            padding: 9px 0;
        }


        .hv-mobile-button {
            display: block;
        }


        .hv-menu {
            display: none;

            width: 100%;

            flex-basis: 100%;

            flex-direction: column;

            align-items: stretch;

            gap: 14px;

            padding: 12px 0 4px;

            border-top:
                    1px solid
                    rgba(255, 255, 255, 0.07);
        }


        .hv-menu.hv-mobile-open {
            display: flex;
        }


        .hv-nav {
            width: 100%;

            flex-direction: column;

            align-items: stretch;
        }


        .hv-nav-link {
            width: 100%;

            justify-content: space-between;
        }


        .hv-admin {
            width: 100%;
        }


        .hv-admin-dropdown {
            position: static;

            width: 100%;

            margin-top: 5px;

            display: none;

            opacity: 1;

            visibility: visible;

            transform: none;

            pointer-events: auto;

            box-shadow: none;
        }


        .hv-admin.hv-open
        .hv-admin-dropdown {
            display: block;
        }


        .hv-right {
            width: 100%;

            flex-direction: column;

            align-items: stretch;
        }


        .hv-account {
            width: 100%;
        }


        .hv-account-email {
            max-width: none;
        }


        .hv-login-button,
        .hv-register-button,
        .hv-logout-form,
        .hv-logout-button {
            width: 100%;
        }

    }

</style>


<script>

    (function ()
    {

        const adminMenu =
            document.getElementById(
                "hvAdminMenu"
            );


        const adminButton =
            document.getElementById(
                "hvAdminButton"
            );


        if (adminMenu &&
            adminButton)
        {
            adminButton.addEventListener(
                "click",
                function (event)
                {
                    event.preventDefault();

                    event.stopPropagation();


                    adminMenu
                        .classList
                        .toggle(
                            "hv-open"
                        );
                }
            );


            adminMenu.addEventListener(
                "click",
                function (event)
                {
                    event.stopPropagation();
                }
            );


            document.addEventListener(
                "click",
                function ()
                {
                    adminMenu
                        .classList
                        .remove(
                            "hv-open"
                        );
                }
            );


            document.addEventListener(
                "keydown",
                function (event)
                {
                    if (event.key === "Escape")
                    {
                        adminMenu
                            .classList
                            .remove(
                                "hv-open"
                            );
                    }
                }
            );
        }


        const mobileButton =
            document.getElementById(
                "hvMobileButton"
            );


        const mainMenu =
            document.getElementById(
                "hvMainMenu"
            );


        if (mobileButton &&
            mainMenu)
        {
            mobileButton.addEventListener(
                "click",
                function ()
                {
                    mainMenu
                        .classList
                        .toggle(
                            "hv-mobile-open"
                        );
                }
            );
        }


        const currentPath =
            window.location.pathname;


        const navLinks =
            document.querySelectorAll(
                "[data-nav-link]"
            );


        navLinks.forEach(
            function (link)
            {
                const url =
                    new URL(
                        link.href
                    );


                const path =
                    url.pathname;


                if (path === "/" &&
                    currentPath === "/")
                {
                    link
                        .classList
                        .add(
                            "hv-active"
                        );
                }
                else if (path !== "/" &&
                    currentPath.startsWith(path))
                {
                    link
                        .classList
                        .add(
                            "hv-active"
                        );
                }
            }
        );

    })();

</script>