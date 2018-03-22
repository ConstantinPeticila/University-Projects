/**
 * @author Peticila Constantin
 * Factorialul unui numar
 */

public class Factorial extends Procese {
    /**
     * inmulteste parametru cu toate numerele naturale mai mici ca el
     * @param nr numarul de procesat
     * @return factorialul numarului mod 9973
     */
    public int proces(int nr) {

        if ( nr < 0 )
            return 0;
        if(nr == 0)
            return 1;
        int k = 1;
        for (int i = 1; i <= nr; i++) {
            k = (k * i % nmod) % nmod;
        }
        return k;

    }
}
