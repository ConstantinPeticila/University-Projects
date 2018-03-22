/**
 * clasa Patrat
 * @author Peticila Constantin
 * @see Procese
 */
public class Square extends Procese  {
    /**
     * returneaza patrat
     * @param a numar procesat
     * @return parte intreaga din patrat
     */
    public int proces (int a ){
        return (int)Math.pow(a,2);
    }
}
