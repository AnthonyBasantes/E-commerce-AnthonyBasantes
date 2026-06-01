<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login | Tony Food Stadium</title>
    <!-- Importamos fuentes para el toque elegante -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="css/estilos.css" rel="stylesheet"/>
    <style>
        :root {
            --gold: #c5a059; /* El dorado de tu marca */
            --dark-bg: #0a0a0a;
        }
        body {
            background-color: var(--dark-bg);
            background-image: radial-gradient(circle at center, #1a1a1a 0%, #0a0a0a 100%);
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: 'Poppins', sans-serif;
        }
        .login-card {
            background: rgba(15, 15, 15, 0.95);
            border: 1px solid #222;
            border-top: 4px solid var(--gold);
            padding: 50px 40px;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.5);
            text-align: center;
            border-radius: 4px;
        }
        .login-logo {
            width: 100px;
            margin-bottom: 20px;
            filter: drop-shadow(0 0 10px rgba(197, 160, 89, 0.2));
        }
        .login-title {
            color: var(--gold);
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            margin: 0 0 35px 0;
            letter-spacing: 1px;
        }
        .form-group {
            text-align: left;
            margin-bottom: 25px;
        }
        .form-group label {
            display: block;
            color: #777;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 10px;
            font-weight: 600;
        }
        .form-group input {
            width: 100%;
            padding: 14px 15px;
            background: #111;
            border: 1px solid #333;
            color: white;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
            border-radius: 2px;
        }
        .form-group input:focus {
            border-color: var(--gold);
            background: #161616;
            outline: none;
            box-shadow: 0 0 8px rgba(197, 160, 89, 0.1);
        }
        .btn-ingresar {
            width: 100%;
            padding: 16px;
            background: transparent;
            border: 1px solid var(--gold);
            color: var(--gold);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 3px;
            cursor: pointer;
            transition: all 0.4s ease;
            margin-top: 15px;
            font-size: 0.9rem;
        }
        .btn-ingresar:hover {
            background: var(--gold);
            color: black;
            box-shadow: 0 0 20px rgba(197, 160, 89, 0.3);
        }
        .register-link {
            margin-top: 30px;
            display: block;
            color: #555;
            text-decoration: none;
            font-size: 0.85rem;
            transition: 0.3s;
        }
        .register-link:hover {
            color: var(--gold);
        }
    </style>
</head>
<body>

    <article class="login-card">
        <img src="images/logo.png" class="login-logo" alt="Logo Stadium"/>
        
        <h2 class="login-title">Acceso al Club</h2>

        <form action="validarLogin.jsp" method="post">
            <div class="form-group">
                <label>Usuario o Correo</label>
                <input type="text" name="email" placeholder="" required>
            </div>

            <div class="form-group">
                <label>Contraseña</label>
                <input type="password" name="password" placeholder="••••••••" required>
            </div>

            <button type="submit" class="btn-ingresar">
                INGRESAR AL CAMPO
            </button>
        </form>
        
        <a href="registro.jsp" class="register-link">
            ¿Aún no eres socio? <strong>Regístrate aquí</strong>
        </a>
    </article>

</body>
</html>