
/**
 * Imlpementeaza cache-ul de tip Lru
 * @author Peticila Constantin
 * @see Cache -extinde aceasta clasa
 *
 */
class LruCache extends Cache {

    /**
     * <p>Metoda realizeaza un vector de structuri pentru a simula lrucache si pune in fisierul de out elementele calculate sau direct
     * luate din cache </p>
     * Daca elementul cautat nu este in cache si vectorul de structuri  nu este plin se pune la sfarsit
     * Daca el cautat nu este gasit dar vectorul este plin se muta toate elementele incepand cu al doilea cu unu mai in fata si se pune el pe ultima poz
     * Daca este gasit atunci se muta structura corespunzatoare in aux si toate de dupa vin mai in fata cu una iar aux se pune la ultima structura nenula
     * In toate cazurile se fac afisari
     * @param a informatiile din fisierul de intrare
     * @param out fisierul de scriere
     * @param lru vector cu structuri de tip int,string,int de dimensiune scrisa in fisier
     * @param prc vector de procese
     * @param vectornr vector auxiliar folosit pnetru Lfu
     * @param i pozitia numarului pentru care se aplica procesul
     * @param rnd pozitia procesului in vectorul de procese
     */

    public   void cache(ProblemData a,HomeworkWriter out,ProcessStructure[] lru,Procese[] prc,int[] vectornr,int i,int rnd){

        int j = 0,k;
        boolean ok = false,ok2 =false;
        while(!( lru[j].getType()==null)){ //cat timp e cv pe pozitie
            if(lru[j].getType().equals(a.getProcesses()[rnd].getType()) && (lru[j].getWeight() == a.getNumbersToBeProcessed()[i])){ //daca e deja procesul pt nr
                if ( j < lru.length - 1 ) {//daca nu e ultima pozitie
                    k = j+1;
                    ProcessStructure aux = new ProcessStructure(lru[j].getType(),lru[j].getWeight());//proces auxiliar
                    aux.setrez(lru[j].getnr());
                    aux.setWeight(lru[j].getWeight());
                    aux.setType(lru[j].getType());
                    while ( !( lru[k].getType()==null) ){
                        //le mutam pe toate mai in fata
                        lru[k-1].setType(lru[k].getType());
                        lru[k-1].setWeight(lru[k].getWeight());
                        lru[k-1].setrez(lru[k].getnr());
                        if(k < lru.length -1 )
                            k++;
                        else break;

                    }
                    if(( k == lru.length -1)&& (!(lru[j].getType()==null))){
                        lru[k ].setType(aux.getType());
                        lru[k ].setWeight(aux.getWeight());
                        lru[k ].setrez(aux.getnr());
                        afisare2(out, lru[k ].getWeight(), lru[k ].getType(), lru[k ].getnr());
                    }else {
                        lru[k - 1].setType(aux.getType());
                        lru[k - 1].setWeight(aux.getWeight());
                        lru[k - 1].setrez(aux.getnr());
                        afisare2(out, lru[k - 1].getWeight(), lru[k - 1].getType(), lru[k - 1].getnr());

                    }
                }
                else {
                    afisare2(out,lru[lru.length-1].getWeight(),lru[lru.length-1].getType(),lru[lru.length-1].getnr());
                }

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
            for( k = 1;k <lru.length;k++){
                lru[k-1].setType(lru[k].getType());
                lru[k-1].setWeight(lru[k].getWeight());
                lru[k-1].setrez(lru[k].getnr());
            }
            // pun pe ultima pozitia ce am si afisez
            lru[k-1].setWeight(a.getNumbersToBeProcessed()[i]);
            lru[k-1].setType(a.getProcesses()[rnd].getType());
            lru[k-1].setrez(prc[rnd].proces(lru[j].getWeight()));
            // lru[k-1].setrez(rez);
            afisare(out,lru[k-1].getWeight(),lru[k-1].getType(),lru[k-1].getnr());

        }
        else    {
            if ( !ok ){

                lru[j] = new ProcessStructure(a.getProcesses()[rnd].getType(),a.getNumbersToBeProcessed()[i]);
               // lru[j].setType(a.getProcesses()[rnd].getType());
               // lru[j].setWeight(a.getNumbersToBeProcessed()[i]);
                lru[j].setrez(prc[rnd].proces(lru[j].getWeight()));

                afisare(out,lru[j].getWeight(),lru[j].getType(),lru[j].getnr());

                //fac structura noua
            }
        }


    }
}

