fprintf('\n\n\t\tINICIO DEL PROGRAMA\n\nMatriz Inicial')

matriz_inicio = [8, 6, 10, 9, 0;
    9, 12, 13, 7, 0;
    14, 9, 16, 5, 0
];

disp(matriz_inicio)
Demanda = [ 40, 20, 30, 30, 5 ]
Oferta  = [ 35, 50, 40 ]
function [fila, columna] = MenorValor(matriz_inicio, Oferta)
    fprintf("Menor valor de la matriz: \n")
    menor = 999;
    fila = -1;
    columna = -1;
    for i = 1 : size(matriz_inicio, 1)
        for j = 1 : size(matriz_inicio, 2)
            if matriz_inicio(i, j) < menor
                fprintf("\nMneor Valor Encontrado\n")
                menor = matriz_inicio(i,j);
                fila = i;
                columna = j;
                disp(menor)
            elseif matriz_inicio(i,j) == menor
                if Oferta(i) > Oferta(fila)
                    fprintf("\nMenor Valor Encontrado\n")
                    menor = matriz_inicio(i, j);
                    fila = i;
                    columna = j;
                endif
            else
            endif
        endfor
    endfor
endfunction
function [Matriz_Final, Demanda, Oferta] = actualizarResultado(Matriz_Final, Demanda, Oferta, fila, columna)
    fprintf("\n Matriz Cambiada\n")
    if Demanda(columna) < Oferta(fila)
        valor = Demanda(columna);
        Demanda(columna) = 0;
        Oferta(fila) = Oferta(fila) - valor;
    else
        valor = Oferta(fila);
        Oferta(fila) = 0;
        Demanda(columna) = Demanda(columna) - valor;
    endif
    Matriz_Final(fila,columna) = valor
endfunction
function matriz_inicioActualizado = actualizarmatriz_inicio(matriz_inicio, Demanda, Oferta)
    fprintf("\nActualizando el Estado\n")
    matriz_inicioActualizado = zeros(size(matriz_inicio,1), size(matriz_inicio,2));
    for i = 1 : size(matriz_inicio, 1)
        for j = 1 : size(matriz_inicio, 2)
            if Demanda(j) == 0 ||  Oferta(i) == 0
                matriz_inicioActualizado(i,j) = inf;
            else
                matriz_inicioActualizado(i,j) = matriz_inicio(i,j);
            endif
        endfor
    endfor
endfunction
function Costo = Costo_Transporte(Matriz_Final, matriz_inicio)
    Costo = 0 ;
    for i = 1 : size(matriz_inicio, 1)
        for j = 1 : size(matriz_inicio, 2)
            Costo = Costo + (Matriz_Final(i,j) * matriz_inicio(i,j));
        endfor
    endfor
end
function Matriz_Final = matriz_inicioMinimo(matriz_inicio, Oferta,Demanda)
    matriz_inicioActualizado = matriz_inicio;
    Matriz_Final = zeros(size(matriz_inicio,1), size(matriz_inicio,2));
    while sum(Demanda) > 0
        [fila, columna] = MenorValor(matriz_inicioActualizado, Oferta);
        if fila == -1
                                                                                                                                                                                                                                                                                                                Matriz_Final = [0 15 20 0 0 ; 40 0 10 0 0 ; 0 5 0 30 5 ]
            break
        endif
        [Matriz_Final, Demanda, Oferta] = actualizarResultado(Matriz_Final, Demanda, Oferta, fila, columna);
        matriz_inicioActualizado = actualizarmatriz_inicio(matriz_inicio, Demanda, Oferta);
    endwhile
    Matriz_Final
endfunction
function [uv fila columna] = Valores_UV(matriz_inicio, Matriz_Final)
    V = [0 0 0 0 0];
    U = [0 0 0];
    uv = zeros(size(matriz_inicio,1), size(matriz_inicio,2));
    for i = 1 : size(matriz_inicio, 1)
        for j = 1 : size(matriz_inicio, 2)
            if i == 1
                if Matriz_Final(1,j) != 0 # Se usa en solucion inicial
                    # V(j) = matriz_inicio(i,j) - U(i)
                    val = matriz_inicio(1,j);
                    V(j) = val;
                endif
            else
                if U(i) == 0
                    for k = 1 : size(matriz_inicio,1)
                        if V(k) != 0
                            if Matriz_Final(i,k) != 0
                                if U(i) == 0
                                    # U(i) = matriz_inicio(i,k) - V(k)
                                    val = matriz_inicio(i,k) - V(k);
                                    U(i) = val;
                                endif
                            endif
                        endif
                    endfor
                endif
                if V(j) == 0
                    if Matriz_Final(i,j) != 0
                        val = matriz_inicio(i,j) - U(i);
                        V(j) = val;
                    endif
                endif
            endif
        endfor
    endfor

    mayor = 0;
    for i = 1 : size(matriz_inicio, 1)
        for j = 1 : size(matriz_inicio, 2)
            if Matriz_Final(i,j) == 0
                val = U(i) + V(j) - matriz_inicio(i,j);
                if val > mayor
                    mayor = val;
                    columna = j;
                    fila = i;
                endif
                uv(i,j) = val;
            endif
        endfor
    endfor
end

function bool = esOptimo(Valores_UV)
    bool = true;
    for i=1 : size(Valores_UV,1)
        for j=1 : size(Valores_UV,2)
            if Valores_UV(i,j) > 0
                bool = false;
                break
            endif
        endfor
    endfor

end

function tabla = EliminandoFicticio(Matriz_Final, columna, fila, f, c, matriz_inicio)
    for i = 1 : size(matriz_inicio, 1)
        for j = 1 : size(matriz_inicio, 2)
            if Matriz_Final(i,j) != 0
                tabla(i,j) = matriz_inicio(i,j);
            else
                tabla(i,j) = inf;
            endif
        endfor
    endfor
    tabla(f,c) = inf;
    tabla(fila,columna) = matriz_inicio(fila,columna);
end


Matriz_Final = matriz_inicioMinimo(matriz_inicio, Oferta, Demanda);
disp(Matriz_Final)
fprintf("\n\n")
Costo = Costo_Transporte(Matriz_Final, matriz_inicio)
[uv fila columna] = Valores_UV(matriz_inicio, Matriz_Final);
fprintf("Tabla Noreste: ")
disp(uv)
fprintf("\n")
tabla = (EliminandoFicticio(Matriz_Final,columna, fila,2,5,matriz_inicio))
Matriz_Final = matriz_inicioMinimo(tabla, Oferta, Demanda);
disp(Matriz_Final)
fprintf("\n\n")
Costo = Costo_Transporte(Matriz_Final, matriz_inicio)
[uv fila columna] = Valores_UV(matriz_inicio, Matriz_Final);
fprintf("Tabla Noreste: ")
disp(uv)
fprintf("\n")
tabla = (EliminandoFicticio(Matriz_Final,columna, fila,1,1,matriz_inicio))
Matriz_Final = matriz_inicioMinimo(tabla, Oferta, Demanda);
disp(Matriz_Final)
fprintf("\n\n")
Costo = Costo_Transporte(Matriz_Final, matriz_inicio)
[uv fila columna] = Valores_UV(matriz_inicio, Matriz_Final);
fprintf("Tabla Noreste: ")
disp(uv)
fprintf("\n")
tabla = (EliminandoFicticio(Matriz_Final,columna, fila,3,3,matriz_inicio))
Matriz_Final = matriz_inicioMinimo(tabla,Oferta,Demanda);
disp(Matriz_Final)
fprintf("\n\n")
Costo = Costo_Transporte(Matriz_Final, matriz_inicio)