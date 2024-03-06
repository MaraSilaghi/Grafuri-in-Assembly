.data
nr_cerinta: .space 4
matrice: .space 1600
matrice1: .space 1600
matrice_rez: .space 1600
v_nr_muchii: .space 404
j: .space 4
i: .space 4
k: .space 4
n: .space 4
e: .space 4
lung: .space 4
nrMuchii: .space 4
index: .space 4
index1:.space 4
index2:.space 4
nod: .space 4
nod1: .space 4
nod2: .space 4
formatScanf: .asciz "%d"
formatPrintf: .asciz "%d "
lin_noua: .asciz "\n"
x:.space 4
val:.space 4
.text
.global main
matrix_mult:       ;functia de inmultit matrice
      push %ebp
      mov %esp, %ebp
      push %edi
      push %ebx 
      subl $24, %esp
      for_mult:
         movl $0, -12(%ebp)
         for_linii_mult:    ;pe linia i
             movl -12(%ebp), %ecx      
             cmp %ecx, 20(%ebp)
             je et_atribuire
             movl $0, -16(%ebp)
             for_coloane_mult:    ;elementul mrez[i][j] se modifica de k ori
                movl -16(%ebp), %ecx   
                cmp %ecx, 20(%ebp)
                je cont_mult
                movl $0, -20(%ebp)
                movl $0, -24(%ebp)
                for_n_mult:  
                     movl -20(%ebp), %ecx    
                     cmp %ecx, 20(%ebp)
                     je cont1_mult
                     movl -12(%ebp), %eax
                     movl $0, %edx
                     mull 20(%ebp)
                     addl -20(%ebp), %eax
                     movl 8(%ebp), %edi
                     movl (%edi, %eax, 4), %ebx    ;ebx=m[i][k]
										
                     movl -20(%ebp), %eax    
                     movl $0, %edx
                     mull 20(%ebp)       
                     addl -16(%ebp), %eax     
                     movl 12(%ebp), %edi
                     movl (%edi, %eax, 4), %ecx  ;ecx=m1[k][j]

		     movl %ebx, %eax
                     movl $0, %edx
                     mull %ecx
                     addl -24(%ebp), %eax
                     movl %eax,-24(%ebp)      
                     movl -20(%ebp), %ecx
                     incl -20(%ebp)                      ;mrez[i][j]+=m[i][k]*m1[k][j]                 
                     jmp for_n_mult  
        cont_mult:
                incl -12(%ebp)
                jmp for_linii_mult
        cont1_mult:
		movl -12(%ebp), %eax
		movl $0, %edx
		mull 20(%ebp)
		addl -16(%ebp), %eax
		movl 16(%ebp), %edi
		movl -24(%ebp), %ebx
		movl %ebx, (%edi, %eax, 4)
                incl -16(%ebp)             
                jmp for_coloane_mult
	;mrez stocheaza m*m1
	;acum, trebuie sa facem o copie a mrez in m1
	et_atribuire:
	        movl $0, -12(%ebp)
                for_l_atribuire:
                                movl -12(%ebp), %ecx   
                                cmp %ecx, 20(%ebp)
                                je cont_lung     ;am terminat o inmultire din "lung"
                                movl $0, -16(%ebp)
                for_c_atribuire:
                                movl -16(%ebp), %ecx    
                                cmp %ecx, 20(%ebp)
                                je cont_a
                                movl -12(%ebp), %eax
                                movl $0, %edx
                                mull 20(%ebp)
                                addl -16(%ebp), %eax
                                movl 16(%ebp), %edi     
                                movl (%edi, %eax, 4), %ebx  ;ebx=mrez[i][j]
                                movl -16(%ebp), %ecx    
				movl -12(%ebp), %eax
                                movl $0, %edx
                                mull 20(%ebp)
                                addl -16(%ebp), %eax
				movl 12(%ebp), %edi    
				movl %ebx, (%edi, %eax, 4)  ;m1[i][j]=ebx
                                incl -16(%ebp)
                                jmp for_c_atribuire
        cont_a:
                incl -12(%ebp)
                jmp for_l_atribuire
	addl $24, %esp
        pop %ebx
        pop %edi
        pop %ebp
        ret
