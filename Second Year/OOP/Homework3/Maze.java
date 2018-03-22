import java.io.*;
import java.util.*;

/**
 * @author Constantin Peticila
 */
class Maze {

    /**
     * linia si coloana celulei din care porneste eroul
     * le folosesc pentru scriere in fisier
     */
   private int lin,  win;
    /**
     * labirintul
     */
   private Cell[][] maze;
    /**
     * lista folosita la task1 in care pun vecinii celului,apoi o sortez
     */
    private ArrayList <Cell> arrayList = new ArrayList <>();
    /**
     * array in care o sa pun drumul,atat pentru task1 cat si pentru task2
     */
     private ArrayList <Cell> drum = new ArrayList <>();

    /**
     *coada folosita pentru algoritmul lui lee-task2
     */
    private Queue <Cell> q = new LinkedList <>();
    /**
     * metoda care cauta celula de input si o marcheaza ca celula prin care s-a trwecut o data;
     * @return o celula cu aceeasi linie ,coloana si directie
     *
     */

 Cell inceput1() {

        Cell poz = new InCell();
        for (int i = 1; i < maze.length - 1; i++) {
            for (int j = 1; j < maze[i].length - 1; j++) {
                if ( maze[i][j] instanceof InCell ) {

                    poz.setLiCo(i, j);
                    poz.setDir(maze[i][j].getDir());
                    maze[i][j].setNr(maze[i][j].getnr() + 1);
                    break;
                }
            }
        }
        return poz;
    }

    /**
     * metoda care cauta celula de input din labirint
     * locul de unde incepe eroul
     * @return celula in input
     */
    Cell inceput() {

        Cell poz = new InCell();
        for (int i = 1; i < maze.length - 1; i++) {
            for (int j = 1; j < maze[i].length - 1; j++) {
                if ( maze[i][j] instanceof InCell ) {
			 return maze[i][j];
                }
            }
        }
        return poz;
    }

    /**
     * metoda care cauta celula din labirint unde trebuie sa ajunga eroul
     * @return aceasta celula
     */
    Cell sfarsit() {

        Cell poz = new InCell();
        for (int i = 1; i < maze.length - 1; i++) {
            for (int j = 1; j < maze[i].length - 1; j++) {
                if ( maze[i][j] instanceof PortalCell ) {
                     return maze[i][j];
                }
            }
        }
        return poz;
    }


    /**
     * metoda care construieste labirintul
     * aceasta citeste lungimea si latimea specifica in fisierul dat ca argument
     * creaza un labirint (matrice patratica de celule) de dimensiunile date +2
     * inconjurand labirintul cu un tip de celule anume(OutCell) in care eroul nu trebuie sa ajunga
     * apoi in functie de fiecare simbol citit se creaza o celula specifica in locul din matrice corespunzator
     * se seteaza si linia si coloana din labirint corespunzatoare celulei in
     * @param f fisierul din care se citeste
     * @throws Exception exceptie la deschidere si citire
     */
   void construire(File f) throws Exception {

        Scanner sc = new Scanner(f);
        int l = sc.nextInt() + 2, w = sc.nextInt() + 2;
        maze = new Cell[l][w];
        for (int i = 0; i < w; i++) {
            maze[0][i] = new OutCell();
            maze[0][i].setLiCo(0, i);
            maze[l - 1][i] = new OutCell();
            maze[l - 1][i].setLiCo(l - 1, i);
        }
        for (int i = 0; i < l; i++) {
            maze[i][0] = new OutCell();
            maze[i][0].setLiCo(i, 0);
            maze[i][w - 1] = new OutCell();
            maze[i][w - 1].setLiCo(i, w - l);
        }
        for (int i = 1; i < l - 1; i++) {
            String next = sc.next();
            for (int j = 1; j < w - 1; j++) {

                switch (next.substring(j - 1, j)) {
                    case ".":
                        maze[i][j] = new SpaceCell();
                        break;
                    case "#":
                        maze[i][j] = new WallCell();
                        break;
                    case "O":
                        maze[i][j] = new PortalCell();
                        break;
                    case "I":
                        maze[i][j] = new InCell();
                        this.lin = i - 1;
                        this.win = j - 1;
                        break;
                }
                maze[i][j].setLiCo(i, j);

            }
        }
    }

