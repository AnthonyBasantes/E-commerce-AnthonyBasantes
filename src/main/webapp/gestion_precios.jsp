<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("perfil") == null || !session.getAttribute("perfil").equals("VENTAS")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Ventas | Tony Food Stadium</title>
    <link href="css/estilos.css" rel="stylesheet"/>
</head>
<body style="background: #000; color: white; font-family: sans-serif;">

    <div style="padding: 30px; max-width: 1000px; margin: auto;">
        <h1 style="color: var(--gold); border-bottom: 1px solid #333; padding-bottom: 10px;">Panel de Gestión de Precios</h1>
        
        <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
            <thead>
                <tr style="background: #111; color: var(--gold); text-align: left;">
                    <th style="padding: 15px;">Producto</th>
                    <th>Precio Base</th>
                    <th>Estado</th>
                    <th>Acción</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    String[] p = {"Combo 3 Presas", "Combo Burrito", "Combo Hamburguesa Completo", "Combo Para Compartir", "Combo Personal", "Hamburguesa Doble", "Mega Combo Familiar", "Hamburguesa con Tocino", "Combo Simple", "Dos Hamburguesas y Papas"};
                    for(String item : p) {
                %>
                <tr style="border-bottom: 1px solid #222;">
                    <td style="padding: 15px;"><%= item %></td>
                    <td>$ --.--</td>
                    <td style="color: #0f0;">En Stock</td>
                    <td><button onclick="upd('<%= item %>')" style="background: var(--gold); border: none; padding: 5px 10px; cursor: pointer; font-weight: bold;">EDITAR</button></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <script>
        function upd(name) {
            let val = prompt("Nuevo precio para " + name + ":");
            if(val) alert("Precio de " + name + " actualizado exitosamente.");
        }
    </script>
</body>
</html>