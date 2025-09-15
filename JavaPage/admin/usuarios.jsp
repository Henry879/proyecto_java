<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%
    // Check if user is logged in and is admin
    Object usuarioObj = session.getAttribute("usuario");
    Object rolObj = session.getAttribute("rol");
    if (usuarioObj == null || !"admin".equals(rolObj)) {
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
    <meta name="Description" content="Gestión de Usuarios"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos.css">
    <title>Usuarios - Panel Admin</title>
</head>
<body class="d-flex flex-column h-100">
    <!-- Barra superior -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">
                <i class="fas fa-cog mr-2"></i> Panel Admin
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarAdmin" aria-controls="navbarAdmin" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarAdmin">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/shop/shop.jsp">Propiedades</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/reviews.jsp">Reseñas</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/blog.jsp">Blog</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/soporte.jsp">Soporte</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/perfil.jsp">Editar información</a></li>
                    <li class="nav-item"><a class="nav-link" href="admin.jsp">Panel Admin</a></li>
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
            <h2 class="fw-bolder mb-4 text-center" style="color: #23395d;">Gestión de Usuarios</h2>
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
                <div class="col-md-12">
                    <a href="agregar_usuario.jsp" class="btn btn-primary mb-3"><i class="fas fa-plus"></i> Agregar Usuario</a>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre Usuario</th>
                                    <th>Email</th>
                                    <th>Rol</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                Connection conn = null;
                                PreparedStatement stmt = null;
                                ResultSet rs = null;
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    conn = DriverManager.getConnection("jdbc:mysql://bimg5zspe3vpdruhh5sp-mysql.services.clever-cloud.com:3306/bimg5zspe3vpdruhh5sp?useSSL=false&serverTimezone=UTC", "urqjyyyurwfqifmx", "cR0QWIrrmASKpi10R4Vy");

                                    String sql = "SELECT id_usuario, nombre_usuario, email, rol FROM usuarios ORDER BY id_usuario DESC";
                                    stmt = conn.prepareStatement(sql);
                                    rs = stmt.executeQuery();

                                    while (rs.next()) {
                            %>
                                <tr>
                                    <td><%= rs.getInt("id_usuario") %></td>
                                    <td><%= rs.getString("nombre_usuario") %></td>
                                    <td><%= rs.getString("email") %></td>
                                    <td><%= rs.getString("rol") %></td>
                                    <td>
                                        <a href="editar_usuario.jsp?id=<%= rs.getInt("id_usuario") %>" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Editar</a>
                                        <a href="eliminar_usuario.jsp?id=<%= rs.getInt("id_usuario") %>" class="btn btn-danger btn-sm" onclick="return confirm('¿Estás seguro de eliminar este usuario?')"><i class="fas fa-trash"></i> Eliminar</a>
                                    </td>
                                </tr>
                            <%
                                    }
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='6'>Error cargando usuarios: " + e.getMessage() + "</td></tr>");
                                } finally {
                                    if (rs != null) try { rs.close(); } catch (Exception e) {}
                                    if (stmt != null) try { stmt.close(); } catch (Exception e) {}
                                    if (conn != null) try { conn.close(); } catch (Exception e) {}
                                }
                            %>
                            </tbody>
                        </table>
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
