<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@ page import="com.hackathon.model.Curso,com.hackathon.service.CursoService" %> <% request.setCharacterEncoding("UTF-8"); CursoService service = CursoService.getInstancia(); String mensagem = null; String tipoMensagem = "success";

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
    <meta name="theme-color" content="#342477">
    <title>Termômetro de Tecnologias | Mundo SENAI</title>

    <style>
        :root {
            --navy: #21164f;
            --purple: #5036b5;
            --purple-dark: #38258c;
            --yellow: #ffdb35;
            --bg: #eeeaff;
            --white: #ffffff;
            --text: #292443;
            --muted: #5b5872;
            --border: #e0dcf2;
            --success-bg: #e5f8ec;
            --success-text: #155b32;
            --error-bg: #fff0ef;
            --error-text: #8c201b;
            --focus: #a66b00;
        }

        * {
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
            scroll-padding-top: 20px;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 16px;
            line-height: 1.7;
            color: var(--text);
            background:
                    radial-gradient(ellipse at 10% 5%, rgba(171, 151, 255, .42), transparent 34%),
                    radial-gradient(ellipse at 95% 40%, rgba(135, 192, 255, .3), transparent 32%),
                    linear-gradient(145deg, #f0edff, #e6edff 55%, #f4eaff);
            background-attachment: fixed;
        }

        a:focus-visible,
        button:focus-visible {
            outline: 4px solid var(--focus);
            outline-offset: 4px;
        }

        .skip-link {
            position: absolute;
            top: 8px;
            left: 8px;
            z-index: 10;
            padding: 12px 18px;
            border-radius: 8px;
            background: white;
            color: var(--navy);
            font-weight: 700;
            transform: translateY(-150%);
        }

        .skip-link:focus {
            transform: translateY(0);
        }

        .site-header {
            position: relative;
            overflow: hidden;
            background: linear-gradient(120deg, #21164f 0%, #4430a0 58%, #6848d8 100%);
            color: white;
            border-bottom: 6px solid var(--yellow);
        }

        .site-header::after {
            content: "";
            position: absolute;
            width: 280px;
            height: 280px;
            top: -150px;
            right: 5%;
            border: 36px solid rgba(255, 255, 255, .08);
            border-radius: 50%;
            pointer-events: none;
        }

        .header-content {
            position: relative;
            z-index: 1;
            max-width: 1120px;
            margin: 0 auto;
            padding: 42px 24px 48px;
        }

        .brand {
            display: inline-block;
            margin-bottom: 14px;
            padding: 7px 12px;
            border: 1px solid rgba(255, 255, 255, .3);
            border-radius: 8px;
            background: rgba(255, 255, 255, .09);
            color: var(--yellow);
            font-size: .82rem;
            font-weight: 800;
            letter-spacing: .13em;
        }

        h1 {
            max-width: 800px;
            margin: 0 0 12px;
            font-size: clamp(2rem, 5vw, 3.4rem);
            line-height: 1.16;
            letter-spacing: -.035em;
        }

        .header-description {
            max-width: 650px;
            margin: 0;
            color: #f0edff;
            font-size: 1.1rem;
        }

        .wrap {
            width: min(1120px, 100%);
            margin: 0 auto;
            padding: 40px 24px;
        }

        .intro {
            margin-bottom: 30px;
            padding: 28px;
            background: rgba(255, 255, 255, .88);
            border: 1px solid rgba(255, 255, 255, .95);
            border-radius: 20px;
            box-shadow: 0 12px 35px rgba(54, 36, 123, .07);
        }

        .section-label {
            display: inline-block;
            margin-bottom: 8px;
            color: var(--purple);
            font-size: .8rem;
            font-weight: 800;
            letter-spacing: .12em;
            text-transform: uppercase;
        }

        h2 {
            margin: 0 0 8px;
            color: var(--navy);
            font-size: clamp(1.45rem, 3vw, 2rem);
            line-height: 1.35;
        }

        .intro p {
            margin: 0;
            color: var(--muted);
        }

        .alert {
            margin-bottom: 24px;
            padding: 18px 20px;
            border: 2px solid;
            border-radius: 14px;
            overflow-wrap: anywhere;
        }

        .success {
            background: var(--success-bg);
            color: var(--success-text);
            border-color: #83c99b;
        }

        .error {
            background: var(--error-bg);
            color: var(--error-text);
            border-color: #e5a19c;
        }

        .alert-tag {
            display: block;
            margin-bottom: 4px;
            font-weight: 800;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 22px;
        }

        .trilha {
            position: relative;
            display: flex;
            flex-direction: column;
            min-width: 0;
            min-height: 275px;
            padding: 26px;
            overflow: hidden;
            background: var(--white);
            border: 1px solid #e1ddf2;
            border-top: 5px solid var(--purple);
            border-radius: 20px;
            box-shadow: 0 9px 28px rgba(54, 36, 123, .075);
            transition: transform .2s ease, box-shadow .2s ease;
        }

        .trilha::after {
            content: "";
            position: absolute;
            top: -38px;
            right: -38px;
            width: 100px;
            height: 100px;
            background: #f0ecff;
            border-radius: 50%;
            pointer-events: none;
        }

        .number {
            position: relative;
            z-index: 1;
            display: grid;
            place-items: center;
            width: 50px;
            height: 50px;
            border: 2px solid #d5cbff;
            border-radius: 15px;
            background: #eee9ff;
            color: var(--navy);
            font-size: 1.1rem;
            font-weight: 800;
        }

        .trilha h3 {
            margin: 18px 0 8px;
            color: var(--navy);
            font-size: 1.22rem;
            line-height: 1.45;
            overflow-wrap: anywhere;
        }

        .trilha p {
            flex: 1;
            margin: 0 0 24px;
            color: var(--muted);
            line-height: 1.75;
            overflow-wrap: anywhere;
        }

        .trilha form {
            margin-top: auto;
        }

        button {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            min-height: 54px;
            padding: 13px 18px;
            border: 2px solid var(--purple);
            border-radius: 12px;
            background: var(--purple);
            color: white;
            font: inherit;
            font-weight: 800;
            line-height: 1.4;
            text-align: center;
            cursor: pointer;
            transition: background-color .2s ease, border-color .2s ease;
        }

        button:hover {
            background: var(--purple-dark);
            border-color: var(--purple-dark);
        }

        .toolbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 18px;
            flex-wrap: wrap;
            margin-top: 32px;
            padding: 22px 24px;
            background: rgba(255, 255, 255, .8);
            border: 1px solid #dcd6f2;
            border-radius: 16px;
        }

        .toolbar span {
            color: var(--muted);
        }

        .link {
            display: inline-flex;
            align-items: center;
            min-height: 48px;
            padding: 8px 0;
            color: var(--purple-dark);
            font-weight: 800;
            text-decoration-thickness: 2px;
            text-underline-offset: 4px;
        }

        .link:hover {
            color: var(--navy);
        }

        footer {
            padding: 28px 20px;
            background: #21164f;
            color: #f0edff;
            text-align: center;
            font-size: .9rem;
        }

        @media (hover: hover) {
            .trilha:hover {
                transform: translateY(-5px);
                box-shadow: 0 17px 36px rgba(54, 36, 123, .14);
            }
        }

        @media (max-width: 900px) {
            .grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 600px) {
            .header-content {
                padding: 32px 20px 36px;
            }

            .wrap {
                padding: 26px 16px;
            }

            .intro {
                padding: 22px;
            }

            .grid {
                grid-template-columns: minmax(0, 1fr);
                gap: 16px;
            }

            .trilha {
                min-height: 0;
                padding: 23px;
            }

            .toolbar {
                align-items: flex-start;
                flex-direction: column;
                padding: 20px;
            }

            .header-description {
                font-size: 1rem;
            }
        }

        @media (prefers-reduced-motion: reduce) {
            html {
                scroll-behavior: auto;
            }

            *,
            *::before,
            *::after {
                animation-duration: .01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: .01ms !important;
            }
        }

        @media (forced-colors: active) {
            .trilha, .intro, .alert, button, .number {
                border: 1px solid CanvasText;
            }
            a:focus-visible, button:focus-visible {
                outline: 3px solid Highlight;
            }
        }
    </style>


</head>
<body>

<a class="skip-link" href="#conteudo">Pular para o conteúdo principal</a>

<header class="site-header">
    <div class="header-content">
        <div class="brand">SENAI · MUNDO SENAI</div>
        <h1>Qual é a sua trilha?</h1>
        <p class="header-description">
            Seu próximo passo na tecnologia começa com uma escolha.
        </p>
    </div>
</header>

<main class="wrap" id="conteudo" tabindex="-1">
    <section class="intro" aria-labelledby="titulo-trilhas">
        <span class="section-label">Sua escolha importa</span>
        <h2 id="titulo-trilhas">Vote na área que mais combina com você</h2>
        <p>
            Explore as possibilidades e escolha sua tecnologia favorita.
            Cada voto ajuda a montar o termômetro da feira.
        </p>
    </section>

    <% if (mensagem != null) { %>
    <div class="alert <%= tipoMensagem %>" role="status" aria-live="polite" aria-atomic="true">
        <span class="alert-tag">
            <%= "error".equals(tipoMensagem) ? "Atenção" : "Tudo certo!" %>
        </span>
        <%= mensagem %>
    </div>
    <% } %>

    <% if (trilhas.length > 0) { %>
    <section aria-labelledby="lista-trilhas">
        <h2 id="lista-trilhas" class="section-label">Trilhas disponíveis</h2>

        <div class="grid">
            <% for (Curso curso : trilhas) { %>
            <article class="trilha">
                <div class="number" aria-label="Número da trilha">
                    <%= curso.getNumero() %>
                </div>
                <h3><%= curso.getNome() %></h3>
                <p><%= curso.getDescricao() %></p>
                <form method="post" action="index.jsp">
                    <input type="hidden" name="id" value="<%= curso.getNumero() %>">
                    <button type="submit" aria-label="Votar na trilha <%= curso.getNome() %>">
                        Votar nesta trilha
                    </button>
                </form>
            </article>
            <% } %>
        </div>
    </section>
    <% } else { %>
    <div class="alert error" role="alert">
        Nenhum curso foi cadastrado no arquivo trilhas.txt.
    </div>
    <% } %>

    <nav class="toolbar" aria-label="Navegação da votação">
        <span>Votação aberta ao público · Mundo SENAI</span>
        <a class="link" href="resultado.jsp">Ver ranking da feira →</a>
    </nav>


</main>

<footer>SENAI · Educação Profissional e Tecnológica</footer>

</body>
</html>