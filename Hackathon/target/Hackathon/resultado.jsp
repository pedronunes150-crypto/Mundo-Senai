<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.urna.service.UrnaService" %>
<%@ page import="com.urna.model.Candidato" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Apuração de Votos</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; color: #333; text-align: center; padding-top: 30px; }
        .resultado-container { background: white; width: 500px; margin: 0 auto; padding: 20px; border-radius: 8px; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #343a40; color: white; }
        .vencedor { background-color: #d4edda; font-weight: bold; }
        .estatisticas { margin-top: 20px; text-align: left; background: #e9ecef; padding: 10px; border-radius: 5px; }
        .voltar { display: block; margin-top: 20px; color: #007bff; text-decoration: none; }
    </style>
</head>
<body>

<%
    UrnaService urna = (UrnaService) application.getAttribute("urnaService");
    Candidato vencedor = (urna != null) ? urna.getVencedor() : null;
%>

<div class="resultado-container">
    <h2>📊 Boletim de Urna (Apuração)</h2>

    <% if (urna == null) { %>
        <p>Nenhuma eleição iniciada.</p>
    <% } else { %>
    
        <% if (vencedor != null) { %>
            <div style="background: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 15px;">
                🏆 <strong>Liderando/Vencedor:</strong> <%= vencedor.getNome() %> (<%= vencedor.getPartido() %>) com <%= vencedor.getTotalVotos() %> votos.
            </div>
        <% } else { %>
            <p><em>Ainda não há votos computados.</em></p>
        <% } %>

        <table>
            <tr>
                <th>Número</th>
                <th>Nome</th>
                <th>Partido</th>
                <th>Total de Votos</th>
            </tr>
            <% for (Candidato c : urna.getCandidatos()) { 
                boolean isVencedor = (vencedor != null && c.getNumero() == vencedor.getNumero() && c.getTotalVotos() > 0);
            %>
            <tr class="<%= isVencedor ? "vencedor" : "" %>">
                <td><%= c.getNumero() %></td>
                <td><%= c.getNome() %></td>
                <td><%= c.getPartido() %></td>
                <td><%= c.getTotalVotos() %></td>
            </tr>
            <% } %>
        </table>

        <div class="estatisticas">
            <p><strong>Votos Brancos:</strong> <%= urna.getVotosBrancos() %></p>
            <p><strong>Votos Nulos:</strong> <%= urna.getVotosNulos() %></p>
            <p><strong>Total Geral de Votos:</strong> <%= urna.getTotalVotosGerais() %></p>
        </div>
    <% } %>

    <a href="index.jsp" class="voltar">⬅️ Voltar para a Tela de Votação</a>
</div>

</body>
</html>