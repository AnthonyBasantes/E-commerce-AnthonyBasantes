<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String nombreSocio = (String) session.getAttribute("nombre");
    String perfilSocio = (String) session.getAttribute("perfil");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Tony Food Stadium | Home</title>
    <link href="css/estilos.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        /* ══════════════ TOUR 3D ══════════════ */
        #tour-section {
            width: 100%;
            background: #050505;
            padding: 60px 20px 40px;
            text-align: center;
            border-top: 1px solid #1a1a1a;
            border-bottom: 1px solid #1a1a1a;
            margin-top: 60px;
        }
        #tour-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            color: var(--gold);
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 6px;
        }
        .section-sub {
            color: #555;
            font-size: 0.7rem;
            letter-spacing: 3px;
            text-transform: uppercase;
            margin-bottom: 30px;
        }
        #canvas-wrap {
            position: relative;
            width: 100%;
            max-width: 900px;
            margin: 0 auto;
            border: 1px solid #222;
            border-radius: 8px;
            overflow: hidden;
            background: #000;
        }
        #three-canvas {
            display: block;
            width: 100% !important;
            height: 480px;
            cursor: grab;
        }
        #three-canvas:active { cursor: grabbing; }
        #tour-controls {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 18px;
            flex-wrap: wrap;
        }
        .tour-btn {
            background: transparent;
            border: 1px solid var(--gold);
            color: var(--gold);
            padding: 8px 20px;
            font-family: 'Montserrat', sans-serif;
            font-size: 0.7rem;
            letter-spacing: 1px;
            text-transform: uppercase;
            cursor: pointer;
            border-radius: 2px;
            transition: 0.25s;
        }
        .tour-btn:hover, .tour-btn.active {
            background: var(--gold);
            color: #000;
        }
        #tour-label {
            margin-top: 12px;
            font-size: 0.72rem;
            color: #444;
            letter-spacing: 2px;
            text-transform: uppercase;
            min-height: 18px;
        }

        /* ══════════════ CHATBOT ══════════════ */
        #chat-section {
            width: 100%;
            max-width: 860px;
            margin: 60px auto 80px;
            padding: 0 20px;
        }
        #chat-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: var(--gold);
            text-align: center;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 6px;
        }
        #chat-status-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 14px;
        }
        .status-dot {
            width: 7px; height: 7px;
            border-radius: 50%;
            background: #2ecc71;
            display: inline-block;
            margin-right: 6px;
            animation: pulse-dot 2s infinite;
        }
        @keyframes pulse-dot { 0%,100%{opacity:1} 50%{opacity:0.35} }
        .status-label {
            font-size: 0.65rem;
            color: #555;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        #clear-btn {
            background: transparent;
            border: 1px solid #222;
            color: #444;
            padding: 5px 14px;
            font-size: 0.65rem;
            cursor: pointer;
            border-radius: 2px;
            letter-spacing: 1px;
            text-transform: uppercase;
            font-family: 'Montserrat', sans-serif;
            transition: 0.2s;
        }
        #clear-btn:hover { border-color: #c0392b; color: #c0392b; }

        /* Mood selector */
        #mood-bar {
            display: flex;
            gap: 8px;
            margin-bottom: 14px;
            align-items: center;
            flex-wrap: wrap;
        }
        #mood-bar span {
            font-size: 0.62rem;
            color: #444;
            letter-spacing: 1px;
            text-transform: uppercase;
            margin-right: 4px;
        }
        .mood-btn {
            background: transparent;
            border: 1px solid #222;
            color: #666;
            padding: 5px 14px;
            border-radius: 20px;
            font-size: 0.7rem;
            cursor: pointer;
            font-family: 'Montserrat', sans-serif;
            transition: 0.2s;
        }
        .mood-btn.active { border-color: var(--gold); color: var(--gold); }

        /* Chat box */
        #chat-box {
            background: #0d0d0d;
            border: 1px solid #1e1e1e;
            border-radius: 8px;
            height: 420px;
            overflow-y: auto;
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 14px;
            scroll-behavior: smooth;
        }
        #chat-box::-webkit-scrollbar { width: 4px; }
        #chat-box::-webkit-scrollbar-thumb { background: #222; border-radius: 4px; }

        .chat-msg {
            display: flex;
            align-items: flex-end;
            gap: 10px;
            animation: msgFadeUp 0.3s ease;
        }
        @keyframes msgFadeUp { from{opacity:0;transform:translateY(8px)} to{opacity:1;transform:none} }
        .chat-msg.user { flex-direction: row-reverse; }

        .chat-bubble {
            max-width: 74%;
            padding: 12px 16px;
            border-radius: 16px;
            font-size: 0.84rem;
            line-height: 1.6;
            white-space: pre-wrap;
        }
        .chat-msg.bot .chat-bubble {
            background: #181818;
            border: 1px solid #252525;
            border-bottom-left-radius: 4px;
            color: #ccc;
        }
        .chat-msg.user .chat-bubble {
            background: var(--gold);
            color: #000;
            border-bottom-right-radius: 4px;
            font-weight: 600;
        }
        .chat-avatar {
            width: 32px; height: 32px;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 15px;
            flex-shrink: 0;
        }
        .bot .chat-avatar { background: #1a1a1a; border: 1px solid var(--gold); }
        .user .chat-avatar { background: #7a5c1e; }

        /* Typing indicator */
        .typing-dots span {
            display: inline-block;
            width: 6px; height: 6px;
            background: var(--gold);
            border-radius: 50%;
            margin: 0 2px;
            animation: dotBlink 1.2s infinite;
        }
        .typing-dots span:nth-child(2) { animation-delay: 0.2s; }
        .typing-dots span:nth-child(3) { animation-delay: 0.4s; }
        @keyframes dotBlink { 0%,80%,100%{opacity:0.15} 40%{opacity:1} }

        /* Quick replies */
        #quick-replies {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            margin-top: 14px;
        }
        .quick-btn {
            background: transparent;
            border: 1px solid #2a2a2a;
            color: #777;
            padding: 6px 14px;
            font-size: 0.68rem;
            letter-spacing: 0.5px;
            cursor: pointer;
            border-radius: 20px;
            font-family: 'Montserrat', sans-serif;
            transition: 0.2s;
        }
        .quick-btn:hover { border-color: var(--gold); color: var(--gold); }

        /* Input */
        #chat-form {
            display: flex;
            gap: 10px;
            margin-top: 14px;
        }
        #chat-input {
            flex: 1;
            background: #0d0d0d;
            border: 1px solid #222;
            color: #fff;
            padding: 12px 16px;
            border-radius: 4px;
            font-family: 'Montserrat', sans-serif;
            font-size: 0.85rem;
            outline: none;
            transition: 0.2s;
        }
        #chat-input:focus { border-color: var(--gold); }
        #chat-input::placeholder { color: #383838; }
        #send-btn {
            background: var(--gold);
            border: none;
            color: #000;
            padding: 0 22px;
            font-size: 1.1rem;
            cursor: pointer;
            border-radius: 4px;
            transition: 0.2s;
            font-weight: bold;
        }
        #send-btn:hover { background: #a88030; }
        #send-btn:disabled { opacity: 0.35; cursor: not-allowed; }

        /* ══════════════ UBICACIÓN ══════════════ */
        #location-section {
            width: 100%;
            max-width: 860px;
            margin: 0 auto 80px;
            padding: 0 20px;
        }
        #location-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: var(--gold);
            text-align: center;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 6px;
        }
        .location-wrapper {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            align-items: stretch;
        }
        .location-info {
            flex: 1;
            min-width: 220px;
            background: #0d0d0d;
            border: 1px solid #1e1e1e;
            border-top: 2px solid var(--gold);
            border-radius: 8px;
            padding: 28px 24px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        .location-info .loc-label {
            font-size: 0.6rem;
            letter-spacing: 3px;
            text-transform: uppercase;
            color: #555;
            margin: 0 0 6px;
        }
        .location-info p {
            color: #ccc;
            font-size: 0.88rem;
            line-height: 1.6;
            margin: 0;
        }
        .loc-divider {
            border: none;
            border-top: 1px solid #1a1a1a;
            margin: 4px 0 0;
        }
        .loc-footer {
            margin-top: auto;
            padding-top: 16px;
            border-top: 1px solid #1a1a1a;
        }
        .loc-footer p {
            font-size: 0.62rem;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #444;
            margin: 0;
        }
        .maps-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-top: 8px;
            padding: 10px 20px;
            background: transparent;
            border: 1px solid var(--gold);
            color: var(--gold);
            font-family: 'Montserrat', sans-serif;
            font-size: 0.7rem;
            letter-spacing: 1px;
            text-transform: uppercase;
            text-decoration: none;
            border-radius: 2px;
            transition: 0.25s;
        }
        .maps-btn:hover {
            background: var(--gold);
            color: #000;
        }
        .location-map {
            flex: 2;
            min-width: 280px;
            min-height: 360px;
            border-radius: 8px;
            overflow: hidden;
            border: 1px solid #1e1e1e;
            position: relative;
        }
        .location-map iframe {
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            border: 0;
            filter: grayscale(1) invert(1) contrast(0.85);
        }

        /* ══════════════ BURGER MASCOT ══════════════ */
        #burger-mascot {
            position: fixed;
            bottom: 30px;
            right: 30px;
            z-index: 9999;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 12px;
        }
        #burger-btn {
            width: 72px; height: 72px;
            border-radius: 50%;
            background: linear-gradient(145deg, #c5a059, #8b6914);
            border: 3px solid #c5a059;
            cursor: pointer;
            display: flex; align-items: center; justify-content: center;
            font-size: 2.4rem;
            box-shadow: 0 6px 28px rgba(197,160,89,0.5);
            transition: transform 0.2s, box-shadow 0.2s;
            animation: burgerPulse 3s ease-in-out infinite;
            position: relative;
        }
        #burger-btn:hover {
            transform: scale(1.12);
            box-shadow: 0 10px 36px rgba(197,160,89,0.7);
            animation: none;
        }
        #burger-btn.open { animation: none; transform: scale(1.08) rotate(10deg); }
        #burger-btn::before {
            content: '';
            position: absolute;
            top: 18px; left: 16px;
            width: 8px; height: 8px;
            background: #1a0a00;
            border-radius: 50%;
            box-shadow: 22px 0 0 #1a0a00;
        }
        @keyframes burgerPulse {
            0%, 100% { transform: scale(1) rotate(0deg); }
            25% { transform: scale(1.07) rotate(-5deg); }
            75% { transform: scale(1.07) rotate(5deg); }
        }
        #burger-tooltip {
            background: #111;
            border: 1px solid #c5a059;
            color: #c5a059;
            font-family: 'Montserrat', sans-serif;
            font-size: 0.7rem;
            letter-spacing: 1px;
            padding: 7px 14px;
            border-radius: 20px;
            white-space: nowrap;
            opacity: 1;
            animation: tooltipBounce 3s ease-in-out infinite;
            pointer-events: none;
        }
        @keyframes tooltipBounce {
            0%,100% { transform: translateY(0); }
            50% { transform: translateY(-4px); }
        }
        #burger-chat {
            position: fixed;
            bottom: 120px; right: 30px;
            width: 330px;
            background: #0d0d0d;
            border: 1px solid #2a2a2a;
            border-top: 2px solid #c5a059;
            border-radius: 12px;
            overflow: hidden;
            display: none;
            flex-direction: column;
            z-index: 9998;
            box-shadow: 0 16px 48px rgba(0,0,0,0.6);
            animation: popupSlideUp 0.3s ease;
        }
        #burger-chat.open { display: flex; }
        @keyframes popupSlideUp {
            from { opacity: 0; transform: translateY(20px) scale(0.95); }
            to   { opacity: 1; transform: none; }
        }
        #burger-chat-header {
            background: linear-gradient(90deg, #1a1006, #0d0d0d);
            padding: 12px 16px;
            display: flex; align-items: center; gap: 10px;
            border-bottom: 1px solid #1e1e1e;
        }
        #burger-chat-header .mascot-icon { font-size: 1.6rem; }
        #burger-chat-header .mascot-name {
            font-family: 'Playfair Display', serif;
            color: #c5a059; font-size: 0.95rem;
        }
        #burger-chat-header .mascot-status {
            font-family: 'Montserrat', sans-serif;
            font-size: 0.58rem; color: #2ecc71;
            letter-spacing: 1px; text-transform: uppercase;
        }
        #burger-close {
            margin-left: auto;
            background: none; border: none;
            color: #444; font-size: 1.1rem;
            cursor: pointer; line-height: 1; transition: color 0.2s;
        }
        #burger-close:hover { color: #c0392b; }
        #burger-messages {
            flex: 1; height: 260px;
            overflow-y: auto; padding: 14px;
            display: flex; flex-direction: column; gap: 10px;
            scroll-behavior: smooth;
        }
        #burger-messages::-webkit-scrollbar { width: 3px; }
        #burger-messages::-webkit-scrollbar-thumb { background: #222; }
        .b-msg { display: flex; align-items: flex-end; gap: 8px; animation: msgFadeUp 0.25s ease; }
        .b-msg.user { flex-direction: row-reverse; }
        .b-bubble {
            max-width: 80%; padding: 9px 13px; border-radius: 14px;
            font-size: 0.78rem; line-height: 1.5; white-space: pre-wrap;
            font-family: 'Montserrat', sans-serif;
        }
        .b-msg.bot .b-bubble { background: #181818; border: 1px solid #252525; border-bottom-left-radius: 3px; color: #ccc; }
        .b-msg.user .b-bubble { background: #c5a059; color: #000; border-bottom-right-radius: 3px; font-weight: 600; }
        .b-avatar { width: 26px; height: 26px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 13px; flex-shrink: 0; }
        .b-msg.bot .b-avatar { background: #1a1a1a; border: 1px solid #c5a059; }
        .b-msg.user .b-avatar { background: #7a5c1e; }
        #burger-input-row {
            display: flex; gap: 8px; padding: 10px 12px;
            border-top: 1px solid #1a1a1a; background: #0a0a0a;
        }
        #burger-input {
            flex: 1; background: #111; border: 1px solid #1e1e1e;
            color: #fff; padding: 8px 12px; border-radius: 20px;
            font-family: 'Montserrat', sans-serif; font-size: 0.78rem;
            outline: none; transition: 0.2s;
        }
        #burger-input:focus { border-color: #c5a059; }
        #burger-input::placeholder { color: #2a2a2a; }
        #burger-send {
            background: #c5a059; border: none; color: #000;
            width: 34px; height: 34px; border-radius: 50%;
            cursor: pointer; font-size: 0.9rem; font-weight: bold;
            transition: 0.2s; display: flex; align-items: center; justify-content: center; flex-shrink: 0;
        }
        #burger-send:hover { background: #a88030; }
        #burger-send:disabled { opacity: 0.3; cursor: not-allowed; }
        #burger-chips { display: flex; gap: 6px; flex-wrap: wrap; padding: 8px 12px 0; }
        .b-chip {
            background: transparent; border: 1px solid #1e1e1e; color: #555;
            padding: 4px 10px; font-size: 0.62rem; border-radius: 20px;
            cursor: pointer; font-family: 'Montserrat', sans-serif; transition: 0.2s;
        }
        .b-chip:hover { border-color: #c5a059; color: #c5a059; }

        @media (max-width: 700px) {
            #three-canvas { height: 260px !important; }
            .chat-bubble { max-width: 88%; }
            #tour-section h2 { font-size: 1.5rem; }
            #burger-chat { width: calc(100vw - 24px); right: 12px; }
            #burger-mascot { right: 16px; bottom: 20px; }
            .location-map { min-height: 260px; }
        }
    </style>
</head>
<body>

<!-- ══════════════ HEADER ══════════════ -->
<header class="hero">
    <div class="hero-overlay">
        <img class="logo" src="<%=request.getContextPath()%>/images/logo.png"/>
        <h1 class="main-title">Tony Food Stadium</h1>
        <p class="subtitle">
            <% if (nombreSocio != null) { %>
                ¡Bienvenido de nuevo al campo, <%= nombreSocio %>!
            <% } else { %>
                La élite de la gastronomía deportiva
            <% } %>
        </p>
    </div>
</header>

<!-- ══════════════ NAVBAR ══════════════ -->
<nav class="navbar">
    <a class="active" href="index.jsp">Inicio</a>
    <% if ("ADMIN".equals(perfilSocio)) { %>
        <a href="usuarios.jsp">Gestión Usuarios</a>
    <% } else { %>
        <a href="productos.jsp">Menú</a>
    <% } %>
    <a href="servicios.jsp">Servicios</a>
    <a href="contacto.jsp">Contacto</a>
    <% if (nombreSocio != null) { %>
        <a href="logout.jsp" class="nav-auth" style="background: #96281b;">Cerrar Sesión</a>
    <% } else { %>
        <a href="login.jsp" class="nav-auth">Ingresar</a>
    <% } %>
</nav>

<!-- ══════════════ MAIN CONTENT ══════════════ -->
<main class="container">
    <div class="grid-layout">

        <article class="card">
            <img src="<%=request.getContextPath()%>/images/estadio.png"/>
            <h2 style="color: var(--gold); margin-top:20px;">Excelencia en el Campo</h2>
            <p style="font-weight: 300; line-height: 1.6; color: #bbb;">
                Bienvenido a la tribuna exclusiva de los sabores. En Tony Food Stadium, cada plato es un homenaje a la pasión del fútbol, elaborado con ingredientes premium para los paladares más exigentes.
            </p>
            <% if (nombreSocio == null) { %>
                <a href="registro.jsp" style="display:inline-block; margin-top:10px; color: var(--gold); text-decoration:none; border-bottom: 1px solid var(--gold); font-size: 0.8rem; letter-spacing: 1px;">REGISTRARSE EN EL CLUB</a>
            <% } else { %>
                <p style="color: var(--gold); margin-top: 15px; font-size: 0.8rem;">ESTADO: SOCIO ACTIVO</p>
            <% } %>
        </article>

        <div style="display: flex; flex-direction: column; gap: 20px;">
            <article class="card" style="padding: 10px;">
                <div class="carousel">
                    <img class="slide active" src="<%=request.getContextPath()%>/images/cr7-combo.png"/>
                    <img class="slide" src="<%=request.getContextPath()%>/images/hat-trick-wings.png"/>
                    <img class="slide" src="<%=request.getContextPath()%>/images/stadium-combo.png"/>
                    <img class="slide" src="<%=request.getContextPath()%>/images/cup-combo.png"/>
                    <button class="prev" onclick="changeSlide(-1)" style="left:10px;">❮</button>
                    <button class="next" onclick="changeSlide(1)" style="right:10px;">❯</button>
                </div>
                <div style="padding: 15px; text-align: center;">
                    <h3 id="combo-title" style="color: var(--gold); margin: 5px 0;">CR7 Crunch Combo</h3>
                    <p id="combo-desc" style="font-size: 0.85rem; color: #888; font-style: italic;">Inspiración en el máximo goleador.</p>
                </div>
            </article>

            <aside class="dev-card">
                <span style="font-size: 0.6rem; letter-spacing: 2px; color: #555; text-transform: uppercase;">Información de Desarrollador</span>
                <p class="dev-name">Anthony Basantes</p>
                <div class="dev-icons">
                    <a href="https://github.com/AnthonyBasantes" target="_blank" class="dev-link">
                        <img src="<%=request.getContextPath()%>/icons/github.png"/><br>GITHUB
                    </a>
                    <a href="https://www.linkedin.com/in/anthony-basantes-5305232a6" target="_blank" class="dev-link">
                        <img src="<%=request.getContextPath()%>/icons/linkedin.png"/><br>LINKEDIN
                    </a>
                </div>
            </aside>
        </div>
    </div>

    <!-- ══════════════ TOUR 3D ══════════════ -->
    <section id="tour-section">
        <h2>Tour Virtual 3D</h2>
        <p class="section-sub">Explora el estadio desde adentro — arrastra para rotar · scroll para zoom</p>
        <div id="canvas-wrap">
            <canvas id="three-canvas"></canvas>
        </div>
        <div id="tour-controls">
            <button class="tour-btn active" data-cam="0">Vista General</button>
            <button class="tour-btn" data-cam="1">Zona VIP</button>
            <button class="tour-btn" data-cam="2">Barra Principal</button>
            <button class="tour-btn" data-cam="3">Pantalla Central</button>
            <button class="tour-btn" data-cam="4">Vista Tribuna</button>
        </div>
        <div id="tour-label">Vista general del restaurante</div>
    </section>

    <!-- ══════════════ CHATBOT ══════════════ -->
    <section id="chat-section">
        <h2>Tony Coach</h2>
        <p class="section-sub" style="text-align:center; margin-bottom:24px;">Asistente Virtual — Tony Food Stadium</p>

        <div id="chat-status-bar">
            <div>
                <span class="status-dot"></span>
                <span class="status-label">En línea — Respuesta inmediata</span>
            </div>
            <button id="clear-btn" onclick="clearChat()">Limpiar chat</button>
        </div>

        <div id="mood-bar">
            <span>Modo:</span>
            <button class="mood-btn active" data-mood="normal">⚽ Normal</button>
            <button class="mood-btn" data-mood="formal">🎩 Formal</button>
            <button class="mood-btn" data-mood="futbol">🔥 Fútbolero</button>
        </div>

        <div id="chat-box"></div>

        <div id="quick-replies">
            <button class="quick-btn" onclick="sendQuick('¿Cuál es el menú?')">Ver menú</button>
            <button class="quick-btn" onclick="sendQuick('¿Tienen promociones hoy?')">Promociones</button>
            <button class="quick-btn" onclick="sendQuick('¿Cuál es el horario?')">Horario</button>
            <button class="quick-btn" onclick="sendQuick('¿Cómo me registro como socio?')">Ser socio</button>
            <button class="quick-btn" onclick="sendQuick('¿Tienen zona VIP?')">Zona VIP</button>
            <button class="quick-btn" onclick="sendQuick('¿Tienen delivery?')">Delivery</button>
            <button class="quick-btn" onclick="sendQuick('¿Aceptan reservaciones?')">Reservar</button>
            <button class="quick-btn" onclick="sendQuick('¿Cuáles son sus redes sociales?')">Redes sociales</button>
        </div>

        <div id="chat-form">
            <input id="chat-input" type="text" placeholder="Escríbeme, campeón..." autocomplete="off" maxlength="300"/>
            <button id="send-btn" type="button" onclick="handleSend()">➤</button>
        </div>
    </section>

    <!-- ══════════════ UBICACIÓN ══════════════ -->
    <section id="location-section">
        <h2>Nuestra Ubicación</h2>
        <p class="section-sub" style="text-align:center; margin-bottom:28px;">Encuéntranos en el campo — visítanos en persona</p>

        <div class="location-wrapper">

            <!-- Info card -->
            <div class="location-info">

                <div>
                    <p class="loc-label">Dirección</p>
                    <p>Tony Food Stadium<br>Quito, Ecuador</p>
                </div>

                <hr class="loc-divider"/>

                <div>
                    <p class="loc-label">Horario</p>
                    <p>Lunes – Domingo<br>12:00 – 22:00</p>
                </div>

                <hr class="loc-divider"/>

                <div>
                    <p class="loc-label">Reservaciones</p>
                    <p>Mínimo 2 horas antes.<br>Grupos de 10+ reserva obligatoria.</p>
                </div>

                <hr class="loc-divider"/>

                <div>
                    <p class="loc-label">Cómo llegar</p>
                    <a class="maps-btn"
                       href="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3179.3582446672604!2d-78.5115043!3d-0.24144419999999994!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x91d599a30d1fc5fd%3A0x85e9eeaed4b607a4!2sAbel%20Mel%C3%A9ndez%2C%20170121%20Quito!5e1!3m2!1ses!2sec!4v1780353247401!5m2!1ses!2sec"
                       target="_blank">
                        &#9655;&nbsp; Abrir en Google Maps
                    </a>
                </div>

                <div class="loc-footer">
                    <p>⚽ ¡Te esperamos en el estadio de los sabores!</p>
                </div>
            </div>

            <!-- Mapa -->
            <div class="location-map">
                <iframe
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3989.815656442089!2d-78.52283492426875!3d-0.17601523545922368!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x91d59a7de9b0a3b7%3A0x0!2zMCoxMCcxMy42IlMgNzjCsDMxJzIyLjIiVw!5e0!3m2!1ses!2sec!4v1717200000000!5m2!1ses!2sec"
                    allowfullscreen=""
                    loading="lazy"
                    referrerpolicy="no-referrer-when-downgrade"
                    title="Ubicación Tony Food Stadium">
                </iframe>
            </div>

        </div>
    </section>

</main>

<!-- ══════════════ FOOTER ══════════════ -->
<footer>
    <div class="social-container">
        <a href="https://www.facebook.com/share/1G4bzdNSw5/" target="_blank">
            <img class="soc-icon" src="<%=request.getContextPath()%>/icons/facebook.png">
        </a>
        <a href="https://www.instagram.com/xxthx_03/" target="_blank">
            <img class="soc-icon" src="<%=request.getContextPath()%>/icons/instagram.png">
        </a>
        <a href="https://www.tiktok.com/@anth0_03" target="_blank">
            <img class="soc-icon soc-tiktok" src="<%=request.getContextPath()%>/icons/tiktok.png">
        </a>
    </div>
    <p class="copyright-text">&copy; 2026 TONY FOOD STADIUM</p>
</footer>

<!-- ══════════════ BURGER MASCOT (fixed) ══════════════ -->
<div id="burger-mascot">
    <div id="burger-tooltip">¡Hola! Soy Toñito 🍔</div>
    <button id="burger-btn" onclick="toggleBurgerChat()" title="Hablar con Toñito">🍔</button>
</div>

<!-- Burger Mascot Chat Popup -->
<div id="burger-chat">
    <div id="burger-chat-header">
        <span class="mascot-icon">🍔</span>
        <div>
            <div class="mascot-name">Toñito</div>
            <div class="mascot-status">● En cancha</div>
        </div>
        <button id="burger-close" onclick="toggleBurgerChat()">✕</button>
    </div>
    <div id="burger-chips">
        <button class="b-chip" onclick="burgerQuick('¿Qué me recomiendas?')">Recomiéndame algo</button>
        <button class="b-chip" onclick="burgerQuick('¿Cuál es tu plato favorito?')">Tu favorito</button>
        <button class="b-chip" onclick="burgerQuick('¿Hay combos?')">Combos</button>
    </div>
    <div id="burger-messages"></div>
    <div id="burger-input-row">
        <input id="burger-input" type="text" placeholder="Habla con Toñito..." maxlength="200" autocomplete="off"/>
        <button id="burger-send" type="button" onclick="burgerSend()">➤</button>
    </div>
</div>

<!-- ══════════════ SCRIPTS ══════════════ -->

<!-- Carrusel -->
<script>
let slideIndex = 0;
const titles = ["CR7 Crunch Combo", "Hat-Trick Wings", "Stadium Combo", "Cup Combo"];
const descs = [
    "Inspiración en el máximo goleador.",
    "Alitas seleccionadas con salsa artesanal.",
    "El combo más completo para el fanático.",
    "La corona de nuestro menú premium."
];
function showSlide(i) {
    const slides = document.querySelectorAll(".slide");
    if (!slides.length) return;
    slides.forEach(s => s.classList.remove("active"));
    slideIndex = (i + slides.length) % slides.length;
    slides[slideIndex].classList.add("active");
    document.getElementById("combo-title").innerText = titles[slideIndex];
    document.getElementById("combo-desc").innerText = descs[slideIndex];
}
function changeSlide(step) { showSlide(slideIndex + step); }
showSlide(0);
</script>

<!-- Three.js CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>

<!-- Tour 3D -->
<script>
(function () {
    const canvas = document.getElementById('three-canvas');
    const wrap   = document.getElementById('canvas-wrap');

    const renderer = new THREE.WebGLRenderer({ canvas: canvas, antialias: true });
    renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
    renderer.shadowMap.enabled = true;
    renderer.shadowMap.type = THREE.PCFSoftShadowMap;
    renderer.setClearColor(0x050505);

    const scene  = new THREE.Scene();
    scene.fog    = new THREE.Fog(0x050505, 25, 55);

    const camera = new THREE.PerspectiveCamera(55, 1, 0.1, 100);
    camera.position.set(0, 5, 14);

    function resize() {
        var w = wrap.clientWidth;
        var h = 480;
        if (window.innerWidth <= 700) h = 260;
        renderer.setSize(w, h, false);
        canvas.style.height = h + 'px';
        camera.aspect = w / h;
        camera.updateProjectionMatrix();
    }

    function mat(color, roughness, metalness) {
        return new THREE.MeshStandardMaterial({
            color: color,
            roughness: roughness !== undefined ? roughness : 0.8,
            metalness: metalness || 0
        });
    }

    function box(w, h, d, mtl, x, y, z) {
        var mesh = new THREE.Mesh(new THREE.BoxGeometry(w, h, d), mtl);
        mesh.position.set(x || 0, y || 0, z || 0);
        mesh.castShadow = true;
        mesh.receiveShadow = true;
        scene.add(mesh);
        return mesh;
    }

    function cyl(rt, rb, h, mtl, x, y, z, segs) {
        var mesh = new THREE.Mesh(new THREE.CylinderGeometry(rt, rb, h, segs || 8), mtl);
        mesh.position.set(x || 0, y || 0, z || 0);
        mesh.castShadow = true;
        mesh.receiveShadow = true;
        scene.add(mesh);
        return mesh;
    }

    var mFloor   = mat(0x1a1208, 0.95);
    var mWall    = mat(0x0e0e0e, 0.9);
    var mGold    = mat(0xc5a059, 0.3, 0.7);
    var mDark    = mat(0x080808, 1);
    var mScreen  = mat(0x001a33, 0.1);
    var mChair   = mat(0x8b0000, 0.7);
    var mCounter = mat(0x1c1006, 0.6);
    var mGreen   = mat(0x1a3a0a, 0.9);
    var mWhite   = mat(0xffffff, 0.5);

    var logoMat = new THREE.MeshStandardMaterial({
        color: 0xc5a059, emissive: 0xc5a059, emissiveIntensity: 0.5
    });

    box(40, 0.2, 40, mFloor, 0, -0.1, 0);
    box(40, 14, 0.3, mWall, 0, 7, -12);
    box(0.3, 14, 24, mWall, -12, 7, 0);
    box(0.3, 14, 24, mWall, 12, 7, 0);
    box(40, 0.3, 40, mDark, 0, 14, 0);

    box(40, 0.12, 0.25, mGold, 0, 2.5, -11.8);
    box(40, 0.12, 0.25, mGold, 0, 8.0, -11.8);
    for (var px = -10; px <= 10; px += 5) box(0.15, 11, 0.25, mGold, px, 5.5, -11.8);

    box(9, 5, 0.15, mScreen, 0, 7, -11.7);
    box(9.2, 5.2, 0.05, mGold, 0, 7, -11.6);
    var logo = new THREE.Mesh(new THREE.PlaneGeometry(2.5, 2.5), logoMat);
    logo.position.set(0, 7, -11.55);
    scene.add(logo);

    box(18, 0.05, 10, mGreen, 0, 0.05, 3);
    box(18, 0.02, 0.08, mWhite, 0, 0.06, -2);
    box(0.08, 0.02, 10, mWhite, 0, 0.06, 3);

    function table(tx, tz) {
        cyl(0.05, 0.05, 1.1, mat(0x1a1a1a, 0.6, 0.4), tx, 0.55, tz);
        cyl(0.7,  0.7,  0.06, mCounter, tx, 1.1, tz, 32);
        for (var a = 0; a < 4; a++) {
            var angle = (a / 4) * Math.PI * 2;
            var cx = tx + Math.cos(angle) * 1.1;
            var cz = tz + Math.sin(angle) * 1.1;
            cyl(0.03, 0.03, 0.85, mat(0x111111, 0.5, 0.5), cx, 0.425, cz);
            cyl(0.28, 0.28, 0.05, mChair, cx, 0.87, cz, 16);
        }
    }
    table(-5, 2); table(0, 2); table(5, 2);
    table(-5, 5); table(0, 5); table(5, 5);
    table(-7, 8); table(7, 8);

    box(10, 1.2, 1.2, mCounter, 0, 0.6, -9);
    box(10, 0.1, 1.4, mGold,    0, 1.25, -9);
    for (var bx = -4; bx <= 4; bx += 2) {
        cyl(0.04, 0.04, 1.0, mat(0x222222, 0.4, 0.6), bx, 0.5, -7.5);
        cyl(0.24, 0.24, 0.05, mGold, bx, 1.02, -7.5, 12);
    }
    var bottleColors = [0x1a3300, 0x330000, 0x002233];
    for (var bx2 = -4; bx2 <= 4; bx2 += 1.2) {
        cyl(0.06, 0.08, 0.55, mat(bottleColors[Math.floor(Math.random() * 3)], 0.3, 0.3), bx2, 1.58, -9, 8);
    }

    box(3, 0.08, 0.4, mGold, -10, 4, -6);
    box(3, 0.08, 0.4, mGold, -10, 6, -6);
    function trophy(tx, ty, tz) {
        cyl(0.06, 0.1,  0.35, mGold, tx, ty + 0.17, tz, 8);
        cyl(0.12, 0.06, 0.15, mGold, tx, ty + 0.42, tz, 8);
    }
    trophy(-10.8, 4, -6); trophy(-10, 4, -6); trophy(-9.2, 4, -6);
    trophy(-10.4, 6, -6); trophy(-9.6, 6, -6);

    box(5, 0.15, 2.8, mat(0x1a1006, 0.8), -8.5, 0,    -6);
    box(5, 0.9,  0.3, mat(0x0d0800, 0.9), -8.5, 0.5,  -7.2);
    box(5, 0.1,  2.8, mat(0x8b0000, 0.6), -8.5, 0.95, -6);
    cyl(0.06, 0.06, 0.8, mat(0x333333, 0.5, 0.4), -8.5, 0.4,  -5.8);
    cyl(0.5,  0.5,  0.06, mCounter, -8.5, 0.83, -5.8, 24);
    box(0.7, 0.05, 0.4, mGold, -8.5, 0.86, -5.8);

    var pendantMat = mat(0x1a1a1a, 0.4, 0.8);
    function pendant(px, pz) {
        box(0.04, 1.5, 0.04, pendantMat, px, 13.25, pz);
        cyl(0.18, 0.14, 0.22, pendantMat, px, 12.4, pz, 12);
    }
    pendant(-5, 0); pendant(0, 0); pendant(5, 0);
    pendant(-5, 4); pendant(0, 4); pendant(5, 4);
    pendant(-5, 8); pendant(5, 8);

    scene.add(new THREE.AmbientLight(0x1a1208, 1.2));
    var dirLight = new THREE.DirectionalLight(0xfff0d0, 0.8);
    dirLight.position.set(5, 12, 8);
    dirLight.castShadow = true;
    scene.add(dirLight);

    var barSpot = new THREE.SpotLight(0xffa040, 3, 18, Math.PI / 6, 0.4);
    barSpot.position.set(0, 12, -9);
    barSpot.target.position.set(0, 0, -9);
    scene.add(barSpot); scene.add(barSpot.target);

    var tablePt = new THREE.PointLight(0xc5a059, 1.5, 8);
    tablePt.position.set(0, 3, 3);
    scene.add(tablePt);

    var screenPt = new THREE.PointLight(0x0066cc, 1, 10);
    screenPt.position.set(0, 7, -10);
    scene.add(screenPt);

    var cams = [
        { pos: [0,  5, 14],  look: [0, 1,  0]  },
        { pos: [-8, 2, -4],  look: [-8.5, 1, -6] },
        { pos: [2,  2, -6],  look: [0, 1.2, -9]  },
        { pos: [0,  6, -8],  look: [0, 7, -11.7] },
        { pos: [0, 10,  2],  look: [0, 0,  0]   }
    ];
    var camLabels = [
        'Vista general del restaurante',
        'Zona VIP exclusiva',
        'Barra principal',
        'Pantalla central gigante',
        'Perspectiva de tribuna'
    ];

    var targetPos  = new THREE.Vector3(0, 5, 14);
    var targetLook = new THREE.Vector3(0, 1, 0);
    var currentLook = new THREE.Vector3(0, 1, 0);
    var camAnimating = false;

    document.querySelectorAll('.tour-btn').forEach(function (btn, i) {
        btn.addEventListener('click', function () {
            document.querySelectorAll('.tour-btn').forEach(function (b) { b.classList.remove('active'); });
            btn.classList.add('active');
            targetPos.set(cams[i].pos[0], cams[i].pos[1], cams[i].pos[2]);
            targetLook.set(cams[i].look[0], cams[i].look[1], cams[i].look[2]);
            camAnimating = true;
            document.getElementById('tour-label').textContent = camLabels[i];
        });
    });

    var isDragging = false, lastMX = 0, lastMY = 0;
    var orbitTheta = 0, orbitPhi = 0.35, orbitR = 14;
    var userInteracted = false;
    var pivot = new THREE.Vector3(0, 1, 0);

    canvas.addEventListener('mousedown', function (e) { isDragging = true; lastMX = e.clientX; lastMY = e.clientY; userInteracted = true; });
    window.addEventListener('mouseup',   function ()  { isDragging = false; });
    window.addEventListener('mousemove', function (e) {
        if (!isDragging) return;
        orbitTheta -= (e.clientX - lastMX) * 0.005;
        orbitPhi = Math.max(0.1, Math.min(1.3, orbitPhi - (e.clientY - lastMY) * 0.005));
        lastMX = e.clientX; lastMY = e.clientY;
    });
    canvas.addEventListener('wheel', function (e) {
        orbitR = Math.max(4, Math.min(22, orbitR + e.deltaY * 0.02));
    }, { passive: true });

    var lastTX = 0, lastTY = 0;
    canvas.addEventListener('touchstart', function (e) {
        lastTX = e.touches[0].clientX; lastTY = e.touches[0].clientY; userInteracted = true;
    }, { passive: true });
    canvas.addEventListener('touchmove', function (e) {
        orbitTheta -= (e.touches[0].clientX - lastTX) * 0.006;
        orbitPhi = Math.max(0.1, Math.min(1.3, orbitPhi - (e.touches[0].clientY - lastTY) * 0.006));
        lastTX = e.touches[0].clientX; lastTY = e.touches[0].clientY;
    }, { passive: true });

    var clock = 0;
    function animate() {
        requestAnimationFrame(animate);
        clock += 0.016;
        logoMat.emissiveIntensity = 0.35 + Math.sin(clock * 0.8) * 0.2;
        screenPt.intensity        = 0.8  + Math.sin(clock * 0.5) * 0.35;
        if (!userInteracted) orbitTheta += 0.003;
        if (camAnimating) {
            camera.position.lerp(targetPos, 0.06);
            currentLook.lerp(targetLook, 0.06);
            camera.lookAt(currentLook);
            if (camera.position.distanceTo(targetPos) < 0.05) camAnimating = false;
        } else {
            var x = pivot.x + orbitR * Math.sin(orbitPhi) * Math.sin(orbitTheta);
            var y = pivot.y + orbitR * Math.cos(orbitPhi);
            var z = pivot.z + orbitR * Math.sin(orbitPhi) * Math.cos(orbitTheta);
            camera.position.set(x, y, z);
            camera.lookAt(pivot);
        }
        renderer.render(scene, camera);
    }

    resize();
    window.addEventListener('resize', resize);
    animate();
})();
</script>

<!-- ══════════════ CHATBOT SCRIPT ══════════════ -->
<script>
var currentMood = 'normal';

document.querySelectorAll('.mood-btn').forEach(function (btn) {
    btn.addEventListener('click', function () {
        document.querySelectorAll('.mood-btn').forEach(function (b) { b.classList.remove('active'); });
        btn.classList.add('active');
        currentMood = btn.dataset.mood;
    });
});

function appendMsg(role, text) {
    var box = document.getElementById('chat-box');
    var div = document.createElement('div');
    div.className = 'chat-msg ' + role;
    var icon = role === 'bot' ? '🏟️' : '👤';
    div.innerHTML =
        '<div class="chat-avatar">' + icon + '</div>' +
        '<div class="chat-bubble">' + text.replace(/\n/g, '<br>') + '</div>';
    box.appendChild(div);
    box.scrollTop = box.scrollHeight;
    return div;
}

function showTyping() {
    var box = document.getElementById('chat-box');
    var div = document.createElement('div');
    div.className = 'chat-msg bot'; div.id = 'typing-indicator';
    div.innerHTML =
        '<div class="chat-avatar">🏟️</div>' +
        '<div class="chat-bubble"><div class="typing-dots"><span></span><span></span><span></span></div></div>';
    box.appendChild(div);
    box.scrollTop = box.scrollHeight;
}
function removeTyping() {
    var el = document.getElementById('typing-indicator');
    if (el) el.remove();
}

function sendMessage(text) {
    if (!text.trim()) return;
    var btn = document.getElementById('send-btn');
    btn.disabled = true;
    document.getElementById('chat-input').value = '';

    appendMsg('user', text);
    showTyping();

    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'AsistenteServlet', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            removeTyping();
            if (xhr.status === 200) {
                appendMsg('bot', xhr.responseText);
            } else {
                appendMsg('bot', respuestaLocal(text, currentMood));
            }
            btn.disabled = false;
            document.getElementById('chat-input').focus();
        }
    };
    xhr.send('mensaje=' + encodeURIComponent(text) + '&modo=' + encodeURIComponent(currentMood));
}

