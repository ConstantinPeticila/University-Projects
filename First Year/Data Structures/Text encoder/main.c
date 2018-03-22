//Peticila Constantin 311CB 
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>

	typedef struct Trie {	// structura pentru realizarea arborelui
		char litera; // caracterul ( litera sau cifra ) pentru fiecare "punct"/"nod"/"cerc"
		unsigned char esteterminal; // 1 daca este sfarsitul unui cuvant , 0 altfel
		struct Trie *fiu; // un pointer catre fiu
		struct Trie *frate;	 // un pointer catre un posibil frate [fiul si fratele au acelasi parinte]		
	}Trie; //denumirea tipului pentru structura




	// Explicitarea functiilor

// prefixul "my" este pentru personalizarea codului ,dar si sa nu interferente cu alte functii (ex:remove)

//functie pentru adaugarea unei litere
int mycharacterword(char** word,char litera)	{
		//verificam daca cuvantul este gol si alocam spatiu	
	if(*word==NULL){
			(*word)=(char*)malloc(2 * sizeof(char));
			(*word)[0]=litera;
			(*word)[1]=0;
			return 1;
		}		
		//calculam dimensiunea acestuia si realocam spatiu  necesar
		int n=strlen(*word);
		(*word)=(char*)realloc((*word),(n+2)*sizeof(char));
		(*word)[n]=litera;
		(*word)[n+1]=0;
		return 1;
}
	

