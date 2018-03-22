import java.io.*;

/**
 * @author Constantin Peticila
 * clasa principala
 */
public class MainClass {

    /**
     * imi iau fisierele de citire si scriere
     * imi construiesc labirintul folosind datele din fisierul de citire
     * imi iau o copie a celulei de In si celulele de in si out
     * in functie de taskul cerut creez drumul specific
     * inchid fisierul de scriere
     * @param args primul argument-numarul taskului,al doilea-numele fisierului de citire,al treilea-fisier de scriere
     * @throws Exception exceptii
     */
    public static void main(String args[]) throws Exception {


        File f = new File(args[1]);
        PrintWriter wrt = new PrintWriter(args[2], "UTF-8");
        Maze m = new Maze();
       
	    m.construire(f);
        Cell poz = m.inceput1();
	    Cell poz1 = m.inceput();
        Cell poz2 = m.sfarsit();

        switch (args[0]){
         case "1":
		     m.task1help(poz);
		     m.task1(wrt);
		     break;
		  case "2":
             m.task2help(poz1,poz2);
             m.task2(wrt);
             break;
        }
    wrt.close();
 }
}
