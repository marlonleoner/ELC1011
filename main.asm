###############################################################################################################################
#
#	Trabalho 1 - ELC1011 Organizacao de Computadores
#
#	Commands:
#		- lt <nome do arquivo>
#			Faz a leitura do arquivo bin�rio <nome do arquivo> com as instru��es em linguagem de m�quina.
#			Ex.: lt text.bin. Este comando faz a leitura das instru��es em linguagem de m�quina do arquivo text.bin.
#
#		- ld <nome do arquivo>
#			Faz a leitura do arquivo bin�rio <nome do arquivo> com os dados est�ticos do programa.
#			Ex.: ld data.bin. Este comando faz a leitura dos dados est�ticos do arquivo data.bin.
#
#		- r <numero de instrucoes>
#			Realiza a simula��o das instru��es em linguagem de m�quina.
#			Ex.: r 10. Este comando realiza a simula��o de 10 instru��es em linguagem de m�quina, do endere�o dado por PC
#
#		- d
#			Apresenta no terminal o conte�do atual dos registradores.
#			Ex. d
#
#		- m <endere�o inicial> <n�mero de endere�os>
#			> Este comando apresenta no terminal o conte�do da mem�ria.
#			Ex.: m 0x10010000 10. Este comando apresenta o conte�do de 10 endere�os, come�ando pelo endere�o 0x10010000
#
###############################################################################################################################

.data
    # Aux Vars
    BLANK_SPACE: 			.ascii  	" "
    NEW_LINE: 				.asciiz  	"\n"

    ERROR_COMMAND:			.asciiz		"Command not found!\n"

    LD_COMMAND:				.asciiz 	"ld"
    LD_MESSAGE:				.asciiz 	"Executing LD command.."
    LT_COMMAND:				.asciiz 	"lt"
    LT_MESSAGE:				.asciiz 	"Executing LT command.."
    R_COMMAND:				.asciiz 	"r"
    R_MESSAGE:				.asciiz 	"Executing R command.."
    D_COMMAND:				.asciiz 	"d"
    D_MESSAGE:				.asciiz 	"Executing D command.."
    M_COMMAND:				.asciiz 	"m"
    M_MESSAGE:				.asciiz 	"Executing M command.."

    # Messages
    input_message:			.asciiz 	"\n\nEnter the command: "
    output_message:			.asciiz 	"Command:           "

    error_message:			.asciiz 	"Error"
    ok_message:				.asciiz		"Ok"

    # Buffers
    command_buffer:			.space 		20
    command_buffer_size:	.word		20

    # Strings
    command_string:			.space		2
    command_string_size:	.word		2

    buffer:					.space 		20

.text
    j 	main

    ####
    command_not_found:
        # Sycall: "print string"
        li 		$v0,	4
        la 		$a0,  	ERROR_COMMAND
        syscall

        j		exec_return

    ####
    exec_ld:
        # Sycall: "print string"
        li 		$v0,	4
        la 		$a0,  	LD_MESSAGE
        syscall

        j		exec_return

    ####
    exec_lt:
        # Sycall: "print string"
        li 		$v0,	4
        la 		$a0,  	LT_MESSAGE
        syscall

        j		exec_return

    ####
    exec_r:
        # Sycall: "print string"
        li 		$v0,	4
        la 		$a0,  	R_MESSAGE
        syscall

        j		exec_return

    ####
    exec_d:
        # Sycall: "print string"
        li 		$v0,	4
        la 		$a0,   	D_MESSAGE
        syscall

        j		exec_return

    ####
    exec_m:
        # Sycall: "print string"
        li 		$v0,	4
        la 		$a0,  	M_MESSAGE
        syscall

        j		exec_return

    ####
    exec_return:
        lw		$ra,	0($sp)
        addi	$sp,	$sp, 	-4

        jr		$ra

    ####
    compare_commands:
        add 	$t0,	$zero,	$zero

        add 	$t1,	$zero,	$a0		# Command String - User input
        add 	$t2,	$zero,	$a1		# Command String - One of ['ld', 'lt', 'r', 'd', 'm']

            compare_commands_loop:
                lb      $t3,	0($t1)              	# get string char
                lb      $t4,	0($t2)              	# get string char

                beq  	$t3,	0x0a,	compare_commands_check
                beqz 	$t4,	compare_commands_miss

                bne		$t3,	$t4,	compare_commands_miss

                addi    $t2,	$t2,	1
                addi    $t1,	$t1,	1
                j compare_commands_loop

            compare_commands_miss:
                addi 	$v0,	$zero,	1
                j		compare_commands_end
            compare_commands_check:
                bnez 	$t4,	compare_commands_miss
                add 	$v0,	$zero,	$zero
            compare_commands_end:
                jr 		$ra

    ####
    verify_command:
        addi	$sp,	$sp,	4
        sw		$ra,	0($sp)

        la		$a0,	command_string
        la		$a1,	LD_COMMAND
        jal		compare_commands
        beq  	$v0,	$zero,	exec_ld

        la		$a0,	command_string
        la		$a1,	LT_COMMAND
        jal		compare_commands
        beq  	$v0,	$zero,	exec_lt

        la		$a0,	command_string
        la		$a1,	R_COMMAND
        jal		compare_commands
        beq  	$v0,	$zero,	exec_r

        la		$a0,	command_string
        la		$a1,	D_COMMAND
        jal		compare_commands
        beq  	$v0,	$zero,	exec_d

        la		$a0,	command_string
        la		$a1,	M_COMMAND
        jal		compare_commands
        beq  	$v0,	$zero,	exec_m

        j		command_not_found

    ####
    get_command:
        la		$a1,	command_string
        la		$a2,	command_buffer

        j		get_command_next_char

        get_command_loop:
            blez    $t6,	get_command_end			# external loop test: if char is 0x0, NULL char,

            sb      $t6,	0($a1)              	# add to output
            addi    $a1,	$a1,	1           	# advance output pointer

            j		get_command_next_char

        get_command_next_char:
            lb      $t6,	0($a2)              	# get string char
            addi    $a2,	$a2,	1           	# advance 1st source pointer

            j		get_command_loop				# and go back treat this char

        get_command_end:
            jr		$ra

    #############################
    #	Main "Function"			#
    #############################
    main:
        # Sycall: "print string"
        li		$v0, 	4
        la		$a0,	input_message
        syscall

        # Sycall: "read string"
        li		$v0, 	8
        la 		$a0, 	command_buffer			# load byte space into address
        lw 		$a1, 	command_buffer_size		# allot the byte space for string
        syscall

        jal		get_command

        # Sycall: "print string"
        li 		$v0,	4
        la 		$a0,	output_message
        syscall

        # Sycall: "print string"
        li 		$v0,	4
        la 		$a0,  	command_string
        syscall

        jal		verify_command

        j		main

        li 		$v0,	10
        syscall
