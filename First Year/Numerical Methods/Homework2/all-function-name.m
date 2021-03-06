function [limita_inf,limita_sup] = LimiteValProprii(d, s)
  %calculez lungimea diagonalei principale si a supradiagonalei
n = length(d);
m = length(s);
%calculez elementele vectorului t;
t(1) = abs(s(1));
t(n) = abs(s(m));
for i = 2:n-1
t(i) =abs(s(i-1))+abs(s(i));
endfor
%initializez limitele
% acestea se vor  schimba daca diferenta dintre elementul de pe diagonala principala de pe pozitia i si el din t de pe aeeasi pozitie este mai mica r
%espectiv suma este mai mare decat limita_sup
limita_inf=inf;
limita_sup=-inf;
for i = 1:n
  if(d(i)-t(i)) <= limita_inf
  limita_inf = d(i)-t(i);
  endif
  if(d(i)+t(i))>limita_sup
  limita_sup = d(i)+t(i);
  endif
endfor

endfunctionfunction numvp = NrValProprii(d, s, val_lambda)
  %initializez numarul cu 0 pentru inceput;
  numvp = 0;
  %folosesc sirul de polinoame obtinut la prima cerinta
  P= ValoriPolinoame(d, s, val_lambda);
  n = length(P);
  for i = 1:n-1
  %verific daca oricare doua polinoame au semne contrare ceea ce inseamna ca intre ele se afla o valoare proprie
  % imi cresc numarul pe care trebuie sa il calculez cu o unitate in caz afirmativ
    if P(i) <= 0
     if P(i+1) > 0
      numvp=numvp+1;
    endif
   elseif P(i) >= 0
    if P(i+1) <= 0
      numvp = numvp+1;
    endif
  endif
 endfor
 endfunctionfunction [ valp vecp] = PutereInv(d, s, h, y, maxIter,tol)
  %calculez lungimea diagonalei principale ce reprezinta sii lungimea matricei din care ea face parte
  n = length(d);
 # A = diag(d,0)+diag(s,-1)+diag(s,1);
  %folosesc metoda puterii inverse
 % la inceput initializez vecp cu aproximatia initiala y;
  vecp = y;
  %procesez datele pana cand se atinge precizia tol
  do
    %ma folosesc dde functia Thomas si aplic algoritmul puterii inverse rezultandu-mi valoarea proprie si vectorul propriu
    z = Thomas(s,(d-h),s,vecp);
    vecp=z /norm(z,2);
    for i = 2:n-1
       b(i) = vecp(i-1)*s(i-1) +vecp(i+1)*s(i) + vecp(i)*d(i);
    endfor
    b(1) = vecp(1)*d(1)+vecp(2)*s(1);
    b(n) = vecp(n-1)*s(n-1)+vecp(n)*d(n);
    valp = b*vecp;
    h = valp;
    %verific daca s-a atins numarul maxim de iteratii si in acest caz opresc procesarea datelor
    if maxIter  == 0
      return
    endif
    %pentru fiecare data cand conditia de oprire a functiei nu este indeplinita micsorez cu o unitate maxiter
    maxIter --;

  until norm(b' -valp*vecp)<tol
 endfunction
 function x = Thomas(a,b,c,d)
n = length(d);
a = [0,a];
c(1) = c(1)/b(1);
d(1) = d(1)/b(1);
for i = 2:n-1
  temp = b(i) - a(i)*c(i-1);
  c(i) = c(i)/temp;
  d(i) = (d(i)-a(i)*d(i-1))/temp;
 endfor
 d(n) = (d(n)-a(n)*d(n-1))/(b(n)-a(n)*c(n-1));
 x(n) = d(n);
 for i =n-1:-1:1
  x(i) = d(i)-c(i)*x(i+1);
  endfor
  x=x';
  endfunction
function P = ValoriPolinoame(d, s, val_lambda)
  P(1) = 1;
  %calculez lungimea diagonalei principale
  n = length(d);
  P(2) = d(1)-val_lambda;
  %pentru fiecare polinom ii calculez valoarea pe care o ia in val_lambda cu formula sugerata in enuntul temei
  for i  = 2:n
    P(i+1) = (d(i)-val_lambda)*P(i) - s(i-1)*s(i-1)*P(i-1);
  endfor
endfunction
function vp = CalculezValProprii(d, s, m, tol)
n =length(d);
%imi iau o functie de x reprezentata de polinomul de pe ultima pozitie din vectorul de polinoame
%obtin astfel o functie polinomiala caracteristica pentru matricea mea tridiagonala simetrica
f = @(X) ValoriPolinoame(d,s,X)(length(ValoriPolinoame(d,s,X)));
%imi iau un vecctor r in care pun capetele ce separa cele mai mici m valori proprii
r = IntervaleValProprii(d,s,m);
%folosesc metoda bisectiei pentru fiecare interval folosind vectorul r implementat la exercittiul anterior si functie initializata mai sus
for i = 1:length(r)-1
  vp(i) = r(i) +(r(i+1)-r(i))/2;
  while abs(f(vp(i)))> tol && abs(r(i+1)-r(i))>tol
    if f(r(i))*f(vp(i)) <0
    r(i+1) = vp(i);
    else
    r(i) = vp(i);
    endif
    vp(i) = r(i)+(r(i+1)-r(i))/2;
    endwhile
  endfor
  %la final obtin cele mai mici m valori proprii(cu o anumita precizie) reprezentate de elemtentele vectorului vp
endfunctionfunction r = IntervaleValProprii(d, s, m)
  %calculez limitele valorilor proprii ale matricei
  [l,L]=LimiteValProprii(d,s);
  %verific ca m sa nu fie mai mare decat lungimea diagonalei
  if(m > length(d))
    m = length(d);
  endif
  %capatului inferior al primului interval ii dau valoarea limitei inferioare
  %acelasi lucru cu limita superioara pe care il pun intr-o variabila auxiliara care imi va folosi sa calculez celelalte elemente ale lui r;
  r(1) = l;
  r(m+2) = L;
  %pronesc de la m si parcurg cu un for si calculez mijlocul intervalului [r 1 , r k+2 ]
 % calculez lungimea intervalului [mij, r k+2 )  k+2 − r 1 )/2
% calculez numarul de valori proprii mai mici decat valoarea mij

for k =m:-1:1
  mij =(r(k+2)+r(1))/2;
  h = (r(k+2) - r(1))/2;
  numvp = NrValProprii(d,s,mij);
%actualizez valoarea mij
%repet aceasta pana cand valoarea numvp va fi egala cu k
   while(numvp ~= k)
   numvp = NrValProprii(d,s,mij);
   h = h/2;
  if numvp < k
    mij = mij +h;
    elseif numvp > k
    mij = mij -h;
   endif
   endwhile
   %obtin r(k+1)
   r(k+1) = mij;
   endfor
   r = r(1:end -1);