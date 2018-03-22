//Peticila Constantin 311 CB
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
//imi formez structurile necesare
typedef struct celula{
  struct celula *urm;
  void *info;
  }Celula,*TCel;

typedef struct {
  int id;
  char prtz;
  }Tinfo;

typedef struct stiva{
  TCel* vf;
 }TStiva,*ASt;

 typedef struct{
 TCel* ic;
 TCel* sc;
 }TCoada,*AQ;


//Initializarea unei stive
ASt InitS(int n)
{
    //aloc memoria necesara+verificare
    ASt S=(ASt) malloc(sizeof(TStiva));
    if(!S) return NULL;
    //aloc memorie pentru varful stivei de tip TCel* + verificare
    S->vf =(TCel*) malloc(n*sizeof(TCel));
    if(!S->vf) return NULL;
    return S;
}

//functia de adaugare in stiva
 void push(TCel *l,int info,char prt)
 {              //imi iau o lista (element de acelasi tip ca varful stivei) si adaug o celula
     //aloc spatiu pentru o structura care sa contina un int (numarul) si un char (paranteza)
     Tinfo * inf;
     inf = (Tinfo*) malloc(sizeof(Tinfo));
     if(!inf) return;
     inf->id = info;//initializez valorile menbrilor structurii alocatee cu cele corespunztoare celului pe care o introducem
     inf->prtz = prt;
     TCel aux;
     //aloc spatiu pentru o celula si maresc lista,astffel mut varful stivei cu o unitate
     aux = (TCel) malloc(sizeof(Celula));
     if(!aux) return;
     aux->info = (void*) inf;
     aux->urm = *l;
     *l = aux;
 }



//functia de scoatere din stiva
void pop(TCel *l)
{                       //functia muta varful stivei si astfel scoate un element(in cazul in care nu este nula)
                if(*l!= NULL)
                        (*l) = (*l)->urm;

}

//afisarea stivei

void prints(TCel *l,FILE *f2)
{
    if(!(*l)) return;
    Tinfo *info;
    info = (Tinfo*)(*l)->info;
    pop(l);
    prints(l,f2);
    fprintf(f2,"%c",info->prtz);
}


void printss(TStiva *S,int p,FILE *f2)
{               //declar o structara de tipul Tinfo * careia ii voi da valoarea castului facut la informatia din varful stivei
        int i;
        Tinfo *inf;
        inf = (Tinfo*)malloc(sizeof(Tinfo));

    TStiva *s1;
    s1 = InitS(p);
    for (i = 0;i < p;i++)

    {   fprintf(f2,"\"");
        if(S->vf[i])
        {
                while (S->vf[i])
                {
                        inf=(Tinfo*)S->vf[i]->info;
                        push(&(s1->vf[i]),inf->id,inf->prtz);
                        pop(&(S->vf[i]));
                }
        while(s1->vf[i])
        {
                                inf=(Tinfo*)s1->vf[i]->info;
                        fprintf(f2,"%c",inf->prtz);
                        push(&(S->vf[i]),inf->id,inf->prtz);
                        pop(&(s1->vf[i]));
        }

        }

    }
    fprintf(f2,"\"\n");
  }

ASt copiestiva(ASt S,int s)
{
        ASt s1;
        s1 = InitS(s);
        int i ;
        for (i = 0;i < s;i++)
        {
                s1->vf[i] = S->vf[i];

        }
        return s1;
}

//functie auxiliara de copiere a stivei
ASt copiestivaa(ASt S,int p,int s)
{ //folosesc doua stive auxiliare
        Tinfo *inf;
        inf = (Tinfo*)malloc(sizeof(Tinfo));
        ASt s1,s2;
        s1 = InitS(s);
        s2 = InitS(s);
        //mut fiecare element din stiva principala in ambele auxiliare
        while (S->vf[p])
        {       inf = (Tinfo*)S->vf[p]->info;
                push(&(s1->vf[p]),inf->id,inf->prtz);
                push(&(s2->vf[p]),inf->id,inf->prtz);
                pop(&S->vf[p]);
        }
        //rastorn din auxiliara 1 inapoi in principala si astfel aceasta revine la forma initiala
        //golesc stiva 1 axuliara
        while(s1->vf[p])
        {
                inf = (Tinfo*)s1->vf[p];
                push(&(S->vf[p]),inf->id,inf->prtz);
                pop(&s1->vf[p]);
        }
        //rastorn din auxiliara doi in prima si astfel obtin in aux 1 ce aveam si in principala
        //golesc a doua auxiliara
        while (s2->vf[p])
        {

                inf = (Tinfo*)s2->vf[p];
                push(&(s1->vf[p]),inf->id,inf->prtz);
                pop(&s2->vf[p]);
        }
        ///returnez copia stivei
        return s1;
}





