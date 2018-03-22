//import java.util.*;
/**
 * clasa pentru procese numar egal
 * @author Peticila Constantin
 */
class RoundRobinSheduler extends Scheduler {

    /**
     *Metoda atribuie procesele in ordine,unul cate unul repetitiv
     * Cu ajutorul vectorului de structuri pentru Cache si a unui vector auxiliar fiecarui numar citit i se atribuie un proces
     * si apoi se realizeaza punerea rezultatului in fisierul de out utilizand functia de scriere din tipul respectiv de cache
     * @param a -informatiile din fisierul de intrare
     * @param out fisierul de iesire
     */
  void scris(ProblemData a, HomeworkWriter out) {
        int j = 0;
        Procese[] prc = super.vectorproc(a);
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
            if ( j == a.getProcesses().length )
                j = 0;
            obj.cache(a, out, cache, prc, vector, i, j);
            j++;
        }

    }
}


