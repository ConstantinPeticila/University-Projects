function x = morse_encode(c)
 %verific daca lungimea este 1,adica se introduce un caracter iar in caz contrar eturnez "*" pentru ca inputul nu este potrivit si inchei programul
 if length(c) ~= 1
    x = "*";
    return
   endif
  %daca a fost introdusa o litera mica in loc de litera mare fac conversia 
  aux = "abcdefghijklmnopqrstuvwxyz";
  aux2 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  n = length(aux);
  for i = 1:n
    if c == aux(i)
      c = aux2(i);
    endif
  endfor
	ok0=0;
	%verific daca este introdusa o valoare corecta,altfel opresc functia	
	vectorlitere="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	for i =1:length(vectorlitere)
		if vectorlitere(i)==c
			ok0 = 1;
			break;
		endif
	endfor

	if ok0 == 0	
		x="*";
		return
	endif  

	% initialiez M cu cell array-ul corespunzator codului morse
  M = morse(); 
  %initializez A cu o structura ce cuprinde in interiorul ei tot arborele codului morse
  %Astfel morse() va reprezenta elemtul de pe prima pozitie a lui A
  A = {M};
  %realizez o structura care ma va ajuta in pastrarea raspunsusului in x
  B = {''};
  %initializez ok cu 0 pentru a realiza functia while din care is atunci cand gasesc litera pe care o caut
  ok = 1;
  while  ok
    A1 = A{1};
    %x ia valoarea elemtului stocat in prima poztie a lui B si astfel x va avea stocat drumul catre litera corespunzatoare
    x = B{1};
		%Il copiez pe A in A1 pentru a il putea folisi dupa modificarea lui A
    % A ia valoarea lui A fara prima pozitie iar poztiile avanseaza cu o unitate
   %Acelasi lucru si la B 
		A2=A;
		for i = 2:length(A)
			A{i-1} = A{i};	
		endfor
		
		
		for i = 2:length(B)
			B{i-1} = B{i};	
		endfor	
		
		
    %verific daca A1 este gol,in caz contrar verific daca este stocat pe prima pozitie litera pe care o cautam
	
    ok1 = isempty(A1);
		if ok1 == false
      %In cazul in care litera corespunzatoare lui A1 este aceea pe care o cautam oprim programul iar drumul pana la ea ramane salvat in x; 
			litera=A1{1};       
			if litera == c
  	    %iesim din functie iar x ramane B{1}
         break;
       else
     
					A = {A2{1}{2} A2{1}{3} A{1:end}};
				
				 B = {strcat(x ,'.') strcat(x,'-') B{1:end}};
      endif
    endif
  
  endwhile	

  endfunction