//functia de verificare a ccelui mai lung subsir din stiva
int corrects(TStiva *S,int p,int s)
{
        int nr1 = 0,max1 = 0,nr = 0,max = 0;
        TStiva *s1,*s2, *s3,*s22;
        s22 = InitS(s);
        s2 = InitS(s);
        s3 = InitS(s);
        //s2 = copiestiva(S,s);
        Tinfo *INF,* inf1,*inf2;
        s1 = InitS(s);
        inf1 =(Tinfo*) malloc(sizeof(Tinfo));
  if (!inf1)
        return 1;
  inf2 =(Tinfo*) malloc(sizeof(Tinfo));
        if (!inf2)
                return 1;
        INF =(Tinfo*) malloc(sizeof(Tinfo));
        if (!INF)
                return 1;
                inf1 =(Tinfo*) malloc(sizeof(Tinfo));
                s2 = copiestiva(S,s);
                        while(s2->vf[p])
        {       inf1 = (Tinfo*)s2->vf[p]->info;

                push(&(s3->vf[p]),inf1->id,inf1->prtz);
                pop(&s2->vf[p]);

        }

                while(S->vf[p])
                {
                                inf1 = (Tinfo*)S->vf[p]->info;
                        if((inf1->prtz == ')') || (inf1->prtz == ']') || (inf1->prtz == '}'))
                                {
                                                push(&(s1->vf[p]),inf1->id,inf1->prtz);

                                }
                        else
                        {
                                if(s1->vf[p] != NULL)
                                {
                                        inf2 = (Tinfo*) s1->vf[p]->info;

                                        if((inf1->prtz == '(' && inf2->prtz == ')' ) || (inf1->prtz == '[' && inf2->prtz == ']' ) || (inf1->prtz == '{' && inf2->prtz == '}' ))
                                        {
                                                nr = nr+2;
                                                pop(&s1->vf[p]);
                                        }
                                        else
                                        {
                                                if (nr >= max)
                                                {
                                                        max = nr;
                                                        nr = 0;
                                                }
                                                while(s1->vf[p]!=NULL)
                                                        {
                                                                pop(&s1->vf[p]);
                                                        }
                                        }

                                }
                                else
                                {
                                        if (nr > max)
                                        {
                                                max = nr;
                                                nr = 0;
                                        }
                                }
                        }
                        pop(&S->vf[p]);
                }


                        while(s3->vf[p])
                {
                        inf1 = (Tinfo*)s3->vf[p]->info;
                        if((inf1->prtz == '(') || (inf1->prtz == '[') || (inf1->prtz == '{'))
                                {
                                                push(&(s22->vf[p]),inf1->id,inf1->prtz);

                                }
                        else
                        {
                                if(s22->vf[p] != NULL)
                                {
                                        inf2 = (Tinfo*) s22->vf[p]->info;

                                        if((inf1->prtz == ')' && inf2->prtz == '(' ) || (inf1->prtz == ']' && inf2->prtz == '[' ) || (inf1->prtz == '}' && inf2->prtz == '{' ))
                                        {
                                                nr1 = nr1+2;
                                                pop(&s22->vf[p]);
                                        }
                                        else
                                        {
                                                if (nr1 >= max1)
                                                {
                                                        max1 = nr1;
                                                        nr1 = 0;
                                                }
                                                while(s22->vf[p]!=NULL)
                                                        {
                                                                pop(&s22->vf[p]);
                                                        }
                                        }

                                }
                                else
                                {
                                        if (nr1 > max1)
                                        {
                                                max1 = nr1;
                                                nr1 = 0;
                                        }
                                }
                        }
                        pop(&s3->vf[p]);
                }


                if(nr1 >max1)
                        max1 = nr1;

                if(nr > max)
                        max = nr;
                if(max1 <max && max1 != 0)
                max = max1;
                return max;
}


