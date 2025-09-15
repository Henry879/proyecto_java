    <%@ page contentType="text/html; charset=UTF-8" language="java" %>
    <%@ page import="java.sql.Connection, java.sql.Statement, java.sql.DriverManager, java.sql.SQLException, java.sql.ResultSet" %>
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        String error = "";
        String success = "";
        if ("POST".equals(request.getMethod())) {
            String nombre = request.getParameter("nombre");
            String usuario = request.getParameter("usuario");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmar = request.getParameter("confirmar");

            if (nombre != null && usuario != null && email != null && password != null && confirmar != null) {
                if (!password.equals(confirmar)) {
                    error = "Las contraseñas no coinciden";
                } else {
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(
                            "jdbc:mysql://bimg5zspe3vpdruhh5sp-mysql.services.clever-cloud.com:3306/bimg5zspe3vpdruhh5sp?useSSL=false&serverTimezone=UTC",
                            "urqjyyyurwfqifmx",
                            "cR0QWIrrmASKpi10R4Vy"
                        );

                        // Check if usuario or email exists
                        String checkQuery = "SELECT * FROM usuarios WHERE nombre_usuario = ? OR email = ?";
                        java.sql.PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
                        checkStmt.setString(1, usuario);
                        checkStmt.setString(2, email);
                        ResultSet rs = checkStmt.executeQuery();

                        if (rs.next()) {
                            error = "El usuario o email ya existe";
                        } else {
                            String insertQuery = "INSERT INTO usuarios (nombre_usuario, contrasena, nombre, email, rol) VALUES (?, ?, ?, ?, 'cliente')";
                            java.sql.PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                            insertStmt.setString(1, usuario);
                            insertStmt.setString(2, password);
                            insertStmt.setString(3, nombre);
                            insertStmt.setString(4, email);
                            insertStmt.executeUpdate();
                            success = "Registro exitoso. Ahora puedes iniciar sesión.";
                        }

                        rs.close();
                        checkStmt.close();
                        conn.close();
                    } catch (Exception e) {
                        error = "Error de conexión: " + e.getMessage();
                    }
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
    <meta name="Description" content="Registro de usuario"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos.css">
    <title>Registro</title>
    </head>
    <body class="d-flex flex-column h-100">
    <!-- Barra superior -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid px-4">
      <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">
        <i class="fas fa-user-plus mr-2"></i> Inmobiliaria java
      </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarRegistro" aria-controls="navbarRegistro" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarRegistro">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/shop/shop.jsp">Propiedades</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/reviews.jsp">Reseñas</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/blog.jsp">Blog</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/soporte.jsp">Soporte</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/login/login.jsp"><i class="fas fa-user"></i> Ingresar</a></li>
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
                    <h2 class="fw-bolder mb-4 text-center" style="color: #23395d;">Registrarse</h2>
                    <% if (!error.isEmpty()) { %>
                        <div class="alert alert-danger"><%= error %></div>
                    <% } %>
                    <% if (!success.isEmpty()) { %>
                        <div class="alert alert-success"><%= success %></div>
                    <% } %>
                    <form method="post">
                    <div class="mb-3">
                        <label for="nombre" class="form-label fw-bold">Nombre completo</label>
                        <input type="text" class="form-control" name="nombre" id="nombre" placeholder="Ingresa tu nombre" required>
                    </div>
                    <div class="mb-3">
                        <label for="usuario" class="form-label fw-bold">Usuario</label>
                        <input type="text" class="form-control" name="usuario" id="usuario" placeholder="Elige un usuario" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label fw-bold">Correo electrónico</label>
                        <input type="email" class="form-control" name="email" id="email" placeholder="Ingresa tu correo" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label fw-bold">Contraseña</label>
                        <input type="password" class="form-control" name="password" id="password" placeholder="Crea una contraseña" required>
                    </div>
                    <div class="mb-3">
                        <label for="confirmar" class="form-label fw-bold">Confirmar contraseña</label>
                        <input type="password" class="form-control" name="confirmar" id="confirmar" placeholder="Repite la contraseña" required>
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary btn-lg">Registrarse</button>
                    </div>
                    <div class="mt-3 text-center">
                    <a href="<%=request.getContextPath()%>/login/login.jsp" class="text-primary fw-bold">¿Ya tienes cuenta? Ingresar</a>
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