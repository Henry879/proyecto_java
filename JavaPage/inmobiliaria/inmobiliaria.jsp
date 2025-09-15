<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%
    // Check if user is logged in and is inmobiliaria
    Object usuarioObj = session.getAttribute("usuario");
    Object rolObj = session.getAttribute("rol");
    if (usuarioObj == null || !"inmobiliaria".equals(rolObj)) {
        response.sendRedirect("../login/login.jsp");
        return;
    }
    String usuario = (String) usuarioObj;
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="Description" content="Panel Inmobiliaria"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos.css">
    <title>Panel Inmobiliaria - Inmobiliaria Java</title>
</head>
<body class="d-flex flex-column h-100">
    <!-- Barra superior -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">
                <i class="fas fa-building mr-2"></i> Panel Inmobiliaria
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarInmobiliaria" aria-controls="navbarInmobiliaria" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarInmobiliaria">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/shop/shop.jsp">Propiedades</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/reviews.jsp">Reseñas</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/blog.jsp">Blog</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/soporte.jsp">Soporte</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/inmobiliaria/reportes.jsp">Reportes</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/perfil.jsp">Editar información</a></li>
                    <li class="nav-item">
                        <span class="navbar-text mr-3">Bienvenido, <%= usuario %></span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/index.jsp?logout=true"><i class="fas fa-sign-out-alt"></i> Cerrar sesión</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <main class="flex-shrink-0">
        <div class="container px-5 my-5">
            <h2 class="fw-bolder mb-4 text-center" style="color: #23395d;">Panel Inmobiliaria</h2>
            <% if (request.getParameter("success") != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <%= request.getParameter("success") %>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            <% } %>
            <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= request.getParameter("error") %>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            <% } %>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card text-center">
                        <div class="card-body">
                            <i class="fas fa-home fa-3x mb-3 text-primary"></i>
                            <h5 class="card-title">Propiedades</h5>
                            <p class="card-text">Gestionar propiedades: agregar, editar, eliminar.</p>
                            <a href="<%=request.getContextPath()%>/inmobiliaria/propiedades.jsp" class="btn btn-primary">Ir a Propiedades</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card text-center">
                        <div class="card-body">
                            <i class="fas fa-calendar-alt fa-3x mb-3 text-secondary"></i>
                            <h5 class="card-title">Solicitudes de Clientes</h5>
                            <p class="card-text">Ver citas y solicitudes de clientes.</p>
                            <a href="<%=request.getContextPath()%>/inmobiliaria/citas.jsp" class="btn btn-secondary">Ver Solicitudes</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card text-center">
                        <div class="card-body">
                            <i class="fas fa-chart-bar fa-3x mb-3 text-info"></i>
                            <h5 class="card-title">Reportes</h5>
                            <p class="card-text">Generar reportes de ventas y alquileres.</p>
                            <a href="<%=request.getContextPath()%>/inmobiliaria/reportes.jsp" class="btn btn-info">Ver Reportes</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>
