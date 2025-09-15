<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // For demonstration, settings are stored in session attributes.
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String siteTitle = request.getParameter("siteTitle");
        String darkMode = request.getParameter("darkMode");
        String maintenanceMode = request.getParameter("maintenanceMode");
        String userRegistration = request.getParameter("userRegistration");

        session.setAttribute("siteTitle", siteTitle != null ? siteTitle : "Inmobiliaria Java");
        session.setAttribute("darkMode", darkMode != null);
        session.setAttribute("maintenanceMode", maintenanceMode != null);
        session.setAttribute("userRegistration", userRegistration != null);

        request.setAttribute("message", "Configuración guardada correctamente.");
    }

    String siteTitle = (String) session.getAttribute("siteTitle");
    if (siteTitle == null) siteTitle = "Inmobiliaria Java";
    Boolean darkMode = (Boolean) session.getAttribute("darkMode");
    if (darkMode == null) darkMode = false;
    Boolean maintenanceMode = (Boolean) session.getAttribute("maintenanceMode");
    if (maintenanceMode == null) maintenanceMode = false;
    Boolean userRegistration = (Boolean) session.getAttribute("userRegistration");
    if (userRegistration == null) userRegistration = true;
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Configuración del Sistema - Panel Admin</title>
    <link rel="stylesheet" href="../estilos.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css" />
    <style>
        body {
            background-color: #f8f9fa;
        }
        .config-container {
            max-width: 600px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        h1 {
            color: #23395d;
            margin-bottom: 30px;
            text-align: center;
        }
        .form-check-label {
            font-weight: 600;
        }
        .btn-save {
            background-color: #23395d;
            border: none;
        }
        .btn-save:hover {
            background-color: #1a2a45;
        }
        .alert-success {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="config-container">
        <h1>Configuración del Sistema</h1>
        <form method="post" action="configuracion.jsp">
            <div class="form-group">
                <label for="siteTitle">Título del Sitio</label>
                <input type="text" id="siteTitle" name="siteTitle" class="form-control" value="<%= siteTitle %>" required />
            </div>
            <div class="form-check mt-3">
                <input type="checkbox" id="darkMode" name="darkMode" class="form-check-input" <%= darkMode ? "checked" : "" %> />
                <label for="darkMode" class="form-check-label">Activar modo oscuro</label>
            </div>
            <div class="form-check mt-3">
                <input type="checkbox" id="maintenanceMode" name="maintenanceMode" class="form-check-input" <%= maintenanceMode ? "checked" : "" %> />
                <label for="maintenanceMode" class="form-check-label">Activar modo mantenimiento</label>
            </div>
            <div class="form-check mt-3">
                <input type="checkbox" id="userRegistration" name="userRegistration" class="form-check-input" <%= userRegistration ? "checked" : "" %> />
                <label for="userRegistration" class="form-check-label">Habilitar registro de usuarios</label>
            </div>
            <button type="submit" class="btn btn-save btn-primary mt-4 w-100">Guardar configuración</button>
        </form>
        <% if (request.getAttribute("message") != null) { %>
            <div class="alert alert-success" role="alert"><%= request.getAttribute("message") %></div>
        <% } %>
    </div>
</body>
</html>
