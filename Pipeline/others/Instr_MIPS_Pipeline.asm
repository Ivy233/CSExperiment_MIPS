
L0:   lui   $1,0x1000
      ori $1,$1,0x2211   #  $1=0x10002211
      lui   $2,0x1000
      ori $2,$2,0x4433    #  $2=0x10004433
      add $3, $2, $1   #  $3=0x20006644
      sw $3, 0($0)      # 0($0)=0x20006644

      lui  $4,0x3000
      ori $4,$4,0x5566   #  $4=0x30005566
      sub  $5, $3, $4   #  $5=0xf00010de
      sw $5, 4($0)     # 4($0) =0xf00010de

      lw $6, 0($0)    #  $s6=0x20006644
      slti $7,$6,0x7fff     # $7=0   $6>$5
      beq $7, $0, L2     # goto L2
L1:   j  L3
L2:   slt $8,$2,$3     #   $2=0x10004433  <   $3=0x20006644    $8=1
      bne $8, $0, L1    # $8=1  goto L1
L3:   ori $9,$0,0x10    #  $9=0x000010
      sll $10, $9, 5      #  $10 =0x00000200
      srl $11, $10, 4    #  $11 =0x00000020

      ori $13, $0, 0x1234  # $13=0x1234
      ori  $14,$0,0xff    # $13=0xff
      and $15, $13, $14   # $15=0x34
      lui   $16,0xffff    # $17=0xffff0000
      or   $17, $13, $16   # $17=0xffff1234

      addu  $18, $2, $1   #  $18=10004433+10002211 = 0x20006644
      subu  $19, $3, $4   #  $19=20006644- 30005566= 0xf00010de
      lw $20, 0($0)     # $20 =0x20006644
      sw $20, 8($0)     # 8($0) =0x20006644
      addi $21,$20, 0x1000      # $21 =0x20007644
      addi $22,$20, -0x1000   # $22 =0x20005644
      j  L0
