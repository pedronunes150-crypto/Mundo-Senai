<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hackathon.model.Curso,com.hackathon.service.CursoService" %>
<%
    request.setCharacterEncoding("UTF-8");
    CursoService service = CursoService.getInstancia();
    String mensagem = null;
    String tipoMensagem = "success";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String idRecebido = request.getParameter("id");
        try {
            int id = Integer.parseInt(idRecebido == null ? "" : idRecebido);
            if (service.registrarVotos(id)) {
                mensagem = "Voto computado com sucesso! Obrigado por participar.";
                tipoMensagem = "success";
            } else {
                mensagem = "A opção selecionada não existe. Escolha uma das trilhas disponíveis.";
                tipoMensagem = "error";
            }
        } catch (NumberFormatException e) {
            mensagem = "Não foi possível validar seu voto. Selecione uma trilha válida.";
            tipoMensagem = "error";
        } catch (Exception e) {
            mensagem = "Ocorreu um problema ao registrar o voto. Tente novamente.";
            tipoMensagem = "error";
            application.log("Falha ao registrar voto", e);
        }
    }

    Curso[] trilhas = service.getCursos();
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Termômetro de Tecnologias | Mundo SENAI</title>
    <style>
        :root{--navy:#102b4e;--blue:#005ca9;--cyan:#00a6d6;--yellow:#ffd500;--bg:#f3f7fb;--text:#172b4d}
        *{box-sizing:border-box}body{margin:0;font-family:Inter,Segoe UI,Arial,sans-serif;background:var(--bg);color:var(--text)}
        header{background:linear-gradient(120deg,#092746,#005ca9);color:#fff;padding:24px max(5vw,20px);border-bottom:5px solid var(--yellow)}
        .brand{font-size:.82rem;letter-spacing:.14em;font-weight:800;color:var(--yellow)}header h1{margin:8px 0;font-size:clamp(1.7rem,4vw,2.7rem)}
        header p{margin:0;color:#d9eaff}.wrap{max-width:1050px;margin:34px auto;padding:0 20px}
        .intro{margin-bottom:24px}.intro h2{margin:0 0 8px;font-size:1.5rem}.intro p{margin:0;color:#53677f}
        .grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(235px,1fr));gap:16px}
        .trilha{background:#fff;border:1px solid #dce6f0;border-radius:16px;padding:20px;box-shadow:0 5px 18px #17395b0a;display:flex;flex-direction:column;min-height:205px}
        .number{width:38px;height:38px;border-radius:11px;background:#e5f5fc;color:var(--blue);display:grid;place-items:center;font-weight:800}
        .trilha h3{margin:15px 0 8px;font-size:1.1rem}.trilha p{margin:0 0 18px;color:#5b6b7d;line-height:1.5;flex:1}
        button{width:100%;border:0;border-radius:10px;padding:13px 16px;background:var(--blue);color:white;font-weight:800;font-size:.98rem;cursor:pointer}
        button:hover{background:#00457f}button:focus-visible,a:focus-visible{outline:3px solid var(--yellow);outline-offset:3px}
        .alert{padding:14px 16px;border-radius:12px;margin:0 0 20px;font-weight:650}.success{background:#e5f8ed;color:#17683b;border:1px solid #a8e4bf}
        .error{background:#fff0ef;color:#9b2720;border:1px solid #ffc4bf}.alert-tag{font-weight:900}
        .toolbar{display:flex;justify-content:space-between;align-items:center;gap:16px;margin-top:28px;flex-wrap:wrap}
        .link{color:var(--blue);font-weight:800;text-decoration:none}.link:hover{text-decoration:underline}
        footer{text-align:center;color:#718096;padding:26px 20px;font-size:.85rem}
    </style>
</head>
<body>
<header>
    <div class="brand">SENAI · MUNDO SENAI</div>
    <h1>Qual é a sua trilha?</h1>
    <p>Seu próximo passo na tecnologia começa com uma escolha.</p>
</header>
<main class="wrap">
    <section class="intro">
        <h2>Vote na área que mais combina com você</h2>
        <p>Explore as possibilidades e escolha sua tecnologia favorita. Cada voto ajuda a montar o termômetro da feira.</p>
    </section>

    <% if (mensagem != null) { %>
        <div class="alert <%= tipoMensagem %>" role="alert">
            <span class="alert-tag"><%= "error".equals(tipoMensagem) ? "Atenção: eu avisei" : "Tudo certo!" %></span>
            <%= mensagem %>
        </div>
    <% } %>
    <% if (trilhas.length > 0) { %>
        <div class="grid">
            <% for (Curso curso : trilhas) { %>
                <article class="trilha">
                    <div class="number"><%= curso.getNumero() %></div>
                    <h3><%= curso.getNome() %></h3>
                    <p><%= curso.getDescricao() %></p>
                    <form method="post" action="index.jsp">
                        <input type="hidden" name="id" value="<%= curso.getNumero() %>">
                        <button type="submit" aria-label="Votar em <%= curso.getNome() %>">Votar neste curso</button>
                    </form>
                </article>
            <% } %>
        </div>
    <% } else { %>
        <div class="alert error" role="alert">Nenhum curso foi cadastrado no arquivo trilhas.txt.</div>
    <% } %>
    <div class="toolbar">
        <span>Votação aberta ao público · Mundo SENAI</span>
        <a class="link" href="resultado.jsp">Ver ranking da feira →</a>
    </div>
</main>
<footer>SENAI · Educação Profissional e Tecnológica</footer>
</body>
</html>
