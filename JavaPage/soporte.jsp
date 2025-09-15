<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.DriverManager, java.sql.SQLException, java.sql.ResultSet" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if ("true".equals(request.getParameter("logout"))) {
        session.invalidate();
        response.sendRedirect("index.jsp");
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="Description" content="Soporte y ayuda"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos.css">
    <title>Soporte - Inmobiliaria Java</title>
</head>
<body class="d-flex flex-column h-100">
    <!-- Barra superior -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid px-4">
      <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">
        <i class="fas fa-question-circle mr-2"></i> Inmobiliaria java
      </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSoporte" aria-controls="navbarSoporte" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSoporte">
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
    <main class="flex-shrink-0">
        <section class="py-5">
            <div class="container px-5 my-5">
                <div class="row gx-5 justify-content-center">
                    <div class="col-lg-8 col-xl-6">
                        <div class="text-center">
                            <h2 class="fw-bolder">Soporte y Ayuda</h2>
                            <p class="lead fw-normal text-muted mb-5">Encuentra respuestas a tus preguntas o contáctanos para asistencia personalizada.</p>
                        </div>
                    </div>
                </div>
                <div class="row gx-5">
                    <!-- FAQ -->
                    <div class="col-lg-6 mb-5">
                        <div class="card h-100 shadow border-0">
                            <div class="card-body p-4">
                                <h5 class="card-title mb-3"><i class="fas fa-question-circle me-2"></i>Preguntas Frecuentes</h5>
                                <div class="accordion" id="faqAccordion">
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="headingOne">
                                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                                ¿Cómo puedo buscar propiedades?
                                            </button>
                                        </h2>
                                        <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#faqAccordion">
                                            <div class="accordion-body">
                                                Puedes buscar propiedades utilizando nuestro buscador en la sección "Propiedades". Filtra por ubicación, precio, tipo de propiedad y más.
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="headingTwo">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                                ¿Qué documentos necesito para comprar una casa?
                                            </button>
                                        </h2>
                                        <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#faqAccordion">
                                            <div class="accordion-body">
                                                Necesitarás identificación oficial, comprobante de ingresos, historial crediticio y posiblemente un enganche del 10-20% del valor de la propiedad.
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="headingThree">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                                ¿Ofrecen financiamiento?
                                            </button>
                                        </h2>
                                        <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#faqAccordion">
                                            <div class="accordion-body">
                                                Sí, trabajamos con varias instituciones financieras para ayudarte a obtener el mejor crédito hipotecario según tu perfil.
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="headingFour">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                                ¿Cómo puedo vender mi propiedad?
                                            </button>
                                        </h2>
                                        <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#faqAccordion">
                                            <div class="accordion-body">
                                                Contáctanos para una evaluación gratuita de tu propiedad. Te ayudaremos con la tasación, marketing y negociación.
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Contact Form -->
                    <div class="col-lg-6 mb-5">
                        <div class="card h-100 shadow border-0">
                            <div class="card-body p-4">
                                <h5 class="card-title mb-3"><i class="fas fa-envelope me-2"></i>Formulario de Contacto</h5>
                                <form>
                                    <div class="mb-3">
                                        <label for="contactName" class="form-label">Nombre</label>
                                        <input type="text" class="form-control" id="contactName" placeholder="Tu nombre" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="contactEmail" class="form-label">Correo electrónico</label>
                                        <input type="email" class="form-control" id="contactEmail" placeholder="tu@email.com" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="contactSubject" class="form-label">Asunto</label>
                                        <select class="form-control" id="contactSubject" required>
                                            <option value="">Selecciona un asunto</option>
                                            <option value="consulta">Consulta general</option>
                                            <option value="compra">Compra de propiedad</option>
                                            <option value="venta">Venta de propiedad</option>
                                            <option value="alquiler">Alquiler</option>
                                            <option value="soporte">Soporte técnico</option>
                                            <option value="otro">Otro</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="contactMessage" class="form-label">Mensaje</label>
                                        <textarea class="form-control" id="contactMessage" rows="4" placeholder="Describe tu consulta..." required></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Enviar mensaje</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Support Options -->
                <div class="row gx-5 justify-content-center">
                    <div class="col-lg-8">
                        <div class="card shadow border-0">
                            <div class="card-body p-4">
                                <h5 class="card-title mb-3 text-center"><i class="fas fa-headset me-2"></i>Otras formas de contactarnos</h5>
                                <div class="row text-center">
                                    <div class="col-md-4 mb-3">
                                        <i class="fas fa-envelope fa-2x text-primary mb-2"></i>
                                        <h6>Correo electrónico</h6>
                                        <p class="small">info@inmobiliaria.com</p>
                                        <small class="text-muted">Respuesta en 24 horas</small>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <i class="fas fa-phone fa-2x text-success mb-2"></i>
                                        <h6>Teléfono</h6>
                                        <p class="small">+1 (555) 123-4567</p>
                                        <small class="text-muted">Lun-Vie 9:00-18:00</small>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <i class="fas fa-comments fa-2x text-info mb-2"></i>
                                        <h6>Chat en vivo</h6>
                                        <p class="small">Disponible en sitio web</p>
                                        <small class="text-muted">Respuesta inmediata</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
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
    <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/scripts.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>
