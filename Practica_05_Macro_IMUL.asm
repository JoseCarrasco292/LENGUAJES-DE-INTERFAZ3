; Materia: Lenguajes de Interfaz - Unidad 3
; Alumno: Carrasco Larios José Mario
; Práctica 05: Macro de multiplicación con IMUL y despliegue en main
; Descripción: Define una macro que calcula el producto de dos valores con IMUL en EAX y lo imprime desde main.

INCLUDE Irvine32.inc

; ---------------------------------------------------------
; Macro: MostrarMensaje
; Descripción: Imprime una cadena terminada en 0 y un salto de línea.
; ---------------------------------------------------------
MostrarMensaje MACRO texto
    mov edx, OFFSET texto
    call WriteString
    call Crlf
ENDM

; ---------------------------------------------------------
; Macro: MultiplicarValores
; Descripción: Calcula la multiplicación con signo de dos
;              valores de 32 bits dejando el producto en EAX.
; ---------------------------------------------------------
MultiplicarValores MACRO valor1, valor2
    mov eax, valor1
    imul eax, valor2
ENDM

.data
    msgBienvenida BYTE "Bienvenido al sistema", 0
    msgResultado  BYTE "Resultado de 6 por 7:", 0
    msgFin        BYTE "Hasta luego, vuelva pronto", 0
    valorA DWORD 6
    valorB DWORD 7

.code
main PROC
    MostrarMensaje msgBienvenida
    MostrarMensaje msgResultado

    ; Calcular 6 * 7 usando la macro (deja el resultado 42 en EAX)
    MultiplicarValores valorA, valorB

    ; Mostrar el resultado contenido en EAX desde main
    call WriteDec
    call Crlf

    MostrarMensaje msgFin
    exit
main ENDP

END main
