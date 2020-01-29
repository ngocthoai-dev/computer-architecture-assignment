.data
	nums: .word 12
	elems: .word 5, 30, -3, 11, -7, 55, 19, 23, -98, -78, 19, 27
.text
main:
	la $s0, elems
	lw $s2, nums
	addi $s1, $zero, 0			#set low
	addi $s2, $s2, -1			#set high
	jal quickSort				
end:	
	li $v0, 10				#end program {
    	syscall					# }
quickSort:
	addi $sp, $sp, -12
	sw $ra, 0($sp) 				#store ra to stack
	sw $s1, 4($sp) 				#base low
	sw $s2, 8($sp) 				#base high
	bge $s1, $s2, return			#recursion_condition (low < high)
execution:
	la $s0, elems
	jal partition
	add $t2, $v1, $zero
	
	la $s0, elems				#First recursion: quickSort(elems, low, pi-1) {
	addi $s2, $t2, -1
	jal quickSort				# }
	lw $s1, 4($sp)				#load the old low
	lw $s2, 8($sp)				#load the old high
	
	la $s0, elems				#Second recursion: quickSort(elems, pi+1, high) {
	addi $s1, $t2, 1
	jal quickSort				# }
	lw $s1, 4($sp)				#load the old low
	lw $s2, 8($sp)				#load the old high
return:
	lw $ra, 0($sp)				#load return
	addi $sp, $sp, 12			#restore the stack
	jr $ra
partition:
	la $s0, elems				#pivot = $t7= arr[high] {
	sll $t9, $s2, 2
	add $s0, $s0, $t9
	lw $t7, ($s0)				# }
	addi $t0, $s1, -1			#$t0 = i = low - 1
	add $t1, $s1, $zero			#$t1 = j = low
	addi $t8, $s2, -1			#high - 1
loop:
	bgt $t1, $t8, swap_pivot		#if(j > high-1) end loop
	la $s0, elems				#$t6 = elems[j] {
	sll $t9, $t1, 2
	add $s0, $s0, $t9
	lw $t6, ($s0)				# }
	addi $t1, $t1, 1			#j++
	ble $t6, $t7, partition_swap		#if(elems[j] <= pivot) swap(elems[i], elems[j])
	j loop
partition_swap:
	addi $t1, $t1, -1			#j
	addi $t0, $t0, 1			#i++
swap:
	la $s0, elems				#swap $t5 and $t6: elems[i] and elems[j] {
	sll $t9, $t0, 2
	add $s0, $s0, $t9 
	lw $t5, ($s0)
	sw $t6, ($s0)
	la $s0, elems
	sll $t9, $t1, 2
	add $s0, $s0, $t9
	sw $t5, ($s0)				# }
	addi $t1, $t1, 1			#j++
	j loop
swap_pivot:
	addi $t0, $t0, 1			#i+1
	la $s0, elems				#swap $t5 and $t7: elems[i+1] and pivot = elems[high] {
	sll $t9, $t0, 2
	add $s0, $s0, $t9 
	lw $t5, ($s0)
	sw $t7, ($s0)
	la $s0, elems
	sll $t9, $t1, 2
	add $s0, $s0, $t9
	sw $t5, ($s0)				# }
	add $v1, $zero, $t0			#return v1 = i+1 {
	jr $ra					# }
