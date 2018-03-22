/**
 * Numar din sirul lui Fibonacci
 * @author Peticila Constantin
 */
public class Fibonacci extends  Procese {
    /**
     * verifica daca numarul e pozitiv si calculeaza numarul de pe pozita sa din sir
     * @param a numarul ce reprezinta pozitia din sir
     * @return numarul din sir mod nmod
     */
    public int proces(int a) {
        if( a < 0)
            return -1;
        if (a  == 0)
            return 0;
        if(a == 1)
            return 1;
        if(a == 2)
            return 1;
        int n1=0,n2=1,n3 = 0,i;
        for(i=2;i<=a;i++)
        {
            n3=(n1+n2)%nmod;
            n1=n2;
            n2=n3;
        }

        return  n3;
    }
}


