<%@ page import="com.productos.datos.Conexion" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String email = request.getParameter("email");
    String pass = request.getParameter("password");

    // 1. NIVEL ADMIN (Anthony)
    if ("anthonyadmin".equals(email) && "anthony123".equals(pass)) {
        session.setAttribute("perfil", "ADMIN");
        session.setAttribute("nombre", "Anthony Admin");
        response.sendRedirect("usuarios.jsp");
        return;
    }

    // 2. NIVEL VENTAS (Trabajador)
    if ("ventas@tony.com".equals(email) && "ventas123".equals(pass)) {
        session.setAttribute("perfil", "VENTAS");
        session.setAttribute("nombre", "Agente de Ventas");
        response.sendRedirect("gestion_precios.jsp");
        return;
    }

    // 3. NIVEL CLIENTE (Base de Datos)
    Conexion con = new Conexion();
    String sql = "SELECT nombre_us FROM public.tb_usuario WHERE correo_us='" + email + "' AND clave_us='" + pass + "'";
    
    try {
        ResultSet rs = con.Consulta(sql);
        if (rs != null && rs.next()) {
            session.setAttribute("perfil", "CLIENTE");
            session.setAttribute("nombre", rs.getString("nombre_us"));
            response.sendRedirect("productos.jsp"); 
        } else {
            out.print("<script>alert('Acceso Denegado'); window.location='login.jsp';</script>");
        }
    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    }
%>