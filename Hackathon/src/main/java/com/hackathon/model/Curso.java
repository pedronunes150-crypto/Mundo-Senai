package com.hackathon.model;

public class Curso {
    private int numero;
    private String nome;
    private String descricao;
    private int totalVotos = 0;

    public Curso(int numero, String nome, String descricao) {
        this.numero = numero;
        this.nome = nome;
        this.descricao = descricao;
    }




    public int getNumero() {
        return numero;
    }

    public String getNome() {
        return nome;
    }

    public String getDescricao() { return descricao; }

    public int getTotalVotos() {
        return totalVotos;
    }

    public static void incrementarVotos(Curso curso) {
        curso.totalVotos++;
    }

    public int getVotos() { return totalVotos; }
}
