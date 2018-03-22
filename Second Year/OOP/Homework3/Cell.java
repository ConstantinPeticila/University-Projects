/**
 * @author Peticila Constantin
 * clasa parinte pnetru toate tipurile de celule din labirint
 * linie si coloana reprezinta linia si coloana
 * parinte reprezinta celula parinte-task2
 * type-ul este specific pentrufiecare tip de celule in parte
 * nr reprezinta numarul de ori in care eroul trece prin celula respectiva
 * directia reprezinta directia,se seteaza in functie de orientarea eroului
 */
abstract class Cell {
   private int nr ,dir ,linie,coloana;
    private   String type;
    private Cell parinte;

    /**
     * seteaza Parintele
     * @param c celula parinte
     */
    void setParinte(Cell c){
        this.parinte = c;
    }

    /**
     *
     * @return parintele unei celule
     */
    Cell getParinte(){ return this.parinte; }

    /**
     * returneaza tipul de celula
     * @return tip
     */
     String getType(){ return this.type;}

    /**
     * scrie tipul celulei
     * @param type noul tip
     */
    void setType(String type){ this.type = type;}

    /**
     * ia linia specifica celulei
     * @return lina
     */
    int getLinie(){
        return this.linie;
    }

    /**
     *
      * @return coloana
     */
    int getColoana(){
        return this.coloana;
    }

    /**
     *
     * @return numarul
     */
    int getnr(){
        return this.nr;
    }

    /**
     * seteaza linia si coloana
     * @param a linie
     * @param b coloana
     */
      void setLiCo(int a,int b){
        this.linie = a;
        this.coloana = b;
    }

    /**
     * seteaza directia
     * @param d -noua directie
     */
    void setDir(int d){this.dir = d;}

    /**
     *
     * @return directia
     */
    int getDir(){return this.dir;}
    void setNr(int nr){
        this.nr = nr;
    }
}
