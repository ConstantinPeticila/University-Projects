function x = multiple_decode(sir)
  %il initializam pe x;
  x='';
  ok = 0;
  %bucla pana cand se opreste ori pentru ca am introdus datele incorect ori pentru ca a terminat
  while ok == 0
  %dimensiunea sirului
  n = length(sir);
  %verificam daca sirul este nul si oprim functia in acest caz
  if n == 0
    return
 endif
 %verificam daca sunt greseli de introducere a sirului si oprim din nou functia
  for i = 1:n
    if sir(i) ~='.' && sir(i) ~= '-' && sir(i) ~= ' '
      x = '*';
      return
    endif
  endfor
 
 %pentru a opri for la primul i gasit
  k = 0;
  %initializez un nou sir;
  sir1 = '';
  %caut primul spatiu din sir si il memorez intr- o constanta
  for i = 1:n
    if sir(i) == ' '
      primspatiu = i;
      k = 1;
      break;
    else primspatiu = n+1;
    endif
   %opresc for-ul
    if k ==1
      break;
    endif
  endfor
  %mut elementele de pana in spatiu in sir1
  %ma folosesc de nr pentru a le numara
 nr = 1;
 for i = 1:primspatiu-1 
    sir1(i) = sir(i);
    nr = nr+1;
  endfor
  %scad sirul s1 din sirul initializam
  sir = sir(nr+1:end);
  %x devine cat era + rezultatul codarii lui sir1;
  x =strcat(x,morse_decode(sir1));
  %calculam lungimea lui x si verificam daca exista vreo steluta si in acest caz returnam "*"
  n1 = length(x); 
  for i = 1:n1
    if x(i) == "*"
      x = "*";
      return
    endif
  endfor
 endwhile 
 
 endfunction