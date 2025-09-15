<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="java.util.*" %>
<%
    // Check if user is inmobiliaria
    Object rolObj = session.getAttribute("rol");
    if (rolObj == null || !"inmobiliaria".equals(rolObj)) {
        response.sendRedirect("../login/login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    List<Map<String, String>> disponiblesList = new ArrayList<>();
    List<Map<String, String>> alquiladasList = new ArrayList<>();
    List<Map<String, String>> vendidasList = new ArrayList<>();
    int pendientes = 0, realizadas = 0, canceladas = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://bimg5zspe3vpdruhh5sp-mysql.services.clever-cloud.com:3306/bimg5zspe3vpdruhh5sp?useSSL=false&serverTimezone=UTC", "urqjyyyurwfqifmx", "cR0QWIrrmASKpi10R4Vy");

        // Propiedades
        String sqlProp = "SELECT * FROM propiedades ORDER BY estado";
        stmt = conn.prepareStatement(sqlProp);
        rs = stmt.executeQuery();

        while (rs.next()) {
            Map<String, String> prop = new HashMap<>();
            prop.put("id", String.valueOf(rs.getInt("id_propiedad")));
            prop.put("nombre", rs.getString("nombre"));
            prop.put("precio", String.valueOf(rs.getDouble("precio")));
            prop.put("ubicacion", rs.getString("ubicacion"));
            String estado = rs.getString("estado");
            if ("disponible".equals(estado)) {
                disponiblesList.add(prop);
            } else if ("alquilada".equals(estado)) {
                alquiladasList.add(prop);
            } else if ("vendida".equals(estado)) {
                vendidasList.add(prop);
            }
        }
        rs.close();
        stmt.close();

        // Citas
        String sqlCitas = "SELECT estado, COUNT(*) AS total FROM citas GROUP BY estado";
        stmt = conn.prepareStatement(sqlCitas);
        rs = stmt.executeQuery();

        while (rs.next()) {
            String estado = rs.getString("estado");
            int total = rs.getInt("total");
            if ("pendiente".equals(estado)) {
                pendientes = total;
            } else if ("realizada".equals(estado)) {
                realizadas = total;
            } else if ("cancelada".equals(estado)) {
                canceladas = total;
            }
        }
        rs.close();
        stmt.close();
        conn.close();

        request.setAttribute("disponiblesList", disponiblesList);
        request.setAttribute("alquiladasList", alquiladasList);
        request.setAttribute("vendidasList", vendidasList);
        request.setAttribute("pendientes", pendientes);
        request.setAttribute("realizadas", realizadas);
        request.setAttribute("canceladas", canceladas);
    } catch (Exception e) {
        request.setAttribute("error", "Error al obtener reporte: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Reportes - Panel Inmobiliaria</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos.css" />
</head>
<body class="d-flex flex-column h-100">
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="<%=request.getContextPath()%>/inmobiliaria/inmobiliaria.jsp">
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
                    <li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/inmobiliaria/reportes.jsp">Reportes</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/perfil.jsp">Perfil</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/index.jsp?logout=true">Cerrar sesión</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <main class="flex-shrink-0">
        <div class="container px-5 my-5">
            <h2 class="fw-bolder mb-4 text-center" style="color: #23395d;">Reportes de Propiedades</h2>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
            <% } else { %>
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <i class="fas fa-home fa-3x mb-3 text-success"></i>
                                <h5 class="card-title">Disponibles</h5>
                                <p class="card-text">Propiedades disponibles para venta o alquiler.</p>
                                <div class="alert alert-success">
                                    <strong><%= ((List)request.getAttribute("disponiblesList")).size() %></strong> propiedades
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <i class="fas fa-key fa-3x mb-3 text-warning"></i>
                                <h5 class="card-title">Alquiladas</h5>
                                <p class="card-text">Propiedades actualmente alquiladas.</p>
                                <div class="alert alert-warning">
                                    <strong><%= ((List)request.getAttribute("alquiladasList")).size() %></strong> propiedades
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <i class="fas fa-dollar-sign fa-3x mb-3 text-danger"></i>
                                <h5 class="card-title">Vendidas</h5>
                                <p class="card-text">Propiedades vendidas.</p>
                                <div class="alert alert-danger">
                                    <strong><%= ((List)request.getAttribute("vendidasList")).size() %></strong> propiedades
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <h2 class="fw-bolder mb-4 text-center" style="color: #23395d;">Reportes de Citas</h2>
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <i class="fas fa-clock fa-3x mb-3 text-info"></i>
                                <h5 class="card-title">Pendientes</h5>
                                <p class="card-text">Citas pendientes de realizar.</p>
                                <div class="alert alert-info">
                                    <strong><%= request.getAttribute("pendientes") %></strong> citas
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <i class="fas fa-check fa-3x mb-3 text-success"></i>
                                <h5 class="card-title">Realizadas</h5>
                                <p class="card-text">Citas realizadas exitosamente.</p>
                                <div class="alert alert-success">
                                    <strong><%= request.getAttribute("realizadas") %></strong> citas
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <i class="fas fa-times fa-3x mb-3 text-danger"></i>
                                <h5 class="card-title">Canceladas</h5>
                                <p class="card-text">Citas canceladas.</p>
                                <div class="alert alert-danger">
                                    <strong><%= request.getAttribute("canceladas") %></strong> citas
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
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
</html>
