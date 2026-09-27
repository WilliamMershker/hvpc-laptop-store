<%@ page contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>Hoàng Vũ PC</title>

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


        /* ============================= */
        /* HERO */
        /* ============================= */

        .page-hero {
            background:
                    radial-gradient(
                            circle at top right,
                            rgba(59, 130, 246, 0.20),
                            transparent 35%
                    ),
                    linear-gradient(
                            135deg,
                            #0f172a,
                            #1e293b
                    );

            color: white;

            border-radius: 24px;

            padding: 55px 45px;

            box-shadow:
                    0 20px 50px
                    rgba(15, 23, 42, 0.18);
        }


        .hero-badge {
            display: inline-block;

            background:
                    rgba(255, 255, 255, 0.10);

            border:
                    1px solid
                    rgba(255, 255, 255, 0.15);

            padding: 7px 15px;

            border-radius: 999px;

            font-size: 0.9rem;

            margin-bottom: 18px;
        }


        .page-hero h1 {
            font-weight: 800;

            font-size: 2.7rem;

            margin-bottom: 15px;
        }


        .page-hero p {
            color:
                    rgba(255, 255, 255, 0.75);

            max-width: 650px;

            font-size: 1.05rem;
        }


        /* ============================= */
        /* CARD */
        /* ============================= */

        .feature-card {
            background: white;

            border: none;

            border-radius: 20px;

            padding: 28px;

            height: 100%;

            box-shadow:
                    0 10px 30px
                    rgba(15, 23, 42, 0.07);

            transition:
                    transform 0.25s ease,
                    box-shadow 0.25s ease;
        }


        .feature-card:hover {
            transform:
                    translateY(-5px);

            box-shadow:
                    0 18px 40px
                    rgba(15, 23, 42, 0.12);
        }


        .feature-icon {
            width: 52px;

            height: 52px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 15px;

            background:
                    linear-gradient(
                            135deg,
                            #2563eb,
                            #3b82f6
                    );

            color: white;

            font-size: 1.3rem;

            font-weight: 800;

            margin-bottom: 20px;
        }


        .feature-card h5 {
            font-weight: 700;
        }


        .feature-card p {
            color: #64748b;

            margin-bottom: 0;
        }


        /* ============================= */
        /* CTA */
        /* ============================= */

        .btn-main {
            background:
                    linear-gradient(
                            135deg,
                            #f59e0b,
                            #f97316
                    );

            border: none;

            color: white;

            font-weight: 600;

            padding:
                    11px 22px;

            border-radius: 12px;

            transition:
                    transform 0.2s ease;
        }


        .btn-main:hover {
            color: white;

            transform:
                    translateY(-2px);
        }


        .btn-secondary-custom {
            border:
                    1px solid
                    rgba(255, 255, 255, 0.25);

            color: white;

            padding:
                    10px 22px;

            border-radius: 12px;

            text-decoration: none;
        }


        .btn-secondary-custom:hover {
            background:
                    rgba(255, 255, 255, 0.10);

            color: white;
        }


        /* ============================= */
        /* FOOTER */
        /* ============================= */

        .simple-footer {
            color: #64748b;

            border-top:
                    1px solid #e2e8f0;

            margin-top: 70px;

            padding:
                    25px 0;

            text-align: center;

            font-size: 0.9rem;
        }


        @media (max-width: 768px) {

            .page-hero {
                padding:
                        38px 25px;
            }


            .page-hero h1 {
                font-size:
                        2rem;
            }

        }

    </style>

</head>


<body>


<!-- ============================== -->
<!-- NAVBAR -->
<!-- ============================== -->

<jsp:include page="/WEB-INF/view/shared/navbar.jsp"/>


<!-- ============================== -->
<!-- MAIN -->
<!-- ============================== -->

<main class="container mt-5">


    <!-- HERO -->

    <section class="page-hero">


        <span class="hero-badge">

            HOÀNG VŨ PC

        </span>


        <h1>

            Công nghệ cho mọi nhu cầu.

        </h1>


        <p>

            Khám phá laptop phù hợp cho học tập,
            lập trình, văn phòng và gaming với
            trải nghiệm mua sắm đơn giản và hiện đại.

        </p>


        <div class="d-flex gap-3 mt-4 flex-wrap">


            <a
                    href="${pageContext.request.contextPath}/"
                    class="btn btn-main">

                Xem sản phẩm

            </a>


            <a
                    href="${pageContext.request.contextPath}/cart"
                    class="btn-secondary-custom">

                Xem giỏ hàng

            </a>


        </div>


    </section>


    <!-- ============================== -->
    <!-- FEATURES -->
    <!-- ============================== -->

    <section class="mt-5">


        <div class="mb-4">

            <h2 class="fw-bold">

                Hoàng Vũ PC

            </h2>


            <p class="text-secondary">

                Website bán laptop được xây dựng bằng
                Spring Boot, Spring MVC, JPA và MySQL.

            </p>

        </div>


        <div class="row g-4">


            <!-- CARD 1 -->

            <div class="col-lg-4 col-md-6">


                <div class="feature-card">


                    <div class="feature-icon">

                        01

                    </div>


                    <h5>

                        Sản phẩm

                    </h5>


                    <p>

                        Xem thông tin, giá,
                        số lượng và chi tiết
                        các dòng laptop.

                    </p>


                </div>


            </div>


            <!-- CARD 2 -->

            <div class="col-lg-4 col-md-6">


                <div class="feature-card">


                    <div class="feature-icon">

                        02

                    </div>


                    <h5>

                        Giỏ hàng

                    </h5>


                    <p>

                        Thêm sản phẩm,
                        tăng giảm số lượng
                        và thực hiện thanh toán.

                    </p>


                </div>


            </div>


            <!-- CARD 3 -->

            <div class="col-lg-4 col-md-6">


                <div class="feature-card">


                    <div class="feature-icon">

                        03

                    </div>


                    <h5>

                        Đơn hàng

                    </h5>


                    <p>

                        Theo dõi đơn hàng
                        và xem lại lịch sử
                        mua hàng của tài khoản.

                    </p>


                </div>


            </div>


        </div>

    </section>

</main>

<!-- ============================== -->
<!-- FOOTER -->
<!-- ============================== -->

<footer class="simple-footer">

    <div class="container">

        © 2026 Hoàng Vũ PC
        • Spring Boot Project

    </div>

</footer>


<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


</body>

</html>