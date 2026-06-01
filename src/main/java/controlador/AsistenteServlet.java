package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AsistenteServlet")
public class AsistenteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        // CORS headers para evitar bloqueos en desarrollo local
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");

        String mensaje = request.getParameter("mensaje");
        String modo    = request.getParameter("modo");
        if (mensaje == null) mensaje = "";
        if (modo    == null) modo    = "normal";

        mensaje = mensaje.toLowerCase().trim();

        PrintWriter out = response.getWriter();
        out.print(generar(mensaje, modo));
    }

    @Override
    protected void doOptions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        response.setStatus(HttpServletResponse.SC_OK);
    }

    // ──────────────────────────────────────────────
    private String generar(String m, String modo) {

        // SALUDOS
        if (tiene(m, "hola", "buenas", "buenos", "saludos", "hi", "hey", "alo")) {
            return resp(modo,
                "¡Hola campeón! Soy Tony Coach, tu asistente de Tony Food Stadium. ⚽\n\n" +
                "Puedo ayudarte con:\n• Menú y precios\n• Reservaciones\n• Promociones para socios\n• Horarios y ubicación\n• Delivery y Zona VIP\n\n" +
                "¿Con qué empezamos?",

                "¡Bienvenido a Tony Food Stadium! Es un placer atenderle. Estoy a su disposición para cualquier consulta sobre nuestros servicios, menú, reservaciones y promociones. ¿En qué le puedo ayudar?",

                "¡GOOOL DE BIENVENIDA! ⚽🔥 Soy Tony Coach, el entrenador de los sabores. ¡El partido acaba de comenzar! ¿Qué jugada me pides hoy?"
            );
        }

        // MENÚ GENERAL
        if (tiene(m, "menu", "menú", "carta", "comer", "platos", "comida", "que tienen", "qué tienen")) {
            return resp(modo,
                "¡Nuestra alineación gourmet! 🏆\n\n" +
                "⚽ CR7 Crunch Burger — $12.90\nDoble carne angus, queso brie, cebolla caramelizada, salsa secreta\n\n" +
                "🍗 Hat-Trick Wings — $9.90\n12 alitas con 3 salsas: BBQ Gold, Piri Piri, Miel-Mostaza\n\n" +
                "🍔 Stadium Combo — $18.90\nBurger + alitas + papas + bebida\n\n" +
                "🥇 Cup Combo — $14.50\nBurger + papas + bebida (¡20% dto. para socios!)\n\n" +
                "🧀 Champion Nachos — $8.50 | 🍟 Golden Fries — $4.90\n🥤 Penalty Shake — $5.50 | 🍺 Beer Pint — $4.00\n\n" +
                "Visita la sección Menú para ver todos los platos.",

                "Estimado cliente, nuestra propuesta gastronómica incluye:\n\n" +
                "• CR7 Crunch Burger — $12.90\n• Hat-Trick Wings — $9.90\n" +
                "• Stadium Combo — $18.90\n• Cup Combo — $14.50 (descuento para socios)\n" +
                "• Champion Nachos — $8.50 | Golden Fries — $4.90\n\n" +
                "Le invitamos a visitar nuestra sección de productos para una experiencia visual completa.",

                "¡EL ONCE TITULAR DE NUESTRO MENÚ! ⚽🔥\n\n" +
                "⚽ CR7 Crunch Burger — $12.90 ← el delantero estrella\n" +
                "🍗 Hat-Trick Wings — $9.90 ← ¡tres goles en un plato!\n" +
                "🍔 Stadium Combo — $18.90 ← el equipo completo\n" +
                "🥇 Cup Combo — $14.50 ← con descuento para socios, oferta de primera división!\n\n" +
                "¡El mejor plantel gastronómico de la ciudad! 🏆"
            );
        }

        // HAMBURGUESAS
        if (tiene(m, "hamburguesa", "burger", "cr7", "carne")) {
            return resp(modo,
                "Nuestra hamburguesa estrella: CR7 Crunch Burger — $12.90 🏆\n\n" +
                "• Doble carne angus premium\n• Queso brie derretido\n• Cebolla caramelizada\n" +
                "• Salsa secreta de la casa\n• Pan brioche artesanal\n\n" +
                "¡Viene con papas artesanales incluidas!",

                "Nuestra hamburguesa insignia es la CR7 Crunch Burger ($12.90), elaborada con doble carne angus, queso brie, cebolla caramelizada y salsa exclusiva de la casa.",

                "¡La CR7 Crunch Burger es un GOLAZO de sabor! 🔥 Doble angus, brie derretido, cebolla caramelizada... ¡como un hat-trick en tu paladar! Solo $12.90. ¡Pídela ya!"
            );
        }

        // ALITAS
        if (tiene(m, "alitas", "wings", "pollo", "hat-trick", "hat trick")) {
            return resp(modo,
                "¡Nuestras Hat-Trick Wings son legendarias! 🍗\n\n" +
                "• 12 alitas premium seleccionadas\n• 3 salsas: BBQ Gold, Piri Piri y Miel-Mostaza\n• Precio: $9.90\n\n" +
                "¡El aperitivo favorito del estadio!",

                "Las Hat-Trick Wings ($9.90) consisten en 12 alitas premium con tres salsas artesanales propias: BBQ Gold, Piri Piri y Miel-Mostaza.",

                "¡HATRICK DE SABORES en un solo plato! 🔥 12 alitas explosivas con 3 salsas. ¡Como marcar 3 goles en el mismo partido! Solo $9.90. ¡Pídelas ya, campeón!"
            );
        }

        // PRECIOS
        if (tiene(m, "precio", "costo", "cuánto", "cuanto", "valor", "barato", "caro", "económico")) {
            return resp(modo,
                "Nuestros precios:\n\n" +
                "• Agua / Jugos — $2.50\n• Beer Pint — $4.00\n• Golden Fries — $4.90\n" +
                "• Penalty Shake — $5.50\n• Champion Nachos — $8.50\n• Hat-Trick Wings — $9.90\n" +
                "• CR7 Crunch Burger — $12.90\n• Cup Combo — $14.50 (¡20% dto. para socios!)\n" +
                "• Stadium Combo — $18.90\n\n" +
                "¡Los socios obtienen descuentos exclusivos!",

                "Nuestros precios oscilan entre $2.50 y $18.90. Los socios registrados obtienen un 20% de descuento en el Cup Combo en días de partido.",

                "¡Los mejores precios de la liga premium! 🏆 Desde $2.50 hasta $18.90, siempre en primera división de sabor sin que tu bolsillo salga expulsado!"
            );
        }

        // PROMOCIONES
        if (tiene(m, "promo", "descuento", "oferta", "especial", "beneficio", "2x1")) {
            return resp(modo,
                "¡Tenemos grandes promos! 🎯\n\n" +
                "🏅 Cup Combo con 20% OFF para socios en días de partido\n" +
                "🎉 Eventos privados con precios especiales (grupos 10+)\n" +
                "⭐ Acceso preferencial a Zona VIP para miembros del club\n\n" +
                "¡Regístrate como socio para acceder a todos los beneficios!",

                "Contamos con las siguientes promociones:\n• 20% de descuento en Cup Combo para socios (días de partido)\n" +
                "• Precios especiales para eventos corporativos y grupos\n• Beneficios exclusivos de membresía.",

                "¡LAS MEJORES JUGADAS DE DESCUENTO! ⚽🔥\n• Cup Combo al 20% para socios en días de partido — ¡gol cantado!\n" +
                "• Grupos con precio especial — ¡como tener la cancha para ti!\n¡Regístrate y juega en ventaja desde el primer minuto!"
            );
        }

        // HORARIO
        if (tiene(m, "horario", "hora", "abierto", "abre", "cierra", "cuando abren", "cuándo abren")) {
            return resp(modo,
                "¡Estamos en cancha todos los días! ⏰\n\nLunes a Domingo — 12:00 a 22:00\n\n¡Sin excepciones, siempre listos para recibirte!",
                "Nuestro horario de atención es de 12:00 a 22:00, los siete días de la semana, incluyendo festivos.",
                "¡EL ESTADIO NUNCA DESCANSA! ⏰⚽ Puertas abiertas todos los días de 12:00 a 22:00. ¡El pitazo inicial es al mediodía!"
            );
        }

        // UBICACIÓN
        if (tiene(m, "donde", "dónde", "ubicacion", "ubicación", "dirección", "direccion", "llegar", "mapa", "lugar")) {
            return resp(modo,
                "Estamos en el sector principal de la ciudad. 📍\n\n" +
                "El local está decorado como un estadio auténtico:\n" +
                "• Pantalla gigante para partidos en vivo\n• Zona VIP exclusiva\n• Barra premium\n" +
                "• Estacionamiento disponible\n\n" +
                "¡Escríbenos por redes para indicaciones precisas!",

                "Nos encontramos en el sector principal de la ciudad, con estacionamiento propio. Para indicaciones detalladas le recomendamos contactarnos por nuestros canales oficiales.",

                "¡En el corazón de la ciudad, como la cancha central! 🏟️⚽ Estacionamiento disponible. Escríbenos por las redes y te damos las instrucciones exactas. ¡Sin fuera de juego!"
            );
        }

        // RESERVACIONES
        if (tiene(m, "reserva", "reservación", "reservacion", "mesa", "apartar", "evento", "cumpleaños", "grupos")) {
            return resp(modo,
                "¡Hacemos reservaciones! 📋\n\n" +
                "• Mínimo 2 horas de anticipación\n• Grupos 10+ requieren reserva obligatoria\n" +
                "• Eventos privados: cumpleaños, corporativos y más\n• Por WhatsApp o en persona\n\n" +
                "¡Contáctanos por nuestras redes para reservar!",

                "Aceptamos reservaciones con mínimo 2 horas de anticipación. Para grupos de 10 o más personas es obligatorio. También organizamos eventos privados. Contáctenos por WhatsApp o presencialmente.",

                "¡ASEGURA TU POSICIÓN EN EL CAMPO! ⚽📋 Reserva 2 horas antes. Grupos grandes deben reservar obligatorio. ¡No dejes que el rival te quite la cancha! Escríbenos ya."
            );
        }

        // SOCIO / REGISTRO
        if (tiene(m, "socio", "registrar", "registro", "membresia", "membresía", "club", "unirme", "inscribir")) {
            return resp(modo,
                "¡Únete al Club Tony Food Stadium! 🏆\n\n" +
                "Beneficios:\n✅ 20% dto. en Cup Combo (días de partido)\n" +
                "✅ Acceso preferencial a Zona VIP\n✅ Promociones exclusivas\n\n" +
                "Haz clic en 'REGISTRARSE EN EL CLUB' en esta página. ¡Es completamente gratis!",

                "Le invitamos a unirse a nuestro programa de socios. Obtendrá descuentos, acceso VIP y beneficios exclusivos. El registro es gratuito y está disponible en nuestra página web.",

                "¡FICHA POR EL MEJOR EQUIPO! 🔥🏆 Descuento 20% en días de partido, entrada VIP y beneficios de Champions League. ¡Regístrate ya, que los cupos son limitados, campeón!"
            );
        }

        // DELIVERY
        if (tiene(m, "delivery", "domicilio", "envío", "envio", "llevar", "take away", "para llevar")) {
            return resp(modo,
                "¡Llevamos el estadio a tu casa! 🚀\n\n" +
                "• Delivery en zona cercana al local\n• Take away siempre disponible\n" +
                "• Consulta cobertura por nuestras redes\n\nEscríbenos por Instagram o Facebook.",

                "Ofrecemos delivery en zona cercana y pedidos para llevar. Para verificar cobertura contáctenos por nuestros canales oficiales.",

                "¡GOL A DOMICILIO! 🏠⚽ Hacemos delivery en la zona. Take away siempre listo. ¡Contáctanos por las redes y te decimos si llegamos a tu campo!"
            );
        }

        // ZONA VIP
        if (tiene(m, "vip", "exclusivo", "privado", "premium", "zona vip")) {
            return resp(modo,
                "¡Nuestra Zona VIP es única! 🌟\n\n" +
                "• Butacas de diseño especial\n• Servicio premium en mesa\n" +
                "• Vista privilegiada a la pantalla\n• Para eventos y celebraciones\n" +
                "• Acceso preferencial para socios\n\n" +
                "¡Explórala ahora en el Tour 3D de esta página!",

                "La Zona VIP ofrece mobiliario exclusivo, servicio personalizado y prioridad para socios activos. Ideal para eventos corporativos y celebraciones de alto nivel.",

                "¡LA CHAMPIONS LEAGUE DEL RESTAURANTE! 🏆✨ Zona VIP con butacas de lujo y servicio de primera. Los socios entran directo. ¡Véla en el Tour 3D aquí arriba, un golazo de experiencia!"
            );
        }

        // REDES / CONTACTO
        if (tiene(m, "redes", "instagram", "facebook", "tiktok", "contacto", "teléfono", "telefono", "whatsapp", "social")) {
            return resp(modo,
                "¡Síguenos! 📱\n\n" +
                "• Facebook: Tony Food Stadium\n• Instagram: @xxthx_03\n• TikTok: @anth0_03\n\n" +
                "Para reservas y consultas directas escríbenos por Instagram o Facebook. ¡Respondemos rápido!",

                "Puede encontrarnos en:\n• Facebook: Tony Food Stadium\n• Instagram: @xxthx_03\n• TikTok: @anth0_03\n\nPara consultas le recomendamos Facebook o Instagram.",

                "¡EL MARCADOR DE NUESTRAS REDES! ⚽📱\nFacebook: Tony Food Stadium — Instagram: @xxthx_03 — TikTok: @anth0_03\n¡Síguenos y no pierdas ningún partido gastronómico!"
            );
        }

        // BEBIDAS
        if (tiene(m, "bebida", "cerveza", "jugo", "agua", "shake", "milkshake", "refresco", "tomar")) {
            return resp(modo,
                "¡Nuestra selección de bebidas! 🍺\n\n" +
                "• Draft Beer Pint (artesanal de barril) — $4.00\n" +
                "• Penalty Shake (milkshake artesanal) — $5.50\n  Sabores: vainilla, chocolate, fresa, oreo\n" +
                "• Agua mineral / Jugos naturales — $2.50",

                "Nuestra selección incluye cerveza artesanal ($4.00), milkshakes en cuatro sabores ($5.50) y agua mineral o jugos naturales ($2.50).",

                "¡HIDRATACIÓN DE PRIMERA DIVISIÓN! 🍺🥤 Cerveza artesanal $4.00, Penalty Shake $5.50 en 4 sabores y jugos $2.50. ¡El equipo completo para refrescarte, campeón!"
            );
        }

        // VEGETARIANO
        if (tiene(m, "vegetariano", "vegano", "sin carne", "vegetal")) {
            return resp(modo,
                "¡Tenemos opciones para todos! 🥗\nContamos con menú vegetariano bajo petición. Consúltanos al llegar o por nuestras redes.",
                "Disponemos de opciones vegetarianas bajo petición. Le recomendamos consultarnos con antelación.",
                "¡También jugamos para el equipo verde! 🌿⚽ Opciones vegetarianas bajo petición. ¡Pregunta al llegar!"
            );
        }

        // MASCOTAS
        if (tiene(m, "mascota", "perro", "gato", "animales", "pets")) {
            return resp(modo,
                "¡Las mascotas son bienvenidas! 🐾\nPermitimos mascotas en nuestra zona exterior.",
                "Las mascotas son bienvenidas en nuestra zona exterior. Es un placer recibirles junto a su compañero.",
                "¡LAS MASCOTAS TAMBIÉN VEN EL PARTIDO! 🐾⚽ Son bienvenidas en zona exterior. ¡Trae a tu hincha peludo!"
            );
        }

        // ESTACIONAMIENTO
        if (tiene(m, "estacionamiento", "parqueadero", "parking", "aparcar", "parquear")) {
            return resp(modo,
                "¡Sí contamos con estacionamiento! 🚗\nDisponible para todos nuestros clientes. ¡Sin excusas para no venir!",
                "Efectivamente, disponemos de estacionamiento para nuestros clientes.",
                "¡El parqueadero también juega en el equipo! 🚗⚽ Sí tenemos estacionamiento. ¡Ven sin miedo, campeón!"
            );
        }

        // GRACIAS
        if (tiene(m, "gracias", "thanks", "perfecto", "excelente", "genial", "bien")) {
            return resp(modo,
                "¡Un placer ayudarte! 🏆 Si tienes más preguntas aquí estaré. ¡Te esperamos pronto en el estadio!",
                "¡Con mucho gusto! Ha sido un placer atenderle. Quedo a su disposición para cualquier consulta adicional.",
                "¡GOOOL DE SATISFACCIÓN! 🎉⚽ Para eso estoy yo. ¡Te esperamos con la camiseta puesta y el menú listo!"
            );
        }

        // DESPEDIDA
        if (tiene(m, "adios", "adiós", "chao", "chau", "bye", "hasta luego", "nos vemos")) {
            return resp(modo,
                "¡Hasta pronto! Fue un placer atenderte. ¡Te esperamos en Tony Food Stadium! ⚽🏟️",
                "¡Hasta luego! Fue un placer atenderle. Le esperamos pronto.",
                "¡PITAZO FINAL! ⚽ Fue un honor ser tu técnico hoy. ¡Vuelve pronto, que aquí siempre hay partido!"
            );
        }

        // DEFAULT
        return resp(modo,
            "Mmm, no tengo esa información exacta. 🤔\n\nPuedo ayudarte con:\n" +
            "• Menú y precios\n• Reservaciones\n• Horarios y ubicación\n• Zona VIP\n• Delivery\n" +
            "• Cómo ser socio\n• Redes y contacto\n\n¿Sobre cuál te cuento?",

            "Disculpe, no dispongo de información sobre ese tema. Le sugiero consultar sobre nuestro menú, horarios, reservaciones, Zona VIP o servicios de delivery.",

            "¡FUERA DE JUEGO esa jugada! 😄⚽ No tengo ese dato en el manual. Prueba con: menú, precios, horario, VIP, delivery, socios o redes. ¡Volvemos al campo!"
        );
    }

    private boolean tiene(String msg, String... palabras) {
        for (String p : palabras) {
            if (msg.contains(p)) return true;
        }
        return false;
    }

    private String resp(String modo, String normal, String formal, String futbol) {
        switch (modo) {
            case "formal":  return formal;
            case "futbol":  return futbol;
            default:        return normal;
        }
    }
}