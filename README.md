# Manipulación de Displays con el PIC16F877A

![image](https://github.com/user-attachments/assets/bffcba36-89e7-4827-a1a4-671058767143)

El objetivo de esta práctica es la comprensión de los puertos de salida y su manejo de estos en el despliegue de mensajes

# Materiales

-PIC 16F877A

-74LS374 (8)

-Display de 7 segmentos de cátodo común (8)

-Resistencia de 100Ω (8)

# Limitantes

Debido a las limitantes fisicas de la práctica y los displays, solo ciertas letras se pueden reproducir correctamente. Así mismo, la longitud de caracteres está limitada a 8 por las mismas razones.

Para verificar si se puede reproducir una palabra, existe la herramienta "character.py", la cual muestra si la palabra cabe o se recorta, y si es la segunda, como se mostrará en el display

```python:src/trabate_lucas.asm
  trabate_lucas;
  call retardo;
  goto trabate_lucas;"

```
