/**
 * clasa Radical
 * @author Peticila Constantin
 */
public class Sqrt extends Procese {
    /**
     * Daca numarul este negativ il inverseaza apoi returneaza parte intreaga din radical
     * @param a numarul de procesat
     * @return partee intreaga din radical
     */
    public int proces(int a){
        if(a < 0)
            a  = -a;
        return (int)Math.sqrt(a);
    }
}