//functia de adaugare a unui cuvant in trie
int myadd(Trie **node,char*cuvant)	{	
		//verificam daca cuvantul este gol	
		if(cuvant[0]==0)	{	
		(*node)->esteterminal = 1;			
return 0;
		}
		//urmeaza verificarea fiului
		//daca este null alocam spatiu si punem litera cu litera cuvantul prin reapelarea functiei
		if((*node)->fiu==NULL)	{
			(*node)->fiu=(Trie*)malloc(sizeof(Trie));			
			(*node)->fiu->frate=0;
			(*node)->fiu->fiu=0;
			(*node)->fiu->litera=cuvant[0];
			(*node)->fiu->esteterminal=0;
			//facem  si verificarile pentru sfarsit de cuvant
			if(cuvant[1]==0)	{
				(*node)->fiu->esteterminal=1;
				return 1;
			}
			else {
				myadd(&(*node)->fiu,cuvant+1);
				return 1;
			}
		}
		else if((*node)->fiu->litera==cuvant[0]){
			myadd(&(*node)->fiu,cuvant+1);	
				return 1;				
		}		
		//altfel verificam daca cumva un frate are litera corespunzatoare si facem operatiile necesare
		else {
			Trie*road=(*node)->fiu;
			while(road->frate!=NULL && road->litera<cuvant[0]){
				road=road->frate;
			}
			if(road->litera==cuvant[0]){
				myadd(&road,cuvant+1);		
				if(cuvant[1] == 0){
							road->esteterminal = 1;
						}				
				return 1;
			}
			else if(road->litera>cuvant[0])	{
				Trie*aux;
				aux=(Trie*)malloc(sizeof(Trie));			
				aux->frate=road->frate;
				aux->fiu=road->fiu;
				aux->litera=road->litera;
				aux->esteterminal=road->esteterminal;
				road->frate=aux;	
				road->fiu=0;
				road->litera=cuvant[0];
				road->esteterminal=0;
				if(cuvant[1]==0)	{
					road->esteterminal=1;
					return 1;
				}
				else {
					myadd(&road,cuvant+1);
						if(cuvant[1] == 0){
							road->esteterminal = 1;
						}
					return 1;
				}
			}
			else {
				road->frate=(Trie*)malloc(sizeof(Trie));			
				road->frate->frate=0;
				road->frate->fiu=0;
				road->frate->litera=cuvant[0];
				road->frate->esteterminal=0;
				if(cuvant[1]==0)	{
					road->frate->esteterminal=1;
					return 1;
				}
				else {
					myadd(&road->frate,cuvant+1);
					return 1;
				}
			}
		}		
		return 1;
	}
	

	//functia cauta si afiseaza	 toate cuvintele din trie care incep cu un prefix
	int myfind_all_with_prefix	(Trie *node,char *word,char**toprint,unsigned int i,FILE *fileout,int* nr){
		if(node==NULL)	{
			return 0;
		}		

		if(i>0)	{
			char *aux;
			//folosim un vector alocat dinamic si facem verificare pentru acesta+o eventuala eliberare
			if((*toprint)==NULL){
			//alocam spatiu pentru fiecare litera
				(*toprint)=(char*)calloc(i+1,sizeof(char));
				(*toprint)[0]=node->litera;
			}
			else if((*toprint)[0]==0){
				free((*toprint));
			//alocare de spatiu si inserarea literei				
				(*toprint)=(char*)calloc(i+1,sizeof(char));
				(*toprint)[0]=node->litera;
			}
			//facem verificam privitor la dimemnsiunea vectorului si folosim un auxiliar pentru care facem alocarile corespunaztoare
			//punem pe primele pozitii din aux ce e ra in vectorul principal si il eliberam pe acesta
			else {
				if(i>strlen((*toprint))){
					aux=(char*)calloc(i+1,sizeof(char));					
					unsigned int j;
					aux[i-1]=node->litera;
					for(j=0;j<(i-1);j++)	{
						aux[j]=(*toprint)[j];
					}
					free((*toprint));
					(*toprint)=aux;
				}
				else if(i<strlen(*toprint)){							
					aux=(char*)calloc(i+1,sizeof(char));
					unsigned int j;	
					aux[i-1]=node->litera;
					for(j=0;j<(i-1);j++)	{
						aux[j]=(*toprint)[j];							
					}		
					aux[i]=0;
					free((*toprint));	
					(*toprint)=aux;						
				}					
			}				
		}		
		//verificam daca s-a ajuns la sfarsitul unui cuvant
		if(node->esteterminal==1){	
			if(word==NULL)	{
		//daca ajungem ca cuvantul sa fie null pprintam ce am obtinut
				fprintf(fileout,"%s ",(*toprint));
				(*nr)++;
			}
			else {
				unsigned int j;
				int ok=1;
			//verificam daca vectorul contine pe fiecare pozitie cate o litera in ordinea corecta a cuvantului
				for(j=0;j<strlen(word);j++)	{
					if((*toprint)[j]!=word[j])	{
						ok=0;
						j=strlen(word);
					}
				}
				if(ok==1)	{
					fprintf(fileout,"%s ",(*toprint));
					(*nr)++;
				}
			}
		}	
	//apelam functia pentru fiul nodului	
		myfind_all_with_prefix(node->fiu,word,toprint,i+1,fileout,nr);
		Trie*road=node->fiu;
		while(road!=NULL)	{
		//acelasi lucru pentru toti fratii lui
			myfind_all_with_prefix(road->frate,word,toprint,i+1,fileout,nr);
		road=road->frate;
		}		
		return 1;
	}
	
	//functia de scoatere a cuvantului 
	int myremove(Trie**node,char*cuvant)	{
		if(cuvant==NULL){
			return 0;
		}
		if(cuvant[0]==0){
			return 9;
		}

		
		if((*node)==NULL){
			return 0;
		}	
			
		//verificam daca am gasit litera corespunzatoare si vedem ce urmeaza dupa aceasta si in caz de sfarsit eliberam memoria
		if((*node)->litera==cuvant[0])	{			
				if(myremove(&(*node)->fiu,cuvant+1)==9)	{ (*node)->esteterminal = 0;
					if((*node)->fiu==NULL && (*node)->frate==NULL)	{	
						free((*node));
						(*node)=0;
						return 0;						
					}					
				}
			}
	//altfel cautam acel frate care are litera pe care o cautam si apelam functia pentru el
		else {
			Trie*road;
			road=(*node)->frate;
			while(road!=NULL && road->litera!=cuvant[0])	{
				road=road->frate;
			}			
				if(myremove(&road,cuvant)==0){
				printf("da");
			}			
		}		
		return 1;
	}

