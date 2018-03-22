/**
 * clasa parinte pentru tipurile de cache
 * @author Peticila Constantin
 */

  abstract class Cache {

    /**
     * metoda care printeza in fisier procese care nu sunt in Cache
     * @param fout fisierul in care are loc scrierea
     * @param nr numarul pentru care se aplica procesul
     * @param numeprc tipul procesului
     * @param rez rezultatul calcularii procesului pe numar
     *
     */
    void afisare(HomeworkWriter fout, int nr, String numeprc, int rez) {
         fout.println(nr + " " + numeprc + " " + rez + " Computed");

    }

    /**
     * metoda care printeaza in fisier procese care sunt in Cache
     * @param fout fisierul in care se scrie
     * @param nr numarul de procesat
     * @param numeprc tipul procesului
     * @param rez rezultatul procesarii
     *
     */

    void afisare2(HomeworkWriter fout, int nr, String numeprc, int rez) {
       fout.println(nr + " " + numeprc + " " + rez + " FromCache");

    }

    /**
     * metoda abstracta ce se va implementata in mod diferit in clasele ce mostenesc clasa Cache
     * @param a informatiile din fisierul de intrare
     * @param out fisierul de scriere
     * @param cache vector cu structuri de tip int,string,int
     * @param prc vector de procese
     * @param vector vector auxiliar-pentru Lfu
     * @param i pozitia numarului pentru care se aplica procesul
     * @param rnd pozitia procesului in vectorul de procese
     */
    public abstract void cache(ProblemData a, HomeworkWriter out, ProcessStructure[] cache, Procese[] prc, int[] vector, int i, int rnd);

}
