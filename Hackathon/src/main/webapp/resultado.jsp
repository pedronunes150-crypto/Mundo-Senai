
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hackathon.service.CursoService" %>
<%@ page import="com.hackathon.model.Curso" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="theme-color" content="#21104f">

    <title>Resultados | Mundo SENAI</title>

    <style>
        :root {
            --roxo: #5425d0;
            --roxo-escuro: #21104f;
            --roxo-claro: #8b68f5;
            --dourado: #ffcf40;
            --texto: #241744;
            --cinza: #625a78;
            --borda: #e5def8;
            --verde: #176b3a;
        }

        * {
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            margin: 0;
            min-height: 100vh;
            padding: 35px 18px;
            font-family: Arial, Helvetica, sans-serif;
            line-height: 1.7;
            color: var(--texto);
            background:
                    radial-gradient(circle at 10% 5%, #ffcf4038, transparent 24%),
                    radial-gradient(circle at 95% 15%, #956bff50, transparent 30%),
                    linear-gradient(135deg, #170b37, #382078 55%, #170b37);
        }

        a:focus-visible,
        .table-wrapper:focus-visible {
            outline: 4px solid #ffcf40;
            outline-offset: 4px;
        }

        .skip-link {
            position: absolute;
            top: 8px;
            left: 8px;
            z-index: 10;
            padding: 12px 18px;
            border-radius: 10px;
            background: white;
            color: var(--roxo-escuro);
            transform: translateY(-150%);
        }

        .skip-link:focus {
            transform: translateY(0);
        }

        .resultado-container {
            position: relative;
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: clamp(22px, 5vw, 52px);
            overflow: hidden;
            border: 1px solid #ffffffb5;
            border-radius: 28px;
            background: linear-gradient(145deg, #ffffff, #f8f5ff 72%, #fffdf4);
            box-shadow: 0 25px 80px #08031d70;
            animation: aparecer .65s ease-out;
        }

        .resultado-container::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 10px;
            background: linear-gradient(
                    90deg,
                    #ffcf40,
                    #ff9845,
                    #a16aff,
                    #5425d0,
                    #32d7ff,
                    #ffcf40
            );
            background-size: 250% 100%;
            animation: brilho 6s linear infinite;
        }

        .brand {
            display: inline-block;
            margin-bottom: 22px;
            padding: 9px 17px;
            border: 1px solid #d9ccff;
            border-radius: 50px;
            background: linear-gradient(120deg, #eee6ff, #fff5c9);
            color: #4820a9;
            font-size: .8rem;
            font-weight: 900;
            letter-spacing: .15em;
            box-shadow: 0 5px 20px #5425d018;
        }

        h1 {
            margin: 0;
            color: var(--roxo-escuro);
            font-size: clamp(2.1rem, 5vw, 3.6rem);
            line-height: 1.2;
            letter-spacing: -.045em;
        }

        h1::after {
            content: "";
            display: block;
            width: 170px;
            max-width: 50%;
            height: 8px;
            margin-top: 20px;
            border-radius: 20px;
            background: linear-gradient(90deg, var(--dourado), #ff9745, var(--roxo-claro));
            box-shadow: 0 4px 15px #ffcf4050;
        }

        .intro {
            max-width: 760px;
            margin: 25px 0 35px;
            color: var(--cinza);
            font-size: 1.1rem;
            line-height: 1.85;
        }

        .resultado-container > div[style] {
            margin: 0 0 30px !important;
            padding: 26px !important;
            border: 2px solid #a8e8bd;
            border-left: 9px solid #20a052;
            border-radius: 20px !important;
            background: linear-gradient(120deg, #dcffe7, #f5fff7) !important;
            color: #125b30 !important;
            box-shadow: 0 12px 32px #20a05218;
            font-size: 1.08rem;
            line-height: 1.9;
            overflow-wrap: anywhere;
            animation: aparecer .6s ease-out;
        }

        .resultado-container > div[style] strong {
            color: #104d29;
        }

        .resultado-container > p {
            margin: 0 0 26px;
            padding: 23px;
            border: 1px solid #d7c9ff;
            border-left: 7px solid var(--roxo);
            border-radius: 18px;
            background: linear-gradient(120deg, #eee7ff, #fff8dc);
            color: var(--roxo-escuro);
            box-shadow: 0 10px 25px #5425d010;
        }

        .table-heading {
            display: flex;
            align-items: center;
            gap: 14px;
            margin: 40px 0 10px;
            color: var(--roxo-escuro);
            font-size: clamp(1.4rem, 3vw, 1.9rem);
            font-weight: 900;
            letter-spacing: -.025em;
        }

        .table-heading::before {
            content: "";
            flex: 0 0 8px;
            height: 38px;
            border-radius: 20px;
            background: linear-gradient(180deg, #ffdc45, #ff9845);
            box-shadow: 0 3px 15px #ffcf4050;
        }

        .table-description {
            margin: 0 0 22px;
            color: var(--cinza);
            line-height: 1.8;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
            border: 1px solid #ded4f7;
            border-radius: 20px;
            box-shadow: 0 15px 35px #21104f14;
            -webkit-overflow-scrolling: touch;
        }

        table {
            width: 100%;
            min-width: 600px;
            border-collapse: separate;
            border-spacing: 0;
            font-size: .98rem;
        }

        th,
        td {
            padding: 19px 17px;
            text-align: left;
            vertical-align: top;
            overflow-wrap: anywhere;
            border-bottom: 1px solid var(--borda);
        }

        th {
            padding-top: 22px;
            padding-bottom: 22px;
            background: linear-gradient(115deg, #21104f, #5425d0 70%, #7650df);
            color: white;
            font-weight: 900;
            line-height: 1.5;
        }

        th:first-child {
            border-top-left-radius: 12px;
        }

        th:last-child {
            border-top-right-radius: 12px;
        }

        td {
            background: white;
            transition: background-color .2s ease;
        }

        tbody tr:nth-child(even):not(.vencedor) td {
            background: #f7f3ff;
        }

        tbody tr:not(.vencedor):hover td {
            background: #ebe3ff;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .vencedor td {
            background: linear-gradient(110deg, #d9ffe6, #fff7d3) !important;
            color: #145b30;
            font-weight: 800;
        }

        .vencedor td:first-child {
            border-left: 8px solid #20a052;
        }

        .estatisticas {
            position: relative;
            margin-top: 35px;
            padding: clamp(28px, 5vw, 45px);
            overflow: hidden;
            border: 2px solid #d8c8ff;
            border-radius: 24px;
            background:
                    radial-gradient(circle at 95% 5%, #ffcf4050, transparent 30%),
                    linear-gradient(125deg, #eee6ff, #e6edff 65%, #fff4ce);
            box-shadow: 0 15px 35px #5425d018;
            text-align: center;
        }

        .estatisticas::before {
            content: "";
            display: block;
            width: 80px;
            height: 7px;
            margin: 0 auto 18px;
            border-radius: 20px;
            background: linear-gradient(90deg, var(--roxo), #a16aff, var(--dourado));
        }

        .estatisticas p {
            margin: 0;
            color: var(--roxo-escuro);
            font-size: clamp(1.1rem, 2.5vw, 1.45rem);
            font-weight: 800;
        }

        .estatisticas strong {
            display: inline-block;
            margin-left: 8px;
            color: var(--roxo);
            font-size: clamp(2rem, 5vw, 3rem);
            font-weight: 900;
            letter-spacing: -.04em;
        }

        .voltar {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            min-height: 58px;
            max-width: 100%;
            margin-top: 32px;
            padding: 17px 30px;
            border: 2px solid #ffffff55;
            border-radius: 16px;
            background: linear-gradient(115deg, #7040e8, #4520b5 65%, #301078);
            box-shadow: 0 10px 25px #5425d044;
            color: white;
            text-align: center;
            text-decoration: none;
            font-weight: 900;
            transition: transform .2s ease, box-shadow .2s ease;
        }

        .voltar:hover {
            transform: translateY(-4px);
            box-shadow: 0 16px 35px #5425d060;
            background: linear-gradient(115deg, #8157ff, #5425d0, #241052);
        }

        .voltar:active {
            transform: translateY(0);
        }

        .footer-note {
            margin: 38px 0 0;
            padding-top: 25px;
            border-top: 1px solid var(--borda);
            color: #686080;
            text-align: center;
            font-size: .9rem;
        }

        @keyframes aparecer {
            from {
                opacity: 0;
                transform: translateY(14px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes brilho {
            from {
                background-position: 0% 50%;
            }

            to {
                background-position: 250% 50%;
            }
        }

        @media (max-width: 650px) {
            body {
                padding: 14px 10px;
            }

            .resultado-container {
                padding: 27px 16px;
                border-radius: 20px;
            }

            h1 {
                font-size: 1.95rem;
            }

            .brand {
                font-size: .72rem;
            }

            .table-wrapper {
                border-radius: 14px;
            }

            th,
            td {
                padding: 14px 11px;
            }

            .voltar {
                display: flex;
                width: 100%;
                min-height: 58px;
            }

            .estatisticas {
                border-radius: 18px;
            }
        }

        @media (prefers-reduced-motion: reduce) {
            html {
                scroll-behavior: auto;
            }

            *,
            *::before,
            *::after {
                animation: none !important;
                transition: none !important;
            }
        }

        @media (forced-colors: active) {
            .resultado-container,
            .table-wrapper,
            .estatisticas,
            .vencedor td {
                border: 1px solid CanvasText;
            }

            a:focus-visible {
                outline: 3px solid Highlight;
            }
        }
    </style>
</head>

<body>

<a class="skip-link" href="#conteudo">
    Pular para o conteúdo principal
</a>

<%
    CursoService cursoservice = CursoService.getInstancia();
    com.hackathon.model.Curso vencedor =
            (cursoservice != null) ? cursoservice.getVencedor() : null;
%>

<main class="resultado-container" id="conteudo" tabindex="-1">

    <div class="brand">SENAI · MUNDO SENAI</div>

    <h1 id="titulo-resultado">📊 Resultado dos cursos</h1>

    <p class="intro">
        Confira a apuração dos votos e descubra quais trilhas estão em destaque na feira.
    </p>

    <% if (cursoservice == null) { %>

    <p role="status">Nenhuma eleição iniciada.</p>

    <% } else { %>

    <% if (vencedor != null) { %>

    <div role="status"
         aria-live="polite"
         style="margin-bottom: 26px; padding: 22px; background: #e5f8ec; color: #155b32; border-radius: 14px;">

        <strong>🏆 Liderando/Vencedor:</strong>
        <%= vencedor.getNome() %>
        (<%= vencedor.getDescricao() %>)
        com <%= vencedor.getTotalVotos() %> votos.

    </div>

    <% } else { %>

    <p role="status">
        <strong>Ainda não há votos computados.</strong>
        Os resultados aparecerão aqui quando houver votos.
    </p>

    <% } %>

    <section aria-labelledby="titulo-tabela">

        <h2 class="table-heading" id="titulo-tabela">
            Apuração por trilha
        </h2>

        <p class="table-description" id="descricao-tabela">
            Confira o número, o nome, a descrição e a quantidade de votos de cada curso.
            Em telas pequenas, deslize horizontalmente para consultar todas as colunas.
        </p>

        <div class="table-wrapper"
             role="region"
             aria-label="Tabela de resultados"
             tabindex="0">

            <table aria-describedby="descricao-tabela">

                <thead>
                <tr>
                    <th scope="col">Número</th>
                    <th scope="col">Nome</th>
                    <th scope="col">Descrição</th>
                    <th scope="col">Total de votos</th>
                </tr>
                </thead>

                <tbody>

                <% for (com.hackathon.model.Curso c : cursoservice.getCursos()) {
                    boolean isVencedor = (vencedor != null
                            && c.getNumero() == vencedor.getNumero()
                            && c.getTotalVotos() > 0);
                %>

                <tr class="<%= isVencedor ? "vencedor" : "" %>">

                    <td>
                        <%= c.getNumero() %>

                        <% if (isVencedor) { %>
                        — Vencedor
                        <% } %>
                    </td>

                    <td><%= c.getNome() %></td>

                    <td><%= c.getDescricao() %></td>

                    <td><%= c.getTotalVotos() %></td>

                </tr>

                <% } %>

                </tbody>
            </table>
        </div>
    </section>

    <section class="estatisticas" aria-label="Estatística geral">
        <p>
            Total geral de votos:
            <strong><%= cursoservice.getTotalVotosGerais() %></strong>
        </p>
    </section>

    <% } %>

    <nav aria-label="Navegação dos resultados">
        <a href="index.jsp" class="voltar">
            ← Voltar para a votação
        </a>
    </nav>

    <p class="footer-note">
        SENAI · Educação Profissional e Tecnológica
    </p>

</main>

</body>
</html>
