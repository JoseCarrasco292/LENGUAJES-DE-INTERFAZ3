; Materia: Lenguajes de Interfaz - Unidad 3
; Alumno: Carrasco Larios José Mario
; Práctica 04: Uso de macros para mensajes y multiplicación
; Descripción: Implementa dos macros con parámetros para imprimir cadenas y multiplicar dos números (8 * 5).

INCLUDE Irvine32.inc

; ---------------------------------------------------------
; Macro: MostrarMensaje
; Descripción: Despliega en consola una cadena terminada en 0
;              seguida de un salto de línea.
; ---------------------------------------------------------
MostrarMensaje MACRO texto
    mov edx, OFFSET texto
    call WriteString
    call Crlf
ENDM

; ---------------------------------------------------------
; Macro: Multiplicar
; Descripción: Multiplica dos valores de 32 bits usando IMUL
;              y muestra el resultado en pantalla.
; ---------------------------------------------------------
Multiplicar MACRO valor1, valor2
    mov eax, valor1
    imul eax, valor2
    call WriteDec
    call Crlf
ENDM

.data
    msgBienvenida BYTE "Bienvenido al sistema", 0
    msgProducto   BYTE "Resultado de la multiplicacion:", 0
    msgFin        BYTE "Hasta luego, vuelva pronto", 0
    num1 DWORD 8
    num2 DWORD 5

.code
main PROC
    MostrarMensaje msgBienvenida
    MostrarMensaje msgProducto

    ; Invocar la macro Multiplicar con num1 (8) y num2 (5)
    Multiplicar num1, num2

    MostrarMensaje msgFin
    exit
main ENDP

END main
