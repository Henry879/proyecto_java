<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%
    // Check if user is admin or inmobiliaria
    Object rolObj = session.getAttribute("rol");
    if (rolObj == null || (!"admin".equals(rolObj) && !"inmobiliaria".equals(rolObj))) {
        response.sendRedirect("../login/login.jsp");
        return;
    }

    String idParam = request.getParameter("id");
    if (idParam == null) {
        response.sendRedirect("propiedades.jsp?error=ID de propiedad no especificado");
        return;
    }
    int idPropiedad = Integer.parseInt(idParam);

    // Fetch property data
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String nombre = "", ciudad = "", tipo = "", oferta = "", estado = "", zona = "", imagen = "";
    int precio = 0, habitaciones = 0, banos = 0, parqueaderos = 0;
    double metros_cuadrados = 0.0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://bimg5zspe3vpdruhh5sp-mysql.services.clever-cloud.com:3306/bimg5zspe3vpdruhh5sp?useSSL=false&serverTimezone=UTC", "urqjyyyurwfqifmx", "cR0QWIrrmASKpi10R4Vy");

        String sql = "SELECT * FROM propiedades WHERE id_propiedad = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, idPropiedad);
        rs = stmt.executeQuery();

            if (rs.next()) {
                nombre = rs.getString("nombre");
                ciudad = rs.getString("ciudad");
                tipo = rs.getString("tipo");
                oferta = rs.getString("oferta");
                estado = rs.getString("estado");
                zona = rs.getString("ubicacion");
                imagen = rs.getString("imagen");
                precio = rs.getInt("precio");
                metros_cuadrados = rs.getDouble("metros_cuadrados");
                habitaciones = rs.getInt("habitaciones");
                banos = rs.getInt("banos");
                parqueaderos = rs.getInt("parqueaderos");
            } else {
                response.sendRedirect("propiedades.jsp?error=Propiedad no encontrada");
                return;
            }
    } catch (Exception e) {
        response.sendRedirect("propiedades.jsp?error=Error cargando propiedad: " + e.getMessage());
        return;
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Editar Propiedad - Panel Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos.css" />
</head>
<body class="d-flex flex-column h-100">
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="<%=request.getContextPath()%>/admin/admin.jsp">
                <i class="fas fa-cog mr-2"></i> Panel Admin
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarAdmin" aria-controls="navbarAdmin" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarAdmin">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/admin/admin.jsp">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/shop/shop.jsp">Propiedades</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/perfil.jsp">Perfil</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/index.jsp?logout=true">Cerrar sesión</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <main class="flex-shrink-0">
        <div class="container px-5 my-5">
            <h2 class="fw-bolder mb-4 text-center" style="color: #23395d;">Editar Propiedad</h2>
            <form method="post" action="actualizar_propiedad.jsp">
                <input type="hidden" name="id_propiedad" value="<%= idPropiedad %>" />
                <div class="mb-3">
                    <label for="nombre" class="form-label fw-bold">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" value="<%= nombre %>" required />
                </div>
                <div class="mb-3">
                    <label for="ciudad" class="form-label fw-bold">Ciudad</label>
                    <select class="form-control" id="ciudad" name="ciudad" required>
                        <option value="bucaramanga" <%= "bucaramanga".equals(ciudad) ? "selected" : "" %>>Bucaramanga</option>
                        <option value="floridablanca" <%= "floridablanca".equals(ciudad) ? "selected" : "" %>>Floridablanca</option>
                        <option value="giron" <%= "giron".equals(ciudad) ? "selected" : "" %>>Girón</option>
                        <option value="barrancabermeja" <%= "barrancabermeja".equals(ciudad) ? "selected" : "" %>>Barrancabermeja</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="tipo" class="form-label fw-bold">Tipo de inmueble</label>
                    <select class="form-control" id="tipo" name="tipo" required>
                        <option value="casa" <%= "casa".equals(tipo) ? "selected" : "" %>>Casa</option>
                        <option value="apartamento" <%= "apartamento".equals(tipo) ? "selected" : "" %>>Apartamento</option>
                        <option value="terreno" <%= "terreno".equals(tipo) ? "selected" : "" %>>Terreno</option>
                        <option value="apartaestudio" <%= "apartaestudio".equals(tipo) ? "selected" : "" %>>Apartaestudio</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="oferta" class="form-label fw-bold">Oferta</label>
                    <select class="form-control" id="oferta" name="oferta" required>
                        <option value="arrendar" <%= "arrendar".equals(oferta) ? "selected" : "" %>>Arrendar</option>
                        <option value="comprar" <%= "comprar".equals(oferta) ? "selected" : "" %>>Comprar</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="precio" class="form-label fw-bold">Precio</label>
                    <input type="number" class="form-control" id="precio" name="precio" value="<%= precio %>" required />
                </div>
                <div class="mb-3">
                    <label for="metros_cuadrados" class="form-label fw-bold">Metros cuadrados</label>
                    <input type="number" step="0.01" class="form-control" id="metros_cuadrados" name="metros_cuadrados" value="<%= metros_cuadrados %>" required />
                </div>
                <div class="mb-3">
                    <label for="habitaciones" class="form-label fw-bold">Habitaciones</label>
                    <input type="number" class="form-control" id="habitaciones" name="habitaciones" value="<%= habitaciones %>" required />
                </div>
                <div class="mb-3">
                    <label for="banos" class="form-label fw-bold">Baños</label>
                    <input type="number" class="form-control" id="banos" name="banos" value="<%= banos %>" required />
                </div>
                <div class="mb-3">
                    <label for="parqueaderos" class="form-label fw-bold">Parqueaderos</label>
                    <input type="number" class="form-control" id="parqueaderos" name="parqueaderos" value="<%= parqueaderos %>" required />
                </div>
                <div class="mb-3">
                    <label for="estado" class="form-label fw-bold">Estado</label>
                    <select class="form-control" id="estado" name="estado" required>
                        <option value="disponible" <%= "disponible".equals(estado) ? "selected" : "" %>>Disponible</option>
                        <option value="alquilada" <%= "alquilada".equals(estado) ? "selected" : "" %>>Alquilada</option>
                        <option value="vendida" <%= "vendida".equals(estado) ? "selected" : "" %>>Vendida</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="zona" class="form-label fw-bold">Zona</label>
                    <input type="text" class="form-control" id="zona" name="zona" value="<%= zona %>" required />
                </div>
                <div class="mb-3">
                    <label for="imagen" class="form-label fw-bold">Imagen URL</label>
                    <input type="text" class="form-control" id="imagen" name="imagen" value="<%= imagen %>" required />
                </div>
                <button type="submit" class="btn btn-primary">Actualizar Propiedad</button>
                <a href="admin.jsp" class="btn btn-secondary">Cancelar</a>
            </form>
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
