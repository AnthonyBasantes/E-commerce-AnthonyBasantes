<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Recuperar datos de sesión para personalizar la experiencia
    String nombreSocio = (String) session.getAttribute("nombre");
    String perfilSocio = (String) session.getAttribute("perfil");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Servicios | Tony Food Stadium</title>
    <link href="css/estilos.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --gold: #c5a059;
            --dark-bg: #050505;
            --card-bg: #0d0d0d;
        }

        body {
            background-color: var(--dark-bg);
            color: #fff;
            font-family: 'Montserrat', sans-serif;
            margin: 0;
        }

        /* ══════════════ HEADER ══════════════ */
        .services-header {
            text-align: center;
            padding: 80px 20px;
            background: linear-gradient(rgba(0,0,0,0.85), rgba(0,0,0,0.85)), url('images/estadio.png');
            background-size: cover;
            background-position: center;
            border-bottom: 1px solid #222;
        }

        .services-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 3.5rem;
            color: var(--gold);
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 4px;
        }

        .section-sub {
            font-size: 0.8rem;
            letter-spacing: 3px;
            text-transform: uppercase;
            color: #666;
        }

        /* ══════════════ GRID DE SERVICIOS ══════════════ */
        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 30px;
            padding: 60px 0;
        }

        .service-card {
            background: var(--card-bg);
            border: 1px solid #1a1a1a;
            border-radius: 12px;
            padding: 40px 30px;
            text-align: center;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
        }

        .service-card:hover {
            transform: translateY(-12px);
            border-color: var(--gold);
            box-shadow: 0 10px 30px rgba(197, 160, 89, 0.1);
        }

        .service-icon {
            font-size: 3.5rem;
            margin-bottom: 25px;
            display: block;
        }

        .service-card h3 {
            font-family: 'Playfair Display', serif;
            color: var(--gold);
            font-size: 1.6rem;
            margin-bottom: 15px;
            letter-spacing: 1px;
        }

        .service-card p {
            font-size: 0.9rem;
            color: #888;
            line-height: 1.7;
            margin-bottom: 30px;
        }

        .btn-service {
            display: inline-block;
            padding: 12px 28px;
            border: 1px solid var(--gold);
            color: var(--gold);
            text-decoration: none;
            font-size: 0.7rem;
            font-weight: 600;
            letter-spacing: 2px;
            text-transform: uppercase;
            transition: 0.3s;
            cursor: pointer;
            background: transparent;
        }

        .btn-service:hover {
            background: var(--gold);
            color: #000;
        }

        .badge-vip {
            background: var(--gold);
            color: #000;
            padding: 5px 15px;
            font-size: 0.6rem;
            font-weight: bold;
            border-radius: 4px;
            position: absolute;
            top: 20px;
            right: 20px;
            letter-spacing: 1px;
        }

        /* ══════════════ BANNER MEMBRESÍA ══════════════ */
        .promo-banner {
            background: #0a0a0a;
            border-left: 4px solid var(--gold);
            padding: 40px;
            margin: 40px 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 20px;
            border-radius: 0 8px 8px 0;
        }

        .promo-content h2 {
            font-family: 'Playfair Display', serif;
            color: #fff;
            margin-bottom: 10px;
        }

        /* ══════════════ MODAL STYLES ══════════════ */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.92);
            z-index: 9999;
            justify-content: center;
            align-items: center;
            backdrop-filter: blur(8px);
        }

        .modal-content {
            background: #111;
            border: 1px solid var(--gold);
            padding: 50px;
            width: 90%;
            max-width: 500px;
            border-radius: 15px;
            position: relative;
            animation: modalFade 0.4s ease-out;
        }

        @keyframes modalFade {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }

        .close-modal {
            position: absolute;
            top: 20px; right: 25px;
            color: #444; font-size: 2.5rem; cursor: pointer;
            line-height: 1;
        }

        .close-modal:hover { color: var(--gold); }

        .stadium-form input, .stadium-form select, .stadium-form textarea {
            width: 100%;
            padding: 14px;
            margin-bottom: 18px;
            background: #000;
            border: 1px solid #222;
            color: #fff;
            border-radius: 4px;
            font-family: 'Montserrat', sans-serif;
            box-sizing: border-box;
        }

        .stadium-form input:focus { border-color: var(--gold); outline: none; }

        footer {
            text-align: center;
            padding: 40px 20px;
            border-top: 1px solid #1a1a1a;
            margin-top: 60px;
        }
    </style>
</head>
<body>

<nav class="navbar">
    <a href="index.jsp">Inicio</a>
    <a href="productos.jsp">Menú</a>
    <a class="active" href="servicios.jsp">Servicios</a>
    <a href="contacto.jsp">Contacto</a>
    <% if (nombreSocio != null) { %>
        <a href="logout.jsp" class="nav-auth" style="background: #96281b;">Cerrar Sesión</a>
    <% } else { %>
        <a href="login.jsp" class="nav-auth">Ingresar</a>
    <% } %>
