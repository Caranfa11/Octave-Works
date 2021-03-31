matriz_inicio = [
    22, 18, 30, 18, 0;
    18, -1, 27, 22, 0;
    26, 20, 28, 28, 0;
    16, 22, -1, 14, 0;
    21, -1, 25, 28, 0;
]

index_minimo_fila = [0, 0, 0, 0, 0];
index_minimo_columna = [0, 0, 0, 0, 0];

function [index_minimo_fila index_minimo_columna] = valores_menores(matriz_inicio)
    menor_fila = 9999;
    menor_columna = 9999;
    for(i = 1 : size(matriz_inicio, 1))
        for(j = 1 : size(matriz_inicio, 2))
            if (matriz_inicio(i,j) >= 0)
                if(matriz_inicio(i,j) < menor_fila)
                    menor_fila = matriz_inicio(i,j);
                endif
            endif
            if (matriz_inicio(j,i) >= 0)
                if(matriz_inicio(j,i) < menor_columna)
                    menor_columna = matriz_inicio(j,i);
                endif
            endif
        endfor
        index_minimo_fila(i) = menor_fila;
        menor_fila = 9999;
        index_minimo_columna(i) = menor_columna;
        menor_columna = 9999;
    endfor
endfunction

function matriz_calculo = Resta_Menor(matriz_inicio, index_minimo_fila, index_minimo_columna)
    fprintf("Matriz Antes del Cambio: \n")
    matriz_calculo = matriz_inicio
    for(i = 1 : size(matriz_inicio, 1))
        for(j = 1 : size(matriz_inicio, 2))
            if (matriz_calculo(i,j) >= 0)
                matriz_calculo(i,j) = matriz_calculo(i,j) - index_minimo_fila(i);
                matriz_calculo(i,j) = matriz_calculo(i,j) - index_minimo_columna(j);
            endif
        endfor
    endfor
    fprintf("Matriz Despues del Cambio: \n")
endfunction

function [index_ceros_columna index_ceros_fila] = Seleccion(matriz_calculo)
    ceros_fila = 0;
    ceros_columnas = 0;
    index_ceros_fila = [0, 0, 0, 0, 0];
    index_ceros_columna = [0, 0, 0, 0, 0];
    for(i = 1 : size(matriz_calculo, 1))
        for(j = 1 : size(matriz_calculo, 2))
            if(matriz_calculo(i,j) == 0)
                ceros_fila += 1;
            endif
            if(matriz_calculo(j,i) == 0)
                ceros_columnas += 1;
            endif
        endfor
        if (ceros_fila > 1)
            index_ceros_fila(i) = ceros_fila;
        endif
        if (ceros_columnas > 1)
            index_ceros_columna(i) = ceros_columnas;
        endif
        ceros_fila = 0;
        ceros_columnas = 0;
    endfor
endfunction

function index_ceros = Diferencia(index_ceros_fila, index_ceros_columna)
    index_ceros = [0,0,0,0,0];
    for(i=1: 5)
        if(index_ceros_columna(i) == 0 && index_ceros_fila(i) == 0)
            index_ceros(i) = 1;
        endif
    endfor
endfunction

function matriz_calculo = Resto(matriz_calculo,index_ceros_fila, index_ceros_columna, index_ceros)
    menor = 999;
    for(i = 1 : size(matriz_calculo, 1))
        if(index_ceros(i) == 1)
            for(j = 1 : size(matriz_calculo, 2) - 1)
                if (matriz_calculo(i,j) > 0)
                    if(matriz_calculo(i,j) < menor)
                        menor = matriz_calculo(i,j);
                    endif
                endif 
            endfor
        endif
    endfor
    fprintf("\n\nMenor valor Encontrado: \n")
    disp(menor)

    for(i = 1 : size(matriz_calculo, 1))
        for(j = 1 : size(matriz_calculo, 2))
            if(matriz_calculo(i,j) >= 0)
                if(index_ceros(i) == 1 && j != 5 )
                    matriz_calculo(i,j) -= menor;
                elseif ((index_ceros_columna(i) != index_ceros_fila(i)) && j == 5)
                    matriz_calculo(i,j) += menor;
                endif
            endif
        endfor
    endfor
endfunction

function matriz_calculo = Localizacion(matriz_calculo)
    for(i = 1 : size(matriz_calculo, 1))
        for(j = 1 : size(matriz_calculo, 2))
            if(matriz_calculo(i,j) != 0)
                matriz_calculo(i,j) = 500000;
            endif
        endfor
    endfor
endfunction

function matriz_inicio = Comparacion(matriz_calculo, matriz_inicio, index_ceros_fila, index_ceros_columna)
    for(i = 1 : size(matriz_inicio, 1))
        for(j = 1 : size(matriz_inicio, 2))
            if(matriz_calculo(i,j) == 500000)
                matriz_inicio(i,j) = 500000; 
            endif
        endfor
    endfor
endfunction

function asig = Asigancion(matriz_inicio)
    asig = matriz_inicio;
    costo = 0
    for(i = 1 : size(asig, 1))
        for(j = 1:size(asig, 2))
            if(asig(i,j) != 500000)
                aux = asig(i,j);
                asig(i,:) = 500000
                asig(:,j) = 500000
                asig(i,j) = aux
                costo += aux


            endif
        endfor
    endfor

    
    
endfunction


[index_minimo_fila index_minimo_columna] = valores_menores(matriz_inicio)
matriz_calculo = Resta_Menor(matriz_inicio, index_minimo_fila, index_minimo_columna)
[index_ceros_columna index_ceros_fila] = Seleccion(matriz_calculo)
index_ceros = Diferencia(index_ceros_fila, index_ceros_columna)
matriz_calculo = Resto(matriz_calculo, index_ceros_fila, index_ceros_columna, index_ceros)
fprintf("\n\n Otorgamos localizacion para cada aplicacion para cada desarrollador\n\n")
matriz_calculo = Localizacion(matriz_calculo)
[index_ceros_columna index_ceros_fila] = Seleccion(matriz_calculo)
matriz_inicio = Comparacion(matriz_calculo, matriz_inicio, index_ceros_fila, index_ceros_columna)
fprintf("\n\n Asigancion de Aplicaciones\n\n")
asig = Asigancion(matriz_inicio)