function respuestaLocal(texto, modo) {
    var m = texto.toLowerCase().trim();
    function tiene() {
        for (var i = 0; i < arguments.length; i++) {
            if (m.indexOf(arguments[i]) !== -1) return true;
        }
        return false;
    }
    function resp(n, f, fu) {
        if (modo === 'formal') return f;
        if (modo === 'futbol') return fu;
        return n;
    }
    if (tiene('hola','buenas','buenos','saludos','hi','hey','alo')) {
        return resp(
            '¡Hola campeón! Soy Tony Coach. ⚽\nPuedo ayudarte con:\n• Menú y precios\n• Reservaciones\n• Promociones\n• Horarios y ubicación\n¿Con qué empezamos?',
            '¡Bienvenido a Tony Food Stadium! Estoy a su disposición. ¿En qué le puedo ayudar?',
            '¡GOOOL DE BIENVENIDA! 🔥⚽ El partido acaba de empezar. ¿Qué jugada me pides?'
        );
    }
    if (tiene('menu','menú','carta','comer','platos','comida','qué tienen','que tienen')) {
        return resp(
            '¡Nuestra alineación gourmet! 🏆\n\n⚽ CR7 Crunch Burger — $12.90\n🍗 Hat-Trick Wings — $9.90\n🍔 Stadium Combo — $18.90\n🥇 Cup Combo — $14.50 (20% dto. socios)\n🧀 Champion Nachos — $8.50\n🍟 Golden Fries — $4.90\n🥤 Penalty Shake — $5.50\n🍺 Beer Pint — $4.00',
            'Nuestra propuesta gastronómica incluye: CR7 Crunch Burger ($12.90), Hat-Trick Wings ($9.90), Stadium Combo ($18.90), Cup Combo ($14.50 con descuento para socios), entre otros.',
            '¡EL ONCE TITULAR! ⚽🔥\n⚽ CR7 Crunch Burger $12.90 ← delantero estrella\n🍗 Hat-Trick Wings $9.90 ← tres goles en un plato\n🍔 Stadium Combo $18.90 ← el equipo completo!'
        );
    }
    if (tiene('horario','hora','abierto','abre','cierra')) {
        return resp(
            '¡Estamos en cancha todos los días! ⏰\nLunes a Domingo — 12:00 a 22:00',
            'Nuestro horario es de 12:00 a 22:00 los siete días de la semana.',
            '¡EL ESTADIO NUNCA DESCANSA! ⏰⚽ Abierto todos los días 12:00 a 22:00.'
        );
    }
    if (tiene('reserva','mesa','evento','grupos','cumpleaños')) {
        return resp(
            '¡Hacemos reservaciones! 📋\n• Mínimo 2 horas antes\n• Grupos 10+ reserva obligatoria\n• Eventos privados disponibles\nEscríbenos por redes o WhatsApp.',
            'Aceptamos reservaciones con mínimo 2 horas de anticipación. Para grupos de 10 o más es obligatorio. Contáctenos por nuestros canales oficiales.',
            '¡ASEGURA TU POSICIÓN EN EL CAMPO! ⚽ Reserva 2 horas antes. ¡No dejes que el rival te quite la cancha!'
        );
    }
    if (tiene('promo','descuento','oferta','beneficio')) {
        return resp(
            '¡Tenemos promos! 🎯\n• Cup Combo 20% OFF para socios (días partido)\n• Precios especiales grupos 10+\n• Beneficios Zona VIP para miembros',
            'Nuestras promociones incluyen 20% en Cup Combo para socios y precios especiales para grupos y eventos corporativos.',
            '¡LAS MEJORES JUGADAS DE DESCUENTO! ⚽🔥 Cup Combo 20% para socios. ¡Regístrate y juega en ventaja!'
        );
    }
    if (tiene('vip','exclusivo','premium')) {
        return resp(
            '¡Nuestra Zona VIP es única! 🌟\n• Butacas de diseño especial\n• Servicio premium en mesa\n• Vista privilegiada a la pantalla\n• Acceso preferencial para socios\n¡Explórala en el Tour 3D!',
            'La Zona VIP ofrece mobiliario exclusivo, servicio personalizado y prioridad para socios activos.',
            '¡LA CHAMPIONS LEAGUE DEL RESTAURANTE! 🏆✨ Zona VIP, butacas de lujo. Los socios entran directo.'
        );
    }
    if (tiene('delivery','domicilio','llevar','take away')) {
        return resp(
            '¡Llevamos el estadio a tu casa! 🚀\n• Delivery en zona cercana\n• Take away siempre disponible\nEscríbenos por Instagram o Facebook.',
            'Ofrecemos delivery en zona cercana y pedidos para llevar. Contáctenos para verificar cobertura.',
            '¡GOL A DOMICILIO! 🏠⚽ Hacemos delivery en la zona. ¡Contáctanos y te decimos si llegamos a tu campo!'
        );
    }
    if (tiene('socio','registrar','membresía','membresia','club')) {
        return resp(
            '¡Únete al Club! 🏆\n✅ 20% dto. Cup Combo días partido\n✅ Acceso preferencial Zona VIP\n✅ Promociones exclusivas\nHaz clic en "REGISTRARSE EN EL CLUB". ¡Es gratis!',
            'Le invitamos a unirse a nuestro programa de socios. Obtendrá descuentos, acceso VIP y beneficios. El registro es gratuito.',
            '¡FICHA POR EL MEJOR EQUIPO! 🔥🏆 Descuento 20%, entrada VIP. ¡Regístrate ya, campeón!'
        );
    }
    if (tiene('redes','instagram','facebook','tiktok','contacto','whatsapp')) {
        return resp(
            '¡Síguenos! 📱\n• Facebook: Tony Food Stadium\n• Instagram: @xxthx_03\n• TikTok: @anth0_03',
            'Puede encontrarnos en Facebook (Tony Food Stadium), Instagram (@xxthx_03) y TikTok (@anth0_03).',
            '¡EL MARCADOR DE NUESTRAS REDES! ⚽📱 FB: Tony Food Stadium | IG: @xxthx_03 | TT: @anth0_03'
        );
    }
    if (tiene('ubicacion','ubicación','donde','dónde','llegar','dirección','direccion','mapa')) {
        return resp(
            '¡Encuéntranos en Quito! 📍\nEstamos en Quito, Ecuador.\nRevisa la sección "Nuestra Ubicación" o abre Google Maps desde el botón en la página.',
            'Nos encontramos en Quito, Ecuador. Puede consultar nuestra ubicación exacta en la sección del mapa en esta misma página.',
            '¡TE DAMOS LAS COORDENADAS! 📍⚽ Estamos en Quito, Ecuador. ¡Baja al mapa y ven a vernos!'
        );
    }
    if (tiene('gracias','perfecto','excelente','genial')) {
        return resp(
            '¡Un placer! 🏆 ¿Algo más en que pueda ayudarte?',
            '¡Con mucho gusto! Ha sido un placer atenderle.',
            '¡GOOOL DE SATISFACCIÓN! 🎉⚽ Para eso estoy yo. ¡Te esperamos con el menú listo!'
        );
    }
    return resp(
        'No tengo esa información exacta. 🤔\nPuedo ayudarte con:\n• Menú y precios\n• Reservaciones\n• Horarios y ubicación\n• Zona VIP · Delivery · Ser socio\n¿Sobre cuál te cuento?',
        'Disculpe, no dispongo de esa información. Le sugiero consultar sobre nuestro menú, horarios, reservaciones o servicios.',
        '¡FUERA DE JUEGO esa jugada! 😄⚽ Prueba con: menú, horario, VIP, delivery o socios. ¡Volvemos al campo!'
    );
}