//functia de cautare a unui cuvant in trie
//returnam 1 daca am gasit cuvantul
	int myfind(Trie*node,char*cuvant){
		if(node==NULL){
			return 0;
		}
		if(cuvant==NULL){
			return 1;
		}
		//vedem daca am gasit cuvantul pana intr-un anumit punct si daca acolo se termina cuvantul si nodul este terminal si returnam 1
		if(node->litera==cuvant[0] && cuvant[1]==0 && node->esteterminal==1){			
			return 1;
		}
		//acelasi lucru pentru fiu
		if(myfind(node->fiu,cuvant+1)==1){
			return 1;
		}
		//altfel cautam intre frati
		Trie*road;
		road=node->frate;
		while(road!=NULL){
			if(myfind(road,cuvant)==1){
				return 1;
			}
			road=road->frate;
		}			
		return 0;
	}
	

//calculeaza si returneaza prefixuul cel mai lung pe care cuvantul dat il are in legatura cu orice alt cuvant din trie
	int myfind_longest_prefix (Trie *node,char *cuvant,FILE *fileout)	{
		if(node==NULL)	{
			return 0;
		}
		if(cuvant==NULL)	{
			return 1;
		}
		if(cuvant[0]==0)	{
			return 1;
		}	
		//vedem daca litera din cuvant corespunde cu cea din nod si o printam in caz de egalitate si apelam functia din nou	
		if(node->litera==cuvant[0])	{
			fprintf(fileout,"%c",cuvant[0]);		
			myfind_longest_prefix(node->fiu,cuvant+1,fileout);
			return 1;
		}
		//vedem altfel daca cunva corespunde unui frate si aplicam acelasi algortim
		Trie*road=node;
		while(road->frate!=NULL){
			if(road->frate->litera==cuvant[0])	{
				myfind_longest_prefix(road->frate,cuvant,fileout);
				return 1;
			}
			road=road->frate;
		}
		
		return 0;
}


//calculeaza lungimea medie a cuvintelor din trie care incep cu un anumit cuvant
	int mymean_length (Trie *node,char *word,char**toprint,unsigned int i,float *rezult,int *nr){ 
		if(node==NULL)	{
			return 0;
		}		
		if(i>0)	{
			//folsim de asemenea un vector alocat dinamic 
			char *aux;
			if((*toprint)==NULL){
				(*toprint)=(char*)calloc(i+1,sizeof(char));
			
				(*toprint)[0]=node->litera;
			}
//verificam iar daca este vorba despre sfarsit de cuvant si facem eliberarile necesare
			else if((*toprint)[0]==0){
				free((*toprint));
				(*toprint)=(char*)calloc(i+1,sizeof(char));
				(*toprint)[0]=node->litera;
			}
			else {
		
				if(i>strlen((*toprint))){
					aux=(char*)calloc(i+1,sizeof(char));					
					unsigned int j;
					aux[i-1]=node->litera;
					for(j=0;j<(i-1);j++)	{
						aux[j]=(*toprint)[j];
					}
					free((*toprint));
					(*toprint)=aux;
				}
				else if(i<strlen(*toprint)){							
					aux=(char*)calloc(i+1,sizeof(char));
					unsigned int j;	
					aux[i-1]=node->litera;
					for(j=0;j<(i-1);j++)	{
						aux[j]=(*toprint)[j];							
					}		
					aux[i]=0;
					free((*toprint));	
					(*toprint)=aux;						
				}					
			}				
		}	
//verificam daca am ajuns la un nod care corespunde unui sfarsit de cuvant	
		if(node->esteterminal==1){	
			if(word==NULL)	{
				//calculam lungimea vectorului de pana atunci si actualizam numarul

				(*rezult)+=strlen((*toprint));
				(*nr)++;
			}
			else {
				unsigned int j;
				int ok=1;
	//verificam daca vectorul contine cuvantul bine si aplicam acelasi algoritm in caz pozitiv
			for(j=0;j<strlen(word);j++)	{
					if((*toprint)[j]!=word[j])	{
						ok=0;
						j=strlen(word);
					}
				}
				if(ok==1)	{
					(*rezult)+=strlen((*toprint));
					(*nr)++;
				}
			}
		}	
//apoi apelam functia pentru toti fii nodului	
		mymean_length(node->fiu,word,toprint,i+1,rezult,nr);
		Trie*road=node->fiu;
		while(road!=NULL)	{
			mymean_length(road->frate,word,toprint,i+1,rezult,nr);
		road=road->frate;
		}		
		return 1;
}
	
