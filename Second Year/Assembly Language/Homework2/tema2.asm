;Peticila Constantin 321 CB
extern puts
extern printf

section .data
 

filename: db "./input.dat",0
inputlen: dd 2263
fmtstr: db "Key: %d",0xa,0

section .text
global main

xor_strings:
    
    push ebp
    mov ebp,esp
    
    mov ecx,[ebp +8]
    mov eax, [ebp +12]
    xor edx,edx
   
    mov esi,0   ;index parcurgere stringuri
    
    repet:
    mov dh,byte [ecx+esi]   
    mov dl,byte [eax+esi]
    cmp dl,0x00 ;verific daca am ajuns la sfarsitul stringului
    je finalex1
    xor dh,dl   ;fac xor si pastrez in dh
    mov byte [ecx+esi],dh   ;mut in byteul corespunzator din ecx 
    inc esi ;incrementez contorul
    jmp repet   ;bucla
    
finalex1:       
    leave 
    ret



rolling_xor:
    
    push ebp
    mov ebp,esp
    
    mov eax,[ebp +8] ;pun registru pe stiva
    mov ebx,eax ;ii fac o copie
    xor edx,edx     ;fac edx 0 
   
   mov dl,byte [eax] ;pun primul byte din eax in dl
   mov dh,byte [ebx + 1 ]
   mov esi,1
   
    repetex2:
    xor dh,dl ;fac xor intre byte-ul de pe pozitia pt care calc si cel de pe  pozitia precedenta criptat
    mov dl,byte [ebx + esi  ]   ;mut byte-ul nealterat de pe pozitia care va fi precedenta pentru urmatorul set de operatii
    mov byte [eax+esi],dh   ;pun in byteul corespunzator din eax rezultatul
    inc esi ;incrementez
    mov dh,byte [eax+esi]   ;pun byte-ul  de pe pozitia pentru care calculez in dh
    cmp dh,0x00 ;vad daca am ajuns la null
    jne repetex2 ;repet
   
    
    leave 
    ret
    

xor_hex_strings:
 
    push ebp
    mov ebp,esp
    
    mov eax,[ebp +8]    ;stringul
    mov ebx, [ebp +12]  ;cheia
    xor edx,edx
    xor ecx,ecx
    
    mov dl,byte [eax]   ;iau cate doi byte din cheie si cuvant
    mov dh,byte [eax+1]
    mov cl,byte [ebx]
    mov ch,byte [ebx+1]
    
    mov esi,0   ;contor
exista: ;nu s a terminat stringul 
    
    cmp dl,65   ;compar sa vad daca e cifra sau numar
    jge caracterdl  ;scad 87 in decimal 48+39
    jmp numardl ;daca e numar scad 48
caracterdl:
    sub dl,39
numardl:
    sub dl,48

    cmp dh,65
    jge caracterdh
    jmp numardh
caracterdh:
    sub dh,39
numardh:
    sub dh,48

    cmp cl,65
    jge caractercl
    jmp numarcl
caractercl:
    sub cl,39
numarcl:
    sub cl,48


    cmp ch,65
    jge caracterch
    jmp numarch
caracterch:
    sub ch,39
numarch:
    sub ch,48
    
    shl dl,4    ;nibble mare va fi primul caracter
    shl cl,4    ;ex fe se duce in 0xfe

    add dh,dl   ;le adunam
    add ch,cl
    xor dh,ch   ;facem xor

    mov byte[eax + esi],dh  ;pun in  byteul stringului rezultatul
    add esi,2
    mov dl,byte [eax+esi]   ;pentru urmatoarea iteratie
    mov dh,byte [eax+esi+1]
    mov cl,byte [ebx+esi]
    mov ch,byte [ebx+esi+1]
    
    cmp dl,0x00     ;cat timp nu am ajuns la null
    jne exista  

    mov esi,0   ;o sa am caracter spatiu caracter
    mov ebx,0   ;asa ca mut el de pe poz 2i pe poz i
    mov dl,byte[eax+esi]

caracternenul:
    mov byte[eax+ebx],dl
    inc ebx
    add esi,2 
    mov dl,byte[eax+esi]
     
    cmp dl,0x00 ;cat timp nu dau de null
    jne caracternenul

    mov byte[eax+ebx],0 ;pun null dupa ce termin
    
    leave 
    ret
    
base32decode:

    push ebp
    mov ebp,esp
    
    mov eax,[ebp +8] ;pun stringul
    xor edx,edx

    mov dl,byte[eax]
    mov esi,0
  
inceput: 
    cmp dl,64   ;verific cat trebuie sa scad in functie de codul ASCII
    jl scad
    sub dl,41
