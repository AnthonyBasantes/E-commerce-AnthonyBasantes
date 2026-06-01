<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Solo el ADMIN entra aquí
    if (session.getAttribute("perfil") == null || !session.getAttribute("perfil").equals("ADMIN")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel de Ventas | Admin</title>
    <style>
        body { background: #050505; color: white; font-family: sans-serif; padding: 40px; }
        h1 { color: #c5a059; border-bottom: 2px solid #c5a059; padding-bottom: 10px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; background: #111; }
        th { background: #c5a059; color: black; padding: 15px; text-align: left; }
        td { padding: 15px; border-bottom: 1px solid #222; }
        tr:hover { background: #1a1a1a; }
        .status { color: #00ff00; font-weight: bold; }
    </style>
</head>
<body>
    <h1>HISTORIAL DE VENTAS - TONY FOOD STADIUM</h1>
    
    <table>
        <thead>
            <tr>
                <th>ID VENTA</th>
                <th>FECHA Y HORA</th>
                <th>CLIENTE</th>
                <th>PRODUCTOS</th>
                <th>TOTAL PAGADO</th>
                <th>ESTADO</th>
            </tr>
        </thead>
        <tbody>
            <!-- Aquí conectarías con tu base de datos (ResultSet de Java) -->
            <tr>
                <td>#1001</td>
                <td>13/05/2026 14:30</td>
                <td>Anthony Basantes</td>
                <td>Combo 3 Presas, Hamburguesa Doble</td>
                <td>$20.00</td>
                <td class="status">COMPLETADO</td>
            </tr>
            <tr>
                <td>#1002</td>
                <td>13/05/2026 15:10</td>
                <td>Juan Perez</td>
                <td>Mega Combo Familiar</td>
                <td>$25.99</td>
                <td class="status">COMPLETADO</td>
            </tr>
        </tbody>
    </table>

    <br>
    <a href="index.jsp" style="color: #c5a059; text-decoration: none;">← Volver al Inicio</a>
</body>
</html>