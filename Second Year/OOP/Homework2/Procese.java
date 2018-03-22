/**
 * clasa parinte pentru toate tipurile de procese
 * @author Peticila Constantin
 */
public abstract class Procese {
    /**
     * pentru a retine numarul mod
     */
     int nmod = 9973;

    /**
     * metoda de implementat in functie de proces
     * @param numar numarul citit din fisier pentru care se realizeaza un proces
     * @return rezultatul procesului pentru numar
     */
    public   abstract int  proces(int numar);
}
