<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is admin or inmobiliaria
    Object rolObj = session.getAttribute("rol");
    if (rolObj == null || (!"admin".equals(rolObj) && !"inmobiliaria".equals(rolObj))) {
        response.sendRedirect("../login/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Agregar Propiedad - Panel Inmobiliaria</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos.css" />
</head>
<body class="d-flex flex-column h-100">
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="<%=request.getContextPath()%>/inmobiliaria/inmobiliaria.jsp">
                <i class="fas fa-building mr-2"></i> Panel Inmobiliaria
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarInmobiliaria" aria-controls="navbarInmobiliaria" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarInmobiliaria">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/inmobiliaria/inmobiliaria.jsp">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/shop/shop.jsp">Propiedades</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/perfil.jsp">Perfil</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/index.jsp?logout=true">Cerrar sesión</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <main class="flex-shrink-0">
        <div class="container px-5 my-5">
            <h2 class="fw-bolder mb-4 text-center" style="color: #23395d;">Agregar Nueva Propiedad</h2>
            <form method="post" action="guardar_propiedad.jsp" accept-charset="UTF-8">
                <div class="mb-3">
                    <label for="nombre" class="form-label fw-bold">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" required />
                </div>
                <div class="mb-3">
                    <label for="ciudad" class="form-label fw-bold">Ciudad</label>
                    <select class="form-control" id="ciudad" name="ciudad" required>
                        <option value="bucaramanga">Bucaramanga</option>
                        <option value="floridablanca">Floridablanca</option>
                        <option value="giron">Girón</option>
                        <option value="barrancabermeja">Barrancabermeja</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="tipo" class="form-label fw-bold">Tipo de inmueble</label>
                    <select class="form-control" id="tipo" name="tipo" required>
                        <option value="casa">Casa</option>
                        <option value="apartamento">Apartamento</option>
                        <option value="terreno">Terreno</option>
                        <option value="apartaestudio">Apartaestudio</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="oferta" class="form-label fw-bold">Oferta</label>
                    <select class="form-control" id="oferta" name="oferta" required>
                        <option value="arrendar">Arrendar</option>
                        <option value="comprar">Comprar</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="precio" class="form-label fw-bold">Precio</label>
                    <input type="number" class="form-control" id="precio" name="precio" required />
                </div>
                <div class="mb-3">
                    <label for="metros_cuadrados" class="form-label fw-bold">Metros cuadrados</label>
                    <input type="number" step="0.01" class="form-control" id="metros_cuadrados" name="metros_cuadrados" required />
                </div>
                <div class="mb-3">
                    <label for="habitaciones" class="form-label fw-bold">Habitaciones</label>
                    <input type="number" class="form-control" id="habitaciones" name="habitaciones" required />
                </div>
                <div class="mb-3">
                    <label for="banos" class="form-label fw-bold">Baños</label>
                    <input type="number" class="form-control" id="banos" name="banos" required />
                </div>
                <div class="mb-3">
                    <label for="parqueaderos" class="form-label fw-bold">Parqueaderos</label>
                    <input type="number" class="form-control" id="parqueaderos" name="parqueaderos" required />
                </div>
                <div class="mb-3">
                    <label for="estado" class="form-label fw-bold">Estado</label>
                    <select class="form-control" id="estado" name="estado" required>
                        <option value="disponible">Disponible</option>
                        <option value="alquilada">Alquilada</option>
                        <option value="vendida">Vendida</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="zona" class="form-label fw-bold">Zona</label>
                    <input type="text" class="form-control" id="zona" name="zona" required />
                </div>
                <div class="mb-3">
                    <label for="imagen" class="form-label fw-bold">Imagen URL</label>
                    <input type="text" class="form-control" id="imagen" name="imagen" required />
                </div>
                <button type="submit" class="btn btn-primary">Agregar Propiedad</button>
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
