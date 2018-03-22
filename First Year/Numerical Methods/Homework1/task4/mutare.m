function [X] = mutare (X,str)
  %utilizatorul trebuie sa introduca de la tastatura numarul liniei si al coloanei [e care vrea sa puna
  %daca unul dintre ele este "q" atunci jocul curent se opreste
    l = input('Alege coloana pe care vrei sa pui:','s');
    if ( l =='q')
      %in cazul in care una dintre ele este 'q' atunci matricea se va transforma in eye(3) acest lucru folosind in functia principala pentru iesire
      X =eye(3);
     break;
     
    endif
    
   c  = input('Alege linia   pe care vrei sa pui:','s');
   if ( c =='q')
    X = eye(3);
    break;
   endif  
    
  %verific daca datele sunt corecte si reapelez functia in caz contrar
   
  if( (l ~= '1' && l~= '2' &&l ~= '3')||(c~='1' && c ~= '2' && c ~='3')||(length(l) ~=1) ||(length(c) ~=1))
    printf('Alegere incorecta!Alege din nou:\n');  
    
  X=mutare(X,str);  
 endif
%verific daca pozitia este disponibila si apelez functia in caz contrar 
  if( l == '1' && c == '1' && (length(l) ==1) && (length(c) ==1))
    if (X(1,1) == '_')
    X(1,1) = str;
    
    else printf('Casuta ocupata!Alege din nou!\n');
    X=  mutare(X,str);
    endif
  
    elseif( l == '1' && c == '2' && (length(l) ==1) && (length(c) ==1) )
     if (X(1,2) == '_')
       X(1,2) = str;
   
      else printf('Casuta ocupata!Alege din nou!\n');
        X=mutare(X,str);
      endif
    elseif( l == '1' && c == '3' && (length(l) ==1) && (length(c) ==1))
      if (X(1,3) == '_')
        X(1,3) = str;
    
      else printf('Casuta ocupata!Alege din nou!\n');
        X=mutare(X,str);
      endif
  
   elseif( l == '2' && c == '1' && (length(l) ==1) && (length(c) ==1))
      if (X(2,1) == '_')
        X(2,1) = str;
    
      else printf('Casuta ocupata!Alege din nou!\n');
        X=mutare(X,str);
      endif
  
   elseif( l == '2' && c == '2' && (length(l) ==1) && (length(c) ==1))
      if (X(2,2) == '_')
        X(2,2) = str;
    
     else printf('Casuta ocupata!Alege din nou!\n');
        X =mutare(X,str);
      endif
    elseif( l == '2' && c == '3' && (length(l) ==1) && (length(c) ==1))
      if (X(2,3) == '_')
        X(2,3) = str;
     
      else printf('Casuta ocupata!Alege din nou!\n');
       X =  mutare(X,str);
      endif
  
   elseif( l == '3' && c == '1' && (length(l) ==1) && (length(c) ==1) )
      if (X(3,1) == '_')
          X(3,1) = str;
      else printf('Casuta ocupata!Alege din nou!\n');
        X = mutare(X,str);
      endif
  
   elseif( l == '3' && c == '2' && (length(l) ==1) && (length(c) ==1))
      if (X(3,2) == '_')
        X(3,2) = str;
    
      else printf('Casuta ocupata!Alege din nou!\n');
       X =  mutare(X,str);
      endif
  
   elseif( l == '3' && c == '3' && (length(l) ==1) && (length(c) ==1))
      if (X(3,3) == '_')
        X(3,3) = str;
     else printf('Casuta ocupata!Alege din nou!\n');
       X = mutare(X,str);
     endif
     
  endif 

endfunction