//sortarea stivei
void sorts(TStiva **S,int p ,int s)
{ //folosesc doua stive auxiliare
        TStiva *s1,*s2;
        //aloc spatiu pentru ele
        s1 = InitS(s);
  s2 = InitS(s);
  //imi declar si doua structuri in care o sa retin si valoarea varfului stivelor
  Tinfo *inf1,*inf2;
  //aloc spatiu pentru ele + verificare
  inf1 =(Tinfo*) malloc(sizeof(Tinfo));
  if (!inf1)
        return;
  inf2 =(Tinfo*) malloc(sizeof(Tinfo));
        if (!inf2)
                return;

        while((*S)->vf[p])
        {
                inf1 = NULL;
                inf2 = NULL;
                //in inf1 retin valorile varfului stivei pricipale
                inf1 = (Tinfo*)(*S)->vf[p]->info;
                //verific daca prima auxiliara este goala si in caz afirmativ adaug elementul in ea
                if(s1->vf[p] == NULL)

                {
                        push(&(s1->vf[p]),inf1->id,inf1->prtz);
                }
                else
                {//altfel vad ce valoare are intregul corespunzator varfului lui s1
                        inf2 = (Tinfo*)s1->vf[p]->info;
                        // daca este mai mare decat valoarea intului lui S in lasam pe pozitie si adaugam peste el varful lui S
                        if(inf1->id < inf2->id)
                        {
                                push(&(s1->vf[p]),inf1->id,inf1->prtz);
                        }
                        else
                        {// altfel mutam in s2 toate elementele ce au intregul mai mic decat cel din varful lui S
                        // il punem pe varful lui S apoi in stiva auxiliara 1 iar apoi mutam elmentele din s2 inapoi in s1
                        //astfel varfului lui s1 ii va corespunde cea mai mica valoare
                                while(s1->vf[p] && inf1->id > inf2->id)
                                {
                                        inf2 = (Tinfo*)s1->vf[p]->info;
                                        push(&(s2->vf[p]),inf2->id,inf2->prtz);
                                        pop(&(s1->vf[p]));
                                        if(s1->vf[p]) inf2 = (Tinfo*) s1->vf[p]->info;
                                }
                                push(&(s1->vf[p]),inf1->id,inf1->prtz);
                                while (s2->vf[p])
                                {
                                        inf2 = (Tinfo*) s2->vf[p]->info;
                                        push(&(s1->vf[p]),inf2->id,inf2->prtz);
                                        pop(&(s2->vf[p]));
                                }
                        }
                }
                //extragem elementul din Stiva principala pana devine nula
                pop(&(*S)->vf[p]);

        }
        //avem toate elementele din Stiva principala intr-o auxliara in ordine inversa fata de cea pe care o vrem asa ca rasturnam auxiliara in principala si obtinem sortarea
        while (s1->vf[p])
        {
                inf1 = (Tinfo*) s1->vf[p]->info;
                push(&(*S)->vf[p] ,inf1->id ,inf1->prtz);
                pop(&(s1->vf[p]));
        }

}

//initializere coada
AQ InitC(int n)
{
   //aloc spatiu pentru Q si pentru inceputul si sfarsitul acesteia care sunt de tipul TCel * si verific daca alocarea a avut loc cu succes
    AQ Q = (AQ)malloc(sizeof(TStiva));
    if (!Q) return NULL;
    Q->ic =(TCel*) malloc(n*sizeof(TCel));
    Q->sc =(TCel*) malloc(n*sizeof(TCel));
    if(!Q->ic || !Q->sc) return NULL;

    //returnez coada obtinuta
    return Q;
}


