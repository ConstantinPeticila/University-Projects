import java.util.Comparator;

/**
 * clasa care compara doua obiecte de tip celula
 */
 class Sort implements Comparator<Cell> {
    @Override
    /**
     * compar dupa numarul de vizitari
     * apoi dupa prioritate(folosesc directia drept prioritate)
     */
    public int compare(Cell cell, Cell cell2) {
        if ( cell.getnr() > cell2.getnr() ) return 1;
        if ( cell.getnr() < cell2.getnr() ) return -1;

        if ( cell.getDir() > cell2.getDir() ) return -1;
        return 1;
    }

    @Override
    public Comparator<Cell> reversed() {
        return null;
    }

}