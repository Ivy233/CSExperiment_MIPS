LOAD:   lui $1,0x1000
        ori $1,$1,0x1008
        sw $1,0($0)
        xori $1,$1,0xA
        sw $1,4($0)
        xori $1,$1,0x7
        sw $1,12($0)

        lui $1,0x8000
        ori $1,$1,0x1001
        sw $1,8($0)
        xori $1,$1,0x1
        sw $1,16($0)
        #xor $9,$9,$9
        andi $9,$9,0
        ori $9,$9,0x14      # length=max_I=$9=20
        #xor $10,$10,$10
        andi $10,$10,0
        ori $10,$10,0x10    #max_J=$10=20-i-4

        andi $11,$11,0
        #xor $11,$11,$11     # i=$11
I_LOOP: slt $1,$11,$9       # i<length
        beq $1,$0,END
        andi $12,$12,0
        #xor $12,$12,$12     # j=$12

J_LOOP: slt $1,$12,$10
        beq $1,$0,END_I
        #for-loop
        lw $2,0($12)
        lw $3,4($12)
        slt $1,$2,$3        # if a[i]<a[j]
        beq $1,$0,SWAP
        sw $2,0($12)
        sw $3,4($12)
        j END_J

SWAP:   sw $2,4($12)
        sw $3,0($12)

END_J:  addi $12,$12,4
        j J_LOOP

END_I:  addi $11,$11,4
        addi $10,$10,-4
        j I_LOOP

END: