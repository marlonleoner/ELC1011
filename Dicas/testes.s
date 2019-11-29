#*******************************************************************************
# testes.s               Copyright (C) 2019 Giovani Baratto
# This program is free software under GNU GPL V3 or later version
# see http://www.gnu.org/licences
#
# Autor: Giovani Baratto (GBTO) - UFSM - CT - DELC
# e-mail: giovani.baratto@ufsm.br
# versão: 0.1
# Descrição: Programa para testar os procedimentos:
#            (i) 
#
# Documentação:
# Assembler: MARS
# Revisões:
# Rev #  Data           Nome   Comentários
# 0.1    08.10.2019     GBTO   versão inicial 
#*******************************************************************************
#        1         2         3         4         5         6         7         8
#2345678901234567890123456789012345678901234567890123456789012345678901234567890
#           M       O                   #

.data
################################################################################
# Variáveis e constantes de testes   

# strings

.align 2
ok: .space 4

str_numero_decimal_01:      .asciiz "123456789"
str_numero_decimal_02:      .asciiz "12345678a"
str_numero_decimal_03:      .asciiz "000000000"
str_numero_decimal_04:      .asciiz ""
str_numero_decimal_05:      .asciiz "-100"
str_numero_decimal_06:      .asciiz "4294967295"
str_numero_decimal:         .word str_numero_decimal_01, str_numero_decimal_02 
                            .word str_numero_decimal_03, str_numero_decimal_04
                            .word str_numero_decimal_05, str_numero_decimal_06
                            .word 0

str_numero_hexadecimal_01:  .asciiz "0x1001aafF"
str_numero_hexadecimal_02:  .asciiz "0x1001aAfG"
str_numero_hexadecimal_03:  .asciiz "10010000"
str_numero_hexadecimal_04:  .asciiz "0xA"
str_numero_hexadecimal_05:  .asciiz "0xFFFFFFFF"
str_numero_hexadecimal_06:  .asciiz "0x00000000"
str_numero_hexadecimal:     .word str_numero_hexadecimal_01, str_numero_hexadecimal_02
                            .word str_numero_hexadecimal_03, str_numero_hexadecimal_04
                            .word str_numero_hexadecimal_05, str_numero_hexadecimal_06
                            .word 0


# mensagens 
str_testa_memoria_instrucoes_inicio:    .asciiz "Iniciando o teste da memória de instruções. Este teste pode demorar muito.\n"
str_testa_memoria_instrucoes_final:     .asciiz "\nTerminou o teste da memória de instruções\n"
str_testa_memoria_dados_inicio:         .asciiz "Iniciando o teste da memória de dados. Este teste pode demorar muito.\n"
str_testa_memoria_dados_final:          .asciiz "\nTerminou o teste da memória de dados.\n"
str_testa_memoria_pilha_inicio:         .asciiz "Iniciando o teste da memória da pilha. Este teste pode demorar muito.\n"
str_testa_memoria_pilha_final:          .asciiz "\nTerminou o teste da memória da pilha\n"

str_testa_registradores_inicio:         .asciiz "Iniciando o teste dos registradores\n"
str_testa_registradores_final:          .asciiz "\nTerminou o teste dos registradores\n"

str_testa_conversao_string_decimal_inicio:      .ascii "\nIniciando o teste de conversão string decimal para número inteiro decimal.\n"
                                                .ascii "Apresentamos a string de teste, o valor numérico e o valor da variável\n"
                                                .asciiz " indicando que a conversão foi um sucesso\n"
str_testa_conversao_string_decimal_final:       .asciiz "\nTerminou o teste de conversão string decimal para número inteiro decimal\n"

str_testa_conversao_string_hex_decimal_inicio:  .ascii "\nIniciando o teste de conversão string hexadecimal para número inteiro decimal.\n"
                                                .ascii "Apresentamos a string de teste, o valor numérico e o valor da variável\n"
                                                .asciiz " indicando que a conversão foi um sucesso\n"
str_testa_conversao_string_hex_decimal_final:   .asciiz "\nTerminou o teste de conversão string hexadecimal para número inteiro decimal\n"

################################################################################


.text
################################################################################
main:
################################################################################
            # testes da memória
            jal     teste_memoria_instrucoes
            jal     teste_memoria_dados
            jal     teste_memoria_pilha
            # teste dos registradores
            jal     teste_registradores
            # teste da conversão string para número decimal 
            jal     teste_conversao_string_para_decimal
            # teste da conversão string hexadecimal para número decimal
            jal     teste_conversao_string_hexadedimal_para_decimal
# encerramos o programa
            li      $v0, 10 # procedimento exit
            syscall # chamada ao sistema para terminar o programa 
