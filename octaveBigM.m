fprintf("\t\tMinimizacion por Metodo de la Gran M\n\n");
fprintf("Suponiendo Valor de M: \n");
m = 100
fprintf("\nMinimizar Z = 4*X1 + X2\n\nRestricciones:\n\t3X1 + X2 = 3\n\t 4X1 + 3X2 >= 6\n\tX1 + X2 <= 3\n\t X1 , X2 >= 0");
fprintf("\n\nMatriz Inicial segun las restricciones:\n");
matriz_inicio = [-4 + 7 * m, -1 + 4 * m, 0 , 0, -m, 0, 9*m; #Z
                 1, 1/3, 1/3, 0, 0, 0, 1;                   #X1
                 4, 3, 0, 1, -1, 0, 6;                      #X2
                 1, 1, 0, 0, 0, 1, 3];                      #h1
                 
disp(matriz_inicio)
fprintf("\n\n\n\t\tInicio de la Minimizacion\n\n");

function [existe mayor indice_columna] = buscando_positivo(matriz) #UTILIZADO
  mayor = 0;
  existe = false;
  indice_columna = 0;
  fprintf("Buscamos en la fila de Z los numeros mas positivos\n\n");
  for j=1:6
    if(mayor < matriz(1,j))
      fprintf("Valor positivo = %.6f \n\n",matriz(1,j)) 
      existe = true;
      mayor = matriz(1,j);
      indice_columna = j;
    end
  endfor
endfunction


function [menor indice_fila] = buscando_pivote(matriz, indice_columna) #UTILIZADO
  menor = 999;
  fprintf("\n\n Buscamos el Pivote\n");
  for i=2:4
    if(matriz(i,indice_columna) > 0)
      fprintf("%.6f  /  %.6f  = %.6f\n\n",matriz(i,7),matriz(i,indice_columna),matriz(i,7) / matriz(i,indice_columna));
      if(matriz(i,7) / matriz(i,indice_columna) < menor) #Colocar condicion de negativos y 0 de no tomar en cuenta
        menor = matriz(i,7) / matriz(i,indice_columna)
        indice_fila = i;    
      endif
    endif
  endfor
endfunction  


function pivote = get_pivote(matriz,indice_fila,indice_columna) #UTILIZADO en pivote_1
  fprintf("\nObtenemos pivote: \n");
  pivote = matriz(indice_fila,indice_columna);
  disp(pivote)  
endfunction


function matriz_act = pivote_1(matriz,indice_fila,indice_columna) #UTILIZADO
  matriz_act = matriz;
  fprintf("\n\nMatriz Antes del Cambio\n");
  disp(matriz_act)
  pivote_act = get_pivote(matriz,indice_fila,indice_columna);
  for j=1:7
    matriz_act(indice_fila,j) = matriz_act(indice_fila,j) / pivote_act;
  endfor
  
  fprintf("\n\nMatriz Actualizada: \n");
  disp(matriz_act)
endfunction


function matriz_actual = columna_pivote_cero(matriz, indice_fila, indice_columna)
    matriz_actual = matriz;
    for i=1:4
      valor_columna = matriz_actual(i,indice_columna);
      if(i == indice_fila)
        #Nada que hacer, estamos en la fila pivote
      else
        matriz_actual(i,:) = (-matriz_actual(indice_fila,:) * valor_columna) + matriz_actual(i,:);
      endif
      fprintf("\n\nCambios a la Fila(%d))\n",i);
      disp(matriz_actual)
    endfor
    
    fprintf("\n\nMatriz antes del cambio:\n")
    disp(matriz)
    
    fprintf("\n\n\nValor luego de la Columna = 0 \n");
    disp(matriz_actual)
endfunction


#Inicio del Bucle
[positivo mayor columna] = buscando_positivo(matriz_inicio);
i = 0;
while(positivo==1 && i!= 5)
  i += 1;
  fprintf("\n\n\t\tIteracion #%d\n\n",i);
  fprintf("Encontramos el valor m�s positivo de la tabla\n");
  fprintf("En la columna [%d] se encuentra el valor mas positivo, %.6f \n\n",columna,mayor);
  fprintf("Procedemos a encontrar el pivote de esa columna, segun la Menor division\n");
  [menor fila] = buscando_pivote(matriz_inicio,columna);
  fprintf("\n\n Convertimos el pivote en 1 y aplicamos CAMBIOS a la fila\n")
  matriz_inicio = pivote_1(matriz_inicio,fila,columna);
  fprintf("\n\n Luego Convertimos la columna del pivote en 0 y APLICAMOS CAMBIOS a las demas filas\n");
  matriz_inicio = columna_pivote_cero(matriz_inicio,fila,columna);
  fprintf("\n\nVerificamos si aun hay numeros positivos en la tabla...de ser si se repite, si no pasamos a la verificacion\n");
  [positivo mayor columna] = buscando_positivo(matriz_inicio);
endwhile

fprintf("\nValrores Obtenidos:\n\t Z = %.6f \n\t X1 = %.6f \n\t X2 = %.6f \n\t h1 = %.6f",matriz_inicio(1,7),matriz_inicio(2,7),matriz_inicio(3,7),matriz_inicio(4,7));
Z = matriz_inicio(1,7);
X1 = matriz_inicio(2,7);
X2 = matriz_inicio(3,7);
h1 = matriz_inicio(4,7);
fprintf("\n\n\t\t COMPROBACION:\n\nYa que no hay valores positivos procedemos a evaluar los resultados obtenidos:\n")
fprintf("\n\t Z = 4*%.6f + %.6f",X1,X2);
disp(Z)
fprintf("\n\t 3*%.6f + %.6f= 3",X1,X2);
fprintf("\n\t 4*%.6f + 3*%.6f >= 6",X1,X2);
fprintf("\n\t %.6f + %.6f <= 3",X1,X2);
fprintf("\n\t %.6f , %.6f >= 0",X1,X2);

fprintf("\n\n\n\t\t FIN DEL PROGRAMA\n\n");