//functia de introducere in coada
void intrq(AQ Q,int k,int info,char prt)
{
                        //dclar o structura si ii aloc spatiul necesar folosind-o pentru a pastra componentele elementului ce trebuie introdus in coada
           Tinfo * inf;
     inf = (Tinfo*) malloc(sizeof(Tinfo));
     //verific alocare
     if(!inf) return;

     inf->id = info;
     inf->prtz = prt;

     //structura ce repezinta elementul pe care o sa il adaug
     TCel aux;
     //alocare + verificare
    aux = (TCel) malloc(sizeof(Celula));
     if(!aux) return;

     //initializare componente structura lui aux + cast
     aux->info = (void*) inf;
     aux->urm = NULL;

     //doua cazuri
     if(Q->ic[k]) //coada nu este goala
     {
     //sfarsitul cozii se va modifica,coada marindu-se cu un elemet (aux)
                        Q->sc[k]->urm = aux;
        Q->sc[k] = Q->sc[k]->urm;
                        Q->sc[k]->urm=NULL;
     }
     else //coada nula
    {   //coada va fi formata dintrun singur elemtent(aux)
                Q->ic[k] = aux;
                          Q->sc[k] = Q->ic[k];
                Q->sc[k]->urm = NULL;
   }
}



// extragerea din coada
void extrq(TCel *l)
{
        //verific daca e nula si in caz contrar extrag un element
        if(*l != NULL)
        *l = (*l)->urm;

}


//afisarea cozii
void printq(TCel *l,FILE*f2)
{
                //imi declar o structura ce va reprezenta castul facut elementului info din inceputul cozii
                Tinfo *info;
    fprintf(f2,"\"");
    while((*l))
    {
        info = (Tinfo*)(*l)->info;
        //afisez paranteza corespunzatoare incepului apoi il elimin
        fprintf(f2,"%c",info->prtz);
        pop(l);
    }
    fprintf(f2,"\"\n");
}



//verificare sir maxim coada
int correctq(TCoada *Q,int p,int c)
{
        //folosesc o coada auxliara si doua informatii auxiliare;
        int nr = 0,max = 0;
        TCoada *c1;
        Tinfo * inf1,*inf2;
        //initializere coada
        c1 = InitC(c);

        //alocare spatiu info + verificare
        inf1 =(Tinfo*) malloc(sizeof(Tinfo));
  if (!inf1)
        return 1;
  inf2 =(Tinfo*) malloc(sizeof(Tinfo));
        if (!inf2)
                return 1;

                //cat timp am elemente in coada verific ce element am la inceput
                while(Q->ic[p])
                {
                        // verific daca paranteza corespunzatoare inceputului cozii este inchisa si in acest caz o mut intr-o coada auxiliara
                        inf1 = (Tinfo*)Q->ic[p]->info;
                        if((inf1->prtz == '(') || (inf1->prtz == '(') || (inf1->prtz == '{'))
                                {
                                                intrq(c1,p,inf1->id,inf1->prtz);

                                }
                        else
                        {
                                //altfel verific daca coada auxliara este nula
                                if(c1->ic[p] != NULL)
                                {
                                        //daca nu este
                                        inf2 = (Tinfo*) c1->ic[p]->info;

                                        if((inf1->prtz == ')' && inf2->prtz == '(' ) || (inf1->prtz == ']' && inf2->prtz == '[' ) || (inf1->prtz == '}' && inf2->prtz == '{' ))
                                        {
                                                nr = nr+2;
                                                extrq(&c1->ic[p]);
                                        }
                                        else
                                        {
                                                if (nr >= max)
                                                {
                                                        max = nr;
                                                        nr = 0;
                                                }
                                                while(c1->ic[p]!=NULL)
                                                        {
                                                                extrq(&c1->ic[p]);
                                                        }
                                        }

                                }
                                else
                                {
                                        if (nr > max)
                                        {
                                                max = nr;
                                                nr = 0;
                                        }
                                }
                        }
                        extrq(&Q->ic[p]);
                }
                if(nr >max)
                        max = nr;
                return max;
}

//ordonarea cozii
void sortq(TCoada **Q,int p ,int c)
{
        //folosesc doua stive auxiliare pe care le aloc si doua structuri Tinfo
        TStiva *q1,*q2;
        q1 = InitS(c);
        q2 = InitS(c);
        Tinfo *inf,*inf2;
        inf = (Tinfo*)malloc(sizeof(Tinfo));
        if (!inf)
                 return ;
        inf2 = (Tinfo*)malloc(sizeof(Tinfo));
        if(!inf2)
                return ;

        while((*Q)->ic[p])
                {
                //pastrez inceputul cozii
                inf2 =NULL;
                inf = NULL;
                inf = (Tinfo*)(*Q)->ic[p]->info;
                if(q1->vf[p] == NULL)
                        {
                                //daca stiva 1 auxiliara este goala punem inceputul cozii in ea
                push(&(q1->vf[p]),inf->id,inf->prtz);
                        }
                else
                        {
                                //altfel pastram varful stivei si il comparam cu inceputul cozii
                                inf2 = (Tinfo*)q1->vf[p]->info;
                                if(inf->id < inf2->id)
                                        {
                                                //daca este mai mare rasturnam inceputul cozii peste el
                                                push(&(q1->vf[p]),inf->id,inf->prtz);

                                        }
                                else

                                        {//mutam varful stivei auxiliare 1 in auxiliara 2 pana cand gasim un varf mai mare ca inceputul cozii
                                                while(q1->vf[p]  && inf->id > inf2->id )
                                                {
                                                        inf2 = (Tinfo*)q1->vf[p]->info;
                                                        push(&(q2->vf[p]),inf2->id,inf2->prtz);
                                                        pop(&(q1->vf[p]));
                                                        if(q1 ->vf[p])  inf2 = (Tinfo*) q1->vf[p]->info;

                                                }
                                                //punem inceputul cozii in stiva
                                                push(&(q1->vf[p]),inf->id,inf->prtz);
                                                //mutam elementele inpoi in auxiliara 1
                                                        while(q2->vf[p])
                                        {
                                                inf2 = (Tinfo*)q2->vf[p]->info;
                        push(&(q1->vf[p]),inf2->id,inf2->prtz);
           pop(&(q2->vf[p]));

                                        }

                                }
                }
        // extragem inceputul stivei
        extrq(&(*Q)->ic[p]);

        }
        //extragem varful stivei si il punem in coada care a devenit goala inainte de aceasta operatie si astfel o sortam
        while(q1->vf[p]!=NULL)
        {
                inf = (Tinfo*)q1->vf[p]->info;
                intrq((*Q),p,inf->id,inf->prtz);
                pop(&(q1->vf[p]));
        }

}

//functie copiere cozi
AQ copiecoada(AQ Q,int c)
{
                                //coada auxiliara pe care o intializam
        AQ q1;
        q1 = InitC(c);
        int i ;
        //pentru fiecare coada fac copierea;
        for (i = 0;i < c;i++)
        {
                q1->ic[i] = Q->ic[i];
                q1->sc[i] = Q->ic[i];

        }
        return q1;
}


//functie auxiliara de copiere a unei cozi -nu merge
AQ copiecoadaa(AQ Q,int p,int c)
{
        //folosim doua cozi auxiliare pentru care facem alocarile aferente
        Tinfo *inf;
        inf = (Tinfo*)malloc(sizeof(Tinfo));

        AQ s1,s2;
        s1 = InitC(c);
        s2 = InitC(c);

        while (Q->ic[p])
        {
                //pastram inceputul cozii
                inf = (Tinfo*)Q->ic[p]->info;
                //il introducem in ambele auxiliare si apoi il extragem din coada principala
                intrq(s1,p,inf->id,inf->prtz);
                intrq(s2,p,inf->id,inf->prtz);
                extrq(&(Q->ic[p]));

        }

        while(s1->ic[p])
        {
                // mutam acum inappoi tot din s1 inapoi in coada principala pentru a ramane intacta
                inf = (Tinfo*)s1->ic[p];
                intrq(Q,p,inf->id,inf->prtz);
                // extragem mereu inceputul cozii s1 pentru ca aceasta sa devina nula
                 extrq(&(s1->ic[p]));

        }

        return s2;
}


