<%
    session.invalidate(); // Destruye la sesión actual
    response.sendRedirect("index.jsp"); // Redirige al inicio
%>