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
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="Description" content="Blog inmobiliario"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos.css">
    <title>Blog - Inmobiliaria Java</title>
</head>
<body class="d-flex flex-column h-100">
    <!-- Barra superior -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid px-4">
    <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">
        <i class="fas fa-newspaper mr-2"></i> Inmobiliaria java
    </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarBlog" aria-controls="navbarBlog" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarBlog">
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
    <main class="flex-shrink-0">
        <section class="py-5">
            <div class="container px-5 my-5">
                <div class="row gx-5 justify-content-center">
                    <div class="col-lg-8 col-xl-6">
                        <div class="text-center">
                            <h2 class="fw-bolder">Blog Inmobiliario</h2>
                            <p class="lead fw-normal text-muted mb-5">Artículos informativos sobre compra, venta, alquiler y mantenimiento de propiedades.</p>
                        </div>
                    </div>
                </div>
                <div class="row gx-5">
                    <!-- Article 1 -->
                    <div class="col-lg-6 mb-5">
                        <div class="card h-100 shadow border-0">
                            <img class="card-img-top" src="img/img4.jpg" alt="..." />
                            <div class="card-body p-4">
                                <div class="badge bg-primary bg-gradient rounded-pill mb-2">Compra</div>
                                <h5 class="card-title mb-3">Guía completa para comprar tu primera casa</h5>
                                <p class="card-text mb-0">Descubre los pasos esenciales para adquirir tu primera propiedad: desde la búsqueda hasta la firma del contrato. Consejos prácticos para evitar errores comunes.</p>
                            </div>
                            <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                <div class="d-flex align-items-center">
                                    <img class="rounded-circle me-3" src="img/user.png" width="40" height="40" alt="..." />
                                    <div class="small">
                                        <div class="fw-bold">María López</div>
                                        <div class="text-muted">15 de enero, 2025</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Article 2 -->
                    <div class="col-lg-6 mb-5">
                        <div class="card h-100 shadow border-0">
                            <img class="card-img-top" src="img/img5.jpg" alt="..." />
                            <div class="card-body p-4">
                                <div class="badge bg-success bg-gradient rounded-pill mb-2">Financiamiento</div>
                                <h5 class="card-title mb-3">Opciones de financiamiento para tu vivienda</h5>
                                <p class="card-text mb-0">Explora las diferentes alternativas de crédito hipotecario disponibles en el mercado. Compara tasas, requisitos y beneficios para elegir la mejor opción.</p>
                            </div>
                            <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                <div class="d-flex align-items-end justify-content-between">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle me-3" src="img/user.png" width="40" height="40" alt="..." />
                                        <div class="small">
                                            <div class="fw-bold">Carlos Rodríguez</div>
                                            <div class="text-muted">10 de enero, 2025</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Article 3 -->
                    <div class="col-lg-6 mb-5">
                        <div class="card h-100 shadow border-0">
                            <img class="card-img-top" src="img/img6.jpg" alt="..." />
                            <div class="card-body p-4">
                                <div class="badge bg-info bg-gradient rounded-pill mb-2">Mantenimiento</div>
                                <h5 class="card-title mb-3">Mantenimiento preventivo de tu hogar</h5>
                                <p class="card-text mb-0">Aprende sobre las tareas de mantenimiento esenciales para mantener tu propiedad en óptimas condiciones y evitar reparaciones costosas.</p>
                            </div>
                            <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                <div class="d-flex align-items-end justify-content-between">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle me-3" src="img/user.png" width="40" height="40" alt="..." />
                                        <div class="small">
                                            <div class="fw-bold">Ana Martínez</div>
                                            <div class="text-muted">5 de enero, 2025</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Article 4 -->
                    <div class="col-lg-6 mb-5">
                        <div class="card h-100 shadow border-0">
                            <img class="card-img-top" src="img/img7.jpg" alt="..." />
                            <div class="card-body p-4">
                                <div class="badge bg-warning bg-gradient rounded-pill mb-2">Alquiler</div>
                                <h5 class="card-title mb-3">Consejos para alquilar tu propiedad</h5>
                                <p class="card-text mb-0">Guía práctica para propietarios que desean alquilar sus inmuebles. Desde la fijación de precios hasta la selección de inquilinos confiables.</p>
                            </div>
                            <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                <div class="d-flex align-items-end justify-content-between">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle me-3" src="img/user.png" width="40" height="40" alt="..." />
                                        <div class="small">
                                            <div class="fw-bold">Luis García</div>
                                            <div class="text-muted">1 de enero, 2025</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Article 5 -->
                    <div class="col-lg-6 mb-5">
                        <div class="card h-100 shadow border-0">
                            <img class="card-img-top" src="img/img8.jpg" alt="..." />
                            <div class="card-body p-4">
                                <div class="badge bg-danger bg-gradient rounded-pill mb-2">Venta</div>
                                <h5 class="card-title mb-3">Cómo vender tu casa rápidamente</h5>
                                <p class="card-text mb-0">Estrategias efectivas para vender tu propiedad en el menor tiempo posible. Preparación, marketing y negociación para obtener el mejor precio.</p>
                            </div>
                            <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                <div class="d-flex align-items-end justify-content-between">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle me-3" src="img/user.png" width="40" height="40" alt="..." />
                                        <div class="small">
                                            <div class="fw-bold">Sofia López</div>
                                            <div class="text-muted">28 de diciembre, 2024</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Article 6 -->
                    <div class="col-lg-6 mb-5">
                        <div class="card h-100 shadow border-0">
                            <img class="card-img-top" src="img/img9.jpg" alt="..." />
                            <div class="card-body p-4">
                                <div class="badge bg-secondary bg-gradient rounded-pill mb-2">Inversión</div>
                                <h5 class="card-title mb-3">Invertir en bienes raíces: ¿Es buen momento?</h5>
                                <p class="card-text mb-0">Análisis del mercado actual y consejos para invertir en propiedades. Riesgos, oportunidades y estrategias de inversión a largo plazo.</p>
                            </div>
                            <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                <div class="d-flex align-items-end justify-content-between">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle me-3" src="img/user.png" width="40" height="40" alt="..." />
                                        <div class="small">
                                            <div class="fw-bold">Javier Torres</div>
                                            <div class="text-muted">25 de diciembre, 2024</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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
