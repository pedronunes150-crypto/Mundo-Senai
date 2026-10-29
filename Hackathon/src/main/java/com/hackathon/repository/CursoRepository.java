package com.hackathon.repository;

import com.hackathon.model.Curso;

import java.util.List;


public interface CursoRepository {
    List<Curso> carregarCursos();

    Curso buscarCursoPorNumero(int numero);

}
