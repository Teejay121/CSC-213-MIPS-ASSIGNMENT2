.data
msg1: .asciiz "Enter coefficient of a\n"
msg2: .asciiz "Enter coefficient of b\n"
msg3: .asciiz "Enter coefficient of c\n"
msg4: .asciiz "Complex root \n"
msg5: .asciiz "The roots of the equation is"
msg6: .asciiz "  and "

two: .float 2
four: .float 4
zero: .float 0


.text
l.s $f1,two
l.s $f2,four
l.s $f3,zero


#prompt user for the value of a
li $v0,4
la $a0,msg1
syscall
li $v0,6
syscall
mov.s $f4,$f0

#prompt user for the value of b
li $v0,4
la $a0,msg2
syscall
li $v0,6
syscall
mov.s $f5,$f0

#prompt user for the value of c
li $v0,4
la $a0,msg3
syscall
li $v0,6
syscall
mov.s $f6,$f0

#square b = $f7
mul.s $f7,$f5,$f5
#get 2a
mul.s $f8,$f1,$f4
#get ac
mul.s  $f6,$f4,$f6
#get 4ac = $f6
mul.s $f6,$f2,$f6
#d = b^2 - 4ac  i.e d=$f7
sub.s $f7,$f7,$f6

#check if d<0
mfc1 $t1,$f7
blez $t1,complex_root

#compute roots
neg.s $f9,$f5
sqrt.s $f7,$f7
#compute x1 = $f20
add.s $f10,$f9,$f7
div.s $f20,$f10,$f8
#compute x2 = $f21
sub.s $f21,$f9,$f7
div.s $f21,$f21,$f8

#print out result
li $v0,4
la $a0,msg5
syscall

li $v0,2
mov.s $f12,$f20
syscall

li $v0,4
la $a0,msg6
syscall

li $v0,2
mov.s $f12,$f21
syscall
b exit

complex_root:
li $v0,4
la $a0,msg4
syscall

exit:
li $v0,10
syscall