int main(int argc, char *argv[])
{
   //iau doua fisiere:f1 - din care citesc
   //f2 - in care scriu
    FILE *f1,*f2;
    //imi declar doua cozi si doua stive
    ASt S,s1;
    AQ Q,q1;
    /*declar n,s,c si apoi le citesc din fisierul de intrare acestea reprezentand
    n-nr de operatii
    s-nr de stive
    c-nr de cozi
    */
    int n,s,c;
    //declar un char care va reprezenta numele comenzii citite de pe fiecare rand
    char op[10];

    // deschid fisierele
    f1=fopen(argv[1],"r");
    f2 = fopen(argv[2],"w");
    fscanf(f1,"%d%d%d",&n ,&s, &c);

                //imi aloc spatiu pentru  o coada si o stiva
                Q = InitC(c);
                S = InitS(s);


    int i,j;
    int pozvct,info; //pozitia stivei si cifra corespunzatoare fiecarului el din fiecare stiva si coada
    char prt; // paranteza

                //pentru fiecare linie vad ce operatie este scrisa pe ea si in functie de aceasta citesc si restul liniei si execut operatia corespunzatoare
    for(i=0; i<n; i++)
    {
        fscanf(f1,"%s",op);
        if(strcmp(op,"push")==0)
        {
                                                //citesc pozitia == coada in care trebuie sa adaug;si ce trebuie sa adaug:numar+paranteza
            fscanf(f1,"%d %d %c",&pozvct, &info, &prt);
            push(&(S->vf[pozvct]), info, prt);

        }


        if(strcmp(op,"extrq")==0)
        {
                                                //citesc din ce coada extrag
            fscanf(f1,"%d",&pozvct);
            extrq(&(Q->ic[pozvct]));
        }

        if(strcmp(op,"printq")==0)
        {
            for(j=0; j<c; j++)
            {
                        //fac copie pentru fiecare coada si printez copia pentru a nu strica coada pe care o s-o folosesc in continuare
                        q1 = copiecoada(Q,c);
                printq(&(q1->ic[j]),f2);
            }
        }

        if(strcmp (op, "sortq") == 0)
        {
                //citesc pentru ce coada fac sortarea si sortez
           fscanf(f1, "%d", &pozvct);
           sortq(&Q, pozvct, c);
        }


        if(strcmp(op,"correctq") == 0)
        {
                                        //aplic functie correctq pentru p copie a cozii pe care o folosesc
           fscanf(f1, "%d", &pozvct);
           q1 = copiecoada(Q, c);
           fprintf(f2, "%d\n", correctq(q1 ,pozvct ,c));
        }

        if(strcmp(op ,"pop") == 0)
        {
                                                //citesc din ce lista elimin varful si execut
            fscanf(f1,"%d", &pozvct);
            pop(&(S->vf[pozvct]));
        }

        if(strcmp(op, "intrq") == 0)
        {
                                                //vad in ce stiva si ce introduc in ea
            fscanf(f1,"%d %d %c",&pozvct,&info,&prt);
           intrq(Q,pozvct,info,prt);

        }

        if(strcmp(op ,"prints") == 0)
        {
                        //fac copie stivelor
                        s1 = copiestiva(S,s);
                                                for(j=0; j<s; j++)
            {
                        // printez copiile
                        fprintf(f2, "\"");
                prints(&(s1->vf[j]) ,f2);
                fprintf(f2 ,"\"\n");
            }
        }

                                if(strcmp(op, "sorts") == 0)
        {
                //sortez o stiva care mi se cere
           fscanf(f1,"%d", &pozvct);
           sorts(&S, pozvct, s);
        }

                                 if(strcmp(op,"corrects")==0)
        {
                //citesc stiva pentru care trebuie sa gasesc subsirul maxim,ii fac o copie si aplic functia pentru  copie
                fscanf(f1,"%d",&pozvct);
                s1 = copiestiva(S,s);
                                  fprintf(f2,"%d\n",corrects(s1,pozvct,s));
        }
    }

  return 0;
 }//*SFARSIT* 
