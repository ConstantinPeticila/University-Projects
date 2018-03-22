//Peticila Constantin 321 CB
import java.io.*;
import java.util.*;
public class AA {

    public static void main(String args[]) throws UnsupportedEncodingException {//exceptie pentru scriere in fisier

        try { //incercare deschidere fisier
            File f = new File("task1.in");
            Scanner sc = new Scanner(f); //pentru citire din fisier
            int nrstari = sc.nextInt(); //citire nr de stari
            String[] stari = new String[nrstari]; // citire stari ca stringuri
            for (int i = 0; i < nrstari; i++) {
                stari[i] = sc.next();

            }

            int nrsf = sc.nextInt(); //nr stari finale

            String[] starif = new String[nrsf];
            for (int i = 0; i < nrsf; i++) { //starile finale citire
                starif[i] = sc.next();

            }

            String starei = sc.next(); //citire starea initiala
            int nrtran = sc.nextInt();

            String[][] tranz = new String[nrtran][8]; //citim tranzitiile ca o matrice de stringuri
            for (int i = 0; i < tranz.length; i++) {
                for (int j = 0; j < tranz[i].length; j++) {
                    tranz[i][j] = sc.next();
                }
            }

            String banda1 = sc.next(); //citim benzile ca pe stringuri
            String banda2 = sc.next();

            String[] b1 = new String[banda1.length()]; //facem vector de stringuri din strunguri pentru comparatia cu elementele din tranzitii
            for (int i = 0; i < banda1.length(); i++) {
                b1[i] = new StringBuilder().append(banda1.charAt(i)).toString(); //fiecare char devine string pe pozitia coresp

            }
            String[] b2 = new String[banda2.length()]; //analog
            for (int i = 0; i < banda2.length(); i++) {
                b2[i] = new StringBuilder().append(banda2.charAt(i)).toString();
                System.out.println(b2[i]);
            }

            String d1, d2; //stringuri pentru directii
            int incr1 = 1; //increment pentru vectorul de stringuri reprezentant banda 1
            int incr2 = 1; //analog banda 2
            boolean ok = true, ok2 = false,ok3 = true; //auxilare pentru conditii
            String s1 = starei;
            while (ok) {

                for (int i = 0; i < nrtran; i++) { //pentru fiecare tranzitie

                    if ( s1.equals(tranz[i][0]) && b1[incr1].equals(tranz[i][1]) && b2[incr2].equals(tranz[i][2]) ) { //verificam daca tranzitia este cea potrivita

                        ok2 = true; // pentru a continua bucla while
                        b1[incr1] = tranz[i][4]; //scriem pe banda
                        b2[incr2] = tranz[i][6];
                        s1 = tranz[i][3]; //actualizam starea in care ne aflam
                        d1 = tranz[i][5]; //actualizam directiile
                        d2 = tranz[i][7];

                        if ( d1.equals("R") ) //verificam directia de pe banda si actualizam cursorul
                            incr1++;
                        if ( d1.equals("L") )
                        incr1--;
                        if ( d2.equals("R") )
                        incr2++;
                        if ( d2.equals("L") )
                        incr2--;


                        if ( incr1 == b1.length - 1 ) { //verificare dimensiune atinsa banda1,redimensionam si  adaugam string
                            b1 = Arrays.copyOf(b1, b1.length + 1);
                            b1[b1.length - 1] = "#";
                        }
                        if ( incr2 == b2.length - 1 ) {
                            b2 = Arrays.copyOf(b2, b2.length + 1);
                            b2[b2.length - 1] = "#";
                        }
                        break; //iesim din tranzitii pentru ca am gasit o pe cea potrivita

                    }
                }


                if ( ok2 == false ) { //caz in care nu exista o tranzitie corespunzatoarea
                    ok3 = false; //pentru scrie in fisier mesaj potrivit
                    break; //iesim din bucla
                }
                ok2 = false; //pentru urmatorul ciclu

                for (int i = 0; i < nrsf; i++) { //caz in care s-a ajuns intr-o stare finala

                    if ( s1.equals(starif[i]) )
                        ok = false; //iesim din while
		
                  }
            }

            PrintWriter writer = new PrintWriter("task1.out", "UTF-8"); //deschidem fisier pentru scriere
            if(ok3 == false) //conditie nu s-a gasit tranzitie corespunzatoare
                writer.println("The machine has blocked!");
                
            else {  //s-a ajuns in stare finala
                String aa = new String(); //facem string folosind vectorul de stringuri reprezentant banda ->pentru scriere corecta in fisier
                for (int j = 0; j < b1.length; j++)
                    aa = aa + b1[j].charAt(0);

                String aaa = new String();
                for (int j = 0; j < b2.length; j++)
                    aaa = aaa + b2[j].charAt(0);


                writer.println(aa); //scriem stringul corespunzator pentru banda 1 in fisier
                writer.println(aaa); //analog banda 2
            }
            writer.close(); // inchidem fisierul de scriere

            sc.close(); //inchidem fisierul de citire

        }
        catch (FileNotFoundException e) { //caz in care nu s-a gasit fisier de citire
            System.out.println("Erorr");
        }
    }
}


