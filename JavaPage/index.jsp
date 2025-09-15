<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.DriverManager, java.sql.SQLException, java.sql.ResultSet" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if ("true".equals(request.getParameter("logout"))) {
        session.invalidate();
        response.sendRedirect("index.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="Description" content="Enter your description here"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos.css">
    <title>Pagina de aterrizaje</title>
</head>
<body class="d-flex flex-column h-100">
    <main class="flex-shrink-0">
        <!-- Navegación-->
            <nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid px-4">
        <a class="navbar-brand" href="index.jsp">
            <i class="fas fa-home mr-2"></i> Inmobiliaria java
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <%
                    Object usuario = null;
                    Object nombre = null;
                    Object rol = null;
                    try {
                        usuario = session.getAttribute("usuario");
                        nombre = session.getAttribute("nombre");
                        rol = session.getAttribute("rol");
                    } catch (IllegalStateException e) {
                        // Session invalidated
                    }
                    if (usuario != null) {
                        if (rol == null) {
                            // Set rol if missing
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection conn = DriverManager.getConnection("jdbc:mysql://bimg5zspe3vpdruhh5sp-mysql.services.clever-cloud.com:3306/bimg5zspe3vpdruhh5sp?useSSL=false&serverTimezone=UTC", "urqjyyyurwfqifmx", "cR0QWIrrmASKpi10R4Vy");
                                String query = "SELECT rol FROM usuarios WHERE nombre_usuario = ?";
                                java.sql.PreparedStatement stmt = conn.prepareStatement(query);
                                stmt.setString(1, (String)usuario);
                                java.sql.ResultSet rs = stmt.executeQuery();
                                if (rs.next()) {
                                    rol = rs.getString("rol");
                                    session.setAttribute("rol", rol);
                                }
                                rs.close();
                                stmt.close();
                                conn.close();
                            } catch (Exception e) {
                                // ignore
                            }
                        }
                %>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/shop/shop.jsp">Propiedades</a></li>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/reviews.jsp">Reseñas</a></li>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/blog.jsp">Blog</a></li>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/soporte.jsp">Soporte</a></li>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/nosotros.jsp">Nosotros</a></li>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/perfil.jsp">Editar información</a></li>
                    <% if ("admin".equals(rol)) { %>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/admin/admin.jsp">Panel Admin</a></li>
                    <% } else if ("inmobiliaria".equals(rol)) { %>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/inmobiliaria/inmobiliaria.jsp">Panel Inmobiliaria</a></li>
                    <% } %>
                    <li class="nav-item">
                        <span class="navbar-text mr-3">Bienvenido, <%= nombre %></span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="?logout=true"><i class="fas fa-sign-out-alt"></i> Cerrar sesión</a>
                    </li>
                <% } else { %>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/shop/shop.jsp">Propiedades</a></li>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/reviews.jsp">Reseñas</a></li>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/blog.jsp">Blog</a></li>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/soporte.jsp">Soporte</a></li>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/nosotros.jsp">Nosotros</a></li>
<li class="nav-item">
    <a class="nav-link" href="login/login.jsp"><i class="fas fa-user"></i> Ingresar</a>
</li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

        <!-- Head-->
        <header class="landing">
            <div class="container px-5">
                <div class="row gx-5 align-items-center justify-content-center">
                    <div class="col-lg-8 col-xl-7 col-xxl-6">
                        <div class="my-5 text-center text-xl-start">
                            <h1 class="display-5 fw-bolder mb-2">Tu mejor oferta de vivienda</h1>
                            <p class="lead fw-normal mb-4">Descubre proyectos modernos, accesibles y pensados para brindarte el hogar que siempre soñaste.</p>
                            <div class="text-center">
                                <a class="btn btn-primary btn-lg px-4" href="<%=request.getContextPath()%>/shop/shop.jsp">
                                    Ver propiedades
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-5 col-xxl-6 d-none d-xl-block text-center">
                        <img class="img-fluid rounded-3 my-5" src="img/header_index.jpg" alt="..." />
                    </div>
                </div>
            </div>
        </header>
        <!-- info-->
        <section class="py-5" id="features">
            <div class="container px-5 my-5">
                <div class="row gx-5">
                    <div class="col-lg-4 mb-5 mb-lg-0">
                        <h2 class="fw-bolder mb-0">Tu nuevo comienzo empieza aquí.</h2>
                    </div>
                    <div class="col-lg-8">
                        <div class="row gx-5 row-cols-1 row-cols-md-2">
                            <div class="col mb-5 h-100">
                                <h2 class="h5">Hogares modernos <i class="bi bi-house-check-fill"></i></h2>
                                <p class="mb-0">Diseñados para tu comodidad, combinando estilo, innovación y funcionalidad.</p>
                            </div>
                            <div class="col mb-5 h-100">
                                <h2 class="h5">Precios accesibles <i class="bi bi-cash-stack"></i></h2>
                                <p class="mb-0">Opciones flexibles que se ajustan a tus posibilidades sin perder calidad.</p>
                            </div>
                            <div class="col mb-5 mb-md-0 h-100">
                                <h2 class="h5">Ubicaciones estratégicas <i class="bi bi-geo-alt-fill"></i></h2>
                                <p class="mb-0">Vive cerca de lo que más necesitas: transporte, comercio y zonas verdes.</p>
                            </div>
                            <div class="col h-100">
                                <h2 class="h5">Atención personalizada <i class="bi bi-person-lines-fill"></i></h2>
                                <p class="mb-0">Te acompañamos en todo el proceso para que encuentres el hogar ideal.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Frase-->
        <div class="py-5 bg-light" style="background: url('img/frase_bg.jpeg') center center/cover no-repeat;">
            <div class="container px-5 my-5">
                <div class="row gx-5 justify-content-center">
                    <div class="col-lg-10 col-xl-7">
                        <div class="text-center" style="background: rgba(255,255,255,0.85); border-radius: 1rem; padding: 2rem;">
                            <div class="fs-4 mb-4 fst-italic">
                                "Un inmueble no es solo un espacio, es el inicio de nuevas historias, sueños cumplidos y un futuro seguro para tu familia."
                            </div>
                            <div class="d-flex align-items-center justify-content-center">
                                <img class="rounded-circle me-3" src="https://dummyimage.com/40x40/ced4da/6c757d" alt="..." />
                                <div class="fw-bold">
                                    María López
                                    <span class="fw-bold text-primary mx-1">/</span>
                                    Asesora Inmobiliaria
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Blog preview section-->
        <section class="py-5">
            <div class="container px-5 my-5">
                <div class="row gx-5 justify-content-center">
                    <div class="col-lg-8 col-xl-6">
                        <div class="text-center">
                            <h2 class="fw-bolder">Reseñas de clientes</h2>
                            <p class="lead fw-normal text-muted mb-5">Lee las experiencias de nuestros clientes satisfechos con nuestros servicios inmobiliarios.</p>
                        </div>
                    </div>
                </div>
                <div class="row gx-5">
                    <!-- Review Card 1 -->
                    <div class="col-lg-4 mb-5">
                        <div class="card h-100 shadow border-0">
                            <img class="card-img-top" src="img/img1.jpg" alt="..." />
                            <div class="card-body p-4">
                                <div class="badge bg-success bg-gradient rounded-pill mb-2">5 Estrellas</div>
                                <h5 class="card-title mb-3">Excelente servicio</h5>
                                <p class="card-text mb-0">Encontré la casa de mis sueños gracias a Inmobiliaria Java. El proceso fue rápido y transparente. ¡Altamente recomendado!</p>
                            </div>
                            <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                <div class="d-flex align-items-end justify-content-between">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle me-3" src="img/user.png" alt="..." width="40" height="40" />
                                        <div class="small">
                                            <div class="fw-bold">Ana García</div>
                                            <div class="text-muted">Cliente desde 2023</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Review Card 2 -->
                    <div class="col-lg-4 mb-5">
                        <div class="card h-100 shadow border-0">
                            <img class="card-img-top" src="img/img2.jpg" alt="..." />
                            <div class="card-body p-4">
                                <div class="badge bg-success bg-gradient rounded-pill mb-2">5 Estrellas</div>
                                <h5 class="card-title mb-3">Profesionalismo total</h5>
                                <p class="card-text mb-0">El equipo de Inmobiliaria Java me guió en cada paso de la compra de mi apartamento. Su atención al detalle es impresionante.</p>
                            </div>
                            <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                <div class="d-flex align-items-end justify-content-between">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle me-3" src="img/user.png" alt="..." width="40" height="40" />
                                        <div class="small">
                                            <div class="fw-bold">Carlos López</div>
                                            <div class="text-muted">Cliente desde 2022</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Review Card 3 -->
                    <div class="col-lg-4 mb-5">
                        <div class="card h-100 shadow border-0">
                            <img class="card-img-top" src="img/img3.jpg" alt="..." />
                            <div class="card-body p-4">
                                <div class="badge bg-success bg-gradient rounded-pill mb-2">5 Estrellas</div>
                                <h5 class="card-title mb-3">La mejor inversión</h5>
                                <p class="card-text mb-0">Gracias a Inmobiliaria Java, invertí en una propiedad que ha valorizado enormemente. Su asesoría financiera fue clave.</p>
                            </div>
                            <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                <div class="d-flex align-items-end justify-content-between">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle me-3" src="img/user.png" alt="..." width="40" height="40" />
                                        <div class="small">
                                            <div class="fw-bold">María Rodríguez</div>
                                            <div class="text-muted">Cliente desde 2021</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Trabaja con nosotros-->
                <aside class="bg-primary bg-gradient rounded-3 p-4 p-sm-5 mt-5">
                    <div class="d-flex align-items-center justify-content-between flex-column flex-xl-row text-center text-xl-start">
                        <div class="mb-4 mb-xl-0">
                            <div class="fs-3 fw-bold text-white">Trabaja con nosotros</div>
                            <div class="text-white-50">Únete a nuestro equipo. Envía tu correo electrónico para más información sobre oportunidades laborales.</div>
                        </div>
                        <div class="ms-xl-4">
                            <form action="#" method="post">
                                <div class="input-group mb-2">
                                    <input class="form-control" type="email" name="email" placeholder="Tu correo electrónico..." aria-label="Correo electrónico..." required />
                                    <button class="btn btn-outline-light" type="submit">Enviar</button>
                                </div>
                            </form>
                            <div class="small text-white-50">Tu privacidad es importante, nunca compartiremos tus datos.</div>
                        </div>
                    </div>
                </aside>
            </div>
        </section>
    </main>
    <!-- Footer-->
    <footer class="bg-dark text-white py-4 mt-auto">
        <div class="container px-5 text-center">
            <div class="mb-2">
                <span class="fw-bold">Proyecto Inmobiliario</span> &copy; 2025. Todos los derechos reservados.
            </div>
            <div>
                <a href="mailto:info@inmobiliaria.com" class="text-white-50 text-decoration-none me-3"><i class="fas fa-envelope"></i> info@inmobiliaria.com</a>
                <a href="#" class="text-white-50 text-decoration-none me-3"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="text-white-50 text-decoration-none"><i class="fab fa-instagram"></i></a>
            </div>
        </div>
    </footer>
    <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/scripts.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>