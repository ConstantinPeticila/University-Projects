/**
 * clasa Next Number Prime
 * @author Peticila Constantin
 * @see Procese
 */
public class NextPrime extends Procese {
    /**
     * Metoda cauta primul numar prim mai mare ca argumentul
     * @param b nr dat ca argument
     * @return numarul prim gasit
     */
    public int proces(int b) {

        if(b <2)
            return 2;
        b++;
        boolean ok = true;
        while (true) {
            for (int i = 2; i <= b / 2; i++) {
                if ( b % i == 0 ) {
                    ok = false;
                    break;
                }
            }
            if(ok )
                return b;
            ok = true;
            b++;

        }

    }
}
