import  java.util.*;
/**
 * clasa pentru procese ranoom
 * @author Peticila Constantin
 * @see Scheduler
 */
class RandomSheduler extends Scheduler {
    /**
     *Metoda atribuie procesele random
     * Cu ajutorul vectorului de structuri pentru Cache si a unui vector auxiliar fiecarui numar citit i se atribuie un proces
     * si apoi se realizeaza punerea rezultatului in fisierul de out utilizand functia de scriere din tipul respectiv de cache
     * @param a -informatiile din fisierul de intrare
     * @param out fisierul de iesire
     */
     void scris(ProblemData a, HomeworkWriter out) {

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
                throw new IllegalArgumentException("Invalid cahe");
        }

        ProcessStructure[] cache = new ProcessStructure[a.getCacheCapacity()];
      for (int j = 0; j < a.getCacheCapacity(); j++) {
            cache[j] = new ProcessStructure();
        }
        int[] vector = new int[a.getCacheCapacity()];

        for (int i = 0; i < a.getNumbersToBeProcessed().length; i++) {

            int rnd = new Random().nextInt(a.getProcesses().length);
            obj.cache(a, out, cache, prc, vector, i, rnd);
        }
    }
}