#-------------------------------------------------------------------------------

################################################################################
teste_conversao_string_apresentacao:
#
# Argumentos
#   $a0: endereço da string convertida para número
#   $a1: valor da conversão
#   $a2: endereço da variável apresentando o estado da conversão
################################################################################
# prólogo do procedimento
# corpo do procedimento
            # $a0 possui o endereço da string convertida
            li      $v0, 4
            syscall
            li      $a0, ' '
            li      $v0, 11
            syscall
            li      $a0, '['
            li      $v0, 11
            syscall
            move    $a0, $a1
            li      $v0, 36
            syscall
            li      $a0, ']'
            li      $v0, 11
            syscall
            li      $a0, '['
            li      $v0, 11
            syscall
            lw      $a0, 0($a2)
            li      $v0, 1
            syscall
            li      $a0, ']'
            li      $v0, 11
            syscall   
            li      $a0, '\n'
            syscall  
# epílogo do procedimento            
            jr      $ra
#-------------------------------------------------------------------------------

################################################################################
teste_conversao_string_para_decimal:
################################################################################
# prólogo do procedimento
            addiu   $sp, $sp, -12
            sw      $ra, 8($sp)
            sw      $s1, 4($sp)
            sw      $s0, 0($sp)
# corpo do procedimento
            # apresentamos uma mensagem de início do teste
            la      $a0, str_testa_conversao_string_decimal_inicio
            li      $v0, 4
            syscall
            la      $s0, str_numero_decimal
teste_conversao_string_para_decimal_laco:            
            lw      $s1, 0($s0)
            beq     $s1, $zero, teste_conversao_string_para_decimal_fim
            move    $a0, $s1
            la      $a1, ok
            jal     converte_string_decimal
            move    $a0, $s1
            move    $a1, $v0
            la      $a2, ok
            jal     teste_conversao_string_apresentacao
            addiu   $s0, $s0, 4
            j       teste_conversao_string_para_decimal_laco
teste_conversao_string_para_decimal_fim:            
# epílogo do procedimento
            lw      $s0, 0($sp)
            lw      $s1, 4($sp)
            lw      $ra, 8($sp)
            addiu   $sp, $sp, 12
            jr      $ra
#-------------------------------------------------------------------------------


################################################################################
teste_conversao_string_hexadedimal_para_decimal:
################################################################################
# prólogo do procedimento
            addiu   $sp, $sp, -4
            sw      $ra, 0($sp)
# corpo do procedimento
            # apresentamos uma mensagem de início do teste
            la      $a0, str_testa_conversao_string_hex_decimal_inicio
            li      $v0, 4
            syscall
            
            la      $s0, str_numero_hexadecimal
teste_conversao_string_hexadecimal_laco:            
            lw      $s1, 0($s0)
            beq     $s1, $zero, teste_conversao_string_hexadecimal_fim
            move    $a0, $s1
            la      $a1, ok
            jal     converte_string_hexadecimal_para_decimal
            move    $a0, $s1
            move    $a1, $v0
            la      $a2, ok
            jal     teste_conversao_string_apresentacao
            addiu   $s0, $s0, 4
            j       teste_conversao_string_hexadecimal_laco
teste_conversao_string_hexadecimal_fim:             
            
            
            # apresentamos uma mensagem de fim de teste
            la      $a0, str_testa_conversao_string_hex_decimal_final
            li      $v0, 4
            syscall
# epílogo do procedimento    
            lw      $ra, 0($sp)
            addiu   $sp, $sp, 4
            jr      $ra
#-------------------------------------------------------------------------------



################################################################################
teste_registradores:
#
# neste procedimento escrevemos em cada registrador um valor e em seguida lemos
# cada um dos registradores. Se o valor de leitura for diferente do valor de
# escrita, será apresentado no console a letra E e entre colchetes o valor do 
# registrador com problema.
#
# Mapa da pilha
#   $sp + 4: $ra
#   $sp + 0: $s0
################################################################################
# prólogo do procedimento
            addiu   $sp, $sp, -8
            sw      $ra, 4($sp)
            sw      $s0, 0($sp)
# corpo do procedimento
            # apresentamos uma mensagem de início do teste
            la      $a0, str_testa_registradores_inicio
            li      $v0, 4
            syscall
            # inicializamos o serviço para gerar inteiros aleatórios (adicionamos a semente)
            li      $a0, 0              # id do gerador
            li      $a1, 0xCAFE0123     # valor da semente
            li      $v0, 40             # serviço 40 - ajustamos a semente do gerador aleatório
            syscall                    
            li      $s0, 0              # começamos a escrita com o regsitrador $0