    /**
     * metoda care verifica daca pasul pe care eroul incearca sa il faca este valid
     * aceasta verifica data tipul celulei este zid sau zid inconjurator
     * @param c celula in care se doreste sa se ajunga
     * @throws CannotMoveIntoWallsException -daca celula e de tip zid inconjurator
     * @throws HeroOutOfGroundException -daca celula e de tip zid
     */
    private static void validstep(Cell c)throws CannotMoveIntoWallsException, HeroOutOfGroundException {
        if(c instanceof WallCell)
            throw new CannotMoveIntoWallsException("not allow to go in wall");
        else if(c instanceof OutCell)
            throw new CannotMoveIntoWallsException("not allow to go in out");
  }


    /**
     * metoda de gasire a drumului pentru taskul 1
     * Cat timp portalul(celula dorita) nu este gasit incercam sa punem vecinii celulei curente intr-o lista auxiliara (celule interzise(wall si out) nu vor intra
     * Verificam apoi daca unul din vecinii bagati in lista este chiar portalul de iesire ,il adaugat in drum si terminam
     * Daca nu se intampla asta,in functie de orientarea eroului(10 - sus; 15 -jos; 20 -dreapta ;25-stanga) le setam un numar de ordine vecinilor din lista
     * folosind comparatorul sortez  lista dupa numarul de vizitari,apoi dupa cea mai mica directie-primul vecin disponibil de la dreapta la stanga
     * iau primul element din lista si il pun in drum,ma deplasez pana la el si reiau pana gasesc portalul de iesire
     * @param poz pozitia din care plec
     */
  void task1help(Cell poz) {

	while(!(poz instanceof PortalCell)){
	    try {
	        validstep(maze[poz.getLinie() + 1][poz.getColoana()]);
               arrayList.add(maze[poz.getLinie() + 1][poz.getColoana()]);
        }
        catch (Exception ignored){}
        try {
            validstep(maze[poz.getLinie() ][poz.getColoana()+1]);
            arrayList.add(maze[poz.getLinie()][poz.getColoana() + 1]);
        }
        catch (Exception ignored){}

        try {
            validstep(maze[poz.getLinie() -1][poz.getColoana()]);
            arrayList.add(maze[poz.getLinie() - 1][poz.getColoana()]);
        }
        catch (Exception ignored){}

        try {
            validstep(maze[poz.getLinie() ][poz.getColoana() -1]);
            arrayList.add(maze[poz.getLinie()][poz.getColoana() - 1]);
        }
        catch (Exception ignored){}


       for (Cell c : arrayList) {
            if ( c instanceof PortalCell ) {
               drum.add(c);
                return;
            }
        }
        switch (poz.getDir()) {
            case 10:
                maze[poz.getLinie()][poz.getColoana() + 1].setDir(25);
                maze[poz.getLinie() - 1][poz.getColoana()].setDir(20);
                maze[poz.getLinie()][poz.getColoana() - 1].setDir(15);
                maze[poz.getLinie() + 1][poz.getColoana()].setDir(10);

                break;
            case 15:
                maze[poz.getLinie()][poz.getColoana() + 1].setDir(15);
                maze[poz.getLinie() - 1][poz.getColoana()].setDir(10);
                maze[poz.getLinie()][poz.getColoana() - 1].setDir(25);
                maze[poz.getLinie() + 1][poz.getColoana()].setDir(20);
                break;
            case 20:
                maze[poz.getLinie()][poz.getColoana() + 1].setDir(20);
                maze[poz.getLinie() - 1][poz.getColoana()].setDir(15);
                maze[poz.getLinie()][poz.getColoana() - 1].setDir(10);
                maze[poz.getLinie() + 1][poz.getColoana()].setDir(25);
                break;
            case 25:
                maze[poz.getLinie()][poz.getColoana() + 1].setDir(10);
                maze[poz.getLinie() - 1][poz.getColoana()].setDir(25);
                maze[poz.getLinie()][poz.getColoana() - 1].setDir(20);
                maze[poz.getLinie() + 1][poz.getColoana()].setDir(15);
                break;
        }
        arrayList.sort(new Sort());
           drum.add(arrayList.get(0));
                if ( arrayList.get(0).getLinie() == poz.getLinie() ) {
                    if ( arrayList.get(0).getColoana() > poz.getColoana() ) poz.setDir(20);
                    else poz.setDir(25);
                } else if ( arrayList.get(0).getLinie() > poz.getLinie() ) poz.setDir(15);
                else poz.setDir(10);

                arrayList.get(0).setNr(arrayList.get(0).getnr() + 1);
                poz.setLiCo(arrayList.get(0).getLinie(), arrayList.get(0).getColoana());

        arrayList.clear();
    }
           
}

