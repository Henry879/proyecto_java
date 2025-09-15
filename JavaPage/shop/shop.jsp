<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.Collections" %>
<%
    if ("true".equals(request.getParameter("logout"))) {
        session.invalidate();
        response.sendRedirect("../index.jsp");
    }

    // Declare variables for filters
    String ciudad = request.getParameter("ciudad");
    String oferta = request.getParameter("oferta");
    String[] tipos = request.getParameterValues("tipo");
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <meta name="Description" content="Catálogo de propiedades en venta"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos.css">
  <title>Propiedades en venta</title>
</head>
<body class="d-flex flex-column h-100">
  <!-- Barra superior -->
  <nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid px-4">
      <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">
        <i class="fas fa-building mr-2"></i> Inmobiliaria java
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarShop" aria-controls="navbarShop" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarShop">
        <ul class="navbar-nav ml-auto">
          <%
                    Object usuario = null;
                    Object nombre = null;
                    Object rol = null;
                    try {
                        usuario = session.getAttribute("usuario");
                        nombre = session.getAttribute("nombre");
                        rol = session.getAttribute("rol");
                    } catch (IllegalStateException e) {
                        // Session invalidated
                    }
                    if (usuario != null) {
                        if (rol == null) {
                            // Set rol if missing
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection conn = DriverManager.getConnection("jdbc:mysql://bimg5zspe3vpdruhh5sp-mysql.services.clever-cloud.com:3306/bimg5zspe3vpdruhh5sp?useSSL=false&serverTimezone=UTC", "urqjyyyurwfqifmx", "cR0QWIrrmASKpi10R4Vy");
                                String query = "SELECT rol FROM usuarios WHERE nombre_usuario = ?";
                                java.sql.PreparedStatement stmt = conn.prepareStatement(query);
                                stmt.setString(1, (String)usuario);
                                java.sql.ResultSet rs = stmt.executeQuery();
                                if (rs.next()) {
                                    rol = rs.getString("rol");
                                    session.setAttribute("rol", rol);
                                }
                                rs.close();
                                stmt.close();
                                conn.close();
                            } catch (Exception e) {
                                // ignore
                            }
                        }
                %>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/shop/shop.jsp">Propiedades</a></li>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/reviews.jsp">Reseñas</a></li>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/blog.jsp">Blog</a></li>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/soporte.jsp">Soporte</a></li>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/nosotros.jsp">Nosotros</a></li>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/perfil.jsp">Editar información</a></li>
                    <% if ("admin".equals(rol)) { %>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/admin/admin.jsp">Panel Admin</a></li>
                    <% } else if ("inmobiliaria".equals(rol)) { %>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/inmobiliaria/inmobiliaria.jsp">Panel Inmobiliaria</a></li>
                    <% } %>
                    <li class="nav-item">
                        <span class="navbar-text mr-3">Bienvenido, <%= nombre %></span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="?logout=true"><i class="fas fa-sign-out-alt"></i> Cerrar sesión</a>
                    </li>
                <% } else { %>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/shop/shop.jsp">Propiedades</a></li>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/reviews.jsp">Reseñas</a></li>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/blog.jsp">Blog</a></li>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/soporte.jsp">Soporte</a></li>
<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/nosotros.jsp">Nosotros</a></li>
<li class="nav-item">
    <a class="nav-link" href="login/login.jsp"><i class="fas fa-user"></i> Ingresar</a>
</li>
                <% } %>
        </ul>
      </div>
    </div>
  </nav>
  <% if ("true".equals(request.getParameter("success"))) { %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
      Cita agendada exitosamente. Nos pondremos en contacto pronto.
      <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
    </div>
  <% } %>
  <% if ("true".equals(request.getParameter("error"))) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
      Error al agendar la cita. Inténtalo de nuevo.
      <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
    </div>
  <% } %>
  <main class="flex-shrink-0">
    <div class="container-fluid px-4 py-4">
      <div class="row">
        <!-- Filtros -->
        <aside class="col-lg-3 mb-4">
          <form method="get" action="shop.jsp">
            <div class="filtros-box">
              <h5><i class="fas fa-filter"></i> Ubicación y tipo</h5>
              <label for="ciudad">Ciudad</label>
              <select class="form-control" id="ciudad" name="ciudad">
                <option value="" <%= (ciudad == null || ciudad.isEmpty()) ? "selected" : "" %>>Todas las ciudades</option>
                <option value="bucaramanga" <%= "bucaramanga".equals(ciudad) ? "selected" : "" %>>Bucaramanga</option>
                <option value="floridablanca" <%= "floridablanca".equals(ciudad) ? "selected" : "" %>>Floridablanca</option>
                <option value="giron" <%= "giron".equals(ciudad) ? "selected" : "" %>>Giron</option>
                <option value="barrancabermeja" <%= "barrancabermeja".equals(ciudad) ? "selected" : "" %>>Barrancabermeja</option>
              </select>
              <label class="mt-2">Oferta</label>
              <div class="btn-group btn-group-toggle d-flex mb-2" data-toggle="buttons">
                <label class="btn btn-outline-dark <%= "arrendar".equals(oferta) || oferta == null ? "active" : "" %>">
                  <input type="radio" name="oferta" value="arrendar" <%= "arrendar".equals(oferta) || oferta == null ? "checked" : "" %>> Arrendar
                </label>
                <label class="btn btn-outline-dark <%= "comprar".equals(oferta) ? "active" : "" %>">
                  <input type="radio" name="oferta" value="comprar" <%= "comprar".equals(oferta) ? "checked" : "" %>> Comprar
                </label>
              </div>
              <label>Tipo de inmueble</label>
              <div class="mb-2">
                <div class="form-check">
                  <input class="form-check-input" type="checkbox" id="tipoCasa" name="tipo" value="casa" <%= tipos != null && java.util.Arrays.asList(tipos).contains("casa") ? "checked" : "" %>>
                  <label class="form-check-label" for="tipoCasa">Casa</label>
                </div>
                <div class="form-check">
                  <input class="form-check-input" type="checkbox" id="tipoApto" name="tipo" value="apartamento" <%= tipos != null && java.util.Arrays.asList(tipos).contains("apartamento") ? "checked" : "" %>>
                  <label class="form-check-label" for="tipoApto">Apartamento</label>
                </div>
                <div class="form-check">
                  <input class="form-check-input" type="checkbox" id="tipoTerreno" name="tipo" value="terreno" <%= tipos != null && java.util.Arrays.asList(tipos).contains("terreno") ? "checked" : "" %>>
                  <label class="form-check-label" for="tipoTerreno">Terreno</label>
                </div>
                <div class="form-check">
                  <input class="form-check-input" type="checkbox" id="tipoEstudio" name="tipo" value="apartaestudio" <%= tipos != null && java.util.Arrays.asList(tipos).contains("apartaestudio") ? "checked" : "" %>>
                  <label class="form-check-label" for="tipoEstudio">Apartaestudio</label>
                </div>
              </div>
              <button type="submit" class="btn btn-search"><i class="fas fa-search"></i> Buscar</button>
            </div>
          </form>
        </aside>
        <!-- Propiedades -->
        <section class="col-lg-9">
          <div class="propiedades-lista">
          <%
            // Connect to DB and fetch properties with filters
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://bimg5zspe3vpdruhh5sp-mysql.services.clever-cloud.com:3306/bimg5zspe3vpdruhh5sp?useSSL=false&serverTimezone=UTC", "urqjyyyurwfqifmx", "cR0QWIrrmASKpi10R4Vy");

                StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM propiedades WHERE 1=1");
                java.util.List<Object> params = new java.util.ArrayList<>();

                if (ciudad != null && !ciudad.isEmpty()) {
                    sqlBuilder.append(" AND ciudad = ?");
                    params.add(ciudad);
                }
                if (oferta != null && !oferta.isEmpty()) {
                    sqlBuilder.append(" AND oferta = ?");
                    params.add(oferta);
                }
                if (tipos != null && tipos.length > 0) {
                    sqlBuilder.append(" AND tipo IN (");
                    for (int i = 0; i < tipos.length; i++) {
                        sqlBuilder.append("?");
                        if (i < tipos.length - 1) sqlBuilder.append(",");
                    }
                    sqlBuilder.append(")");
                    for (String tipo : tipos) {
                        params.add(tipo);
                    }
                }

                String sql = sqlBuilder.toString();
                stmt = conn.prepareStatement(sql);
                for (int i = 0; i < params.size(); i++) {
                    stmt.setObject(i + 1, params.get(i));
                }

                rs = stmt.executeQuery();
                while (rs.next()) {
          %>
          <div class="card-prop">
            <span class="etiqueta" style="background:<%= rs.getString("estado").equals("disponible") ? "#21c97a" : rs.getString("estado").equals("alquilada") ? "#ffd600" : "#d63031" %>;color:<%= rs.getString("estado").equals("alquilada") ? "#222" : "#fff" %>;">
              <%= rs.getString("estado").substring(0,1).toUpperCase() + rs.getString("estado").substring(1) %>
            </span>
            <img src="<%= rs.getString("imagen") %>" alt="<%= rs.getString("nombre") %>">
            <div class="card-body">
              <div class="info-extra"><%= rs.getString("ubicacion").toUpperCase() %> | <%= rs.getString("ciudad").substring(0,1).toUpperCase() + rs.getString("ciudad").substring(1) %></div>
              <div class="precio">$<%= String.format("%,d", rs.getInt("precio")) %></div>
              <div class="card-title"><%= rs.getString("nombre") %></div>
              <div class="card-text">
                <span><i class="fas fa-ruler-combined"></i> <%= rs.getDouble("metros_cuadrados") %> m²</span>
                &nbsp; <i class="fas fa-bed"></i> <%= rs.getInt("habitaciones") %> hab.
                &nbsp; <i class="fas fa-bath"></i> <%= rs.getInt("banos") %> bañ.
                <% if (rs.getInt("parqueaderos") > 0) { %>
                &nbsp; <i class="fas fa-car"></i> <%= rs.getInt("parqueaderos") %> par.
                <% } %>
              </div>
          <div class="text-center">
            <% if ("admin".equals(rol)) { %>
              <form method="post" action="<%=request.getContextPath()%>/admin/guardar_propiedad.jsp" class="d-inline">
                <input type="hidden" name="nombre" value="<%= rs.getString("nombre") %>">
                <input type="hidden" name="ciudad" value="<%= rs.getString("ciudad") %>">
                <input type="hidden" name="tipo" value="<%= rs.getString("tipo") %>">
                <input type="hidden" name="oferta" value="<%= rs.getString("oferta") %>">
                <input type="hidden" name="precio" value="<%= rs.getInt("precio") %>">
                <input type="hidden" name="metros_cuadrados" value="<%= rs.getDouble("metros_cuadrados") %>">
                <input type="hidden" name="habitaciones" value="<%= rs.getInt("habitaciones") %>">
                <input type="hidden" name="banos" value="<%= rs.getInt("banos") %>">
                <input type="hidden" name="parqueaderos" value="<%= rs.getInt("parqueaderos") %>">
                <input type="hidden" name="zona" value="<%= rs.getString("ubicacion") %>">
                <input type="hidden" name="estado" value="<%= rs.getString("estado") %>">
                <input type="hidden" name="imagen" value="<%= rs.getString("imagen") %>">
                <input type="hidden" name="usuario_id" value="<%= session.getAttribute("usuario_id") %>">
              </form>
            <% } else if (usuario != null) { %>
              <button class="btn btn-contactar" data-toggle="modal" data-target="#modalCita" data-id="<%= rs.getString("id_propiedad") %>" data-nombre="<%= rs.getString("nombre") %>">
                <i class="fas fa-envelope"></i> Contactar
              </button>
            <% } else { %>
              <a href="<%=request.getContextPath()%>/login/login.jsp" class="btn btn-contactar">
                <i class="fas fa-envelope"></i> Iniciar sesión para contactar
              </a>
            <% } %>
          </div>
            </div>
          </div>
          <%
                }
            } catch (Exception e) {
                out.println("Error cargando propiedades: " + e.getMessage());
            } finally {
                if (rs != null) try { rs.close(); } catch (Exception e) {}
                if (stmt != null) try { stmt.close(); } catch (Exception e) {}
                if (conn != null) try { conn.close(); } catch (Exception e) {}
            }
          %>



          </div>
        </section>
      </div>
    </div>
  </main>
  <!-- Footer -->
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
  <!-- Modal de cita -->
  <div class="modal fade" id="modalCita" tabindex="-1" aria-labelledby="modalCitaLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="modalCitaLabel">Agendar cita</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <!-- Formulario de citas -->
    <form method="post" action="../citas.jsp">
      <div class="mb-3">
        <label for="nombre" class="form-label fw-bold">Nombre completo</label>
        <input type="text" class="form-control" name="nombre_cliente" id="nombre" required>
      </div>
      <div class="mb-3">
        <label for="email" class="form-label fw-bold">Correo electrónico</label>
        <input type="email" class="form-control" name="email_cliente" id="email" required>
      </div>
      <div class="mb-3">
        <label for="telefono" class="form-label fw-bold">Teléfono</label>
        <input type="tel" class="form-control" name="telefono_cliente" id="telefono" required>
      </div>
      <div class="mb-3">
        <label for="propiedad" class="form-label fw-bold">Propiedad de interés</label>
        <input type="text" class="form-control" name="propiedad_nombre" id="propiedad" readonly>
        <input type="hidden" name="id_propiedad" id="id_propiedad">
      </div>
      <div class="mb-3">
        <label for="fecha" class="form-label fw-bold">Fecha de la cita</label>
        <input type="date" class="form-control" name="fecha" id="fecha" required>
      </div>
      <div class="mb-3">
        <label for="mensaje" class="form-label fw-bold">Mensaje adicional</label>
        <textarea class="form-control" name="mensaje" id="mensaje" rows="2"></textarea>
      </div>
      <button type="submit" class="btn btn-primary btn-block">Agendar cita</button>
    </form>
        </div>
      </div>
    </div>
  </div>
  <script>
    // Script to fill modal inputs with property data on button click
    document.addEventListener('DOMContentLoaded', function() {
      var modal = document.getElementById('modalCita');
      var buttons = document.querySelectorAll('.btn-contactar[data-id]');
      buttons.forEach(function(button) {
        button.addEventListener('click', function() {
          var propiedadId = this.getAttribute('data-id');
          var propiedadNombre = this.getAttribute('data-nombre');
          document.getElementById('id_propiedad').value = propiedadId;
          document.getElementById('propiedad').value = propiedadNombre;
        });
      });
    });
  </script>
  <!-- Bootstrap core JS-->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%=request.getContextPath()%>/js/scripts.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>