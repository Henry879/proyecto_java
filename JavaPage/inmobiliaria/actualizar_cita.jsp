<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement" %>
<%
    // Check if user is logged in and is inmobiliaria
    Object usuarioObj = session.getAttribute("usuario");
    Object rolObj = session.getAttribute("rol");
    if (usuarioObj == null || !"inmobiliaria".equals(rolObj)) {
        response.sendRedirect("../login/login.jsp");
        return;
    }

    int id_cita = Integer.parseInt(request.getParameter("id_cita"));
    String estado = request.getParameter("estado");

    Connection conn = null;
    PreparedStatement stmt = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://bimg5zspe3vpdruhh5sp-mysql.services.clever-cloud.com:3306/bimg5zspe3vpdruhh5sp?useSSL=false&serverTimezone=UTC", "urqjyyyurwfqifmx", "cR0QWIrrmASKpi10R4Vy");

        String sql = "UPDATE citas SET estado = ? WHERE id_cita = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, estado);
        stmt.setInt(2, id_cita);

        int rows = stmt.executeUpdate();
        if (rows > 0) {
            response.sendRedirect("citas.jsp?success=Estado de cita actualizado exitosamente");
        } else {
            response.sendRedirect("citas.jsp?error=Error al actualizar estado de cita");
        }
    } catch (Exception e) {
        response.sendRedirect("citas.jsp?error=Error: " + e.getMessage());
    } finally {
        if (stmt != null) try { stmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
