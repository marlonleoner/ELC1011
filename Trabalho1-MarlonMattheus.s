###############################################################################################################################
#
#   Trabalho 1 - ELC1011 Organizacao de Computadores
#
#   Alunos:
#       - Marlon Leoner
#       - Mattheus Einloft
#
#   Commands:
#       - lt <nome do arquivo>
#           Faz a leitura do arquivo binário <nome do arquivo> com as instruções em linguagem de máquina.
#           Ex.: lt text.bin. Este comando faz a leitura das instruções em linguagem de máquina do arquivo text.bin.
#
#       - ld <nome do arquivo>
#           Faz a leitura do arquivo binário <nome do arquivo> com os dados estáticos do programa.
#           Ex.: ld data.bin. Este comando faz a leitura dos dados estáticos do arquivo data.bin.
#
#       - r <numero de instrucoes>
#           Realiza a simulação das instruções em linguagem de máquina.
#           Ex.: r 10. Este comando realiza a simulaçao de 10 instruções em linguagem de máquina, do endereço dado por PC
#
#       - d
#           Apresenta no terminal o conteúdo atual dos registers.
#           Ex. d
#
#       - m <endereço inicial> <número de endereços>
#           Este comando apresenta no terminal o conteúdo da memória.
#           Ex.: m 0x10010000 10. Este comando apresenta o conteúdo de 10 endereços, começando pelo endereço 0x10010000
#
###############################################################################################################################

.eqv        print_integer_service           1
.eqv        print_string_service            4
.eqv        print_char_service              11

.eqv        input_integer_service           5
.eqv        input_string_service            8

.eqv        open_file_service               13
.eqv        read_file_service               14
.eqv        close_file_service              16
.eqv        end_program_service             17

.eqv        tag_r_instruction               0x00000001
.eqv        tag_i_instruction               0x00000002
.eqv        tag_j_instruction               0x00000003

# Macro Section
.macro print_string (%string)
.data
    string:     .asciiz     %string
.text
    li      $v0,    print_string_service
    la      $a0,    string
    syscall
.end_macro

.macro print_string_label (%string)
    li      $v0,    print_string_service
    la      $a0,    %string
    syscall
.end_macro

.macro print_integer (%integer)
    li      $v0,    print_integer_service
    add     $a0,    $zero,      %integer
    syscall
.end_macro

.macro show_help
    print_string    "Comandos Disponíveis:"
    print_string    "\n\t ld - Carrega o arquivo data.bin"
    print_string    "\n\t lt - Carrega o arquivo text.bin"
    print_string    "\n\t r  - Executar instruções"
    print_string    "\n\t h  - Mostrar 'help'"
    print_string    "\n\t q  - Sair do programa"
.end_macro

