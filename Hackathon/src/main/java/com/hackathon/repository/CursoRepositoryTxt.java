package com.hackathon.repository;

import com.hackathon.model.Curso;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

public class CursoRepositoryTxt implements CursoRepository {

    String caminho;

    public CursoRepositoryTxt(String caminho){
        this.caminho = "Hackathon/src/main/webapp/recursos/trilhas.txt";
    }



    public List<Curso> carregarCursos() {
        List<Curso> cursos = new ArrayList<>();
        InputStream arquivo = getClass().getClassLoader().getResourceAsStream("trilhas.txt");
        try (BufferedReader br = new BufferedReader(new InputStreamReader(arquivo, StandardCharsets.UTF_8))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(";");
                if (parts.length == 3) {
                    int numero = Integer.parseInt(parts[0].trim());
                    String nome = parts[1].trim();
                    String descricao = parts[2].trim();
                    Curso curso = new Curso(numero, nome, descricao);
                    cursos.add(curso);
                }
            }
            return cursos;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }


    @Override
    public Curso buscarCursoPorNumero(int numero) {
        List<Curso> cursos = carregarCursos();
        for (Curso curso : cursos) {
            if (curso.getNumero() == numero) {
                return curso;
            }
        }
        return null;
    }
}
