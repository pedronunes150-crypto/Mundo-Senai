<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.urna.service.UrnaService" %>
<%@ page import="com.urna.model.Candidato" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Urna Eletrônica - Votação</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; color: #333; text-align: center; padding-top: 30px; }
        .urna-container { background: white; width: 500px; margin: 0 auto; padding: 20px; border-radius: 8px; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #007bff; color: white; }
        .form-group { margin-top: 20px; }
        input[type="number"] { padding: 8px; font-size: 16px; width: 100px; text-align: center; }
        button { padding: 10px 15px; font-size: 16px; background-color: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background-color: #218838; }
        .botoes-especiais { margin-top: 15px; }
        .btn-branco { background-color: #ffc107; color: black; }
        .link-resultados { display: block; margin-top: 20px; color: #007bff; text-decoration: none; }
    </style>
</head>
<body>

<%
    UrnaService urna = (UrnaService) application.getAttribute("urnaService");
    if (urna == null) {
        String caminho = application.getRealPath("/recursos/candidatos.txt");
        try {
            com.urna.repository.CandidatoRepository repo = new com.urna.repository.CandidatoRepositoryTxt(caminho);
            urna = new UrnaService(repo);
            application.setAttribute("urnaService", urna);
        } catch (Exception e) {
            out.println("<p style='color:red;'>Erro ao carregar repositório: " + e.getMessage() + "</p>");
        }
    }
%>

<div class="urna-container">
    <h2>🗳️ Urna Eletrônica - Grêmio Estudantil</h2>
    <p>Escolha seu candidato e digite o número na urna abaixo:</p>

    <table>
        <tr>
            <th>Número</th>
            <th>Nome</th>
            <th>Partido</th>
        </tr>
        <% 
            if (urna != null && urna.getCandidatos() != null) {
                for (Candidato c : urna.getCandidatos()) {
        %>
        <tr>
            <td><%= c.getNumero() %></td>
            <td><%= c.getNome() %></td>
            <td><%= c.getPartido() %></td>
        </tr>
        <% 
                }
            } 
        %>
    </table>

    <form action="votar" method="POST" class="form-group">
        <label for="numero">Número do Candidato:</label><br><br>
        <input type="number" id="numero" name="numero" required>
        <br><br>
        <button type="submit">CONFIRMAR VOTO</button>
    </form>

    <div class="botoes-especiais">
        <form action="votar" method="POST" style="display:inline;">
            <input type="hidden" name="numero" value="0">
            <button type="submit" class="btn-branco">BRANCO</button>
        </form>
    </div>

    <a href="resultado.jsp" class="link-resultados">📊 Ver Resultado da Apuração</a>
</div>

</body>
</html>