scad:    
    sub dl,24
    
    mov byte[eax+esi],dl    ;actualizez valoarea
    inc esi
    mov dl,byte[eax+esi]
    cmp dl,0x00
    jne inceput
               
    mov ebx,eax
    mov esi,0   ;pentru valorile din string pe care le folosesc
    mov dl,byte[eax]
    mov cl,byte[eax+esi+1]
    mov ch,byte[eax+esi+2]
    mov edi,0   ;pentru pozitiile din string in care pun
    
repetat4:     ;o bucla mare ce se repeta la 5 bytes actualizati

    shl dl,3   
    shr cl,2
    add dl,cl
    mov byte[eax+edi],dl
    inc esi
    inc edi
    
    mov dl,byte[ebx+esi]    ;folosesc urmatorii 3 bytes
    mov cl,byte[ebx+esi+1]
    mov ch,byte[ebx+esi+2]
    shl dl,6
    shl cl,1
    shr ch,4
    add dl,cl
    add dl,ch
     mov byte[eax+edi],dl   ;actualizez
    add esi,2 ;pt parcurgere string
    inc edi ;pentru scriere
    
    mov dl,byte[ebx+esi]
    cmp dl,0x00
    je stergere4
     mov cl,byte[ebx+esi+1]
    shl dl,4
    shr cl,1
    add dl,cl
    mov byte[eax+edi],dl
    inc esi
    inc edi
    mov dl,byte[ebx+esi]
    
    mov cl,byte[ebx+esi+1]
    mov ch,byte[ebx+esi+2]
    shl dl,7
    shl cl,2
    shr ch,3
    add dl,cl
    add dl,ch
    mov byte[eax+edi],dl
    inc edi
    add esi,2
    
    mov dl,byte[ebx+esi]
    cmp dl,0x00
    je stergere4
    mov cl,byte[ebx+esi+1]
    shl dl,5
    add dl,cl
    mov byte[eax+edi],dl
    add esi,2
    inc edi
   
    mov dl,byte[ebx+esi]
    mov cl,byte[ebx+esi+1]
    cmp dl,0x00
    jne repetat4
    
stergere4:    
   sub edi,3
   mov byte[eax+edi],0x00 ;pun null sa separ stringul
 
    leave 
    ret  
    
             
                    
bruteforce_singlebyte_xor:

    push ebp
    mov ebp,esp
    
    mov eax,[ebp +8] ;iau stringul si cheia
    mov ecx,[ebp +12]
    xor edx,edx
    mov cl,-1
    
cheieinvalida:  ;cheia aleasa nu este buna
    add cl,1   
    mov esi,0
    
caracterincorect:
    
    inc esi    
    cmp byte[eax+esi-1],0x00    ;verific daca am ajuns la sfarsitul stringului
    je cheieinvalida    ;trec la urmatoarea cheie
    mov ch,byte[eax+esi-1]  ;daca nu e verific daca e f in scopul de a cauta force
    xor ch,cl
    cmp ch,'f'
    jne caracterincorect    ;daca nu e trec la urm byte
    
    cmp byte[eax+esi],0x00  ;idem pentru cautare o
    je cheieinvalida
    mov ch,byte[eax+esi]
    xor ch,cl
    cmp ch,'o'
    jne caracterincorect
     
    cmp byte[eax+esi+1],0x00
    je cheieinvalida
    mov ch,byte[eax+esi+1]
    xor ch,cl
    cmp ch,'r'
    jne caracterincorect
    
    cmp byte[eax+esi+2],0x00
    je cheieinvalida
    mov ch,byte[eax+esi+2]
    xor ch,cl
    cmp ch,'c'
    jne caracterincorect
    
    cmp byte[eax+esi+3],0x00
    je cheieinvalida
    mov ch,byte[eax+esi+3]
    xor ch,cl
    cmp ch,'e'
    jne caracterincorect
    movzx ecx,cl
    mov esi,0  ;am gasit cheia deci putem face xor cu ea                                                                         
xorr:
    xor byte[eax+esi],cl
    inc esi
    cmp byte[eax+esi],0x00
    jne xorr
    
    
    leave 
    ret                                              
    

break_substitution:
  
    push ebp
    mov ebp,esp
    
    mov eax,[ebp +8] ;iau stringul 
    mov ebx,[ebp +12]   ;si tabelul
   
    mov edi,0 ;contor pentru string
muta6:
    mov esi,-1 ;contor tabel
    mov cl,byte[eax+edi] 
    cmp cl,0x00 ;verific daca stringul s a terminat
    je final6 
    
compara6: 
     add esi,2  
     mov dl,byte[ebx+esi] 
     mov cl,byte[eax+edi]
     cmp  dl,cl ;compar valoarea din byteul din string cu cea din tabel
     jnz compara6   ;daca nu sunt egale trec la urmatoarea valoarea codata din tabel
     mov dl,byte[ebx+esi-1] ;daca sunt egale iau valoarea decodata=>precedenta
     mov byte[eax+edi],dl ;o mut pe string in locul celei codate
     inc edi    ;trec la urm valoare din string
     jmp muta6   ;reiau pasii  
                                                                                                                                                                                                                                                                                                                                    