main:
pushl $nr_cerinta
pushl $formatScanf
call scanf
popl %ebx
popl %ebx     ;citim nr cerinta
pushl $n
pushl $formatScanf
call scanf
popl %ebx
popl %ebx     ;citim n
movl $0, index
et_for_citire:
        movl index, %ecx
        cmp %ecx, n  
        je et_for
                pushl $x
                pushl $formatScanf
                call scanf
                popl %ebx
                popl %ebx 
                movl x, %eax                ;citim n valori coresp fiecarui nod
                movl index, %ecx            ;(nr noduri)
                lea v_nr_muchii, %edi
                movl %eax, (%edi, %ecx, 4)
                incl index
                jmp et_for_citire     
et_for:
        movl $0, index1
                for_v_nr_muchii:
                                movl index1, %ecx    
                                cmp %ecx, n
                                je et_cerinte
                                movl $0, index2
                for_nod:
                                movl index2, %ecx 
                                movl index1, %eax
                                lea v_nr_muchii, %edi
                                movl (%edi, %eax, 4), %ebx     
                                cmp %ecx, %ebx
                                je cont
                                pushl $nod           
                                pushl $formatScanf
                                call scanf
                                popl %ebx
                                popl %ebx 
                                movl index1, %eax
                                movl $0, %edx
                                mull n
                                addl nod, %eax
                                lea matrice, %edi
                                movl $1, (%edi, %eax, 4) 
				lea matrice1, %edi
                                movl $1, (%edi, %eax, 4) 
				lea matrice_rez, %edi
                                movl $1, (%edi, %eax, 4) 
                                incl index2
                                jmp for_nod
cont:
                incl index1
                jmp for_v_nr_muchii
;s-a construit matricea de adiacenta
et_cerinte:
                movl nr_cerinta, %eax
                movl $1, x
                cmp %eax, x
                je et_afis_matr
		;daca nr cerintei e 1, pur si simplu se afiseaza matricea
		;daca nu, se citeste lung,nod1,nod2, se face fct de inmultire de lung ori
								
		;citim lung-1
		pushl $lung
		pushl $formatScanf
		call scanf
		popl %ebx
		popl %ebx   
		movl lung, %eax
                sub $1, %eax
                movl %eax, lung
		movl $0, e
		for_lung:
			movl e, %ecx
			cmp %ecx, lung
			je et_drum    ;daca functia s a repetat de k ori, afisam m[nod1][nod2]
										
			;aici punem pe stiva tot ce ne trebuie in functie
				
			pushl n
			lea matrice_rez, %edi 
			pushl %edi
			lea matrice1, %edi 
			pushl %edi
			lea matrice, %edi 
			pushl %edi
		        jmp matrix_mult
		cont_lung:
			incl e
			jmp for_lung
et_drum:
	pushl $nod1        ;citim nod1
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx 

	pushl $nod2         ;citim nod2
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx    

	movl nod1, %eax     ;memoram mrez[nod1][nod2]
        movl $0, %edx
        mull n         
        addl nod2, %eax     
        lea matrice_rez, %edi
        movl (%edi, %eax, 4), %ebx 

	pushl %ebx          ;afisam mrez[nod1][nod2]
        pushl $formatPrintf
        call printf
        popl %ebx
        popl %ebx
        pushl $0
        call fflush
        popl %ebx
	jmp et_exit
et_afis_matr:
        movl $0, i
                for_linii:
                                movl i, %ecx   
                                cmp %ecx, n
                                je et_exit
                                movl $0, j
                for_coloane:
                                movl j, %ecx    
                                cmp %ecx, n
                                je cont1
                                movl i, %eax
                                movl $0, %edx
                                mull n
                                addl j, %eax
                                lea matrice, %edi
                                movl (%edi, %eax, 4), %ebx  
                                pushl %ebx
                                pushl $formatPrintf
                                call printf
                                popl %ebx
                                popl %ebx
                                pushl $0
                                call fflush
                                popl %ebx
                                incl j
                                jmp for_coloane
        cont1:
                movl $4, %eax
                movl $1, %ebx
                movl $lin_noua, %ecx
                movl $2, %edx
                int $0x80
                incl i
                jmp for_linii
et_exit:
movl $1, %eax
movl $0, %ebx
int $0x80
