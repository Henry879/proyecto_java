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
<title>Contacto</title>
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
                        <li class="nav-item"><a class="nav-link text-white" href="<%=request.getContextPath()%>/servicios/Nservicios.jsp">Nuestros servicios</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Contact Form Section -->
        <section class="py-5" style="background: #f8f9fa;">
            <div class="container px-5 my-5">
                <div class="row justify-content-center">
                    <div class="col-lg-8 col-xl-6">
                        <div class="card shadow border-0 rounded-3">
                            <div class="card-body p-4">
                                <h2 class="fw-bolder mb-4 text-center" style="color: #05447A;">Contáctanos</h2>
                                <form>
                                    <div class="mb-3">
                                        <label for="nombre" class="form-label fw-bold">Nombre completo</label>
                                        <input type="text" class="form-control" id="nombre" placeholder="Ingresa tu nombre completo" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="correo" class="form-label fw-bold">Correo electrónico</label>
                                        <input type="email" class="form-control" id="correo" placeholder="ejemplo@correo.com" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="telefono" class="form-label fw-bold">Número telefónico</label>
                                        <input type="tel" class="form-control" id="telefono" placeholder="Ingresa tu número" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="mensaje" class="form-label fw-bold">Mensaje</label>
                                        <textarea class="form-control" id="mensaje" rows="4" placeholder="Escribe tu mensaje aquí..." required></textarea>
                                    </div>
                                    <div class="d-grid">
                                        <button type="submit" class="btn btn-primary btn-lg" style="background-color: #05447A;">Enviar mensaje</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
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