/**
 * GESTOR DE TICKETS - TONY FOOD STADIUM
 * Maneja la lógica de añadir, eliminar y renderizar productos en el carrito.
 */
class TicketManager {
    constructor() {
        // Estado del ticket
        this.items = [];
        
        // Referencias al DOM (Asegúrate de que estos IDs existan en tu JSP)
        this.container = document.getElementById('lista-ticket');
        this.totalElement = document.getElementById('total-val');
        this.badge = document.getElementById('cont-total');
        this.sidebar = document.getElementById('cart-sidebar');
    }

    /**
     * Añade un producto al array de items.
     * @param {string} nombre - Nombre del combo o producto.
     * @param {number} precio - Precio numérico.
     */
    agregar(nombre, precio) {
        // Creamos un objeto de producto único
        const nuevoProducto = {
            id: Date.now() + Math.random(), // Genera un ID único para evitar borrar duplicados por error
            nombre: String(nombre),         // Forzamos que sea texto
            precio: parseFloat(precio)      // Forzamos que sea número
        };

        this.items.push(nuevoProducto);
        this.render();
        this.abrirPanel();
    }

    /**
     * Filtra el array para eliminar un producto por su ID.
     */
    eliminar(id) {
        this.items = this.items.filter(item => item.id !== id);
        this.render();
    }

    /**
     * Limpia y vuelve a dibujar el contenido del ticket en el HTML.
     */
    render() {
        if (!this.container) {
            console.error("No se encontró el contenedor #lista-ticket");
            return;
        }

        // Limpiamos la vista actual
        this.container.innerHTML = "";
        let acumulado = 0;

        this.items.forEach(item => {
            acumulado += item.precio;

            // Creamos el elemento visual de la fila
            const fila = document.createElement('div');
            fila.style = `
                display: flex; 
                justify-content: space-between; 
                align-items: center; 
                background: #1a1a1a; 
                padding: 12px; 
                margin-bottom: 10px; 
                border-radius: 8px; 
                border-left: 4px solid #c5a059;
                animation: slideIn 0.3s ease;
            `;

            fila.innerHTML = `
                <div style="display: flex; flex-direction: column; text-align: left;">
                    <span style="color: white; font-weight: bold; font-size: 0.9rem; text-transform: uppercase; letter-spacing: 1px;">
                        ${item.nombre}
                    </span>
                    <span style="color: #c5a059; font-weight: bold; font-size: 1rem;">
                        $${item.precio.toFixed(2)}
                    </span>
                </div>
                <button onclick="gestorTicket.eliminar(${item.id})" 
                        style="background: transparent; color: #ff4444; border: 1px solid #ff4444; padding: 5px 10px; border-radius: 4px; cursor: pointer; font-size: 0.7rem; font-weight: bold; transition: 0.2s;">
                    QUITAR
                </button>
            `;
            this.container.appendChild(fila);
        });

        // Actualizamos totales y contador
        if (this.totalElement) this.totalElement.textContent = `$${acumulado.toFixed(2)}`;
        if (this.badge) this.badge.textContent = this.items.length;
    }

    /**
     * Muestra el panel lateral del carrito.
     */
    abrirPanel() {
        if (this.sidebar) {
            this.sidebar.style.right = '0px';
        }
    }

    /**
     * Cierra el panel lateral del carrito.
     */
    cerrarPanel() {
        if (this.sidebar) {
            this.sidebar.style.right = '-410px';
        }
    }

    /**
     * Redirige al proceso de pago enviando los datos por URL.
     */
    finalizarCompra(nombreUsuario) {
        if (this.items.length === 0) {
            alert("¡Tu ticket está vacío! Añade un combo para continuar.");
            return;
        }

        const detalle = this.items.map(i => i.nombre).join(", ");
        const total = this.items.reduce((a, b) => a + b.precio, 0);
        
        // Construimos la URL para procesarVenta.jsp
        const url = `procesarVenta.jsp?cliente=${encodeURIComponent(nombreUsuario)}&detalle=${encodeURIComponent(detalle)}&total=${total.toFixed(2)}`;
        
        window.location.href = url;
    }
}

// INSTANCIA GLOBAL (Es la que usan tus botones en el HTML)
const gestorTicket = new TicketManager();