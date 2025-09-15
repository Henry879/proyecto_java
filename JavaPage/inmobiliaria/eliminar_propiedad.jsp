<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Object rolObj = session.getAttribute("rol");
    if (rolObj == null || (!"admin".equals(rolObj) && !"inmobiliaria".equals(rolObj))) {
        response.sendRedirect("../login/login.jsp");
        return;
    }

    String idStr = request.getParameter("id");
    if (idStr == null || idStr.trim().isEmpty()) {
        response.sendRedirect("propiedades.jsp?error=ID de propiedad no especificado");
        return;
    }

    try {
        int id = Integer.parseInt(idStr);
        Class.forName("com.mysql.cj.jdbc.Driver");
        java.sql.Connection conn = java.sql.DriverManager.getConnection(
            "jdbc:mysql://bimg5zspe3vpdruhh5sp-mysql.services.clever-cloud.com:3306/bimg5zspe3vpdruhh5sp?useSSL=false&serverTimezone=UTC",
            "urqjyyyurwfqifmx",
            "cR0QWIrrmASKpi10R4Vy"
        );
        String sql = "DELETE FROM propiedades WHERE id_propiedad = ?";
        java.sql.PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        int rows = stmt.executeUpdate();
        stmt.close();
        conn.close();

        if (rows > 0) {
            response.sendRedirect("propiedades.jsp?success=Propiedad eliminada correctamente");
        } else {
            response.sendRedirect("propiedades.jsp?error=No se encontró la propiedad");
        }
    } catch (Exception e) {
        response.sendRedirect("propiedades.jsp?error=Error eliminando propiedad: " + e.getMessage());
    }
%>
