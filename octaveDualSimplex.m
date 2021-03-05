fprintf("\t\t\nMinimizacion por el Metodo Dual Simplex\n");

fprintf("\n\n Minimizar Z = 315*X1 + 110*X2 + 50*X3\n\n\t Restricciones:\n\t15*X1 + 2*X2 + X3 >= 200\n\t7.5*X1 + 3*X2 + X3 >= 150\n\t5*X1 + 3*X2 + X3 >= 120\n\tX1 ^ X2 ^ X3 >= 0")
fprintf("\n\n \n\n\t Cumpliendo condiciones:\n\t-15*X1 - 2*X2 - X3 <= -200\n\t-7.5*X1 - 3*X2 - X3 <= - 150\n\t-5*X1 - 3*X2 - X3 <= - 120\n\t")
fprintf("\n\n \n\n\t Adicion de condiciones:\n\t-15*X1 - 2*X2 - X3 + S1 = -200\n\t-7.5*X1 - 3*X2 - X3 + S2 = - 150\n\t-5*X1 - 3*X2 - X3 + S3 = - 120\n\t")


fprintf("\nMatriz inicio:\n")
matriz_inicio = [
    -15, -2, -1, 1, 0, 0, -200;
    -7.5, -3, -1 ,0, 1, 0, -150;
    -5, -2, -1, 0 ,0 ,1 ,-120;
    315, 110, 50, 0, 0, 0, 0;
];
disp(matriz_inicio)

#Funcion para verificacion de un negativo en la columna de igualdad 
function [existe mayor_negativo indice_fila] = buscando_negativo(matriz)
  mayor_negativo = 0;
  existe = false;
  indice_fila = 0;
  fprintf("Buscamos en la Columna de Igualdad los numeros más negativos\n\n");
  for i=1:3
    if(mayor_negativo > matriz(i,7))
      fprintf("Valor negativo = %.6f \n\n",matriz(i,7)) 
      existe = true;
      mayor_negativo = matriz(i,7);
      indice_fila = i;
    end
  endfor
endfunction

#Funcion para buscar la menor de las divisiones entre la variables de Z con su respectivo valor en la variables principales
function [menor indice_columna] = buscando_pivote(matriz, indice_fila)
  menor = -999;
  fprintf("\n\n Buscamos el Pivote\n");
  for j=1:3
    if(matriz(indice_fila,j) != 0 && matriz(4,j) != 0)
      div = matriz(4,j) / matriz(indice_fila,j);
      fprintf("%.6f  /  %.6f  = %.6f\n\n",matriz(4,j),matriz(indice_fila,j),div);  
      if(div > menor) 
        menor = div;
        indice_columna = j;
        disp(indice_columna)

      endif
    endif
  endfor
endfunction

#Funcion que regresa el pivote
function pivote = get_pivote(matriz,indice_fila,indice_columna)
  fprintf("\nObtenemos pivote: \n");
  disp(indice_fila)
  disp(indice_columna)
  pivote = matriz(indice_fila,indice_columna);
  disp(pivote)  
endfunction

#Funcion que modifica la fila del pivote, y coniverte el pivote a 1

function matriz_act = pivote_1(matriz,indice_fila,indice_columna)
  fprintf("\n\nMatriz Antes del Cambio\n");
  matriz_act = matriz;
  disp(matriz_act)
  pivote_act = get_pivote(matriz,indice_fila,indice_columna);
  for j=1:7
    matriz_act(indice_fila,j) = matriz_act(indice_fila,j) / pivote_act;
  endfor
  
  fprintf("\n\nMatriz Actualizada: \n");
  disp(matriz_act)
endfunction

#Funcion que realiza los cambios a las filas para volver la columna pivote en 0
function matriz_actual = columna_pivote_cero(matriz, indice_fila, indice_columna)
    matriz_actual = matriz;
    for i=1:4
      valor_columna = matriz_actual(i,indice_columna);
      if(i == indice_fila)
        #Nada que hacer, estamos en la fila pivote
      else
        matriz_actual(i,:) = matriz_actual(i,:) - (matriz_actual(indice_fila,:) * valor_columna);
      endif
      fprintf("\n\nCambios a la Fila(%d))\n",i);
      disp(matriz_actual)
    endfor
    
    fprintf("\n\n\n\nMatriz antes del cambio:\n")
    disp(matriz)
    
    fprintf("\n\n\nValor luego de la Columna = 0 \n\n\n");
    disp(matriz_actual)
endfunction

#Inicio del Bucle de la Primera Fase
[negativo mayor_negativo fila] = buscando_negativo(matriz_inicio);
i = 0;

while(negativo==1 && i!= 6)
  i += 1;
  fprintf("\n\n\t\tIteracion #%d\n\n",i);
  fprintf("Encontramos el valor más negativo de la tabla\n");
  fprintf("En la fila [%d] se encuentra el valor mas negativo, %.6f \n\n",fila,mayor_negativo);
  fprintf("Procedemos a encontrar el pivote de esa fila, segun la Menor division\n");
  [menor indice_columna] = buscando_pivote(matriz_inicio,fila);
  fprintf("\n\n Convertimos el pivote en 1 y aplicamos CAMBIOS a la fila\n")
  matriz_inicio = pivote_1(matriz_inicio,fila,indice_columna);
  fprintf("\n\n Luego Convertimos la columna del pivote en 0 y APLICAMOS CAMBIOS a las demas filas\n");
  matriz_inicio = columna_pivote_cero(matriz_inicio,fila,indice_columna);
  fprintf("\n\nVerificamos si aun hay numeros negativo en la tabla...de ser si se repite, si no pasamos a la verificacion\n");
  [negativo mayor_negativo fila] = buscando_negativo(matriz_inicio);

endwhile


X1 = matriz_inicio(1,7);
X2 = matriz_inicio(2,7);
X3 = matriz_inicio(3,7);
Z = matriz_inicio(4,7);

fprintf("\nValrores Obtenidos:\n\t Z = %.6f \n\t X1 = %.6f \n\t X2 = %.6f \n\t X3 = %.6f",Z,X1,X2,X3);

fprintf("\n\n\t\t COMPROBACION:\n\nYa que no hay valores negativos procedemos a evaluar los resultados obtenidos:\n")
fprintf("\n\t Z = 315*%.6f + 110*%.6f + 50*%.6f =",X1,X2,X3);
disp(Z)
fprintf("\n\n\t 15*%.6f + 2*%.6f + %.6f >= 200",X1,X2,X3);
fprintf("\n\t 7.5*%.6f + 3*%.6f + %.6f >= 150",X1,X2,X3);
fprintf("\n\t 5*%.6f + 3*%.6f + %.6f >= 120",X1,X2,X3);
fprintf("\n\t %.6f , %.6f , %.6f >= 0",X1,X2,X3);

fprintf("\n\n\n\t\t FIN DEL PROGRAMA\n\n");