function handleSend() {
    var text = document.getElementById('chat-input').value.trim();
    if (text) sendMessage(text);
}
function sendQuick(text) { sendMessage(text); }
function clearChat() {
    document.getElementById('chat-box').innerHTML = '';
    appendMsg('bot', '¡Campo despejado! ¿En qué puedo ayudarte hoy? ⚽');
}

document.getElementById('chat-input').addEventListener('keydown', function (e) {
    if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); handleSend(); }
});

window.addEventListener('load', function () {
    setTimeout(function () {
        appendMsg('bot',
            '¡Bienvenido al campo de los sabores! 🏟️\n\n' +
            'Soy Tony Coach, tu asistente virtual. Puedo ayudarte con nuestro menú, reservaciones, promociones, horarios y más.\n\n' +
            '¿Con qué te ayudo hoy, campeón?'
        );
    }, 700);
});
</script>

<!-- ══════════════ BURGER MASCOT SCRIPT ══════════════ -->
<script>
var burgerOpen = false;
var burgerGreeted = false;

function toggleBurgerChat() {
    burgerOpen = !burgerOpen;
    var chat = document.getElementById('burger-chat');
    var btn  = document.getElementById('burger-btn');
    var tip  = document.getElementById('burger-tooltip');
    if (burgerOpen) {
        chat.classList.add('open');
        btn.classList.add('open');
        tip.style.display = 'none';
        if (!burgerGreeted) {
            burgerGreeted = true;
            setTimeout(function () {
                appendBurger('bot',
                    '¡Hola hola! 🍔 Soy Toñito, la hamburguesa más famosa del estadio.\n\n' +
                    '¿En qué te puedo ayudar hoy? ¡Pregúntame lo que quieras sobre nuestra comida!'
                );
            }, 400);
        }
        setTimeout(function () {
            document.getElementById('burger-input').focus();
        }, 350);
    } else {
        chat.classList.remove('open');
        btn.classList.remove('open');
        tip.style.display = 'block';
    }
}

