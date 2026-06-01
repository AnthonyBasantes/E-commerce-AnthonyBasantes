<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.productos.datos.Conexion" %>
<%@ page import="java.sql.*" %>
<%
    // Solo permitimos el paso si es ADMIN (puedes ajustar esto según tu lógica de perfiles)
    if (session.getAttribute("perfil") == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin | Reporte de Ventas</title>
    <style>
        body { background: #050505; color: white; font-family: sans-serif; padding: 40px; }
        h1 { color: #c5a059; border-bottom: 2px solid #c5a059; }
        table { width: 100%; border-collapse: collapse; background: #111; margin-top: 20px; }
        th { background: #c5a059; color: black; padding: 15px; text-align: left; }
        td { padding: 15px; border-bottom: 1px solid #333; }
        .gold { color: #c5a059; font-weight: bold; }
    </style>
</head>
<body>
    <h1>HISTORIAL DE VENTAS - TONY FOOD STADIUM</h1>
    
    <table>
        <thead>
            <tr>
                <th>FECHA</th>
                <th>CLIENTE</th>
                <th>PEDIDO</th>
                <th>TOTAL</th>
            </tr>
        </thead>
        <tbody>
            <%
                Conexion con = new Conexion();
                String sql = "SELECT * FROM public.tb_venta ORDER BY fecha_ven DESC";
                ResultSet rs = con.Consulta(sql);
                
                while(rs != null && rs.next()) {
            %>
            <tr>
                <td><%= rs.getTimestamp("fecha_ven") %></td>
                <td><%= rs.getString("cliente_ven") %></td>
                <td><%= rs.getString("detalle_ven") %></td>
                <td class="gold">$<%= rs.getDouble("total_ven") %></td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <br><a href="index.jsp" style="color: #c5a059;">← Volver al Inicio</a>
</body>
</html>