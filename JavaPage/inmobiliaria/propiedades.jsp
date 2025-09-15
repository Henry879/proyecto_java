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

    // Get filter parameters
    String ciudad = request.getParameter("ciudad");
    String tipo = request.getParameter("tipo");
    String oferta = request.getParameter("oferta");
    String estado = request.getParameter("estado");
    String precioMin = request.getParameter("precio_min");
    String precioMax = request.getParameter("precio_max");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="Description" content="Gestión de Propiedades"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos.css">
    <title>Propiedades - Panel Inmobiliaria</title>
</head>
<body class="d-flex flex-column h-100">
    <!-- Barra superior -->
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
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/inmobiliaria/reportes.jsp">Reportes</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/perfil.jsp">Editar información</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/inmobiliaria/inmobiliaria.jsp">Panel Inmobiliaria</a></li>
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
            <h2 class="fw-bolder mb-4 text-center" style="color: #23395d;">Gestión de Propiedades</h2>
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
                    <a href="<%=request.getContextPath()%>/inmobiliaria/agregar_propiedad.jsp" class="btn btn-primary mb-3"><i class="fas fa-plus"></i> Agregar Propiedad</a>
                    <!-- Filtros -->
                    <form method="get" action="<%=request.getContextPath()%>/inmobiliaria/propiedades.jsp" class="mb-3">
                        <div class="row">
                            <div class="col-md-2">
                                <select class="form-control" name="ciudad">
                                    <option value="">Todas las ciudades</option>
                                    <option value="bucaramanga" <%= "bucaramanga".equals(ciudad) ? "selected" : "" %>>Bucaramanga</option>
                                    <option value="floridablanca" <%= "floridablanca".equals(ciudad) ? "selected" : "" %>>Floridablanca</option>
                                    <option value="giron" <%= "giron".equals(ciudad) ? "selected" : "" %>>Girón</option>
                                    <option value="barrancabermeja" <%= "barrancabermeja".equals(ciudad) ? "selected" : "" %>>Barrancabermeja</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select class="form-control" name="tipo">
                                    <option value="">Todos los tipos</option>
                                    <option value="casa" <%= "casa".equals(tipo) ? "selected" : "" %>>Casa</option>
                                    <option value="apartamento" <%= "apartamento".equals(tipo) ? "selected" : "" %>>Apartamento</option>
                                    <option value="terreno" <%= "terreno".equals(tipo) ? "selected" : "" %>>Terreno</option>
                                    <option value="apartaestudio" <%= "apartaestudio".equals(tipo) ? "selected" : "" %>>Apartaestudio</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select class="form-control" name="oferta">
                                    <option value="">Todas las ofertas</option>
                                    <option value="arrendar" <%= "arrendar".equals(oferta) ? "selected" : "" %>>Arrendar</option>
                                    <option value="comprar" <%= "comprar".equals(oferta) ? "selected" : "" %>>Comprar</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select class="form-control" name="estado">
                                    <option value="">Todos los estados</option>
                                    <option value="disponible" <%= "disponible".equals(estado) ? "selected" : "" %>>Disponible</option>
                                    <option value="alquilada" <%= "alquilada".equals(estado) ? "selected" : "" %>>Alquilada</option>
                                    <option value="vendida" <%= "vendida".equals(estado) ? "selected" : "" %>>Vendida</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <input type="number" class="form-control" name="precio_min" placeholder="Precio min" value="<%= precioMin != null ? precioMin : "" %>">
                            </div>
                            <div class="col-md-2">
                                <input type="number" class="form-control" name="precio_max" placeholder="Precio max" value="<%= precioMax != null ? precioMax : "" %>">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-secondary mt-2"><i class="fas fa-search"></i> Buscar</button>
                        <a href="<%=request.getContextPath()%>/inmobiliaria/propiedades.jsp" class="btn btn-outline-secondary mt-2">Limpiar filtros</a>
                    </form>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Ciudad</th>
                                    <th>Tipo</th>
                                    <th>Oferta</th>
                                    <th>Precio</th>
                                    <th>Estado</th>
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
    
                                    StringBuilder sqlBuilder = new StringBuilder("SELECT id_propiedad, nombre, ciudad, tipo, oferta, precio, estado FROM propiedades WHERE 1=1");
                                    java.util.ArrayList<Object> params = new java.util.ArrayList<>();
    
                                            if (ciudad != null && !ciudad.isEmpty()) {
                                                sqlBuilder.append(" AND ciudad = ?");
                                                params.add(ciudad);
                                            }
                                            if (tipo != null && !tipo.isEmpty()) {
                                                sqlBuilder.append(" AND tipo = ?");
                                                params.add(tipo);
                                            }
                                            if (oferta != null && !oferta.isEmpty()) {
                                                sqlBuilder.append(" AND oferta = ?");
                                                params.add(oferta);
                                            }
                                            if (estado != null && !estado.isEmpty()) {
                                                sqlBuilder.append(" AND estado = ?");
                                                params.add(estado);
                                            }
                                            if (precioMin != null && !precioMin.isEmpty()) {
                                                sqlBuilder.append(" AND precio >= ?");
                                                params.add(Integer.parseInt(precioMin));
                                            }
                                            if (precioMax != null && !precioMax.isEmpty()) {
                                                sqlBuilder.append(" AND precio <= ?");
                                                params.add(Integer.parseInt(precioMax));
                                            }
    
                                            sqlBuilder.append(" ORDER BY id_propiedad DESC");
                                            String sql = sqlBuilder.toString();
                                            stmt = conn.prepareStatement(sql);
                                            for (int i = 0; i < params.size(); i++) {
                                                stmt.setObject(i + 1, params.get(i));
                                            }
                                            rs = stmt.executeQuery();
    
                                            while (rs.next()) {
                                    %>
                                        <tr>
                                            <td><%= rs.getInt("id_propiedad") %></td>
                                            <td><%= rs.getString("nombre") %></td>
                                            <td><%= rs.getString("ciudad") %></td>
                                            <td><%= rs.getString("tipo") %></td>
                                            <td><%= rs.getString("oferta") %></td>
                                            <td>$<%= String.format("%,d", rs.getInt("precio")) %></td>
                                            <td><%= rs.getString("estado") %></td>
                                            <td>
                                                <a href="<%=request.getContextPath()%>/inmobiliaria/editar_propiedad.jsp?id=<%= rs.getInt("id_propiedad") %>" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Editar</a>
                                                <a href="<%=request.getContextPath()%>/inmobiliaria/eliminar_propiedad.jsp?id=<%= rs.getInt("id_propiedad") %>" class="btn btn-danger btn-sm" onclick="return confirm('¿Estás seguro de eliminar esta propiedad?')"><i class="fas fa-trash"></i> Eliminar</a>
                                            </td>
                                        </tr>
                                    <%
                                            }
                                        } catch (Exception e) {
                                            out.println("<tr><td colspan='8'>Error cargando propiedades: " + e.getMessage() + "</td></tr>");
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
