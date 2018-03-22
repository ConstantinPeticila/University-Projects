function Z = zigzag(n)
  #initializez matricea cu o matrice plina de zero de dimensiune n:n
  Z = zeros(n);
  #am observat ca indiferent de dimensiunea matricei pe care trebuie sa o obtin termenii de pe prima linie sunt mereu aceeasi asa ca am cautat un algoritm care se imi completeze partea superioara a matricei cu termenii doriti
  #M-am folosit de functia diag si de optiunile acesteia iar pentru a obtine diagonalele secundare am intors matricea
  #Am gasit formule in functie de paritatea lui i;
  for i = 1:n
    %daca i este impar am observat ca inversele diagonalelor sunt descrescatoare asa ca m-am folosit de pozitia curenta si de la elemetul pe care il formez am facut o "digonala secundara" descrescatoare de pas 1,de lungime i si pozitionata a n-1-a fata de diagonala secundara ce uneste capetele  
    if(mod(i,2) == 1)
      Z=Z+fliplr(diag(i*((i+1)/2)-1:-1:i*((i+1)/2) -i,n-i));
    %daca i este par am observat ca cifra de pe linia de sus creste cu o unitate fata de cea de pe pozitia anterioara asa ca am adaptat formula de mai sus cu diferenta ca acum am crescut mereu cu o unitate
    elseif(mod(i,2) == 0)
       Z=Z+fliplr(diag((i-1)*(i/2):1:(i-1)*(i/2) -1+i,n-i));
    endif
  endfor
  #Am calculat elementele de pe ultima linie a matrcei folosind relatii matematice si le-am adaugat matricei,mai putin Z(n,1) care era deja facut
  for i = n:-1:2
     if(mod(n-i,2) == 1)
        Z(n,i) = n^2-1-(n-i)*(n-i+1)/2;
    else 
        Z(n,i) = n^2-1-(n-i+1)*(n-i+2)/2 +1;
    endif
  endfor
 #Am copiat matricea Z in matricea A pentru a elibera elementele de pe ultima pozitie altfel acestea se dublau
 
   A=Z;
  for i = 2:n-1
    Z(n,i)=0;
  endfor
#folosindu-ma de elementele de pe ultima linie am aplicat un algoritm asemanator cu cel de mai sus
  for i = 2:n-1
     %am verificat daca n si i au aceasi paritate,fiind ceva asemaantor cu primul for insa acum am calculat paritatea fata de n ci nu fata de 0
     if  (mod(n-i,2) == 1)
      Z = Z + fliplr(diag(A(n,i) - n + i:1:A(n,i) ,1-i));
     else 
      Z = Z + fliplr(diag(A(n,i)+n-i:-1:A(n,i),1-i));
     endif
  endfor  
endfunction