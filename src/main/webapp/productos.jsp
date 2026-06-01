<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("perfil") == null) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }
    String nombreSocio = (String) session.getAttribute("nombre");
    if (nombreSocio == null) nombreSocio = "Campeón";
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Tony Food Stadium | Menú</title>
    <script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>
    <style>
        :root { --gold: #c5a059; --dark: #050505; }
        body { background: var(--dark); color: white; font-family: 'Segoe UI', sans-serif; margin: 0; }
        
        /* Sidebar del Carrito */
        #cart-sidebar { 
            position: fixed; top: 0; right: -410px; width: 380px; height: 100%; 
            background: #0d0d0d; border-left: 2px solid var(--gold); 
            transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1); z-index: 1000; padding: 25px; 
            display: flex; flex-direction: column; box-sizing: border-box;
        }
        
        .stadium-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; padding: 30px; }
        
        .card-p { 
            background: #111; border: 1px solid #222; padding: 20px; 
            text-align: center; border-radius: 15px; transition: 0.3s;
        }
        .card-p:hover { border-color: var(--gold); transform: translateY(-5px); }

        .btn-add {
            width: 100%; padding: 12px; background: transparent; border: 1px solid var(--gold); 
            color: var(--gold); font-weight: bold; cursor: pointer; border-radius: 5px;
            text-transform: uppercase; margin-top: 10px;
        }
        .btn-add:hover { background: var(--gold); color: black; }

        header { text-align: center; padding: 40px; background: #000; border-bottom: 1px solid #222; }
    </style>
</head>
<body>

<div id="cart-sidebar">
    <h2 style="color: var(--gold); border-bottom: 1px solid #222; padding-bottom: 10px; font-family: serif;">MI TICKET</h2>
    <div id="lista-ticket" style="flex-grow: 1; overflow-y: auto; margin-top: 15px;">
        </div>
    
    <div style="border-top: 2px solid var(--gold); padding-top: 20px;">
        <div style="display: flex; justify-content: space-between; font-size: 1.5rem; margin-bottom: 20px;">
            <span>TOTAL:</span>
            <span id="total-val" style="color: var(--gold); font-weight: bold;">$0.00</span>
        </div>
        <button onclick="gestorTicket.finalizar()" style="width: 100%; padding: 18px; background: var(--gold); color: black; font-weight: bold; cursor: pointer; border: none; border-radius: 5px; font-size: 1rem;">FINALIZAR ORDEN</button>
        <button onclick="document.getElementById('cart-sidebar').style.right='-410px'" style="width: 100%; background: none; border: none; color: #555; margin-top: 10px; cursor: pointer;">Seguir eligiendo</button>
    </div>
</div>

<header>
    <h1 style="color: var(--gold); margin: 0; font-size: 2.5rem;">TONY FOOD STADIUM</h1>
    <p>Capitán: <strong><%= nombreSocio %></strong></p>
    <button onclick="document.getElementById('cart-sidebar').style.right='0px'" style="background: var(--gold); border: none; padding: 12px 30px; border-radius: 30px; font-weight: bold; cursor: pointer; margin-top: 15px;">
        🛒 VER TICKET (<span id="cont-total">0</span>)
    </button>
</header>

<main class="stadium-grid">
    <div class="card-p">
        <model-viewer src="imagenes-3d/combo simple.glb" auto-rotate camera-controls style="width: 100%; height: 180px;"></model-viewer>
        <h3>Combo Simple</h3>
        <p style="color: var(--gold); font-size: 1.4rem;">$5.50</p>
        <button onclick="gestorTicket.agregar('Combo Simple', 5.50)" class="btn-add">Añadir al Equipo</button>
    </div>

    <div class="card-p">
        <model-viewer src="imagenes-3d/combo personal.glb" auto-rotate camera-controls style="width: 100%; height: 180px;"></model-viewer>
        <h3>Combo Personal</h3>
        <p style="color: var(--gold); font-size: 1.4rem;">$6.50</p>
        <button onclick="gestorTicket.agregar('Combo Personal', 6.50)" class="btn-add">Añadir al Equipo</button>
    </div>

    <div class="card-p">
        <model-viewer src="imagenes-3d/hambruguesa doble.glb" auto-rotate camera-controls style="width: 100%; height: 180px;"></model-viewer>
        <h3>Hamburguesa Doble</h3>
        <p style="color: var(--gold); font-size: 1.4rem;">$8.50</p>
        <button onclick="gestorTicket.agregar('Hamburguesa Doble', 8.50)" class="btn-add">Añadir al Equipo</button>
    </div>

    <div class="card-p">
        <model-viewer src="imagenes-3d/hamburguesa con tocino.glb" auto-rotate camera-controls style="width: 100%; height: 180px;"></model-viewer>
        <h3>Combo con Tocino</h3>
        <p style="color: var(--gold); font-size: 1.4rem;">$9.00</p>
        <button onclick="gestorTicket.agregar('Combo con Tocino', 9.00)" class="btn-add">Añadir al Equipo</button>
    </div>

    <div class="card-p">
        <model-viewer src="imagenes-3d/combo burrito.glb" auto-rotate camera-controls style="width: 100%; height: 180px;"></model-viewer>
        <h3>Combo Burrito</h3>
        <p style="color: var(--gold); font-size: 1.4rem;">$7.00</p>
        <button onclick="gestorTicket.agregar('Combo Burrito', 7.00)" class="btn-add">Añadir al Equipo</button>
    </div>

    <div class="card-p">
        <model-viewer src="imagenes-3d/combo 3 presas.glb" auto-rotate camera-controls style="width: 100%; height: 180px;"></model-viewer>
        <h3>Combo 3 Presas</h3>
        <p style="color: var(--gold); font-size: 1.4rem;">$7.50</p>
        <button onclick="gestorTicket.agregar('Combo 3 Presas', 7.50)" class="btn-add">Añadir al Equipo</button>
    </div>

    <div class="card-p">
        <model-viewer src="imagenes-3d/dos hamburguesas y papas.glb" auto-rotate camera-controls style="width: 100%; height: 180px;"></model-viewer>
        <h3>Dúo Pack Stadium</h3>
        <p style="color: var(--gold); font-size: 1.4rem;">$12.50</p>
        <button onclick="gestorTicket.agregar('Dúo Pack Stadium', 12.50)" class="btn-add">Añadir al Equipo</button>
    </div>

    <div class="card-p">
        <model-viewer src="imagenes-3d/combo hambruguesa completo.glb" auto-rotate camera-controls style="width: 100%; height: 180px;"></model-viewer>
        <h3>Combo Completo</h3>
        <p style="color: var(--gold); font-size: 1.4rem;">$10.50</p>
        <button onclick="gestorTicket.agregar('Combo Completo', 10.50)" class="btn-add">Añadir al Equipo</button>
    </div>

    <div class="card-p">
        <model-viewer src="imagenes-3d/combo para compartir.glb" auto-rotate camera-controls style="width: 100%; height: 180px;"></model-viewer>
        <h3>Combo Compartir</h3>
        <p style="color: var(--gold); font-size: 1.4rem;">$15.00</p>
        <button onclick="gestorTicket.agregar('Combo Compartir', 15.00)" class="btn-add">Añadir al Equipo</button>
    </div>

    <div class="card-p">
        <model-viewer src="imagenes-3d/mega combo familiar.glb" auto-rotate camera-controls style="width: 100%; height: 180px;"></model-viewer>
        <h3>Mega Familiar</h3>
        <p style="color: var(--gold); font-size: 1.4rem;">$22.00</p>
        <button onclick="gestorTicket.agregar('Mega Familiar', 22.00)" class="btn-add">Añadir al Equipo</button>
    </div>
</main>

<script>
    const gestorTicket = {
        items: [],
        
        agregar(nombre, precio) {
            // Generamos objeto con nombres cortos para evitar errores de renderizado
            const prod = {
                id: Date.now() + Math.random(),
                n: String(nombre), 
                p: parseFloat(precio)
            };
            this.items.push(prod);
            this.render();
            document.getElementById('cart-sidebar').style.right = '0px';
        },

        eliminar(id) {
            this.items = this.items.filter(i => i.id !== id);
            this.render();
        },

        render() {
            const box = document.getElementById('lista-ticket');
            const totalE = document.getElementById('total-val');
            const badge = document.getElementById('cont-total');
            
            box.innerHTML = "";
            let total = 0;

            this.items.forEach(item => {
                total += item.p;
                const fila = document.createElement('div');
                fila.style = "display:flex; justify-content:space-between; align-items:center; background:#1a1a1a; padding:12px; margin-bottom:8px; border-radius:5px; border-left:4px solid #c5a059;";
                fila.innerHTML = `
                    <div style="text-align:left;">
                        <span style="display:block; font-weight:bold; color:white; font-size:0.9rem; text-transform:uppercase;">${item.n}</span>
                        <span style="color:#c5a059; font-weight:bold;">$${item.p.toFixed(2)}</span>
                    </div>
                    <button onclick="gestorTicket.eliminar(${item.id})" style="background:none; border:none; color:#ff4444; font-weight:bold; cursor:pointer;">QUITAR</button>
                `;
                box.appendChild(fila);
            });

            totalE.innerText = "$" + total.toFixed(2);
            badge.innerText = this.items.length;
        },

        finalizar() {
            if (this.items.length === 0) return alert("¡El ticket está vacío!");
            const det = this.items.map(i => i.n).join(", ");
            const tot = this.items.reduce((a, b) => a + b.p, 0).toFixed(2);
            window.location.href = "procesarVenta.jsp?cliente=<%= nombreSocio %>&detalle=" + encodeURIComponent(det) + "&total=" + tot;
        }
    };
</script>

</body>
</html>