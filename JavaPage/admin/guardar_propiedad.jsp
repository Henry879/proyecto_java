<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%
    // Check if user is admin or inmobiliaria
    Object rolObj = session.getAttribute("rol");
    if (rolObj == null || (!"admin".equals(rolObj) && !"inmobiliaria".equals(rolObj))) {
        response.sendRedirect("../login/login.jsp");
        return;
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nombre = request.getParameter("nombre");
        String ciudad = request.getParameter("ciudad");
        String tipo = request.getParameter("tipo");
        String oferta = request.getParameter("oferta");
        String estado = request.getParameter("estado");
        String ubicacion = request.getParameter("zona");
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

            // Insert into DB
            Connection conn = DriverManager.getConnection("jdbc:mysql://bimg5zspe3vpdruhh5sp-mysql.services.clever-cloud.com:3306/bimg5zspe3vpdruhh5sp?useSSL=false&serverTimezone=UTC", "urqjyyyurwfqifmx", "cR0QWIrrmASKpi10R4Vy");
            String sql = "INSERT INTO propiedades (nombre, precio, metros_cuadrados, habitaciones, banos, parqueaderos, ubicacion, estado, imagen, ciudad, oferta, tipo, usuario_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            Integer usuarioId = 0;
            Object usuarioObj = session.getAttribute("usuario");
            if (usuarioObj != null) {
                String nombreUsuario = usuarioObj.toString();
                try {
                    String queryId = "SELECT id_usuario FROM usuarios WHERE nombre_usuario = ?";
                    java.sql.PreparedStatement stmtId = conn.prepareStatement(queryId);
                    stmtId.setString(1, nombreUsuario);
                    ResultSet rsId = stmtId.executeQuery();
                    if (rsId.next()) {
                        usuarioId = rsId.getInt("id_usuario");
                    }
                    rsId.close();
                    stmtId.close();
                } catch (Exception e) {
                    // Ignore, use 0
                }
            }
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, nombre);
            stmt.setInt(2, precio);
            stmt.setDouble(3, metrosCuadrados);
            stmt.setInt(4, habitaciones);
            stmt.setInt(5, banos);
            stmt.setInt(6, parqueaderos);
            stmt.setString(7, ubicacion);
            stmt.setString(8, estado);
            stmt.setString(9, imagen);
            stmt.setString(10, ciudad);
            stmt.setString(11, oferta);
            stmt.setString(12, tipo);
            stmt.setInt(13, usuarioId);

            int rows = stmt.executeUpdate();
            stmt.close();
            conn.close();

            if (rows > 0) {
                response.sendRedirect("admin.jsp?success=Propiedad agregada exitosamente");
            } else {
                response.sendRedirect("agregar_propiedad.jsp?error=No se pudo agregar la propiedad");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("agregar_propiedad.jsp?error=Error en los datos numéricos: " + e.getMessage());
        } catch (Exception e) {
            response.sendRedirect("agregar_propiedad.jsp?error=Error agregando propiedad: " + e.getMessage());
        }
    } else {
        response.sendRedirect("agregar_propiedad.jsp");
    }
%>
