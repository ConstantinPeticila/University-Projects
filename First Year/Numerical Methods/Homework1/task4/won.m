function [ok] = won(x,str,tr)
  ok  = 0; 
  
   % orizontal si vertical verificam daca olinie sau o coloana este ocupata in totalitate de x sau de 0
 for i = 1:3
   if (x(1,:) == str || x(2,:) == str || x(3,:) == str)
      ok = 1;
   elseif (x(1,:) == tr || x(2,:) == tr || x(3,:) == tr)
      ok = 2; 
   elseif (x(:,1) == tr || x(:,2) == tr || x(:,3) == tr)
      ok = 2;   
   elseif (x(:,1) == str || x(:,2) == str || x(:,3) == str)
      ok = 1; 
   endif
 endfor   
    % Diagonala:verificam elementele in parte
   if (x(1,1) == str && x(2,2) == str  && x(3,3) == str)
        ok = 1;
   elseif (x(1,3) == str && x(2,2) == str  && x(3,1) == str)
        ok = 1;
   elseif (x(1,1) == tr && x(2,2) == tr  && x(3,3) == tr)
        ok = 2;
   elseif (x(1,3) == tr && x(2,2) == tr  && x(3,1) == tr)
        ok = 2;    
   endif
    
endfunction