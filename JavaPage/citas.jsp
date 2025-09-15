<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException, java.sql.ResultSet" %>
<%
    // Handle form submission
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nombreCliente = request.getParameter("nombre_cliente");
        String emailCliente = request.getParameter("email_cliente");
        String telefonoCliente = request.getParameter("telefono_cliente");
        String idPropiedad = request.getParameter("id_propiedad");
        String fecha = request.getParameter("fecha");
        String mensaje = request.getParameter("mensaje");

        // Get user ID if logged in
        Integer idUsuario = null;
        String nombreUsuario = null;
        try {
            Object usuario = session.getAttribute("usuario");
            if (usuario != null) {
                nombreUsuario = usuario.toString();
                // Query to get id_usuario from nombre_usuario
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connTemp = DriverManager.getConnection("jdbc:mysql://bimg5zspe3vpdruhh5sp-mysql.services.clever-cloud.com:3306/bimg5zspe3vpdruhh5sp?useSSL=false&serverTimezone=UTC", "urqjyyyurwfqifmx", "cR0QWIrrmASKpi10R4Vy");
                String query = "SELECT id_usuario FROM usuarios WHERE nombre_usuario = ?";
                java.sql.PreparedStatement stmtTemp = connTemp.prepareStatement(query);
                stmtTemp.setString(1, nombreUsuario);
                ResultSet rs = stmtTemp.executeQuery();
                if (rs.next()) {
                    idUsuario = rs.getInt("id_usuario");
                }
                rs.close();
                stmtTemp.close();
                connTemp.close();
            } else {
                // Not logged in, redirect to login
                response.sendRedirect(request.getContextPath() + "/login/login.jsp?error=Debes iniciar sesión para agendar una cita");
                return;
            }
        } catch (Exception e) {
            out.println("Error obteniendo usuario: " + e.getMessage());
            return;
        }

        // Database connection
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://bimg5zspe3vpdruhh5sp-mysql.services.clever-cloud.com:3306/bimg5zspe3vpdruhh5sp?useSSL=false&serverTimezone=UTC", "urqjyyyurwfqifmx", "cR0QWIrrmASKpi10R4Vy");

            String sql = "INSERT INTO citas (id_usuario, nombre_cliente, email_cliente, telefono_cliente, id_propiedad, fecha, estado, mensaje) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setObject(1, idUsuario);
            stmt.setString(2, nombreCliente);
            stmt.setString(3, emailCliente);
            stmt.setString(4, telefonoCliente);
            if (idPropiedad != null && !idPropiedad.isEmpty()) {
                stmt.setInt(5, Integer.parseInt(idPropiedad));
            } else {
                stmt.setNull(5, java.sql.Types.INTEGER);
            }
            stmt.setString(6, fecha);
            stmt.setString(7, "pendiente");
            stmt.setString(8, mensaje);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                // Success
                response.sendRedirect(request.getContextPath() + "/shop/shop.jsp?success=true");
            } else {
                // Error
                response.sendRedirect(request.getContextPath() + "/shop/shop.jsp?error=true");
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
            e.printStackTrace();
            // response.sendRedirect("shop/shop.jsp?error=true");
        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    } else {
        // If not POST, redirect
        response.sendRedirect("shop/shop.jsp");
    }
%>
