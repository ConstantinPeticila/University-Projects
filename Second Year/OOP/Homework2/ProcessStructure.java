/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//package PooCbTema1.InputOutput;

/**
 *
 * @author alexm
 */
public class ProcessStructure {
    
    private String type;
    private int weight;
    private int rez;


    public ProcessStructure(){
        this.type = null;
    }
    public ProcessStructure(String type, int weight) {
        this.type = type;
        this.weight = weight;
    }
    
    /**
     * @return the type
     */
     String getType() {
        return type;
    }

    /**
     * @return the weight
     */
     int getWeight() {
        return weight;
    }

     void setrez(int nr){
        this.rez = nr;
    }
     int getnr(){return rez;}
     void  setWeight(int weight){
        this.weight = weight;
    }
     void setType(String type){
        this.type = type;
    }
}


