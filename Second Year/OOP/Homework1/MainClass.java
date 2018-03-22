/**
 * clasa Centrala
 * @author Peticila Constantin
 */
 class MainClass {

    /**
     * Deschidem fisierele de citire si scriere
     * In functie de tipul de scheduler cream un obiect nou si apoi apelam metoda corespunzatoare care ne scrie in fisierul de out
     * @param args primul args e pentru fisierul de citire iar args[1] pentru scriere
     */
    public static void main(String args[]) {


        HomeworkReader in = new HomeworkReader(args[0]);
        HomeworkWriter outt =new HomeworkWriter(args[1]);
        ProblemData a = in.readData();
        Scheduler shd ;
        switch (a.getSchedulerType()) {

            case "RandomScheduler":
                shd = new RandomSheduler();
                break;
            case "RoundRobinScheduler":
                shd = new RoundRobinSheduler();
                break;
            case "WeightedScheduler":
                shd = new WeightScheduler();
                    break;
            default:
                throw new IllegalArgumentException("Invalid scheduler");
            }
        shd.scris(a, outt);
        outt.close();
        in.close();
    }
}
