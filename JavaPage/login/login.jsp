<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.DriverManager, java.sql.SQLException, java.sql.ResultSet" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String error = "";
    if ("POST".equals(request.getMethod())) {
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");

        if (usuario != null && password != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://bimg5zspe3vpdruhh5sp-mysql.services.clever-cloud.com:3306/bimg5zspe3vpdruhh5sp?useSSL=false&serverTimezone=UTC",
                    "urqjyyyurwfqifmx",
                    "cR0QWIrrmASKpi10R4Vy"
                );

                String query = "SELECT * FROM usuarios WHERE nombre_usuario = ? AND contrasena = ?";
                java.sql.PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, usuario);
                stmt.setString(2, password);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    session.setAttribute("usuario", rs.getString("nombre_usuario"));
                    session.setAttribute("rol", rs.getString("rol"));
                    session.setAttribute("nombre", rs.getString("nombre"));
                    response.sendRedirect("../index.jsp");
                } else {
                    error = "Usuario o contraseña incorrectos";
                }

                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                error = "Error de conexión: " + e.getMessage();
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<meta name="Description" content="Login page"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/estilos.css">
<title>Login</title>
</head>
<body class="d-flex flex-column h-100">
    <!-- Barra superior -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid px-4">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">
        <i class="fas fa-user mr-2"></i> Inmobiliaria java
        </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarLogin" aria-controls="navbarLogin" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarLogin">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/shop/shop.jsp">Propiedades</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/reviews.jsp">Reseñas</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/blog.jsp">Blog</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/soporte.jsp">Soporte</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <main class="flex-shrink-0">
        <section class="py-5">
            <div class="container px-5 my-5">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-xl-5">
                        <div class="card shadow border-0 rounded-3">
                            <div class="card-body p-4">
                                <h2 class="fw-bolder mb-4 text-center" style="color: #23395d;">Iniciar Sesión</h2>
                                <% if (!error.isEmpty()) { %>
                                    <div class="alert alert-danger"><%= error %></div>
                                <% } %>
                                <form method="post">
                                    <div class="mb-3">
                                        <label for="usuario" class="form-label fw-bold">Usuario</label>
                                        <input type="text" class="form-control" name="usuario" id="usuario" placeholder="Ingresa tu usuario" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="password" class="form-label fw-bold">Contraseña</label>
                                        <input type="password" class="form-control" name="password" id="password" placeholder="Ingresa tu contraseña" required>
                                    </div>
                                    <div class="d-grid">
                                        <button type="submit" class="btn btn-primary btn-lg">Entrar</button>
                                    </div>
                                </form>
                                <div class="mt-3 text-center">
                                    <a href="../registro/registro.jsp" class="text-primary fw-bold">¿No tienes cuenta? Crear</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
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