/**
 * clasa Parinte pentru tipurile de scheduler
 * @author Peticila Constantin
 */
public abstract class Scheduler {

    /**
     * Metoda de implementat in urma careia se va realiza scrierea in fisier in functie de scheduler
     * @param d informatiile despre input
     * @param fout fisierul de out
     */
    abstract void scris(ProblemData d,HomeworkWriter fout);

    /**
     * Metoda care face un vector de procese in care se pune fiecare proces din fisierul de intrare
     * @param prbdata informatie cu legatura la datele problemei-informatii din fisier de intrare
     * @return vectorul cu procese
     */
   Procese[] vectorproc(ProblemData prbdata){

        Procese[] vct = new Procese[prbdata.getProcesses().length] ;

        for(int i = 0; i < prbdata.getProcesses().length ;i++){
            switch (prbdata.getProcesses()[i].getType()) {
                case "Factorial":
                    vct[i] = new Factorial();
                    break;
                case "Cube":
                    vct[i] = new Cube();
                    break;
                case "Sqrt":
                    vct[i] = new Sqrt();
                    break;
                case "Fibonacci":
                    vct[i] = new Fibonacci();
                    break;

                case "CheckPrime":
                    vct[i] = new CheckPrime();
                    break;

                case "NextPrime":
                    vct[i] = new NextPrime();
                    break;
                case "Square":
                    vct[i] = new Square();
                    break;
            }

         }
        return vct;
    }

}