    /**
     * scriere task1
     * scriu lungimea drumului,apoi liniile si coloanele tuturor celulor din labirint pe care le-am parcurs
     * @param wrt fisierul in care scriu
     */
    void task1(PrintWriter wrt){

 	    wrt.println(drum.size()+1);
        wrt.println(this.lin  + " " + this.win  );
        for (Cell c : drum) {
                wrt.print(c.getLinie() - 1 + " ");
                wrt.println(c.getColoana() - 1);
        }
        wrt.close();
	
    }


    /**
     * realizare drum task2 -cel mai scurt drum(la egalitate dupa ordinea ceruta)
     * celulele prin care trec le marchez tipul ca cel al zidurile(sa  nu mai trec inca o data)
     * adaug in coada celula de pornire apoi cat timp coada nu e goala verific,imi iau ultima valoare din ea
     * verific daca am ajuns la partalul de iesire
     * apoi pentru cei patru vecini din labirint ai celulei in care sunt verific daca sunt accesibili( nu au tip specific zid sau zid inconjurator)
     * Le setez tipul specific pentru zid si parintele celula in care eram
     * apoi ii adaug in coada
     * pornind de la portal iesire pana la cel de intrare,pun in lista specifica drumului pe prima pozitie,celula in care sunt si trec la parintele el
     * @param in -celula din care plec
     * @param port -celula in care vreau sa ajung
     */

    void task2help( Cell in, Cell port) {
        in.setType("#");
        q.add(in);

        int[] linie = {0, -1, 0, 1};
        int[] coloana = {1, 0, -1, 0};

        while (!q.isEmpty()) {
            Cell current = q.remove();

            if ( current == port ) {
                break;
            }
            for (int i = 0; i < 4; i++) {
                int x = current.getLinie() + linie[i];
                int y = current.getColoana() + coloana[i];

                try {
                    validstep(maze[x][y]);
                    if ( !maze[x][y].getType().equals("*") && !maze[x][y].getType().equals("#") ) {
                        maze[x][y].setType("#");
                        maze[x][y].setParinte(current);
                        q.add(maze[x][y]);

                    }


                } catch (HeroOutOfGroundException e) {
                } catch (CannotMoveIntoWallsException e) {
                }
            }
        }
        drum.clear();
        Cell step = port;
        while (step != in) {
            drum.add(0, step);
            step = step.getParinte();
        }
        drum.add(0, in);
    }

    /**
     * scriu in fisier de iesire lungimea drumului si linia si coloana fiecarei celule prin care s-a trecut pentru task2
     * @param writer fisierul in care scriu
     */
    void task2(PrintWriter writer){
        writer.println(drum.size());

        for (Cell c : drum) {
            writer.print(c.getLinie() -1+ " ");
            writer.println(c.getColoana()-1);
        }
        writer.close();
    }



}