</nav>

<header class="services-header">
    <p class="section-sub">Experiencias exclusivas</p>
    <h1>Nuestros Servicios</h1>
</header>

<main class="container">
    
    <div class="services-grid">
        <article class="service-card">
            <span class="badge-vip">PREMIUM</span>
            <span class="service-icon">🏟️</span>
            <h3>Palcos VIP</h3>
            <p>Disfruta del partido con pantallas 4K privadas, butacas de cuero y un sistema de pedido táctil directo a tu mesa.</p>
            <button onclick="openModal('vip')" class="btn-service">Reservar Ahora</button>
        </article>

        <article class="service-card">
            <span class="service-icon">🏆</span>
            <h3>Celebraciones</h3>
            <p>Organiza tu cumpleaños o evento de empresa con menús personalizados, decoración temática y zona reservada.</p>
            <button onclick="openModal('evento')" class="btn-service">Cotizar Evento</button>
        </article>

        <article class="service-card">
            <span class="service-icon">🛵</span>
            <h3>Stadium Delivery</h3>
            <p>Llevamos el sabor del estadio a tu casa con empaques térmicos especiales que mantienen la textura "crunch".</p>
            <a href="productos.jsp" class="btn-service">Hacer Pedido</a>
        </article>
    </div>

    <section class="promo-banner">
        <div class="promo-content">
            <h2>¿Aún no eres socio del club?</h2>
            <p style="color: #888;">Los socios obtienen 15% de descuento en todos los servicios de catering y reservas de palcos.</p>
        </div>
        <% if (nombreSocio == null) { %>
            <a href="registro.jsp" class="btn-service" style="background: var(--gold); color: #000;">Unirse al Club</a>
        <% } else { %>
            <span style="color: var(--gold); font-weight: bold; letter-spacing: 2px;">¡JUGADOR NIVEL PRO!</span>
        <% } %>
    </section>

</main>

<div id="serviceModal" class="modal-overlay">
    <div class="modal-content">
        <span class="close-modal" onclick="closeModal()">&times;</span>
        <h2 id="modal-title" style="font-family: 'Playfair Display', serif; color: var(--gold); margin-bottom: 10px;"></h2>
        <p id="modal-desc" style="font-size: 0.85rem; color: #777; margin-bottom: 25px;"></p>
        <form id="reservaForm" class="stadium-form" onsubmit="handleReserva(event)">
            <input type="text" id="form-nombre" placeholder="Nombre completo" value="<%= (nombreSocio != null) ? nombreSocio : "" %>" required>
            <div style="display: flex; gap: 15px;">
                <input type="date" required style="flex: 1;">
                <input type="number" placeholder="Personas" min="1" max="25" required style="flex: 1;">
            </div>
            <select required>
                <option value="" disabled selected>Selecciona el horario</option>
                <option>Almuerzo (12:00 - 15:00)</option>
                <option>Tarde de Fútbol (16:00 - 19:00)</option>
                <option>Cena Estelar (20:00 - 23:00)</option>
            </select>
            <textarea placeholder="¿Algún requerimiento especial? (Opcional)" rows="3"></textarea>
            <button type="submit" class="btn-service" style="width: 100%; background: var(--gold); color: #000;">CONFIRMAR MI JUGADA</button>
        </form>
    </div>
</div>

<footer>
    <p class="copyright-text">&copy; 2026 TONY FOOD STADIUM - Todos los derechos reservados</p>
</footer>

<script>
    function openModal(tipo) {
        const modal = document.getElementById('serviceModal');
        const title = document.getElementById('modal-title');
        const desc = document.getElementById('modal-desc');
        if(tipo === 'vip') {
            title.innerText = "RESERVAR PALCO VIP";
            desc.innerText = "Estás a un paso de la zona más exclusiva del estadio. Prepárate para la élite.";
        } else {
            title.innerText = "PLANIFICAR EVENTO";
            desc.innerText = "Cuéntanos tu idea y nuestro equipo de coaches organizará la final perfecta.";
        }
        modal.style.display = 'flex';
        document.body.style.overflow = 'hidden';
    }
    function closeModal() {
        document.getElementById('serviceModal').style.display = 'none';
        document.body.style.overflow = 'auto';
    }
    window.onclick = function(event) {
        const modal = document.getElementById('serviceModal');
        if (event.target == modal) closeModal();
    }
    function handleReserva(event) {
        event.preventDefault();
        const nombre = document.getElementById('form-nombre').value;
        alert("¡Golazo, " + nombre + "! Tu solicitud ha sido recibida. Un Coach te contactará en breve para confirmar.");
        closeModal();
    }
</script>

</body>
</html>