<%@ page import="com.productos.datos.Conexion" %>
<%@ page import="java.sql.*" %>
<%
    // BLOQUE DE SEGURIDAD PARA EL ADMIN
    if (session.getAttribute("perfil") == null || !session.getAttribute("perfil").equals("ADMIN")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Panel Admin | Tony Food Stadium</title>
    <link href="css/estilos.css" rel="stylesheet"/>
</head>
<body style="background: #000;">

    <header class="hero" style="height: 25vh;">
        <div class="hero-overlay">
            <h1 class="main-title">Panel de Administración</h1>
            <p class="subtitle">Lista Maestra de Socios Registrados</p>
        </div>
    </header>

    <nav class="navbar">
        <a href="index.jsp">Ir al Inicio</a>
        <a class="active" href="usuarios.jsp">Usuarios</a>
        <a href="logout.jsp" class="nav-auth" style="background: #96281b;">Cerrar Sesión</a>
    </nav>

    <main class="container" style="margin-top: -50px;">
        <article class="card" style="border-top: 3px solid var(--gold);">
            <table style="width: 100%; border-collapse: collapse; color: white; text-align: left;">
                <thead>
                    <tr style="border-bottom: 2px solid var(--gold); color: var(--gold); text-transform: uppercase; font-size: 0.75rem; letter-spacing: 1px;">
                        <th style="padding: 20px;">Nombre del Socio</th>
                        <th>Identificación (Cédula)</th>
                        <th>Correo Electrónico</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Conexion con = new Conexion();
                        // Consulta todos los usuarios de la tabla que vimos en tu captura
                        ResultSet rs = con.Consulta("SELECT nombre_us, cedula_us, correo_us FROM public.tb_usuario ORDER BY nombre_us ASC");
                        
                        while(rs != null && rs.next()) {
                    %>
                    <tr style="border-bottom: 1px solid #1a1a1a; transition: 0.3s;">
                        <td style="padding: 15px; font-weight: bold;"><%= rs.getString("nombre_us") %></td>
                        <td style="color: #888;"><%= rs.getString("cedula_us") %></td>
                        <td style="color: var(--gold);"><%= rs.getString("correo_us") %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </article>
    </main>

    <footer style="text-align: center; padding: 40px; color: #444; font-size: 0.7rem;">
        MODO ADMINISTRADOR ACTIVADO - TONY FOOD STADIUM &copy; 2026
    </footer>

</body>
</html>