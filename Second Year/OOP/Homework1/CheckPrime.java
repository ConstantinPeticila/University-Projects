/**
 * @author Peticila Constantin
 * Clasa pentru verificare numar prim
 */
public class CheckPrime extends Procese {
    /**
     *
     * @param b este numarul pentru care se fac verificari
     * @return 1 daca b este numar prim si 0 altfel
     */


    public int proces(int b){

        if(b < 2){
            return 0;
        }
        for(int i = 2 ;i <= b/2;i++){
            if(b % i == 0)
                return 0;
        }
        return 1;
    }
}