final6:
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
    leave 
    ret                                              
                                                                                                                                                                                                                                                                                                                                     
main:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp
    sub esp, 2300
    
    ; fd = open("./input.dat", O_RDONLY);
    mov eax, 5
    mov ebx, filename
    xor ecx, ecx
    xor edx, edx
    int 0x80
    
	; read(fd, ebp-2300, inputlen);
    mov ebx, eax
    mov eax, 3
    lea ecx, [ebp-2300]
    mov edx, [inputlen]
    int 0x80

    ; close(fd);
    mov eax, 6
    int 0x80

    ; TASK 1: Simple XOR between two byte streams

    mov al,0x00
    mov edi,ecx
    repne scasb ;pentru a trece la urmatorul string
    lea ecx, [ebp-2300]
    mov eax,edi
    
    push eax
    push ecx
    call xor_strings
    add esp, 8
    
        ; Print the first resulting string
    push ecx
    call puts
    add esp, 4

        ; TASK 2: Rolling XOR

    mov al,0x00
    repne scasb ;trec la urmatorul string
    mov eax,edi
    
    push eax
    call rolling_xor
    add esp, 4
    
        ; Print the second resulting string
    push eax
    call puts
    add esp, 4

        ; TASK 3: XORing strings represented as hex strings
  
      mov al,0x00
    repne scasb     ;trec la urmatorul string

    mov  eax,edi;ebx va fi sirul citit
    push eax    ;pentru a nu fi modificat de instructiunea urm
    
    mov al,0x00
    repne scasb ;trec la urmatorul string
  
    pop eax ;imi iau eax
    
    push edi    ;edi este cheia
    push eax
    call xor_hex_strings
    add esp, 8
        
        ; Print the third string
    push eax
    call puts
    add esp, 4

        ; TASK 4: decoding a base32-encoded string
    mov al,0x00
    repne scasb ;trec la urmatorul string
    mov ebx,edi
     
    mov al,0x00
    repne scasb
    push edi
   
    push ebx
    call base32decode
    add esp, 4
    
        ; Print the fourth string
    push eax
    call puts
    add esp, 4
        
        ; TASK 5: Find the single-byte key used in a XOR encoding

    pop edi
    mov eax,edi 
   
    sub esp, 4
    lea ecx, [esp]
    push ecx
    push eax
    call bruteforce_singlebyte_xor
    add esp, 8
  
        ; Print the fifth string and the found key value
    push ecx
    push eax
    call puts
    add esp,4
    pop ecx
    
    push ecx
    push fmtstr
    call printf
    add esp, 8
 
 ; TASK 6: Break substitution cipher
 
    mov al,0x00
    repne scasb 

    sub esp,57  ;imi fac spatiu pentru tabelul
    lea ebx,[esp]   ;ebp va face referire la capul tabelului

    mov edx,0
    mov cl,97
    
valorinrpare:
    mov byte[ebx+edx],cl    ;pe locuri pare pun alfabetul
    add edx,2
    add cl,1
    cmp edx,50
    jle valorinrpare  
    
    mov byte[ebx+edx],' '   
    mov byte [ebx+edx+2],'.'
    mov byte[ebx+1],'q' ;pe inpare pun rezultatul din codul c pe care l-am facut 
    mov byte[ebx+3],'r' ;pentru aflarea frecventei de aparitie a literelor    
    mov byte[ebx+5],'w' ;in ordinea data de numarul de aparitii
    mov byte[ebx+7],'e'
    mov byte[ebx+9],' '
    mov byte[ebx+11],'u'
    mov byte[ebx+13],'t'
    mov byte[ebx+15],'y'
    mov byte[ebx+17],'i'
    mov byte[ebx+19],'o'
    mov byte[ebx+21],'p'
    mov byte[ebx+23],'f'
    mov byte[ebx+25],'h'
    mov byte[ebx+27],'.'
    mov byte[ebx+29],'g'
    mov byte[ebx+31],'d'      
    mov byte[ebx+33],'a'
    mov byte[ebx+35],'s'
    mov byte[ebx+37],'l'
    mov byte[ebx+39],'k'
    mov byte[ebx+41],'m'
    mov byte[ebx+43],'j'
    mov byte[ebx+45],'n'
    mov byte[ebx+47],'b'
    mov byte[ebx+49],'z'  
    mov byte[ebx+51],'v'    
    mov byte[ebx+53],'c'
    mov byte[ebx+55],'x'
    mov byte[ebx+56],0x00
    
    push ebx
    push edi
    call break_substitution
    add esp,8

        ; Print final solution (after some trial and error)
    push eax
    call puts
    add esp,4

        ; Print substitution table
    push ebx
    call puts
    add esp,4

	; Phew, finally done
    xor eax, eax
    leave
    ret
