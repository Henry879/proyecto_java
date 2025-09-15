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
    <title>Nosotros - Inmobiliaria Java</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos.css">
</head>
<body class="d-flex flex-column h-100">
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

    <!-- Importar fuente bonita desde Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">

<!-- Nosotros Section -->
<main class="flex-shrink-0">
    <section class="container py-5">
        <div class="row mb-4">
            <div class="col text-center">
                <h2 class="display-4 fw-bold mb-3">Sobre Nosotros</h2>
                <p class="lead text-muted">
                    En <strong>Inmobiliaria Java</strong> somos un equipo apasionado por ayudarte a encontrar el hogar ideal. Nos especializamos en proyectos modernos, atención personalizada y asesoría integral para que tu experiencia inmobiliaria sea segura y satisfactoria.
                </p>
            </div>
        </div>
        <div class="row mb-5">
            <div class="col text-center">
                <h3 class="h4 fw-bold mb-4">¿Quiénes conforman nuestro equipo?</h3>
            </div>
        </div>
        <div class="row justify-content-center">
            <!-- Miembro 1 -->
            <div class="col-md-5 mb-4">
                <div class="card h-100 shadow">
                    <img src="img/cristian.jpg" alt="Cristian - Administrador de sistemas" style="width: 100%; height: 400px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title">Cristian Becerra</h5>
                        <p class="card-text">
                            <span class="badge bg-primary mb-2">Administrador de sistemas</span><br>
                            Encargado de la gestión tecnológica y el despliegue seguro de la plataforma inmobiliaria. Supervisa la infraestructura y garantiza la disponibilidad y protección de tus datos.
                        </p>
                    </div>
                </div>
            </div>
            <!-- Miembro 2 -->
            <div class="col-md-5 mb-4">
                <div class="card h-100 shadow">
                    <img src="img/henry.jpg" alt="Henry - Asesor inmobiliario" style="width: 100%; height: 400px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title">Henry Carreño</h5>
                        <p class="card-text">
                            <span class="badge bg-success mb-2">Asesor inmobiliario</span><br>
                            Especialista en atención al cliente y diseño de experiencias. Te acompaña en cada paso, desde la búsqueda hasta la compra, asegurando que encuentres la propiedad perfecta.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-auto">
        <div class="container text-center">
            <span class="fw-bold">Inmobiliaria Java</span> &copy; 2025. Todos los derechos reservados.<br>
            <a href="mailto:info@inmobiliaria.com" class="text-white-50 text-decoration-none me-3"><i class="fas fa-envelope"></i> info@inmobiliaria.com</a>
            <a href="#" class="text-white-50 text-decoration-none me-3"><i class="fab fa-facebook-f"></i></a>
            <a href="#" class="text-white-50 text-decoration-none"><i class="fab fa-instagram"></i></a>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>