<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="java.util.*" %>
<%
    // Check if user is logged in and is admin
    Object usuarioObj = session.getAttribute("usuario");
    Object rolObj = session.getAttribute("rol");
    if (usuarioObj == null || !"admin".equals(rolObj)) {
        response.sendRedirect("../login/login.jsp");
        return;
    }

    List<Map<String, String>> disponibles = new ArrayList<>();
    List<Map<String, String>> vendidos = new ArrayList<>();
    List<Map<String, String>> alquilados = new ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://bimg5zspe3vpdruhh5sp-mysql.services.clever-cloud.com:3306/bimg5zspe3vpdruhh5sp?useSSL=false&serverTimezone=UTC",
            "urqjyyyurwfqifmx",
            "cR0QWIrrmASKpi10R4Vy"
        );

        String query = "SELECT * FROM propiedades ORDER BY estado";
        PreparedStatement stmt = conn.prepareStatement(query);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Map<String, String> prop = new HashMap<>();
            prop.put("id", String.valueOf(rs.getInt("id_propiedad")));
            prop.put("nombre", rs.getString("nombre"));
            prop.put("precio", String.valueOf(rs.getDouble("precio")));
            prop.put("ubicacion", rs.getString("ubicacion"));
            prop.put("estado", rs.getString("estado"));
            String estado = rs.getString("estado");
            if ("disponible".equals(estado)) disponibles.add(prop);
            else if ("vendido".equals(estado)) vendidos.add(prop);
            else if ("alquilado".equals(estado)) alquilados.add(prop);
        }
        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        // Handle error
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reportes - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">Admin Panel</a>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/admin/citas.jsp">Citas</a></li>
            <li class="nav-item"><a class="nav-link" href="?logout=true">Logout</a></li>
        </ul>
    </nav>
    <main class="container mt-4">
        <h2>Reporte de Propiedades</h2>

        <h3>Propiedades Disponibles (<%= disponibles.size() %>)</h3>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Precio</th>
                    <th>Ubicación</th>
                </tr>
            </thead>
            <tbody>
                <% for (Map<String, String> prop : disponibles) { %>
                <tr>
                    <td><%= prop.get("id") %></td>
                    <td><%= prop.get("nombre") %></td>
                    <td><%= prop.get("precio") %></td>
                    <td><%= prop.get("ubicacion") %></td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <h3>Propiedades Vendidas (<%= vendidos.size() %>)</h3>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Precio</th>
                    <th>Ubicación</th>
                </tr>
            </thead>
            <tbody>
                <% for (Map<String, String> prop : vendidos) { %>
                <tr>
                    <td><%= prop.get("id") %></td>
                    <td><%= prop.get("nombre") %></td>
                    <td><%= prop.get("precio") %></td>
                    <td><%= prop.get("ubicacion") %></td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <h3>Propiedades Alquiladas (<%= alquilados.size() %>)</h3>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Precio</th>
                    <th>Ubicación</th>
                </tr>
            </thead>
            <tbody>
                <% for (Map<String, String> prop : alquilados) { %>
                <tr>
                    <td><%= prop.get("id") %></td>
                    <td><%= prop.get("nombre") %></td>
                    <td><%= prop.get("precio") %></td>
                    <td><%= prop.get("ubicacion") %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </main>
</body>
</html>
