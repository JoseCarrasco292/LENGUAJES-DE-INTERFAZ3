; Materia: Lenguajes de Interfaz - Unidad 3
; Alumno: Carrasco Larios José Mario
; Práctica 02: Modificación del registro EBX en un procedimiento
; Descripción: Inicializa EBX en 10, le suma 5 dentro de un procedimiento y muestra el resultado en consola.

INCLUDE Irvine32.inc

.data
    mensaje BYTE "Valor de EBX: ", 0

.code
main PROC
    ; Inicializar EBX con el valor 10
    mov ebx, 10
    
    ; Llamar al procedimiento que modifica directamente a EBX
    call Procedimiento1

    ; Mostrar etiqueta en pantalla
    mov edx, OFFSET mensaje
    call WriteString

    ; Pasar el valor de EBX a EAX para imprimirlo con WriteDec
    mov eax, ebx
    call WriteDec
    call Crlf

    exit
main ENDP

; ---------------------------------------------------------
; Procedimiento: Procedimiento1
; Descripción: Incrementa en 5 el valor contenido en EBX.
; Recibe: EBX con el valor entero inicial.
; Devuelve: EBX = EBX + 5.
; ---------------------------------------------------------
Procedimiento1 PROC
    add ebx, 5
    ret
Procedimiento1 ENDP

END main
