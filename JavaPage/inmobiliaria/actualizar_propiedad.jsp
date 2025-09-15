<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement" %>
<%
    Object rolObj = session.getAttribute("rol");
    if (rolObj == null || (!"admin".equals(rolObj) && !"inmobiliaria".equals(rolObj))) {
        response.sendRedirect("../login/login.jsp");
        return;
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        request.setCharacterEncoding("UTF-8");
        String idStr = request.getParameter("id_propiedad");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect("propiedades.jsp?error=ID de propiedad no especificado");
            return;
        }
        int id = Integer.parseInt(idStr);

        String nombre = request.getParameter("nombre");
        String ciudad = request.getParameter("ciudad");
        String tipo = request.getParameter("tipo");
        String oferta = request.getParameter("oferta");
        String estado = request.getParameter("estado");
        String zona = request.getParameter("zona");
        String imagen = request.getParameter("imagen");

        int precio = 0;
        double metrosCuadrados = 0.0;
        int habitaciones = 0;
        int banos = 0;
        int parqueaderos = 0;

        try {
            precio = Integer.parseInt(request.getParameter("precio"));
            metrosCuadrados = Double.parseDouble(request.getParameter("metros_cuadrados"));
            habitaciones = Integer.parseInt(request.getParameter("habitaciones"));
            banos = Integer.parseInt(request.getParameter("banos"));
            parqueaderos = Integer.parseInt(request.getParameter("parqueaderos"));
        } catch (NumberFormatException e) {
            response.sendRedirect("editar_propiedad.jsp?id=" + id + "&error=Error en datos numéricos: " + e.getMessage());
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://bimg5zspe3vpdruhh5sp-mysql.services.clever-cloud.com:3306/bimg5zspe3vpdruhh5sp?useSSL=false&serverTimezone=UTC",
                "urqjyyyurwfqifmx",
                "cR0QWIrrmASKpi10R4Vy"
            );

            String sql = "UPDATE propiedades SET nombre=?, ciudad=?, tipo=?, oferta=?, precio=?, metros_cuadrados=?, habitaciones=?, banos=?, parqueaderos=?, estado=?, ubicacion=?, imagen=? WHERE id_propiedad=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, nombre);
            stmt.setString(2, ciudad);
            stmt.setString(3, tipo);
            stmt.setString(4, oferta);
            stmt.setInt(5, precio);
            stmt.setDouble(6, metrosCuadrados);
            stmt.setInt(7, habitaciones);
            stmt.setInt(8, banos);
            stmt.setInt(9, parqueaderos);
            stmt.setString(10, estado);
            stmt.setString(11, zona);
            stmt.setString(12, imagen);
            stmt.setInt(13, id);

            int rows = stmt.executeUpdate();
            stmt.close();
            conn.close();

            if (rows > 0) {
                response.sendRedirect("propiedades.jsp?success=Propiedad actualizada correctamente");
            } else {
                response.sendRedirect("editar_propiedad.jsp?id=" + id + "&error=No se pudo actualizar la propiedad");
            }
        } catch (Exception e) {
            response.sendRedirect("editar_propiedad.jsp?id=" + id + "&error=Error actualizando propiedad: " + e.getMessage());
        }
    } else {
        response.sendRedirect("propiedades.jsp");
    }
%>