.macro print_registers_status
    li      $t0,    0
    la      $t1,    registers

    print_registers_loop:
        mul     $t2,    $t0,    4
        add     $t2,    $t2,    $t1
        lw      $t3,    0($t2)

        beq     $t0,    0x00,   r0
        beq     $t0,    0x01,   r1
        beq     $t0,    0x02,   r2
        beq     $t0,    0x03,   r3
        beq     $t0,    0x04,   r4
        beq     $t0,    0x05,   r5
        beq     $t0,    0x06,   r6
        beq     $t0,    0x07,   r7
        beq     $t0,    0x08,   r8
        beq     $t0,    0x09,   r9
        beq     $t0,    0x0a,   r10
        beq     $t0,    0x0b,   r11
        beq     $t0,    0x0c,   r12
        beq     $t0,    0x0d,   r13
        beq     $t0,    0x0e,   r14
        beq     $t0,    0x0f,   r15
        beq     $t0,    0x10,   r16
        beq     $t0,    0x11,   r17
        beq     $t0,    0x12,   r18
        beq     $t0,    0x13,   r19
        beq     $t0,    0x14,   r20
        beq     $t0,    0x15,   r21
        beq     $t0,    0x16,   r22
        beq     $t0,    0x17,   r23
        beq     $t0,    0x18,   r24
        beq     $t0,    0x19,   r25
        beq     $t0,    0x1d,   r29
        beq     $t0,    0x1f,   r31

        j       next_register

        r0:
            print_string    "["
            print_string_label      label_r0
            j                       continue_print

        r1:
            print_string    "["
            print_string_label      label_r1
            j                       continue_print

        r2:
            print_string    "["
            print_string_label      label_r2
            j                       continue_print

        r3:
            print_string    "["
            print_string_label      label_r3
            j                       continue_print

        r4:
            print_string    "["
            print_string_label      label_r4
            j                       continue_print

        r5:
            print_string    "["
            print_string_label      label_r5
            j                       continue_print

        r6:
            print_string    "["
            print_string_label      label_r6
            j                       continue_print

        r7:
            print_string    "["
            print_string_label      label_r7
            j                       continue_print

        r8:
            print_string    "["
            print_string_label      label_r8
            j                       continue_print

        r9:
            print_string    "["
            print_string_label      label_r9
            j                       continue_print

        r10:
            print_string    "["
            print_string_label      label_r10
            j                       continue_print

        r11:
            print_string    "["
            print_string_label      label_r11
            j                       continue_print

        r12:
            print_string    "["
            print_string_label      label_r12
            j                       continue_print

        r13:
            print_string    "["
            print_string_label      label_r13
            j                       continue_print

        r14:
            print_string    "["
            print_string_label      label_r14
            j                       continue_print

        r15:
            print_string    "["
            print_string_label      label_r15
            j                       continue_print

        r16:
            print_string    "["
            print_string_label      label_r16
            j                       continue_print

        r17:
            print_string    "["
            print_string_label      label_r17
            j                       continue_print

        r18:
            print_string    "["
            print_string_label      label_r18
            j                       continue_print

        r19:
            print_string    "["
            print_string_label      label_r19
            j                       continue_print

        r20:
            print_string    "["
            print_string_label      label_r20
            j                       continue_print

        r21:
            print_string    "["
            print_string_label      label_r21
            j                       continue_print

        r22:
            print_string    "["
            print_string_label      label_r22
            j                       continue_print

        r23:
            print_string    "["
            print_string_label      label_r23
            j                       continue_print

        r24:
            print_string    "["
            print_string_label      label_r24
            j                       continue_print

        r25:
            print_string    "["
            print_string_label      label_r25
            j                       continue_print

        r29:
            print_string    "["
            print_string_label      label_r29
            j                       continue_print

        r31:
            print_string    "["
            print_string_label      label_r31
            j                       continue_print

        continue_print:
            print_string    "] = "
            print_integer   $t3
            print_string    "\n"

        next_register:
            add     $t0,    $t0,    1
            ble     $t0,    31,     print_registers_loop
.end_macro

