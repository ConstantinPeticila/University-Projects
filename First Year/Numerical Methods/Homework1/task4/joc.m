function [] = joc ()

  ok = -1;
  %crearea unei matrice de caractere
  x = [['_','_', '_']
        ['_','_','_']
        ['_','_','_']];
  %explicarea regulilor pentru utilizator      
  printf('Joaca x si 0!La inceput trebuie sa iti alegi daca vrei sa fii cu x (caz in care vei incepe) sau cu 0 (caz in care calculatorul va face prima mutare).\n Pentru a coompleta o casuta trebuie sa iti alegi mai intai indicele liniei si apoi cel al coloanei. \n  Daca vrei sa iesi apasa tasta "q"\n ');       
  %alegerea utilizatorului
  prompt = "Cu ce vrei sa joci?x/0:";
  str = input(prompt,"s");

  while ((str ~= 'q'&& str ~= 'x' && str ~= '0') || length(str) ~= 1)
      str = input("alege altceva:","s");
 endwhile
  if (str == 'x' && length(str) == 1)
  printf('Ai ales sa joci cu x \n');
  elseif (str == '0'&& length(str) == 1)
  printf('Ai ales sa joci cu 0 \n');
  elseif (str == 'q'&& length(str) == 1)
  break;
  endif
  
  if(str == 'x')
    rts = '0';
  elseif str == '0'
    rts = 'x';
  endif
 %initializarea elementelor unui vector ce vor reprezenta numarul de victorii utilizator,egaluri si infrangeri

 numara = [ 0,0,0];
%daca utilizatorul alege sa fie cu 0,pc-ul face pprima mutare in centru
 if str == '0'
  %afisarea matricei initiale
  afisarematrice(x,numara);
  x(2,2) = 'x';
  printf('Este randul calculatorului');
  endif

 

  %jocul se desfasoara cat timp sunt pozitii libere si nimeni nu a castigat 
  while (verificare(x,ok) == 1 && won(x,str,rts) == 0)
    afisarematrice(x,numara);
    printf('Este randul tau:\n');
    %mutarea utilizatorului
    x=mutare(x,str);
    if x == eye(3)
      printf('Ati parasit jocul!\n');
      break;
     endif
    afisarematrice(x,numara);
   %verificare conditii pentru incheiere partida
    if (won(x,str,rts) ==1 )
       printf('AI CASTIGAT');
      numara(1) +=1; 
      afisarematrice(x,numara);
      break;
    elseif (won(x,str,rts) ==2 )
      printf('AI PIERDUT');
      numara(3) += 1;
      afisarematrice(x,numara);
      break;
    elseif(verificare(x,ok) == 3)
      printf('EGAL');
      numara(2)+=1;
      afisarematrice(x,numara);
      break;
    endif
    %mutarea calculatorului
    printf('Este randul calculatorului:\n');
    x=mutarepc(x,rts,str);
   %verificarea acelorasi conditii
   if (won(x,str,rts) ==1 )
      numara(1) +=1; 
      printf('AI CASTIGAT');
      afisarematrice(x,numara);
    elseif (won(x,str,rts) ==2 )
      printf('AI PIERDUT');
      numara(3) += 1;
      afisarematrice(x,numara);
    elseif(verificare(x,ok) == 3)
      printf('EGAL');
      numara(2)+=1;
      afisarematrice(x,numara);
    endif
  endwhile
  %alegere de rejucare
  a=input("vrei sa mai joci[Y/N(q,enter)]:","s");
  while (a ~= 'q' && a ~= 'Y' && a ~= 'N')
      a = input("alege altceva:","s");
  endwhile
  
  if (a == 'N' || a == 'q')
   
    break;
  elseif a == 'Y'
    ok1 = 1;
    while(ok1 == 1) %se reia aceeasi structura fara initializarea numarului de partide dde fiecare
      
       x = [['_','_', '_']
           ['_','_','_']
           ['_','_','_']];
        
      prompt = "Cu ce vrei sa joci?x/0:";
      str = input(prompt,"s");
      while ((str ~= 'q' && str ~= 'x' && str ~= '0' )||( length(str) ~= 1))
        str = input("alege altceva:","s");
        endwhile
          if (str == 'x'&& length(str) == 1)
          printf('Ai ales sa joci cu x \n');
        elseif (str == '0'&& length(str) == 1)
          printf('Ai ales sa joci cu 0 \n');
  
        elseif (str == 'q'&& length(str) == 1)
          break;
        endif
    
      if(str == 'x')
        rts = '0';
      elseif str == '0'
        rts = 'x';
     endif
    
    if str == '0'
      afisarematrice(x,numara);
      x(2,2) = 'x';
       printf('Este randul calculatorului');
    endif

 
     while (verificare(x,ok) == 1 && won(x,str,rts) == 0)
        afisarematrice(x,numara);
        printf('Este randul tau:\n');
        x=mutare(x,str);
        if x == eye(3)
          printf('Ati parasit jocul!\n');
          break;
        endif
        
        afisarematrice(x,numara);
        if (won(x,str,rts) ==1 )
          numara(1) +=1; 
          afisarematrice(x,numara);
          break;
        elseif (won(x,str,rts) ==2 )
          numara(3) += 1;
          afisarematrice(x,numara);
          break;
        elseif(verificare(x,ok) == 3)
          printf('este egal');
          numara(2)+=1;
          afisarematrice(x,numara);
          break;
        endif
  
        printf('Este randul calculatorului:\n');
        x=mutarepc(x,rts,str);
        if (won(x,str,rts) ==1 )
          numara(1) +=1; 
          afisarematrice(x,numara);
        elseif (won(x,str,rts) ==2 )
          numara(3) += 1;
          afisarematrice(x,numara);
        elseif(verificare(x,ok) == 3)
           printf('este egal');
          numara(2)+=1;
          afisarematrice(x,numara);
     
        endif
        endwhile

        a=input("vrei sa mai joci[Y(enter)/N(q)]:","s");
        while (a ~= 'q' && a ~= 'Y' && a ~= 'N')
          a = input("alege altceva:","s");
        endwhile
        if (a == 'N' || a == 'q')
       
          break;
        elseif a == 'Y'
      
        endif
  endwhile
  endif
 endfunction