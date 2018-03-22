function [] = afisarematrice(x,b)
%functia afiseaza matricea ,elemente fiind despartite de '|';iar apoi afiseaza statistica meciurilor folosindu-se de vectorul in care se pastreaza aceste valori
s = b(1)+b(2)+b(3);
printf('\n'); 
  for j = 1:3
    printf('\n |%c | %c | %c|', x(1,j), x(2,j),x(3,j));
  endfor

  printf('\n Meciuri:%d \n victorii player:%d \n egaluri:%d \n victorii pc:%d \n ',s,b(1),b(2),b(3));
  
  endfunction
