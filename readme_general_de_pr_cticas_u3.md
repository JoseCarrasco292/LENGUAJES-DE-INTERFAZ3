# Prácticas de la Unidad 3 - Lenguajes de Interfaz

**Alumno:** José Mario Carrasco Larios  
**Materia:** Lenguajes de Interfaz  

---

## Práctica 01: Llamadas a un procedimiento (`01_Procedimientos`)

### ¿Qué hace el programa?
El programa muestra un mensaje de inicio en consola, realiza dos llamadas consecutivas al procedimiento `mostrarAviso` empleando la instrucción `CALL`, y finalmente imprime un mensaje de cierre antes de terminar la ejecución. El propósito es demostrar la modularidad del código y cómo la instrucción `RET` permite retornar exactamente a la instrucción posterior a cada `CALL` dentro de `main`.

### Salida obtenida
```text
Inicio de programa
Estoy dentro del procedimiento
Estoy dentro del procedimiento
Fin del programa
```

### ¿Qué se comprobó al ejecutarlo?
1. Cada vez que se ejecuta `call mostrarAviso`, la dirección de la siguiente instrucción (`mov eax, 10` en la primera llamada y `mov eax, 20` en la segunda) se guarda en la pila y el registro `EIP` salta al inicio del procedimiento.
2. Al llegar a la instrucción `ret`, el procesador desapila la dirección de retorno y reanuda el flujo normal de `main` sin perder el control del programa.
3. La instrucción `exit` al final de `main` evita que la ejecución continúe accidentalmente hacia las líneas donde está declarado el procedimiento.

---

## Práctica 02: Modificación del registro EBX desde un procedimiento (`02_Registro_EBX`)

### ¿Qué hace el programa?
El programa asigna el valor inicial `10` al registro `EBX` desde el procedimiento principal (`main`) y luego invoca a `Procedimiento1`. Dicho procedimiento le suma `5` directamente a `EBX` y retorna. Finalmente, en `main` se copia el valor resultante de `EBX` hacia `EAX` para desplegarlo en pantalla mediante la rutina `WriteDec` de la biblioteca Irvine32.

### Salida obtenida
```text
Valor de EBX: 15
```

### ¿Qué se comprobó al ejecutarlo?
1. Los registros del procesador son globales entre procedimientos a menos que se preserven explícitamente en la pila con `PUSH` y `POP`.
2. El valor cargado en `EBX` (`10`) se conserva al entrar a `Procedimiento1`, se actualiza a `15` tras ejecutar `add ebx, 5`, y permanece en `EBX` al regresar a `main`.
3. Dado que `WriteDec` requiere que el número a imprimir se encuentre en `EAX`, la instrucción `mov eax, ebx` permite visualizar correctamente el valor `15` en la consola.

---

## Práctica 03: Validación de una cadena no vacía (`03_Cadena_No_Vacia`)

### ¿Qué hace el programa?
El programa carga la dirección de `Cadena1` en el registro puntero `ESI` y llama al procedimiento `Validacion`. Este procedimiento inspecciona el primer byte de la cadena (`BYTE PTR [esi+ecx]`) y lo compara con el carácter nulo (`0`). Si el primer byte es `0`, devuelve `ECX = 0` (cadena vacía); de lo contrario, devuelve `ECX = 1`. Al regresar a `main`, la instrucción `test ecx, ecx` junto con el salto condicional `jz NoValida` deciden si se imprime el contenido de `Cadena1` o el aviso `"La cadena esta vacia"`.

### Salida obtenida
```text
Hola
```

### ¿Qué se comprobó al ejecutarlo?
1. **Con texto (`Cadena1 BYTE "Hola", 0`):** El primer byte contiene el código ASCII `'H'` (`48h`), que es distinto de `0`. El procedimiento asigna `ECX = 1`, la bandera `ZF` queda en `0` tras `test ecx, ecx`, y se imprime `"Hola"` en consola.
2. **Con cadena vacía (`Cadena1 BYTE 0`):** Al probar cambiando temporalmente la cadena únicamente al byte nulo, la comparación `cmp BYTE PTR [esi+ecx], 0` activa la bandera `ZF`, salta a `Salir` conservando `ECX = 0`, y el programa principal salta a `NoValida` mostrando `"La cadena esta vacia"`.

---

## Práctica 04: Macro de multiplicación y despliegue de mensajes (`04_Macro_Multiplicacion`)

### ¿Qué hace el programa?
El programa define y utiliza dos macros con parámetros:
* `MostrarMensaje`: recibe la etiqueta de una cadena, carga su dirección en `EDX` y la imprime con `WriteString` y `Crlf`.
* `Multiplicar`: recibe dos operandos (`num1 = 8` y `num2 = 5`), carga el primero en `EAX`, lo multiplica por el segundo mediante `imul eax, valor2`, y muestra el resultado directamente en consola con `WriteDec`.

### Salida obtenida
```text
Bienvenido al sistema
Resultado de la multiplicacion:
40
Hasta luego, vuelva pronto
```

### ¿Qué se comprobó al ejecutarlo?
1. A diferencia de los procedimientos (que usan `CALL` y `RET` en tiempo de ejecución), las macros `MostrarMensaje` y `Multiplicar` sustituyen y expanden su bloque de instrucciones directamente en el código de `main` durante la etapa de ensamblado.
2. La macro `Multiplicar` calculó correctamente el producto de `8 * 5`, almacenando `40` (`28h`) en el registro `EAX` y mostrándolo en pantalla entre los mensajes de bienvenida y despedida.

---

## Práctica 05: Macro con instrucción IMUL (`05_Macro_IMUL`)

### ¿Qué hace el programa?
El programa extiende el uso de macros incorporando la macro `MultiplicarValores`, la cual recibe dos parámetros (`valorA = 6` y `valorB = 7`) y realiza únicamente la operación aritmética mediante `mov eax, valor1` e `imul eax, valor2`. Una vez que la macro deja el producto en el registro `EAX`, el procedimiento `main` se encarga de invocar `WriteDec` y `Crlf` para mostrar el resultado en consola.

### Salida obtenida
```text
Bienvenido al sistema
Resultado de 6 por 7:
42
Hasta luego, vuelva pronto
```

### ¿Qué se comprobó al ejecutarlo?
1. Separar el cálculo en la macro (`MultiplicarValores`) respecto a la rutina de impresión en `main` permite conservar el resultado en `EAX` (`42` decimal / `2Ah` hexadecimal) por si se requiere utilizar en operaciones posteriores antes de imprimirlo.
2. La instrucción `imul eax, valor2` en su formato de dos operandos en x86 de 32 bits multiplica satisfactoriamente el registro destino `EAX` por el operando fuente y deposita el producto en el propio `EAX`, mostrando en pantalla el valor `42`.