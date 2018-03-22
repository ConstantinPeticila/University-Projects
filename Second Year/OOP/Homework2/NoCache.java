/**
 * clasa pentur lipsa Cacheului
 * @author Peticila Constantin
 * @see Cache
 */
public class NoCache extends Cache {
    /**
     * Metoda cauta numarul primit ca argument si procesul respectiv
     * si calculeaza rezultatul apoi il afiseaza
     * @param a informatiile din fisierul de intrare
     * @param out fisierul de scriere
     * @param lru vector de structuri reprezentand cache-ul
     * @param prc vector de procese
     * @param vector vector auxiliar-pentru Lfu
     * @param i pozitia numarului pentru care se aplica procesul
     * @param rnd pozitia procesului in vectorul de procese
     */
    public  void cache(ProblemData a, HomeworkWriter out, ProcessStructure[] lru, Procese[] prc,int[] vector, int i, int rnd){
        int nr  =   a.getNumbersToBeProcessed()[i];
       String numeprc = a.getProcesses()[rnd].getType();
       int  rez = prc[rnd].proces(nr);
      super.afisare(out, nr, numeprc,rez);
    }

}
