<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.DriverManager, java.sql.SQLException, java.sql.ResultSet" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Check if user is logged in
    Object usuarioObj = session.getAttribute("usuario");
    if (usuarioObj == null) {
        response.sendRedirect("login/login.jsp");
        return;
    }
    String usuario = (String) usuarioObj;

    String error = "";
    String success = "";
    String nombre = "";
    String email = "";

    // Fetch current user data
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://bimg5zspe3vpdruhh5sp-mysql.services.clever-cloud.com:3306/bimg5zspe3vpdruhh5sp?useSSL=false&serverTimezone=UTC",
            "urqjyyyurwfqifmx",
            "cR0QWIrrmASKpi10R4Vy"
        );

        String query = "SELECT nombre, email FROM usuarios WHERE nombre_usuario = ?";
        java.sql.PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, usuario);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            nombre = rs.getString("nombre");
            email = rs.getString("email");
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        error = "Error al cargar datos: " + e.getMessage();
    }

    // Handle form submission
    if ("POST".equals(request.getMethod())) {
        String nuevoNombre = request.getParameter("nombre");
        String nuevoEmail = request.getParameter("email");
        String nuevaPassword = request.getParameter("password");
        String confirmarPassword = request.getParameter("confirmar");

        if (nuevoNombre != null && nuevoEmail != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://bimg5zspe3vpdruhh5sp-mysql.services.clever-cloud.com:3306/bimg5zspe3vpdruhh5sp?useSSL=false&serverTimezone=UTC",
                    "urqjyyyurwfqifmx",
                    "cR0QWIrrmASKpi10R4Vy"
                );

                // Check if email is already used by another user
                String checkQuery = "SELECT * FROM usuarios WHERE email = ? AND nombre_usuario != ?";
                java.sql.PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
                checkStmt.setString(1, nuevoEmail);
                checkStmt.setString(2, usuario);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
                    error = "El correo electrónico ya está en uso por otro usuario.";
                } else {
                    String updateQuery;
                    java.sql.PreparedStatement updateStmt;

                    if (nuevaPassword != null && !nuevaPassword.isEmpty()) {
                        if (!nuevaPassword.equals(confirmarPassword)) {
                            error = "Las contraseñas no coinciden.";
                        } else {
                            updateQuery = "UPDATE usuarios SET nombre = ?, email = ?, contrasena = ? WHERE nombre_usuario = ?";
                            updateStmt = conn.prepareStatement(updateQuery);
                            updateStmt.setString(1, nuevoNombre);
                            updateStmt.setString(2, nuevoEmail);
                            updateStmt.setString(3, nuevaPassword);
                            updateStmt.setString(4, usuario);
                            updateStmt.executeUpdate();
                            success = "Información actualizada exitosamente.";
                            nombre = nuevoNombre;
                            email = nuevoEmail;
                        }
                    } else {
                        updateQuery = "UPDATE usuarios SET nombre = ?, email = ? WHERE nombre_usuario = ?";
                        updateStmt = conn.prepareStatement(updateQuery);
                        updateStmt.setString(1, nuevoNombre);
                        updateStmt.setString(2, nuevoEmail);
                        updateStmt.setString(3, usuario);
                        updateStmt.executeUpdate();
                        success = "Información actualizada exitosamente.";
                        nombre = nuevoNombre;
                        email = nuevoEmail;
                    }
                }

                rs.close();
                checkStmt.close();
                conn.close();
            } catch (Exception e) {
                error = "Error al actualizar: " + e.getMessage();
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
    <meta name="Description" content="Editar perfil de usuario"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos.css">
    <title>Mi Perfil - Inmobiliaria Java</title>
</head>
<body class="d-flex flex-column h-100">
    <!-- Barra superior -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">
                <i class="fas fa-user mr-2"></i> Inmobiliaria java
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarPerfil" aria-controls="navbarPerfil" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarPerfil">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/shop/shop.jsp">Propiedades</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/reviews.jsp">Reseñas</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/blog.jsp">Blog</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/soporte.jsp">Soporte</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/nosotros.jsp">Nosotros</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/perfil.jsp">Editar información</a></li>
                    <li class="nav-item">
                        <span class="navbar-text mr-3">Bienvenido, <%= nombre %></span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/index.jsp?logout=true"><i class="fas fa-sign-out-alt"></i> Cerrar sesión</a>
                    </li>
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
                                <h2 class="fw-bolder mb-4 text-center" style="color: #23395d;">Editar Mi Información</h2>
                                <% if (!error.isEmpty()) { %>
                                    <div class="alert alert-danger"><%= error %></div>
                                <% } %>
                                <% if (!success.isEmpty()) { %>
                                    <div class="alert alert-success"><%= success %></div>
                                <% } %>
                                <form method="post">
                                    <div class="mb-3">
                                        <label for="usuario" class="form-label fw-bold">Usuario</label>
                                        <input type="text" class="form-control" id="usuario" value="<%= usuario %>" readonly>
                                    </div>
                                    <div class="mb-3">
                                        <label for="nombre" class="form-label fw-bold">Nombre completo</label>
                                        <input type="text" class="form-control" name="nombre" id="nombre" value="<%= nombre %>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="email" class="form-label fw-bold">Correo electrónico</label>
                                        <input type="email" class="form-control" name="email" id="email" value="<%= email %>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="password" class="form-label fw-bold">Nueva contraseña (opcional)</label>
                                        <input type="password" class="form-control" name="password" id="password" placeholder="Deja vacío para no cambiar">
                                    </div>
                                    <div class="mb-3">
                                        <label for="confirmar" class="form-label fw-bold">Confirmar nueva contraseña</label>
                                        <input type="password" class="form-control" name="confirmar" id="confirmar" placeholder="Deja vacío para no cambiar">
                                    </div>
                                    <div class="d-grid">
                                        <button type="submit" class="btn btn-primary btn-lg">Actualizar información</button>
                                    </div>
                                </form>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>
