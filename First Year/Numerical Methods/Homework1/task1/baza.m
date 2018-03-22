function r = baza(sursa,b1,b2)
  %am initializat a cu un sir null
  a = '';
  %am luat un sir ce cuprinde toate caracterele posibile
  symbols = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  %am initializat r1 in care voi retine trecerea dintr-o baza in baza 10
r1=0;
  %am comparat toate componenetele sirului sursa cu cele al lui symbol si le-am inlocuit in calcule cu pozitia acestora - 1 din symbol in caz de egalitate pentru a lucra cu numere   
  for i = 1:length(sursa)
    for j =1:length(symbols)
      if sursa(i) == symbols(j)
        r1 = r1+(j-1)*(b1^(length(sursa)-i));   
     endif
    endfor
  endfor

  %cat timp r1 nu este 0 il impartim la cea de a doua baza iar rezultatul il actualizam mereu in ct
  %restul este diferena ce ranane dupa impartirea lui r1 la a doua baza cu ct si rest 
  k = 1;
  while(r1 ~= 0  )
    ct = fix(r1/b2);
    rest = r1 -ct*b2;
    %restul pe care il obtinem sigur este una dintre pozitiile vectorului symbols si ne folosim de acest lucru pentru a trece din nou intr-un sir de caractere deoarece pot aparea si litere  
    for i= 0:length(symbols) -1
      if rest == i
        rest = symbols(i+1);
      endif
    endfor
    %punem rezultatul pe pozitia corespunzatoare a lui a 
    a(k) = rest;
    %il facem pe r1 catul impartirii sale  la baza2 si crestem k cu o unitate
    r1 = ct;
    k=k+1; 
  endwhile
  %can diesim din bucla o sa avem sirul pe care il dorim insa in ordine inversa asa ca il inversam folosind un auxiliar;
  aux= '';
  for i =1:length(a)
    aux(i)=a(length(a)-i+1);
  endfor
  r =aux();
endfunction