.text
    # Set registers values
    li      $t0,    0x7fffeffc
    sw      $t0,    registers + 116

    # Set default PC value
    li      $t0,    0x00400000
    sw      $t0,    pc

    show_help

    ####
    user_input:
        # Print Input Message
        print_string    "\n\nInsira o Comando: "

        # Sycall: "read string"
        addi    $v0,    $zero,  input_string_service
        la      $a0,    command_buffer
        lw      $a1,    command_buffer_size
        syscall

        # Get command from user input
        jal     get_command

        # Print Output Message + User Commnad
        print_string        "Comando:          "
        print_string_label  command_string

        # Verify user command
        jal     verify_command

        # Loop
        j       user_input

    ####
    get_command:
        la      $a1,    command_string
        la      $a2,    command_buffer

        j       get_command_next_char

        get_command_loop:
            blez    $t6,    get_command_end

            sb      $t6,    0($a1)
            addi    $a1,    $a1,    1

            j       get_command_next_char

        get_command_next_char:
            lb      $t6,    0($a2)
            addi    $a2,    $a2,    1

            j       get_command_loop

        get_command_end:
            jr      $ra

    ####
    verify_command:
        addi    $sp,    $sp,    4
        sw      $ra,    0($sp)

        la      $a0,    command_string
        la      $a1,    LD_COMMAND
        jal     compare_commands
        beq     $v0,    $zero,  exec_ld

        la      $a0,    command_string
        la      $a1,    LT_COMMAND
        jal     compare_commands
        beq     $v0,    $zero,  exec_lt

        la      $a0,    command_string
        la      $a1,    R_COMMAND
        jal     compare_commands
        beq     $v0,    $zero,  exec_r

        la      $a0,    command_string
        la      $a1,    D_COMMAND
        jal     compare_commands
        beq     $v0,    $zero,  exec_d

        la      $a0,    command_string
        la      $a1,    H_COMMAND
        jal     compare_commands
        beq     $v0,    $zero,  exec_h

        la      $a0,    command_string
        la      $a1,    Q_COMMAND
        jal     compare_commands
        beq     $v0,    $zero,  exec_q

        j       command_not_found

    ####
    compare_commands:
        add     $t0,    $zero,  $zero

        add     $t1,    $zero,  $a0     # Command String - User input
        add     $t2,    $zero,  $a1     # Command String - One of ['ld', 'lt', 'r', 'd', 'm']

            compare_commands_loop:
                lb      $t3,    0($t1)
                lb      $t4,    0($t2)

                beq     $t3,    0x0a,   compare_commands_check
                beqz    $t4,    compare_commands_miss

                bne     $t3,    $t4,    compare_commands_miss

                addi    $t2,    $t2,    1
                addi    $t1,    $t1,    1
                j compare_commands_loop

            compare_commands_miss:
                addi    $v0,    $zero,  1
                j       compare_commands_end
            compare_commands_check:
                bnez    $t4,    compare_commands_miss
                add     $v0,    $zero,  $zero
            compare_commands_end:
                jr      $ra

    ####
    exec_h:
        show_help

        j       exec_return

    ####
    exec_q:
        j       end_program

    ####
    exec_d:
        print_registers_status

        j       exec_return

    ####
    exec_ld:
        print_string    " > [LD] Executando comando..\n"
        print_string    " > [LD] Abrindo arquivo DATA..\n"

        # Open DATA
        la      $a0,    data_file_name
        la      $a1,    data_file_descriptor
        jal     open_file

        print_string    " > [LD] Lendo arquivo DATA..\n"

        # Read DATA
        la      $t0,    data_file_descriptor
        lbu     $a0,    0($t0)
        la      $a1,    data_memory
        la      $a2,    memory_size
        jal     read_file

        print_string    " =+=+= DATA =+=+= \n"
        print_string_label  data_memory

        j       exec_return

    ####
    exec_lt:
        print_string    " > [LT] Executando comando..\n"
        print_string    " > [LT] Abrindo arquivo TEXT..\n"

        # Open TEXT
        la      $a0,    text_file_name
        la      $a1,    text_file_descriptor
        jal     open_file

        print_string    " > [LT] Lendo arquivo TEXT..\n"

        # Read TEXT
        la      $t0,    text_file_descriptor
        lbu     $a0,    0($t0)
        la      $a1,    text_memory
        la      $a2,    memory_size
        jal     read_file

        print_string    " =+=+= TEXT =+=+= \n"
        print_string_label  text_memory

        j       exec_return

    ####
    exec_r:
        print_string  " > [R] Número de instruções: "

        la      $a0,    instructions_number
        li      $v0,    input_integer_service
        syscall

        sw      $v0,    0($a0)

        la      $s0,    instructions_number
        lw      $t1,    0($s0)
        beqz    $t1,    end_program

        la      $s1,    current_index
        sw      $zero,  0($s1)

        j       verify_for

        exec_r_true_condition:
            addi    $t1,    $t1,    1
            sw      $t1,    0($s1)

            print_string  " > [R] Executando instrução "
            print_integer $t1
            print_string  "\n"

            # Find next instruction
            jal     find_new_instruction
            # Decode instruction
            jal     decode_instruction

            add     $s5,    $zero,  $v0

            jal     exec_instruction

        verify_for:
            lw      $t0,    0($s0)
            lw      $t1,    0($s1)

            blt     $t1,    $t0,    exec_r_true_condition

        j       user_input

    ####
    exec_return:
        lw      $ra,    0($sp)
        addi    $sp,    $sp,    -4

        jr      $ra

    ####
    command_not_found:
        print_string  " > [Error] Comando não encontrado"

        j       exec_return

    ###############################
    #   Open n Read DATA file     #
    ###############################
    open_data_file:
        addiu   $sp,    $sp,    4
        sw      $ra,    0($sp)

        print_string        " > [LD] Abrindo arquivo DATA..\n"

        la      $a0,    data_file_name
        la      $a1,    data_file_descriptor
        jal     open_file

        lw      $ra,    0($sp)
        addiu   $sp,    $sp,    -4

        jr      $ra

    ###############################
    #   Open n Read TEXT file     #
    ###############################
    open_text_file:
        addiu   $sp,    $sp,    4
        sw      $ra,    0($sp)

        print_string        " > [LT] Abrindo arquivo TEXT..\n"

        # Open TEXT
        la      $a0,    text_file_name
        la      $a1,    text_file_descriptor
        jal     open_file

        print_string        " > [LT] Lendo arquivo TEXT..\n"

        # Read TEXT
        la      $t0,    text_file_descriptor
        lbu     $a0,    0($t0)
        la      $a1,    text_memory
        li      $a2,    4096
        jal     read_file

        print_string        " =+=+= TEXT =+=+= "
        print_string_label  text_memory

        lw      $ra,    0($sp)
        addiu   $sp,    $sp,    -4

        jr      $ra

    ###############################
    #   Open file                 #
    ###############################
    open_file:
        addiu   $sp,    $sp,    -4
        sw      $a1,    0($sp)

        li      $v0,    13
        li      $a1,    0
        li      $a2,    0
        syscall

        lw      $a1,    0($sp)
        sb      $v0,    0($a1)
        slt     $t0,    $v0,    $zero

        bne     $t0,    $zero,  file_cannot_be_opened # se $v0 é negativo, o arquivo não pode ser aberto
        j       file_opened

        file_cannot_be_opened:
            print_string " > [File] Erro ao abrir o arquivo\n"

            j     end_program

        file_opened:
            print_string " > [File] Arquivo aberto\n"

            addiu $sp, $sp, 4
            jr    $ra

    ###############################
    #   Read file                 #
    ###############################
    read_file:
        addiu   $sp,    $sp,    -4

        li      $v0,    14
        syscall

        sw      $v0,    0($sp)

        slt     $t0,    $v0,    $zero
        bne     $t0,    $zero,  read_file_error

        j       read_file_end

        read_file_error:
            print_string    " > [File] Erro ao ler o arquivo"

            j       end_program

        read_file_end:
            print_string        " > [File] Arquivo lido\n"

            lw      $v0,    0($sp)
            addiu   $sp,    $sp,    4

            jr      $ra

    ###############################
    #   Get new instruction       #
    ###############################
    find_new_instruction:
        lw      $t0,    pc
        lw      $t1,    text_initial_address
        sub     $t2,    $t0,    $t1

        la      $t3,    text_memory
        add     $t4,    $t3,    $t2
        lw      $t5,    0($t4)

        la      $t6,    ir
        sw      $t5,    0($t6)

        jr      $ra

    ###############################
    #  Decode current instruction #
    ###############################
    decode_instruction:
        lw      $t0,    ir

        # Gets the Opcode
        lw      $t1,    mask_op
        and     $t2,    $t0,    $t1
        srl     $t2,    $t2,    26
        sw      $t2,    op_field

        # R Instruction [0x00, 0x10]
        beq     $t2,    0x00,   decode_r_instruction
        beq     $t2,    0x10,   decode_r_instruction

        # J Instruction [0x02, 0x03]
        beq     $t2,    0x02,   decode_j_instruction
        beq     $t2,    0x03,   decode_j_instruction

        # I Instruction [Others]
        j       decode_i_instruction

    ###############################
    #   Decode R instructions     #
    #   [op, imed26]              #
    ###############################
    decode_r_instruction:
        print_string    " > [R] Decodificando uma instrução R\n"

        # Loads registers
        la      $t3,    registers

        # Get and stores 'rs' register
        lw      $t1,    mask_rs
        and     $t2,    $t0,    $t1
        srl     $t2,    $t2,    21
        sw      $t2,    rs_field

        # Get and stores 'rt' register
        lw      $t1,    mask_rt
        and     $t2,    $t0,    $t1
        srl     $t2,    $t2,    16
        sw      $t2,    rt_field

        # Get and stores 'rd' register
        lw      $t1,    mask_rd
        and     $t2,    $t0,    $t1
        srl     $t2,    $t2,    11
        sw      $t2,    rd_field

        # Get and stores 'shamt' value
        lw      $t1,    mask_shamt
        and     $t2,    $t0,    $t1
        srl     $t2,    $t2,    6
        sw      $t2,    shamt_field

        # Get and stores 'funct' value
        lw      $t1,    mask_funct
        and     $t2,    $t0,    $t1
        sw      $t2,    funct_field

        li      $v0,    tag_r_instruction

        j       increment_pc

    ###############################
    #   Decode J instructions     #
    #   [op, imed26]              #
    ###############################
    decode_j_instruction:
        print_string    " > [R] Decodificando uma instrução J\n"

        # Stores in $ts 'Immediate' value
        lw      $t1,    mask_imed26
        and     $t2,    $t0,    $t1
        sw      $t2,    imed26_field

        li      $v0,    tag_j_instruction

        j     increment_pc


    ###############################
    #   Executes R instructions   #
    ###############################
    decode_i_instruction:
        print_string    " > [R] Decodificando uma instrução I\n"

        # Loads all registers
        la      $t3,    registers

        # Get and stores 'rs' register
        lw      $t1,    mask_rs
        and     $t2,    $t0, $t1
        srl     $t2,    $t2, 21
        sw      $t2,    rs_field

        # Get and stores 'rt' register
        lw      $t1,    mask_rt
        and     $t2,    $t0,    $t1
        srl     $t2,    $t2,    16
        sw      $t2,    rt_field

        # Get and stores immediate value
        lw      $t1,    mask_imed16
        and     $t2,    $t0,    $t1
        sw      $t2,    imed16_field

        li      $v0,    tag_i_instruction       # carrega para o registrador o valor de retorno

    ###############################
    #   Increments: PC = PC + 4   #
    ###############################
    increment_pc:
        # Loads current PC value
        lw      $t0,    pc
        # Increments PC
        addi    $t0,    $t0,    4
        # Stores new PC value (PC + 4)
        sw      $t0,    pc

        jr      $ra

    ###############################
    #   Exec Instrucions          #
    ###############################
    exec_instruction:
        # Check instruction type and exec
        li      $t0,    tag_r_instruction
        beq     $s5,    $t0,    exec_r_instruction

        li      $t0,    tag_j_instruction
        beq     $s5,    $t0,    exec_j_instruction

        li      $t0,    tag_i_instruction
        beq     $s5,    $t0,    exec_i_instruction

        j       end_exec_instruction

    ###############################
    #   Executes R instructions   #
    ###############################
    exec_r_instruction:
        print_string    " > [R] Executando instrução R..\n"
        print_string    " > [Instrução R] "

        # Loads register number - rs
        lw      $t0,    rs_field
        sll     $t0,    $t0,    2
        lw      $t0,    registers($t0)

        # Loads register number - rt
        lw      $t1,    rt_field
        sll     $t1,    $t1, 2
        lw      $t1,    registers($t1)

        # Loads register number - rd
        lw      $t2,    rd_field
        sll     $t2,    $t2,    2

        # Loads 'shamt' value
        lw      $t3,    shamt_field
        # Loads 'funct' value
        lw      $t4,    funct_field

        print_string    "Executando: "
        beq     $t4,    0x08,   R_case_jr
        beq     $t4,    0x0c,   R_case_syscall
        beq     $t4,    0x20,   R_case_add
        beq     $t4,    0x21,   R_case_addu
        beq     $t4,    0x22,   R_case_sub
        beq     $t4,    0x23,   R_case_subu

        print_string    "Error <instrução não reconhecida>"

        j       end_exec_instruction

        R_case_jr:
            print_string "jr"

            # Return to address - 'ra'
            jr      $t0

            j       end_exec_instruction

        R_case_syscall:
            print_string "syscall"

            # system call
            syscall

            j       end_exec_instruction

        R_case_add:
            print_string "add"

            add     $t5,    $t0,    $t1
            sw      $t5,    registers($t2)

            j       end_exec_instruction

        R_case_addu:
            print_string "addu"

            addu    $t5,    $t0,    $t1
            sw      $t5,    registers($t2)

            j     end_exec_instruction

        R_case_sub:
            print_string "sub"

            sub     $t5,    $t0,    $t1
            sw      $t5,    registers($t2)

            j       end_exec_instruction

        R_case_subu:
            print_string "subu"

            subu    $t5,    $t0,    $t1
            sw      $t5,    registers($t2)

            j       end_exec_instruction

    ###############################
    #   Executes I instructions   #
    ###############################
    exec_i_instruction:
        print_string    " > [R] Executando instrução I..\n"
        print_string    " > [Instrução I] "

        # Loads Opcode
        lw      $t0,    op_field

        # Loads register number - rs
        lw      $t1,    rs_field
        mul     $t1,    $t1,    4
        lw      $t1,    registers($t1)

        # Loads register number - rt
        lw      $t2,    rt_field
        mul     $t2,    $t2,    4

        # Loads immediate value - 16bits
        lw      $t3,    imed16_field

        # Gets immediate signal
        srl     $t7,    $t3,    15
        beqz    $t7,    positive_signal

        # if negative signal, complements
        ori     $t3,    $t3,    0xffff0000

        positive_signal:
            print_string    "Executando: "
            beq     $t0,    0x04,   I_case_beq
            beq     $t0,    0x05,   I_case_bne
            beq     $t0,    0x06,   I_case_blez
            beq     $t0,    0x07,   I_case_bgtz
            beq     $t0,    0x08,   I_case_addi
            beq     $t0,    0x09,   I_case_addiu
            beq     $t0,    0x0a,   I_case_slti
            beq     $t0,    0x0b,   I_case_sltiu
            beq     $t0,    0x0c,   I_case_andi
            beq     $t0,    0x0d,   I_case_ori
            beq     $t0,    0x0e,   I_case_xori
            beq     $t0,    0x1c,   I_case_mul

            # Ops - access memoty
            add     $t4,    $t1,    $t3

            lw      $t5,    data_final_address
            bgt     $t4,    $t5,    text_check

            lw      $t5,    text_initial_address
            blt     $t4,    $t5,    text_check

            # Offset
            sub     $t5,    $t4,    $t5
            # Loads base address
            la      $t6,    text_memory
            # (base address + offset)
            add     $t4,    $t6,    $t5

            j     end_check_memory

        text_check:
            lw      $t5,    data_final_address
            bgt     $t4,    $t5,    data_check

            lw      $t5,    data_initial_address
            blt     $t4,    $t5, data_check

            # Offset
            sub     $t5,    $t4,    $t5
            # Loads base address
            la      $t6,    data_memory
            # (base address + offset)
            add     $t4,    $t6,    $t5

            j     end_check_memory

        data_check:
            lw      $t5,    stack_initial_address
            blt     $t4,    $t5, stack_check

            lw      $t5,    stack_final_address
            bgt     $t4,    $t5, stack_check

            # Offset
            sub     $t5,    $t4,    $t5
            # Loads base address
            la      $t6,    stack_memory
            # (base address + offset)
            add     $t4,    $t6,    $t5

            j     end_check_memory

        stack_check:
            j     end_program

        end_check_memory:
            beq     $t0,    0x23,   I_case_lw
            beq     $t0,    0x2b,   I_case_sw

            print_string    "Error <instrução não reconhecida>"

        j     end_exec_instruction

        I_case_beq:
            print_string "beq"

            beq     $t1,    $t2,    branch_set_pc

            j       end_exec_instruction

        I_case_bne:
            print_string "bne"

            bne     $t1,    $t2,    branch_set_pc

            j       end_exec_instruction

        I_case_blez:
            print_string "blez"

            blez    $t1,    branch_set_pc

            j       end_exec_instruction

        I_case_bgtz:
            print_string "bgtz"

            bgtz    $t1,    branch_set_pc

            j       end_exec_instruction

        branch_set_pc:
            lw      $t4,    pc
            mul     $t3,    $t3,    4
            add     $t4,    $t4,    $t3
            sw      $t4,    pc

            j       end_exec_instruction

        I_case_addi:
            print_string "addi"

            add     $t4,    $t1,    $t3
            sw      $t4,    registers($t2)

            j       end_exec_instruction

        I_case_addiu:
            print_string "addiu"

            addu    $t4,    $t1,    $t3
            sw      $t4,    registers($t2)

            j       end_exec_instruction

        I_case_slti:
            print_string "slti"

            slt     $t4,    $t1,    $t3
            sw      $t4,    registers($t2)

            j       end_exec_instruction

        I_case_sltiu:
            print_string "sltiu"

            sltu    $t4,    $t1,    $t3
            sw      $t4,    registers($t2)

            j       end_exec_instruction

        I_case_andi:
            print_string "andi"

            and     $t4,    $t1,    $t3
            sw      $t4,    registers($t2)

            j        end_exec_instruction

        I_case_ori:
            print_string "ori"

            or      $t4,    $t1,    $t3
            sw      $t4,    registers($t2)

            j       end_exec_instruction

        I_case_xori:
            print_string "xori"

            xor     $t4,    $t1,    $t3
            sw      $t4,    registers($t2)

            j       end_exec_instruction

        I_case_mul:
            print_string "mul"

            mul     $t4,    $t1,    $t3
            sw      $t4,    registers($t2)

            j       end_exec_instruction

        I_case_lw:
            print_string "lw"

            lw      $t5,    0($t4)
            sw      $t5,    registers($t2)

            j       end_exec_instruction

        I_case_sw:
            print_string "sw"

            sw      $t2,    0($t4)

            j       end_exec_instruction

    ###############################
    #   Executes J instructions   #
    ###############################
    exec_j_instruction:
        print_string    " > [R] Executando instrução J..\n"
        print_string    " > [Instrução J] "

        # Loads 'Opcode' and 'Immediate'
        lw      $t0,    op_field
        lw      $t1,    imed26_field

        # Gets Immediate signal
        srl     $t7,    $t1,    25
        beqz    $t7,    positive_imed

        # if negative signal, complements
        ori     $t1,    $t1,    0xfc000000

        positive_imed:
            print_string    "Executando: "
            beq     $t0,    0x02,   J_case_j
            beq     $t0,    0x03,   J_case_jal

            print_string    "Error <instrução não reconhecida>"

            j     end_exec_instruction

        J_case_j:
            print_string "j"

            # Gets (Immediate << 2)
            sll     $t1,    $t1,    2
            # Stores in PC new address
            sw      $t1,    pc

            j     end_exec_instruction

        J_case_jal:
            print_string "jal"

            # Gets current PC address
            lw      $t2,    pc
            # PC = PC + 4
            add     $t2,    $t2,    4
            # Stores (PC + 4) in register 'ra'
            sw      $t2,    registers + 124

            # Gets (Immediate << 2)
            sll     $t1,    $t1,    2
            # Stores in PC new address
            sw      $t1,    pc

            j       end_exec_instruction

    #############################
    #   End Exec "Function"     #
    #############################
    end_exec_instruction:
        print_string    "\n\n"

        jr    $ra

    #############################
    #   End "Function"          #
    #############################
    end_program:
        print_string    " =#=#= Fim do Programa =#=#= "

        # Syscall: "end program"
        li      $v0,    17
        syscall