function appendBurger(role, text) {
    var box = document.getElementById('burger-messages');
    var div = document.createElement('div');
    div.className = 'b-msg ' + role;
    var icon = role === 'bot' ? '🍔' : '👤';
    div.innerHTML =
        '<div class="b-avatar">' + icon + '</div>' +
        '<div class="b-bubble">' + text.replace(/\n/g, '<br>') + '</div>';
    box.appendChild(div);
    box.scrollTop = box.scrollHeight;
}

function showBurgerTyping() {
    var box = document.getElementById('burger-messages');
    var div = document.createElement('div');
    div.className = 'b-msg bot'; div.id = 'burger-typing';
    div.innerHTML =
        '<div class="b-avatar">🍔</div>' +
        '<div class="b-bubble"><div class="typing-dots"><span></span><span></span><span></span></div></div>';
    box.appendChild(div);
    box.scrollTop = box.scrollHeight;
}
function removeBurgerTyping() {
    var el = document.getElementById('burger-typing');
    if (el) el.remove();
}

function burgerSend() {
    var input = document.getElementById('burger-input');
    var text = input.value.trim();
    if (!text) return;
    input.value = '';
    var sendBtn = document.getElementById('burger-send');
    sendBtn.disabled = true;
    appendBurger('user', text);
    showBurgerTyping();
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'AsistenteServlet', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            removeBurgerTyping();
            var reply = (xhr.status === 200 && xhr.responseText.trim())
                ? burgerPersonalize(xhr.responseText)
                : burgerPersonalize(respuestaLocal(text, 'normal'));
            appendBurger('bot', reply);
            sendBtn.disabled = false;
            input.focus();
        }
    };
    xhr.send('mensaje=' + encodeURIComponent(text) + '&modo=normal');
}

function burgerPersonalize(text) {
    var emojis = ['🍔', '🧀', '🥩', '🍟', '🔥'];
    var emoji = emojis[Math.floor(Math.random() * emojis.length)];
    return text + '\n\n— Toñito ' + emoji;
}

function burgerQuick(text) {
    document.getElementById('burger-input').value = text;
    burgerSend();
}

document.getElementById('burger-input').addEventListener('keydown', function (e) {
    if (e.key === 'Enter') { e.preventDefault(); burgerSend(); }
});

setTimeout(function () {
    var tip = document.getElementById('burger-tooltip');
    if (tip && !burgerOpen) {
        tip.style.transition = 'opacity 0.5s';
        tip.style.opacity = '0';
        setTimeout(function () { tip.style.display = 'none'; }, 500);
    }
}, 5000);
</script>

</body>
</html>