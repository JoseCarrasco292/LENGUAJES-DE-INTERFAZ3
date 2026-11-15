; Materia: Lenguajes de Interfaz - Unidad 3
; Alumno: Carrasco Larios José Mario
; Práctica 03: Validación de una cadena no vacía
; Descripción: Verifica mediante un procedimiento si una cadena terminada en 0 contiene caracteres o está vacía.

INCLUDE Irvine32.inc

.data
    Cadena1 BYTE "Hola", 0
    Cadena2 BYTE "La cadena esta vacia", 0

.code
main PROC
    ; Apuntar ESI al inicio de la cadena a evaluar
    mov esi, OFFSET Cadena1
    call Validacion

    ; Evaluar bandera devuelta en ECX (0 = vacía, 1 = no vacía)
    test ecx, ecx
    jz NoValida

    ; Caso: La cadena sí tiene contenido
    mov edx, OFFSET Cadena1
    call WriteString
    call Crlf
    jmp Fin

NoValida:
    ; Caso: La cadena está vacía
    mov edx, OFFSET Cadena2
    call WriteString
    call Crlf

Fin:
    exit
main ENDP

; ---------------------------------------------------------
; Procedimiento: Validacion
; Descripción: Comprueba el primer byte apuntado por ESI para
;              determinar si es el terminador nulo (0).
; Recibe: ESI = dirección inicial de la cadena.
; Devuelve: ECX = 0 si está vacía, ECX = 1 si contiene texto.
; ---------------------------------------------------------
Validacion PROC
    mov ecx, 0
    mov eax, 0

Buscar:
    cmp BYTE PTR [esi+ecx], 0
    je Salir
    mov ecx, 1

Salir:
    ret
Validacion ENDP

END main
