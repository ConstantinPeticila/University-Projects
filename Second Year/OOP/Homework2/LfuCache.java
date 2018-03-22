
/**
 * Imlpementeaza cache-ul de tip Lfu
 * @author Peticila Constantin
 * @see Cache -extinde aceasta clasa
 *
 */
class LfuCache extends Cache{
    /**
     * minimul nenul dintr-un vector
     * @param v vectorul pentru care se calculeaza minumul
     * @return pozitia minimului
     */

    private int minim(int[] v){
        int min = v[0];
        int poz = 0;
        for(int i = 1;i < v.length;i++){
            if(v[i]< min && v[i] > 0) {
                min = v[i];
                poz = i;
            }
        }
        return poz;
    }
    /**
     *<p>Metoda realizeaza un vector de structuri pentru a simula lfucache si pune in fisierul de out elementele calculate sau direct
     * luate din cache </p>
     * Daca un proces pentru un nr este deja calculat se actualizeaza doar numarul de proc respectiv
     * Daca nu e calculat si vectorul nu e plin se pune dupa ultimul el fara proces
     * Daca vectorul e plin si nu e calculat elementele din structura corespunzatoare procesului care a aparut de cele mai putine ori este inlocuit
     * la fel si elementul din indincele corespunzator din vect auxliar
     * @param a informatiile din fisierul de intrare
     * @param out fisierul de scriere
     * @param lru vector cu structuri de tip int,string,int de dimensiune scrisa in fisier
     * @param prc vector de procese
     * @param vect vector auxiliar in care pastrez numarul de procese de pe fiecare pozitie
     * @param i pozitia numarului pentru care se aplica procesul
     * @param rnd pozitia procesului in vectorul de procese
     */
    public void cache(ProblemData a,HomeworkWriter out,ProcessStructure[] lru,Procese[] prc,int[] vect,int i,int rnd){

        int j = 0;
        int pozitie ;
        boolean ok = false,ok2 =false;
        while(!("".equals(lru[j].getType()) || lru[j].getType()==null)){ //cat timp e cv pe pozitie
            if(lru[j].getType().equals(a.getProcesses()[rnd].getType()) && (lru[j].getWeight() == a.getNumbersToBeProcessed()[i])){ //daca e deja procesul pt nr
                vect[j]++;
                afisare2(out,lru[j].getWeight(),lru[j].getType(),lru[j].getnr());
                ok=true;
                break;
            }

            if(j == lru.length -1) {
                ok2 = true;
                break;
            }
            j++;

        }
        if(ok2){
            pozitie = minim(vect);
            lru[pozitie].setType(a.getProcesses()[rnd].getType());
            lru[pozitie].setWeight(a.getNumbersToBeProcessed()[i]);
            lru[pozitie].setrez(prc[rnd].proces(lru[pozitie].getWeight()));
            afisare(out,lru[pozitie].getWeight(),lru[pozitie].getType(),lru[pozitie].getnr());
            vect[pozitie]=1;

        }
        else    {
            if ( !ok ){

                lru[j] = new ProcessStructure(a.getProcesses()[rnd].getType(),a.getNumbersToBeProcessed()[i]);
               // lru[j].setType(a.getProcesses()[rnd].getType());
               // lru[j].setWeight(a.getNumbersToBeProcessed()[i]);
                lru[j].setrez(prc[rnd].proces(lru[j].getWeight()));
                afisare(out,lru[j].getWeight(),lru[j].getType(),lru[j].getnr());
                vect[j]++;
            }
        }

    }
}

