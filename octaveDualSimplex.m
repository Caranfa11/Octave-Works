fprintf("\t\t\nMinimizacion por el Metodo de las 2 Fases\n");

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
  for i=1:4
    if(mayor_negativo < matriz(i,7))
      fprintf("Valor negativo = %.6f \n\n",matriz(i,7)) 
      existe = true;
      mayor_negativo = matriz(i,7);
      indice_fila = i;
    end
  endfor
endfunction


