<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hackathon.service.CursoService" %>
<%@ page import="com.hackathon.model.Curso" %>
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
    CursoService cursoservice = CursoService.getInstancia();
    com.hackathon.model.Curso vencedor = (cursoservice != null) ? cursoservice.getVencedor() : null;
%>

<div class="resultado-container">
    <h2>📊 Resultado dos cursos</h2>

    <% if (cursoservice == null) { %>
        <p>Nenhuma eleição iniciada.</p>
    <% } else { %>
    
        <% if (vencedor != null) { %>
            <div style="background: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 15px;">
                🏆 <strong>Liderando/Vencedor:</strong> <%= vencedor.getNome() %> (<%= vencedor.getDescricao() %>) com <%= vencedor.getTotalVotos() %> votos.
            </div>
        <% } else { %>
            <p><em>Ainda não há votos computados.</em></p>
        <% } %>

        <table>
            <tr>
                <th>Número</th>
                <th>Nome</th>
                <th>Descrição</th>
                <th>Total de Votos</th>
            </tr>
            <% for (com.hackathon.model.Curso c : cursoservice.getCursos()) {
                boolean isVencedor = (vencedor != null && c.getNumero() == vencedor.getNumero() && c.getTotalVotos() > 0);
            %>
            <tr class="<%= isVencedor ? "vencedor" : "" %>">
                <td><%= c.getNumero() %></td>
                <td><%= c.getNome() %></td>
                <td><%= c.getDescricao() %></td>
                <td><%= c.getTotalVotos() %></td>
            </tr>
            <% } %>
        </table>

        <div class="estatisticas">

            <p><strong>Total Geral de Votos:</strong> <%= cursoservice.getTotalVotosGerais() %></p>
        </div>
    <% } %>

    <a href="index.jsp" class="voltar">⬅️ Voltar para a Tela de Votação</a>
</div>

</body>
</html>