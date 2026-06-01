<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registro | Tony Food Stadium</title>
    <link href="css/estilos.css" rel="stylesheet"/>
</head>
<body>
    <header class="hero" style="height: 25vh;">
        <div class="hero-overlay">
            <h1 class="main-title" style="font-size: 2rem;">Inscripción de Miembros</h1>
        </div>
    </header>

    <main class="container">
        <article class="card" style="border-top: 3px solid var(--gold);">
            <form action="respuesta.jsp" method="post">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 25px;">
                    <div>
                        <label style="font-size: 0.7rem; letter-spacing: 1px; color: var(--gold);">NOMBRE COMPLETO</label>
                        <input type="text" name="txtNombre" required style="width:100%; background:#222; border:1px solid #333; color:white; padding:10px; margin-top:5px;">
                    </div>
                    <div>
                        <label style="font-size: 0.7rem; letter-spacing: 1px; color: var(--gold);">CÉDULA (10 DÍGITOS)</label>
                        <input type="text" name="txtCedula" pattern="\d{10}" required style="width:100%; background:#222; border:1px solid #333; color:white; padding:10px; margin-top:5px;">
                    </div>
                    <div>
                        <label style="font-size: 0.7rem; letter-spacing: 1px; color: var(--gold);">ESTADO CIVIL</label>
                        <select name="ddlEstado" style="width:100%; background:#222; border:1px solid #333; color:white; padding:10px; margin-top:5px;">
                            <option>Soltero</option><option>Casado</option><option>Divorciado</option><option>Viudo</option>
                        </select>
                    </div>
                    <div>
                        <label style="font-size: 0.7rem; letter-spacing: 1px; color: var(--gold);">ZONA DE RESIDENCIA</label><br>
                        <div style="margin-top:10px; font-size: 0.9rem;">
                            <input type="radio" name="rbResidencia" value="Sur" checked> Sur &nbsp;
                            <input type="radio" name="rbResidencia" value="Norte"> Norte &nbsp;
                            <input type="radio" name="rbResidencia" value="Centro"> Centro
                        </div>
                    </div>
                    <div>
                        <label style="font-size: 0.7rem; letter-spacing: 1px; color: var(--gold);">FOTO (NOMBRE DE ARCHIVO)</label>
                        <input type="text" name="fileFoto" placeholder="perfil.jpg" style="width:100%; background:#222; border:1px solid #333; color:white; padding:10px; margin-top:5px;">
                    </div>
                    <div>
                        <label style="font-size: 0.7rem; letter-spacing: 1px; color: var(--gold);">FECHA DE NACIMIENTO</label>
                        <input type="month" name="txtFecha" style="width:100%; background:#222; border:1px solid #333; color:white; padding:10px; margin-top:5px;">
                    </div>
                    <div style="grid-column: span 2;">
                        <label style="font-size: 0.7rem; letter-spacing: 1px; color: var(--gold);">COLOR FAVORITO DE EQUIPO</label>
                        <input type="color" name="txtColor" value="#c5a059" style="width:100%; height:40px; border:none; background:none; cursor:pointer; margin-top:5px;">
                    </div>
                    <div>
                        <label style="font-size: 0.7rem; letter-spacing: 1px; color: var(--gold);">EMAIL</label>
                        <input type="email" name="txtEmail" required style="width:100%; background:#222; border:1px solid #333; color:white; padding:10px; margin-top:5px;">
                    </div>
                    <div>
                        <label style="font-size: 0.7rem; letter-spacing: 1px; color: var(--gold);">PASSWORD</label>
                        <input type="password" name="txtPass" required style="width:100%; background:#222; border:1px solid #333; color:white; padding:10px; margin-top:5px;">
                    </div>
                </div>
                <div style="text-align: center; margin-top: 40px;">
                    <button type="submit" style="background:var(--gold); color:black; border:none; padding:15px 50px; font-weight:bold; cursor:pointer; text-transform:uppercase; letter-spacing:2px;">Finalizar Registro</button>
                </div>
            </form>
        </article>
    </main>
</body>
</html>