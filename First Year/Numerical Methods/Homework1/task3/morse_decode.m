function x = morse_decode(sir)
%calculez lungimea sirului
  n = length(sir) ;
  #apelez functia morse() si initializez o variabila cu aceasta
  var = morse();
%daca lungimea sirului este mai mare decat 4 sigur acesta nu face parte din arbore asa ca returnez "*" si inchei programul
 if n > 4
    x = "*";
    return 
  endif
  %verific daca sirul este format doar din "." si "-" si in caz contrar opresc programul si returnez "*"
  for i = 1:n
    if sir(i) ~='.' && sir(i) ~= '-' 
    x = '*';
    return
   endif
  endfor
 %pentru fiecare componenta a sirului verific daca aceasta este "." sau "-" si ma duc in partea din stanga(daca este ".") sau in dreapta
  for i = 1:n
    if sir(i) == "."
      var = var{2};
    elseif sir(i) == "-"
      var = var{3};
    endif
    %verific daca am iesit din arbore ceea ce insemna ca sirul nu are un omolog in codul morse asa ca il opresc
    if isempty(var) == true
      x = '*';
      return
    endif
  endfor
 %x ia valoarea literei de pe pozitia la care am ajuns
  x = var{1};

endfunction
