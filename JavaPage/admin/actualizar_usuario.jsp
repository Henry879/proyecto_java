<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement" %>
<%
    // Check if user is logged in and is admin
    Object usuarioObj = session.getAttribute("usuario");
    Object rolObj = session.getAttribute("rol");
    if (usuarioObj == null || !"admin".equals(rolObj)) {
        response.sendRedirect("../login/login.jsp");
        return;
    }

    int id_usuario = Integer.parseInt(request.getParameter("id_usuario"));
    String nombre_usuario = request.getParameter("nombre_usuario");
    String nombre = request.getParameter("nombre");
    String email = request.getParameter("email");
    String rol = request.getParameter("rol");

    Connection conn = null;
    PreparedStatement stmt = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://bimg5zspe3vpdruhh5sp-mysql.services.clever-cloud.com:3306/bimg5zspe3vpdruhh5sp?useSSL=false&serverTimezone=UTC", "urqjyyyurwfqifmx", "cR0QWIrrmASKpi10R4Vy");

        String sql = "UPDATE usuarios SET nombre_usuario = ?, nombre = ?, email = ?, rol = ? WHERE id_usuario = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, nombre_usuario);
        stmt.setString(2, nombre);
        stmt.setString(3, email);
        stmt.setString(4, rol);
        stmt.setInt(5, id_usuario);

        int rows = stmt.executeUpdate();
        if (rows > 0) {
            response.sendRedirect("usuarios.jsp?success=Usuario actualizado exitosamente");
        } else {
            response.sendRedirect("usuarios.jsp?error=Error al actualizar usuario");
        }
    } catch (Exception e) {
        response.sendRedirect("usuarios.jsp?error=Error: " + e.getMessage());
    } finally {
        if (stmt != null) try { stmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