.data
    # File Section
    data_file_name:         .asciiz     "/media/marlonleoner/Files/NovaPasta/ORG/Files/data.bin"
    text_file_name:         .asciiz     "/media/marlonleoner/Files/NovaPasta/ORG/Files/text.bin"
    data_file_descriptor:   .space      4
    text_file_descriptor:   .space      4

    # Command
    LD_COMMAND:                 .asciiz     "ld"
    LT_COMMAND:                 .asciiz     "lt"
    R_COMMAND:                  .asciiz     "r"
    D_COMMAND:                  .asciiz     "d"
    M_COMMAND:                  .asciiz     "m"
    H_COMMAND:                  .asciiz     "h"
    Q_COMMAND:                  .asciiz     "q"

    # Buffers
    command_buffer:         .space      20
    command_buffer_size:    .word       20
    command_string:         .space      2
    command_string_size:    .word       2

    instructions_number:    .word       0
    current_index:          .word       0

    # Data Control
    registers:              .space      128
    pc:                     .space      4
    ir:                     .space      4

    # Memory
    data_memory:            .space      65536
    text_memory:            .space      65536
    stack_memory:           .space      65536
    memory_size:            .word       65536

    # Address
    text_initial_address:   .word       0x00400000
    text_final_address:     .word       0x00400fff
    data_initial_address:   .word       0x10010000
    data_final_address:     .word       0x10010fff
    stack_initial_address:  .word       0x7fffdffd
    stack_final_address:    .word       0x7fffeffc

    # Mascaras
    mask_op:                .word       0xfc000000
    mask_rs:                .word       0x03e00000
    mask_rt:                .word       0x001f0000
    mask_rd:                .word       0x0000f800
    mask_shamt:             .word       0x000007c0
    mask_funct:             .word       0x0000003f
    mask_imed16:            .word       0x0000ffff
    mask_imed26:            .word       0x003fffff

    # Campos
    op_field:               .space      4
    rs_field:               .space      4
    rt_field:               .space      4
    rd_field:               .space      4
    shamt_field:            .space      4
    funct_field:            .space      4
    imed16_field:           .space      4
    imed26_field:           .space      4

    # Registers
    label_r0:               .asciiz     "$zero"
    label_r1:               .asciiz     "$at"
    label_r2:               .asciiz     "$v0"
    label_r3:               .asciiz     "$v1"
    label_r4:               .asciiz     "$a0"
    label_r5:               .asciiz     "$a1"
    label_r6:               .asciiz     "$a2"
    label_r7:               .asciiz     "$a3"
    label_r8:               .asciiz     "$t0"
    label_r9:               .asciiz     "$t1"
    label_r10:              .asciiz     "$t2"
    label_r11:              .asciiz     "$t3"
    label_r12:              .asciiz     "$t4"
    label_r13:              .asciiz     "$t5"
    label_r14:              .asciiz     "$t6"
    label_r15:              .asciiz     "$t7"
    label_r16:              .asciiz     "$s0"
    label_r17:              .asciiz     "$s1"
    label_r18:              .asciiz     "$s2"
    label_r19:              .asciiz     "$s3"
    label_r20:              .asciiz     "$s4"
    label_r21:              .asciiz     "$s5"
    label_r22:              .asciiz     "$s6"
    label_r23:              .asciiz     "$s7"
    label_r24:              .asciiz     "$t8"
    label_r25:              .asciiz     "$t9"
    label_r29:              .asciiz     "$sp"
    label_r31:              .asciiz     "$ra"
