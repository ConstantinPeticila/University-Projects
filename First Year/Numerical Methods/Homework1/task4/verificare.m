function [ok] = verificare(X,ok)
%functia verifica daca mai eixsta cel putin un spatiu neocupat
ok = 3;
for i = 1:3
   for j = 1:3
    if(X(i,j) == '_')
      ok = 1;
    endif;
   endfor
 endfor

endfunction
