function x = multiple_encode(str)
  %x initializez x
  x='';
  %calculez lungimea lui x
  n = length(str);
  %verific daca este sirul nul si intorc "*" in acest caz
  if n == 0
   x="*";
   return 
  endif 
  %daca primesc litere mici le transform in litere mari sa nu conteze in nrezolvare
  aux = "abcdefghijklmnopqrstuvwxyz";
  aux2 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  n1 = length(aux);
  for i = 1:n1
    for j = 1:n
      if str(j) == aux(i)
        str(j) = aux2(i);
      endif
    endfor
  endfor
  %x primeste valoarea codarii primei litere
  x = morse_encode(str(1));
  %stringul se micsoreaza cu 1 iar literele avanseaza cu o pozitie 
  str = str(2:end);
  %initializez ok = 0 pentru a creea o bucla ce se termina doar daca au fost codate toate cifrele sau a fost introdusa o valoare nonconformala
  ok = 0;
  while( ok == 0)
  n = length(str);
  %dimensiunea curenta a sirului
  %verificam daca sirul este nul si oprim functia in acest caz
  if n == 0
   return
  endif 
  %x ia valoarea concatenarii sale cu un tab si codificarea literei curente
  x = strcat(x,"\t",morse_encode(str(1)));
  %stringul scade din nou cu o unitate
  str = str(2:end); 
  %verificam daca x contine "*" si intoarcem "*" in acest cad zi oprim functia
  n1=length(x);
    for i = 1:n1
       if x(i) == "*"
       x = "*";
        return
      endif
    endfor
  endwhile
 endfunction