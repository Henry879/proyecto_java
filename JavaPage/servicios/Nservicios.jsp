<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.DriverManager, java.sql.SQLException, java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<meta name="Description" content="Enter your description here"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="assets/css/style.css">
<title>Servicios</title>
</head>
    <body class="d-flex flex-column">
        <main class="flex-shrink-0">
            <!-- Navigation-->
          <nav class="navbar navbar-expand-lg" style="background-color: #05447A;">
            <div class="container px-5">
                <a class="navbar-brand text-white fw-bold">Servicios</a>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link text-white" href="<%=request.getContextPath()%>/index.jsp">Inicio</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="<%=request.getContextPath()%>/contacto/contacto.jsp">Contact</a></li>
                    </ul>
                </div>
            </div>
        </nav>
            <!-- Header-->
            <header class="py-5">
                <div class="container px-5">
                    <div class="row justify-content-center">
                        <div class="col-lg-8 col-xxl-6">
                            <div class="text-center my-5">
                                <h1 class="fw-bolder mb-3">Nuestra misión es ayudarte a encontrar tu hogar ideal.</h1>
                                    <p class="lead fw-normal text-muted mb-4">
                                    Ofrecemos un servicio confiable y transparente para que adquieras tu vivienda con total seguridad. 
                                    Te acompañamos en cada paso del proceso, garantizando la mejor oferta y asesoría personalizada.
                                    </p>
                                    <a class="btn btn-primary btn-lg" href="<%=request.getContextPath()%>/contacto/contacto.jsp">Para conocernos más contactenos</a>
                            </div>
                        </div>
                    </div>
                </div>
            </header>
            <!-- Sección: Mis Servicios -->
<section class="py-5 bg-light" id="servicios">
  <div class="container px-4 px-lg-5 my-5">
    <div class="text-center mb-5">
      <h2 class="fw-bolder">Mis Servicios</h2>
      <p class="lead fw-normal text-muted">Conoce lo que ofrecemos para ti</p>
    </div>

    <div class="row gx-4 gx-lg-5 row-cols-1 row-cols-md-2 row-cols-lg-3 justify-content-center">

      <!-- Servicio 1 -->
      <div class="col mb-5">
        <div class="card h-100 text-center border-0 shadow-sm">
          <img class="card-img-top img-fluid" src="https://dummyimage.com/600x400/343a40/ffffff" alt="Servicio 1">
          <div class="card-body p-4">
            <h5 class="fw-bolder">Arriendos de Inmueble</h5>
            <p class="text-muted">Administramos inmuebles para destino residencial y comercial.</p>
          </div>
          <div class="card-footer bg-transparent border-0">
            <a href="#" class="btn btn-outline-dark btn-sm">Ver más</a>
          </div>
        </div>
      </div>

      <!-- Servicio 2 -->
      <div class="col mb-5">
        <div class="card h-100 text-center border-0 shadow-sm">
          <img class="card-img-top img-fluid" src="https://dummyimage.com/600x400/495057/ffffff" alt="Servicio 2">
          <div class="card-body p-4">
            <h5 class="fw-bolder">Ventas de Inmuebles</h5>
            <p class="text-muted">Con el MLS y la Lonja de Propiedad Raíz de Santander usted puede comprar y/o vender inmuebles sin riesgos.</p>
          </div>
          <div class="card-footer bg-transparent border-0">
            <a href="#" class="btn btn-outline-dark btn-sm">Ver más</a>
          </div>
        </div>
      </div>

      <!-- Servicio 3 -->
      <div class="col mb-5">
        <div class="card h-100 text-center border-0 shadow-sm">
          <img class="card-img-top img-fluid" src="https://dummyimage.com/600x400/6c757d/ffffff" alt="Servicio 3">
          <div class="card-body p-4">
            <h5 class="fw-bolder">Reparaciones y Remodelaciones</h5>
            <p class="text-muted">Ofrecemos mantenimiento preventivo y correctivo a los inmuebles.</p>
          </div>
          <div class="card-footer bg-transparent border-0">
            <a href="#" class="btn btn-outline-dark btn-sm">Ver más</a>
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
            <a href="mailto:info@inmobiliaria.com" class="text-white-50 text-decoration-none me-3">
            <i class="fas fa-envelope"></i> info@inmobiliaria.com
            </a>
            <a href="#" class="text-white-50 text-decoration-none me-3">
            <i class="fab fa-facebook-f"></i>
            </a>
            <a href="#" class="text-white-50 text-decoration-none">
            <i class="fab fa-instagram"></i>
            </a>
        </div>
        </div>
    </footer>

        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>