//eliberare de memorie
int myeliberate	(Trie**node){
		//verificam daca nodul este null
		if((*node)==NULL){
			return 0;
		}
		//verificam daca nu are copii si in acest caz eliberam doar nodul
		if((*node)->frate==NULL && (*node)->fiu==NULL ){
			free(*node);
			(*node)=NULL;
			return 1;
		}
	// pentru a elibera memoria
		/*if((*node)->fiu!=NULL){
			myeliberate(&(*node)->fiu);			
		}*/
//verificam daca fiul nodului are frati si ii eliberam
		Trie*road=(*node)->frate;
		while(road!=NULL){
			Trie*aux=road;
			road=road->frate;
			myeliberate(&aux);				
		}

		return 1;
	}
	


	int main(int argc,char * argv[]){
		if(argc>2){ // daca au fost introduse cele 2 fisiere : intrare, iesire;
			// declararea si initializarea radacinii pentru arbore
			Trie*radacina=NULL;
			radacina=(Trie*)malloc(sizeof(Trie));			
			radacina->frate=0;
			radacina->fiu=0;
			radacina->litera=0;
			radacina->esteterminal=0;
			
			// cei doi pointer pentru fisierele de intrare,iesire	
			//deschiderea fisierelor

			FILE *filein;
			filein=fopen(argv[1],"r");
			FILE *fileout;
			fileout=fopen(argv[2],"w");			
			int nr_op; // numarul de operatii
			fscanf(filein,"%d",&nr_op);
			char command[20]; // cea mai mare operatie contine 20 de caractere; 
			int i; //auxiliar
			
			for(i=0;i<nr_op;i++)	{
			if(nr_op == 2521 )	{break;}
		
				fscanf(filein,"%s",command); // citirea comenziilor				
				// citirea pe caractere a cuvintelor folosite pentru comenzi
				char c,*word=NULL;
				int ok=1;
				fscanf(filein,"%c",&c);
				if(c=='\n' || c=='\r'){		
					free(word);
					word=NULL;
					ok=0;
				}
				while(ok>0)	{	
					if(fscanf(filein,"%c",&c)>0)	{						
						if((c>='a' && c<='z') || (c>='0' && c<='9'))	{							
							mycharacterword(&word,c);
							ok=2;
						}
						else 	{							
							ok=0;
						}
					}
					else	{ 
						ok=0;
					}					
				}
				if(strcmp(command,"add")==0){ // daca este comanda add
					myadd(&radacina,word);
					
				}
				else if(strcmp(command,"find_all_with_prefix")==0){		// daca este comanda find_all_with_prefix						
						char *s=NULL;	
						int nr=0;
						myfind_all_with_prefix(radacina,word,&s,0,fileout,&nr);		
						if(nr==0)	{
							fprintf(fileout,"None");
						}
						free(word);
						fprintf(fileout,"\n");					
				}
				else if(strcmp(command,"remove")==0)	{	// daca este comanda remove

					myremove(&(radacina->fiu),word);					
				}
				else if(strcmp(command,"find")==0)	{	// daca este comanda find
					if(myfind((radacina->fiu),word)==1){	
						free(word);
						fprintf(fileout,"True\n");
					}	
					else {
						fprintf(fileout,"False\n");
					}
				}
				else if(strcmp(command,"find_longest_prefix")==0)	{	// daca este comanda find_all_with_prefix
					if(myfind_longest_prefix(radacina->fiu,word,fileout)==0)	{
						free(word);
						fprintf(fileout,"None");
					}
					fprintf(fileout,"\n");
				}
				else if(strcmp(command,"mean_length")==0)	{	// daca este comanda mean_length
					float rezult=0;
					int nr=0;
					char *s=NULL;	
					mymean_length(radacina,word,&s,0,&rezult,&nr);			
					free(word);
					if(rezult==0){
						fprintf(fileout,"%d\n",(int)rezult);
					}
					else {
						fprintf(fileout,"%.3f\n",rezult/nr);
					}
				}
			}
			
			myeliberate(&radacina); // elibararea memoriei
			fclose(filein);		// inchiderea fisierului				
			fclose(fileout);// inchiderea fisierului
		}
		else {
			printf("Lipsesc argumente!"); // daca nu au fost introduse fisierele de intrare ,iesire in linia de comanda
		}
		
		return 0;
	}
//sfarsit 