testa_registradores_escrita:
            # escrevemos no registrador um valor pseudoaleatório
            li      $a0, 0              # id do gerador
            li      $v0, 41             # serviço 41 - tomamos o próximo valor da sequência pseudoaleatória.
            syscall
            move    $a1, $a0
            move    $a0, $s0
            jal     escreve_registrador
            addiu   $s0, $s0, 1         # próximo registrador do banco do registradores de uso geral
            sltiu   $t0, $s0, 32        # se for um registrador entre 0 e 31 $t0 = 1
            bne     $t0, $zero, testa_registradores_escrita
            # fazemos a leitura dos registradores
            li      $s0, 0              # começamos a leitura com o registrador $0  
            # inicializamos o serviço para gerar inteiros aleatórios (adicionamos a semente)
            li      $a0, 0
            li      $a1, 0xCAFE0123
            li      $v0, 40
            syscall                     # serviço 40 - ajustamos a semente do gerador aleatório            
testa_registradores_leitura:
            move    $a0, $s0
            jal     leia_registrador
            move    $t0, $v0
            li      $a0, 0
            li      $v0, 41             # 
            syscall
            # O registrador 0 tem sempre o mesmo valor, zero.
            bne     $s0, $zero, testa_registradores_registrador_nao_zero
            li      $a0, 0
testa_registradores_registrador_nao_zero:            
            # comparamos o valor da sequencia pseudoaleatória com o valor do registrador
            beq     $t0, $a0, testa_registradores_proxima_leitura # se a leitura está correta, passe para o próximo registrador
            # se os valores não são iguais imprime E[registrador]
            li      $a0, 'E'
            li      $v0, 11
            syscall
            li      $a0, '['
            syscall
            move    $a0, $s0
            li      $v0, 1
            syscall
            li      $a0, ']'
            li      $v0, 11
            syscall
            li      $a0, '\n'
            syscall
testa_registradores_proxima_leitura:            
            addiu   $s0, $s0, 1         # próximo registrador do banco do registradores de uso geral
            sltiu   $t0, $s0, 32        # se for um registrador entre 0 e 31 $t0 = 1
            bne     $t0, $zero, testa_registradores_leitura
            # apresentamos uma mensagem de fim de teste
            la      $a0, str_testa_registradores_final
            li      $v0, 4
            syscall
# epílogo do procedimento
            lw      $s0, 0($sp)
            lw      $ra, 4($sp)         
            addiu   $sp, $sp, 8
            jr      $ra
#-------------------------------------------------------------------------------

################################################################################
testa_memoria:
#
# Este procedimento escreve sequencialmente no segmento de memória os valores de
# 0 a 255. Na sequência, faz a leitura e verifica se o valor escrito e lido são os
# mesmos. Se há um erro, o valor de leitura é diferente do valor escrito, é apresentado
# no console do simulador MARS o caractere 'E' e entre colchetes o endereço com erro.
#
# Argumentos:
#   $a0: endereço inicial da memória a ser testada
#   $a1: endereço final da memória
#
# Mapa da pilha:
#   $sp + 16: $ra
#   $sp + 12: $s3
#   $sp + 8:  $s2
#   $sp + 4:  $s1
#   $sp + 0:  $s0 
#
# Mapa dos registradores
#
#   $s2: dado escrito ou valor desejado da leitura da memoria
#   $s1: endereço final do segmento a ser testado
#   $s0: endereço inicial do segmento a ser testado
################################################################################
# prólogo do procedimento
            addiu   $sp, $sp, -20        # alocamos espaço na pilha para 1 objeto
            sw      $ra, 16($sp)         # armazenamos o endereço de retorno
            sw      $s3, 12($sp)
            sw      $s2, 8($sp)
            sw      $s1, 4($sp)
            sw      $s0, 0($sp)
# corpo do procedimento
            # escreve sequencialmente nos endereços da memória, os valores entre 0 e 255
            move    $s0, $a0
            move    $s1, $a1
            move    $s2, $a0
            li      $s3, 0
testa_memoria_laco_escrita:
            # enquando o endereço de memoria é menor ou igual ao endereço final de memória
            # realizamos a escrita, senão, terminamos o laço e começamos a leitura
            bgtu    $s2, $s1, testa_memoria_leitura # se terminou escrita, faça leitura
            move    $a0, $s2
            move    $a1, $s3
            jal     escreve_memoria
            # geramos o proximo dado a ser escrito
            addiu   $s3, $s3, 1         # incrementamos o valor escrito
            andi    $s3, $s3, 0x000F    # se 256, retornamos para 0
            # geramos o próximo endereço de escrita
            addiu   $s2, $s2, 1         # incrementamos o endereço de memória
            j       testa_memoria_laco_escrita
testa_memoria_leitura: 
            move    $s2, $s0
            li      $s3, 0
