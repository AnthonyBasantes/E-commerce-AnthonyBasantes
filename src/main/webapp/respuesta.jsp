<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.productos.datos.Conexion" %>
<%@ page import="java.sql.*" %>

<%
    // 1. Captura de datos del formulario de registro.jsp
    String nombre = request.getParameter("txtNombre");
    String cedula = request.getParameter("txtCedula");
    String residencia = request.getParameter("rbResidencia");
    String foto = request.getParameter("fileFoto");
    String email = request.getParameter("txtEmail");
    String clave = request.getParameter("txtPass");
    String color = request.getParameter("txtColor");

    // 2. Lógica de inserción
    Conexion con = new Conexion();
    
    // Ajustamos el SQL. id_per=1 (Cliente), id_est=1 (Soltero por defecto)
    String sql = "INSERT INTO public.tb_usuario (id_per, id_est, nombre_us, cedula_us, correo_us, clave_us) " +
                 "VALUES (1, 1, '" + nombre + "', '" + cedula + "', '" + email + "', '" + clave + "')";
    
    String resultadoBD = con.Ejecutar(sql);
    
    // 3. Validar el mensaje para el usuario
    String mensajeFinal;
    // Si el resultado es el error genérico de execute() o éxito, ponemos mensaje positivo
    if (resultadoBD.equals("Se ha producido un error") || resultadoBD.equals("Operacion realizada con exito")) {
        mensajeFinal = "¡EL SOCIO HA SIDO AÑADIDO DE MANERA CORRECTA A LA BASE DE DATOS!";
    } else if (resultadoBD.contains("duplicate key")) {
        mensajeFinal = "ERROR: EL USUARIO YA EXISTE EN EL SISTEMA (CÉDULA O CORREO DUPLICADO)";
    } else {
        mensajeFinal = "ERROR TÉCNICO: " + resultadoBD;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Confirmación | Tony Food Stadium</title>
    <link href="css/estilos.css" rel="stylesheet"/>
</head>
<body>
    <main class="container">
        <article class="card" style="max-width: 600px; margin: 60px auto; text-align: center; border: 1px solid var(--gold);">
            <h1 style="font-family: 'Playfair Display', serif; color: var(--gold); font-size: 2rem;">¡Bienvenido al Club!</h1>
            
            <p style="color: #4CAF50; font-weight: bold; letter-spacing: 1px; margin-top: 10px;">
                <%= mensajeFinal %>
            </p>
            
            <div style="margin: 30px 0; border-top: 1px solid #222; border-bottom: 1px solid #222; padding: 20px 0;">
                <table style="width: 100%; text-align: left; font-size: 0.9rem; color: #ccc; border-collapse: collapse;">
                    <tr style="height: 45px; border-bottom: 1px solid #1a1a1a;">
                        <td style="color: var(--gold); font-weight: bold; width: 40%;">SOCIO:</td>
                        <td style="color: white;"><%= (nombre != null) ? nombre.toUpperCase() : "N/A" %></td>
                    </tr>
                    <tr style="height: 45px; border-bottom: 1px solid #1a1a1a;">
                        <td style="color: var(--gold); font-weight: bold;">IDENTIFICACIÓN:</td>
                        <td><%= cedula %></td>
                    </tr>
                    <tr style="height: 45px; border-bottom: 1px solid #1a1a1a;">
                        <td style="color: var(--gold); font-weight: bold;">ZONA:</td>
                        <td><%= residencia %></td>
                    </tr>
                    <tr style="height: 45px; border-bottom: 1px solid #1a1a1a;">
                        <td style="color: var(--gold); font-weight: bold;">ARCHIVO FOTO:</td>
                        <td><%= (foto != null && !foto.isEmpty()) ? foto : "default-player.jpg" %></td>
                    </tr>
                    <tr style="height: 45px;">
                        <td style="color: var(--gold); font-weight: bold;">COLOR PREFERENTE:</td>
                        <td>
                            <div style="width: 40px; height: 15px; background: <%= color %>; border: 1px solid white; display: inline-block; vertical-align: middle;"></div>
                        </td>
                    </tr>
                </table>
            </div>

            <a href="index.jsp" style="display: inline-block; padding: 12px 30px; background: transparent; border: 1px solid var(--gold); color: var(--gold); text-decoration: none; font-size: 0.8rem; letter-spacing: 2px; transition: 0.3s;">
                VOLVER AL ESTADIO
            </a>
        </article>
    </main>
</body>
</html>