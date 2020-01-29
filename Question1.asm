.data
	nums: .word 8
	elems: .word -3, 5, 11, 30, -7, 55, 19, 23
.text
main:
	lw $s1, nums 				#$s1 is size of array
	addi $t0, $zero, 0 			#int i = 0
bubble_sort:
	addi $t0, $t0, 1 			#i++
	addi $t5, $t0, -1			#$t5 = size-n-1 {
	sub $t5, $s1, $t5			# }
	addi $t1, $zero, 1 			#reset j=1
	la $s0, elems				#$s0[] = {elems}
	beq $t0, $s1, end			#if i>=n sort done
loop:
	beq $t1, $t5, bubble_sort		#if j=$t5(size-n-1) return line 7
	lw $s2, ($s0)				#$s2 = s0[j]
	addi $s0, $s0, 4			#$s3 = s0[j+1] {
	lw $s3, ($s0)				# }
	addi $t1, $t1, 1			#j++
	blt $s2, $s3, swap			#$s2 < $s3 => swap $s2 and $s3 (s0[j] and s0[j+1])
	j loop					
swap:
	add $t4, $s3, $zero			#$t4 = $s3 
	subi $s0, $s0, 4			#store $s3 to $s2 location in array {
	sw $t4, ($s0)				# }
	add $t4, $s2, $zero			#$t4 = $s2
	addi $s0, $s0, 4			#store $s2 to $s3 location in array {
	sw $t4, ($s0)				# }
	j loop					#j loop
end:
	li $v0, 10				#end program {
	syscall					# }