testa_memoria_leitura_laco:
            # enquando o endereço de memoria é menor ou igual ao endereço final de memória
            # realizamos a escrita, senão, terminamos o procedimento
            bgtu     $s2, $s1, testa_memoria_fim # se terminou a leitura, termine o procedimento
            move    $a0, $s2
            jal     leia_memoria
            # comparamos o dado lido com o dado esperado. Se forem diferentes escreve 
            # o caractere 'E'
            beq     $v0, $s3, testa_memoria_ok
            # Os valores são diferentes, escreve um 'E' e o endereço
            li      $a0, 'E'            # letra 'E' que será apresentada no console
            li      $v0, 11             # serviço 11, imprime um caractere
            syscall                     # imprime o caractere 'E'
            li      $a0, '['
            syscall
            move    $a0, $s2
            li      $v0, 34
            syscall
            li      $a0, ']'
            li      $v0, 11
            syscall
            li      $a0, '\n'
            syscall
testa_memoria_ok:
            # geramos o proximo dado a ser escrito
            addiu   $s3, $s3, 1         # incrementamos o valor escrito
            andi    $s3, $s3, 0x000F    # se 256, retornamos para 0
            # geramos o próximo endereço de escrita
            addiu   $s2, $s2, 1         # incrementamos o endereço de memória
            j       testa_memoria_leitura_laco
testa_memoria_fim:
# epílogo do procedimento
            lw      $s0, 0($sp)
            lw      $s1, 4($sp)
            lw      $s2, 8($sp)
            lw      $s3, 12($sp)
            lw      $ra, 16($sp)
            
            addiu   $sp, $sp, 20         # restauramos a pilha
            jr      $ra                 # retornamos ao procedimento chamador
#-------------------------------------------------------------------------------


################################################################################
teste_memoria_instrucoes:
#
# Este procedimento testa a memória de instruções
#
# Mapa da pilha
#   $sp + 0 : $ra endereço de retorno
#
################################################################################
# prólogo do procedimento
            addiu   $sp, $sp, 4
            sw      $ra, 0($sp)
# corpo do procedimento
            # escreve uma mensagem incial
            li      $v0, 4              # serviço 4 - escreve string
            la      $a0, str_testa_memoria_instrucoes_inicio
            syscall
            # teste da memória de instrucoes
            li      $a0, ei_memoria_instrucoes
            li      $a1, ef_memoria_instrucoes
            jal testa_memoria
            # escreve uma mensagem final
            li      $v0, 4              # serviço 4 - escreve string
            la      $a0, str_testa_memoria_instrucoes_final
            syscall
# epílogo do procedimento
            lw      $ra, 0($sp)
            jr      $ra                 # retornamos ao procedimento chamador
#-------------------------------------------------------------------------------


################################################################################
teste_memoria_dados:
#
# Este procedimento testa a memória de dados
#
# Mapa da pilha
#   $sp + 0 : $ra endereço de retorno
#
################################################################################
# prólogo do procedimento
            addiu   $sp, $sp, 4
            sw      $ra, 0($sp)
# corpo do procedimento
            # escreve uma mensagem incial
            li      $v0, 4              # serviço 4 - escreve string
            la      $a0, str_testa_memoria_dados_inicio
            syscall
            # teste da memória de dados
            li      $a0, ei_memoria_dados
            li      $a1, ef_memoria_dados
            jal testa_memoria
            # escreve uma mensagem final
            li      $v0, 4              # serviço 4 - escreve string
            la      $a0, str_testa_memoria_dados_final
            syscall
# epílogo do procedimento
            lw      $ra, 0($sp)
            jr      $ra                 # retornamos ao procedimento chamador
#-------------------------------------------------------------------------------


################################################################################
teste_memoria_pilha:
#
# Este procedimento testa a memória de pilha
#
# Mapa da pilha
#   $sp + 0 : $ra endereço de retorno
#
################################################################################
# prólogo do procedimento
            addiu   $sp, $sp, 4
            sw      $ra, 0($sp)
# corpo do procedimento
            # escreve uma mensagem incial
            li      $v0, 4              # serviço 4 - escreve string
            la      $a0, str_testa_memoria_pilha_inicio
            syscall
            # teste da memória da pilha
            li      $a0, ei_memoria_pilha
            li      $a1, ef_memoria_pilha
            jal testa_memoria
            # escreve uma mensagem final
            li      $v0, 4              # serviço 4 - escreve string
            la      $a0, str_testa_memoria_pilha_final
            syscall
# epílogo do procedimento
            lw      $ra, 0($sp)
            jr      $ra                 # retornamos ao procedimento chamador
#-------------------------------------------------------------------------------
