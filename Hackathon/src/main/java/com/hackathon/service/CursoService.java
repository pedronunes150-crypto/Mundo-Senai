package com.hackathon.service;

import com.hackathon.model.Curso;
import com.hackathon.repository.CursoRepository;
import com.hackathon.repository.CursoRepositoryTxt;

import java.util.ArrayList;
import java.util.List;

public class CursoService {
    private static final CursoRepository repository = new CursoRepositoryTxt("Hackathon/src/main/webapp/recursos/trilhas.txt");
    private static final CursoService instancia = new CursoService();
    private final List<Curso> cursos = new ArrayList<>();

    private CursoService() {
        cursos.addAll(repository.carregarCursos());
    }

    public static CursoService getInstancia() {
        return instancia;
    }

    public synchronized boolean registrarVotos(int id) {
        for (Curso curso : cursos) {
            if (curso.getNumero() == id) {
                Curso.incrementarVotos(curso);
                return true;
            }
        }
        return false;
    }

    public Curso[] getCursos() {
        return cursos.toArray(new Curso[0]);
    }

    public Curso getVencedor() {
        Curso vencedor = null;
        int maxVotos = -1;
        for (Curso curso : cursos) {
            if (curso.getVotos() > maxVotos) {
                maxVotos = curso.getVotos();
                vencedor = curso;
            }
        }
        return vencedor;
    }

    public int getTotalVotosGerais() {
        return cursos.stream().mapToInt(Curso::getVotos).sum();
    }
}
