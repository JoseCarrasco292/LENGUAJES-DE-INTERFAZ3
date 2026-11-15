; Materia: Lenguajes de Interfaz - Unidad 3
; Alumno: Carrasco Larios José Mario
; Práctica 01: Llamadas a un procedimiento
; Descripción: Programa que invoca dos veces a un mismo procedimiento y retorna al flujo principal en main.

INCLUDE Irvine32.inc

.data
    msgInicio BYTE "Inicio de programa", 0
    msgProc   BYTE "Estoy dentro del procedimiento", 0
    msgFin    BYTE "Fin del programa", 0

.code
main PROC
    ; Mostrar mensaje de inicio
    mov edx, OFFSET msgInicio
    call WriteString
    call Crlf

    ; Primera llamada al procedimiento (CALL apila la dirección de retorno)
    call mostrarAviso
    mov eax, 10

    ; Segunda llamada reutilizando el procedimiento
    call mostrarAviso
    mov eax, 20

    ; Mostrar mensaje de finalización
    mov edx, OFFSET msgFin
    call WriteString
    call Crlf

    exit
main ENDP

; ---------------------------------------------------------
; Procedimiento: mostrarAviso
; Descripción: Imprime en consola un aviso indicando que se
;              encuentra dentro del procedimiento y retorna.
; Recibe: Nada
; Devuelve: Nada (modifica EDX)
; ---------------------------------------------------------
mostrarAviso PROC
    mov edx, OFFSET msgProc
    call WriteString
    call Crlf
    ret
mostrarAviso ENDP

END main
