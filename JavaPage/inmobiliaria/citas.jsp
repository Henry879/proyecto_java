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
    <meta name="Description" content="Citas Solicitadas"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos.css">
    <title>Citas - Panel Inmobiliaria</title>
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
            <h2 class="fw-bolder mb-4 text-center" style="color: #23395d;">Citas Solicitadas</h2>
            <% if (request.getParameter("success") != null) { %>
                <div class="alert alert-success"><%= request.getParameter("success") %></div>
            <% } %>
            <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger"><%= request.getParameter("error") %></div>
            <% } %>
            <div class="row">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>ID Cita</th>
                                    <th>Usuario</th>
                                    <th>Nombre Cliente</th>
                                    <th>Email Cliente</th>
                                    <th>Teléfono</th>
                                    <th>Fecha</th>
                                    <th>Mensaje</th>
                                    <th>Estado</th>
                                    <th>Actualizar Estado</th>
                                    <th>Propiedad de interés</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                Connection connCitas = null;
                                PreparedStatement stmtCitas = null;
                                ResultSet rsCitas = null;
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    connCitas = DriverManager.getConnection("jdbc:mysql://bimg5zspe3vpdruhh5sp-mysql.services.clever-cloud.com:3306/bimg5zspe3vpdruhh5sp?useSSL=false&serverTimezone=UTC", "urqjyyyurwfqifmx", "cR0QWIrrmASKpi10R4Vy");

                                    String sqlCitas = "SELECT c.id_cita, u.nombre_usuario, c.nombre_cliente, c.email_cliente, c.telefono_cliente, c.fecha, c.mensaje, c.estado, p.nombre AS propiedad_nombre FROM citas c JOIN usuarios u ON c.id_usuario = u.id_usuario LEFT JOIN propiedades p ON c.id_propiedad = p.id_propiedad ORDER BY c.fecha DESC";
                                    stmtCitas = connCitas.prepareStatement(sqlCitas);
                                    rsCitas = stmtCitas.executeQuery();

                                    while (rsCitas.next()) {
                            %>
                                <tr>
                                    <td><%= rsCitas.getInt("id_cita") %></td>
                                    <td><%= rsCitas.getString("nombre_usuario") %></td>
                                    <td><%= rsCitas.getString("nombre_cliente") %></td>
                                    <td><%= rsCitas.getString("email_cliente") %></td>
                                    <td><%= rsCitas.getString("telefono_cliente") %></td>
                                    <td><%= rsCitas.getDate("fecha") %></td>
                                    <td><%= rsCitas.getString("mensaje") %></td>
                                    <td><%= rsCitas.getString("estado") %></td>
                                    <td>
                                        <form method="post" action="actualizar_cita.jsp" style="display: inline;">
                                            <input type="hidden" name="id_cita" value="<%= rsCitas.getInt("id_cita") %>">
                                            <select name="estado" class="form-control form-control-sm" style="width: auto; display: inline;">
                                                <option value="pendiente" <%= "pendiente".equals(rsCitas.getString("estado")) ? "selected" : "" %>>Pendiente</option>
                                                <option value="realizada" <%= "realizada".equals(rsCitas.getString("estado")) ? "selected" : "" %>>Realizada</option>
                                                <option value="cancelada" <%= "cancelada".equals(rsCitas.getString("estado")) ? "selected" : "" %>>Cancelada</option>
                                            </select>
                                            <button type="submit" class="btn btn-primary btn-sm ml-2">Actualizar</button>
                                        </form>
                                    </td>
                                    <td><%= rsCitas.getString("propiedad_nombre") != null ? rsCitas.getString("propiedad_nombre") : "N/A" %></td>
                                </tr>
                            <%
                                    }
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='10'>Error cargando citas: " + e.getMessage() + "</td></tr>");
                                } finally {
                                    if (rsCitas != null) try { rsCitas.close(); } catch (Exception e) {}
                                    if (stmtCitas != null) try { stmtCitas.close(); } catch (Exception e) {}
                                    if (connCitas != null) try { connCitas.close(); } catch (Exception e) {}
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
