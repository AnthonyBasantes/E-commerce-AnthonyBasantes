<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String nombreSocio = (String) session.getAttribute("nombre");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Contacto | Tony Food Stadium</title>
    <link href="css/estilos.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        .contact-container {
            display: grid;
            grid-template-columns: 1fr 1.5fr;
            gap: 40px;
            margin: 60px auto;
            max-width: 1100px;
        }

        /* Información de contacto */
        .contact-info {
            background: #0d0d0d;
            padding: 40px;
            border-left: 3px solid var(--gold);
            border-radius: 8px;
        }

        .contact-info h2 {
            font-family: 'Playfair Display', serif;
            color: var(--gold);
            margin-bottom: 25px;
            text-transform: uppercase;
        }

        .info-item {
            margin-bottom: 30px;
        }

        .info-item h4 {
            color: var(--gold);
            font-size: 0.7rem;
            letter-spacing: 2px;
            margin-bottom: 5px;
            text-transform: uppercase;
        }

        .info-item p {
            color: #ccc;
            font-size: 0.95rem;
        }

        /* Formulario de contacto */
        .contact-form-card {
            background: #111;
            padding: 40px;
            border-radius: 8px;
            border: 1px solid #222;
        }

        .stadium-input-group {
            margin-bottom: 20px;
        }

        .stadium-input-group label {
            display: block;
            font-size: 0.65rem;
            color: #555;
            margin-bottom: 8px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }

        .stadium-field {
            width: 100%;
            background: #000;
            border: 1px solid #333;
            padding: 12px;
            color: #fff;
            font-family: 'Montserrat', sans-serif;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .stadium-field:focus {
            border-color: var(--gold);
            outline: none;
        }

        .btn-send {
            background: var(--gold);
            color: #000;
            border: none;
            padding: 15px 30px;
            font-weight: bold;
            letter-spacing: 2px;
            cursor: pointer;
            width: 100%;
            transition: 0.3s;
            text-transform: uppercase;
        }

        .btn-send:hover {
            background: #a88030;
        }

        @media (max-width: 850px) {
            .contact-container { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<nav class="navbar">
    <a href="index.jsp">Inicio</a>
    <a href="productos.jsp">Menú</a>
    <a href="servicios.jsp">Servicios</a>
    <a class="active" href="contacto.jsp">Contacto</a>
    <% if (nombreSocio != null) { %>
        <a href="logout.jsp" class="nav-auth" style="background: #96281b;">Cerrar Sesión</a>
    <% } else { %>
        <a href="login.jsp" class="nav-auth">Ingresar</a>
    <% } %>
</nav>

<main class="container">
    
    <div class="contact-container">
        
        <aside class="contact-info">
            <h2>Sede Central</h2>
            
            <div class="info-item">
                <h4>Ubicación del Estadio</h4>
                <p>Av. de los Granados y 6 de Diciembre<br>Quito, Ecuador</p>
            </div>

            <div class="info-item">
                <h4>Línea Directa</h4>
                <p>+593 9 000 0000<br>(02) 2345-678</p>
            </div>

            <div class="info-item">
                <h4>Email de Prensa</h4>
                <p>coach@tonyfoodstadium.com</p>
            </div>

            <div class="info-item">
                <h4>Horario de Atención</h4>
                <p>Lun - Dom: 12:00 PM - 11:00 PM</p>
            </div>
        </aside>

        <section class="contact-form-card">
            <h3 style="color: #fff; margin-bottom: 25px; font-family: 'Playfair Display';">Envía un mensaje al Coach</h3>
            
            <form action="ContactoServlet" method="POST">
                <div class="stadium-input-group">
                    <label>Nombre del Jugador</label>
                    <input type="text" name="nombre" class="stadium-field" placeholder="Tu nombre..." value="<%= (nombreSocio != null) ? nombreSocio : "" %>" required>
                </div>

                <div class="stadium-input-group">
                    <label>Correo Electrónico</label>
                    <input type="email" name="email" class="stadium-field" placeholder="ejemplo@correo.com" required>
                </div>

                <div class="stadium-input-group">
                    <label>Asunto del Partido</label>
                    <select name="asunto" class="stadium-field">
                        <option>Sugerencia de Menú</option>
                        <option>Problema con mi pedido</option>
                        <option>Información para Eventos</option>
                        <option>Otro</option>
                    </select>
                </div>

                <div class="stadium-input-group">
                    <label>Mensaje</label>
                    <textarea name="mensaje" class="stadium-field" rows="5" placeholder="Escribe tu mensaje aquí..." required></textarea>
                </div>

                <button type="submit" class="btn-send">Enviar Mensaje</button>
            </form>
        </section>

    </div>

</main>

<footer>
    <p class="copyright-text">&copy; 2026 TONY FOOD STADIUM</p>
</footer>

</body>
</html>