/**
 * clasa pentru proces in functie de cote
 * @author Peticila Constantin
 */
class WeightScheduler extends Scheduler {

    /**
     * cmmdc intre doi intregi recursiv
     * @param a primul numar
     * @param b al doilea numar
     * @return cmmdc(a,b)
     */
    private int getGCD(int a, int b) {
        if ( b == 0 ) {
            return a;
        } else {
            return getGCD(b, a % b);
        }
    }

    /**
     * cmmdc pentru vector de intregi
     * @param a vector
     * @return numar reprezenrat cmmd elemente din vector
     */
    private int getGCD(int[] a) {

        int gcd = a[0];

        for (int i = 1; i < a.length; i++) {
            gcd = getGCD(gcd, a[i]);
        }
        return gcd;
    }

    /**
     * vector in care pastrez cotele proceselor
     * @param a infomrmatii intrare
     * @return vector
     */
    private int[] vtinit(ProblemData a) {


        int[] vector = new int[a.getProcesses().length];
        for (int i = 0; i < a.getProcesses().length; i++) {
            vector[i] = a.getProcesses()[i].getWeight();
        }
        return vector;

    }

    /**
     *Metoda atribuie procesele in functie de cate sunt comparativ cu celelalte
     * Cu ajutorul vectorului de structuri pentru Cache si a unui vector auxiliar fiecarui numar citit i se atribuie un proces
     * si apoi se realizeaza punerea rezultatului in fisierul de out utilizand functia de scriere din tipul respectiv de cache
     * @param a -informatiile din fisierul de intrare
     * @param fout fisierul de iesire
     */
     void scris(ProblemData a, HomeworkWriter fout) {

        Procese[] prc = super.vectorproc(a);
        int[] v = this.vtinit(a);
        int cmmdc = this.getGCD(v);
        for (int i = 0; i < v.length; i++) {
            v[i] = v[i] / cmmdc;
        }
        int[] w = v.clone();

        int j = 0;
        Cache obj;
        switch (a.getCacheType()) {
            case "NoCache":
                obj = new NoCache();
                break;
            case "LruCache":
                obj = new LruCache();
                break;
            case "LfuCache":
                obj = new LfuCache();
                break;
            default:
                throw new IllegalArgumentException("Invalid cache");
        }

        ProcessStructure[] cache = new ProcessStructure[a.getCacheCapacity()];
        for (int l = 0; l < a.getCacheCapacity(); l++) {
            cache[l] = new ProcessStructure();
        }
        int[] vector = new int[a.getCacheCapacity()];

        for (int i = 0; i < a.getNumbersToBeProcessed().length; i++) {
            while (true) {
                if ( v[j] > 0 ) {
                    v[j]--;
                    obj.cache(a, fout, cache, prc, vector, i, j);
                    break;
                }
                if ( v[j] == 0 )
                    j++;
                if ( j >= v.length ) {
                    v = w.clone();
                    j = j % v.length;
                }
            }

        }

    }
}



