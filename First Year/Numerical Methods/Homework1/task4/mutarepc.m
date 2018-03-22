function[X] = mutarepc(X,rts,str)
%Am calculat numarul de str si rts reprezentand x si 0,de pe fiecare linie,coloana si diagonala si in functie de acestea dar si de numarul de casute deja completate am incercat sa fac astfel incat sa joace cat mai bine 
nr2_2=nr1_1=nr3_3=nr4=nr4_4=nr5=nr5_5=nr6=nr6_6=0;
 nr=0;
 nr1=nr2=nr3 = 0;
nr8=nr8_8=nr7=nr7_7=0;
k=0;
k;
 for i =1:3
   if X(i,4-i)==str
      nr8 =nr8+1;
   endif
   if X(i,4-i)==rts
     nr8_8 =nr8_8+1;
   endif 
   if X(i,i)==str
    nr7 =nr7+1;
   endif
   if X(i,i)==rts
    nr7_7 =nr7_7+1;
   endif  
   if X(i,1)==str
    nr1 =nr1+1;
   endif
   if X(1,i)==str
    nr4 =nr4+1;
   endif
   if X(i,1)==rts
    nr1_1 =nr1_1+1;
   endif
   if X(1,i)==rts
    nr4_4 =nr4_4+1;
   endif
   if X(i,2)==str
    nr2=nr2+1;
   endif
   if X(i,2)==rts
    nr2_2=nr2_2+1;
   endif
   if X(2,i)==str
    nr5=nr5 +1;
   endif
   if X(2,i)==rts
    nr5_5 = nr5_5 + 1;
   endif
  
   if X(i,3)==str
    nr3=nr3+1;
   endif
  
   if X(i,3)==rts
    nr3_3=nr3_3+1;
   endif
   
   if X(3,i)==rts
    nr6_6 = nr6_6 + 1;
   endif
  
   if X(3,i)==str
    nr6=nr6+1;
   endif
  
 endfor
 
  if (nr1 == 2 || nr1_1 ==2)&& k ==0
    for i = 1:3
     if X(i,1)=='_'
        X(i,1)=rts;
        k =1;
        break;
     endif
    endfor
   endif
   
   if (nr2 == 2 || nr2_2 ==2) && k ==0
    for i = 1:3
     if X(i,2)=='_'
        X(i,2)=rts;
        k =1;
        break;
      endif
    endfor
   endif 
    
    if (nr3 == 2 || nr3_3 ==2) && k ==0
    for i = 1:3
      if X(i,3)=='_'
        X(i,3)=rts;
        k =1;
        break;
      endif
    endfor
    endif
   
   if (nr4 == 2 || nr4_4 ==2)&& k ==0
    for i = 1:3
      if X(1,i)=='_'
        X(1,i)=rts;
        k=1;
        break;
      endif
    endfor
   endif 
   
   if ( nr5 == 2 || nr5_5 ==2) && k ==0
   
    for i = 1:3
      if X(2,i)=='_'
        X(2,i)=rts;
        k=1;
        break;
      endif
    endfor
   endif
   
   if (nr6 == 2 || nr6_6 ==2)&& k==0
    for i = 1:3
      if X(3,i)=='_'
        X(3,i)=rts;
        k=1;
        break;
      endif
    endfor
   endif
    if (nr8 == 2 || nr8_8 ==2)&& k == 0
     for i = 1:3
        if X(i,4-i)=='_'
          X(i,4-i)=rts;
          k = 1;
          break;
        endif
      endfor
    endif
   
   if (nr7 == 2 || nr7_7 ==2)&&k == 0
    for i = 1:3
     if X(i,i)=='_'
        X(i,i)=rts;
        k=1;
       break;
     endif
    endfor
 endif
    
    if(nr1+nr1_1==3 ||  nr2+nr2_2 == 3 || nr3+nr3_3 == 3|| nr4+nr4_4 == 3 || nr5+nr5_5 == 3|| nr6+nr6_6==3 ||  nr7+nr7_7 == 3 || nr8+nr8_8 == 3)&& k ==0 
    
     
      for j= 1:3
        if(X(1,j)=='_' && k == 0)
          X(1,j)=rts;
          k = 1;
         break;
        elseif (X(2,j)=='_' && k ==0)
          X(2,j)=rts;
          k=1;
          break;
        elseif (X(3,j)=='_' && k ==0)
          X(3,j)=rts;
          k=1;
          break;
   
         endif
      endfor
    endif 
   
   for i = 1:3
    for j = 1:3
      if X(i,j)=='_' 
        nr=nr+1;
      endif
    endfor
   endfor
   

  if((X(2,2) =='_')&&(nr == 8)&&k ==0)
    X(2,2) =rts;
    k = 1;
  return
  endif
 if ((X(2,2) ==str)&&(nr == 8)&& k == 0)
    X(1,1) =rts;
    k =1;
  break;
 endif
 
  if(nr ==6 && k ==0)
     if((nr1==1|| nr1_1==1)&&(nr2==1 ||nr2_2==1)&&(nr3==1||nr3_3==1))
       X(1,2)=rts;
       k=1;
       break;
       elseif ((X(1,2) == X(2,1) && X(2,1) == str) ||( X(1,3) == X(2,1) && X(2,1)==str )||( X(1,2) == X(3,1)&&X(3,1) == str ))&& k == 0
        X(1,1) = rts;
        return  
        elseif ((X(1,2) == X(2,3) && X(2,3) == str) ||( X(1,1) == X(2,3) && X(2,3)==str )||( X(1,2) == X(3,3)&&X(3,3) == str ))&& k == 0
        X(1,3) = rts;
        return 
        elseif ((X(1,3) == X(3,2) && X(3,2) == str) ||( X(2,3) == X(3,2) && X(2,3)==str )||( X(2,3) == X(3,1)&&X(3,1) == str ))&& k == 0
        X(3,3) = rts;
        return
       elseif ((X(1,1) == X(3,2) && X(1,1) == str) ||( X(3,3) == X(2,1) && X(2,1)==str )||( X(2,1) == X(3,2)&&X(3,2) == str ))&& k == 0
        X(3,1) = rts;
        return  
     endif
    endif
   if(nr==7 && k ==0)
    if(nr1==0)
      X(1,1)=rts;
      k =1;
      break;
    elseif(nr2==0 && k ==0)
      X(1,2)=rts;
      k = 1;
      break;
    elseif(nr3==0 && k ==0)
      X(3,3)=rts;
      k = 1;
      break;
    endif
  endif
 if(X(1,2)==X(2,1)&& X(1,2)=='_' && k ==0)
  if (X(1,1) == '_')
    X(1,1)=rts;
    k = 1;
    break;
  endif
    endif
   
 if(X(1,2)==X(2,1) && X(1,2)==str  && k ==0)
  if (X(1,1) == '_')
    X(1,1)=rts;
    k = 1;
    break;
  endif
    endif
  if(X(1,2)==X(2,3)&& X(1,2)=='_'&& k == 0)
    if X(1,3) =='_'
      X(1,3)= rts;
      k =  1;
      break;
   endif
  endif
  
   if(X(3,2)==X(2,1)&& X(3,2)=='_'&& k ==0)
    if X(3,1) =='_'
      X(3,1)= rts;
      k =1;
      break;
     endif
   endif
 if(X(3,2)==X(2,3)&& X(3,2)=='_'  && k ==0)
  if X(3,3) =='_'
    X(3,3)= rts;
    k =1;
    break;
  endif
    endif 
endfunction