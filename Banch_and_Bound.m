%Programacion lineal entera metodo de Branch and Bound por medio de
%recursividad
function [xInicial,FOmin] = Banch_and_Bound(c,A,b,xlb,xub,xInicial,FOmin)
% El algoritmo emplea la funcion linprog de matlab
    tolerancia = 1e-5; % Cualquier numero por debajo de este valor es considerado cero
    if ~exist('xlb','var'), xlb = 0*c; end % Forma canonica
    if ~exist('xub','var'), xub = Inf*ones(size(c)); end % Limite superior predeterminado
    if ~exist('xstar','var'), xInicial = []; end
    if ~exist('Jmin','var'), FOmin = Inf; end % Intento de minimizacion
    optns = optimset('display','off'); % Desagtiva el diagnostico en linprog
    [x,j,salida] = linprog(c,A,b,[],[],xlb,xub,[],optns);
    if salida~=1, return, end % Si es infactible, se elimina la rama
    if j>FOmin, return, end % Si el valor de FO es el mismo que el incurrente sale de la rama
    idx = find(abs(x-round(x)) > tolerancia); % Determina que valores no son enteros
    if isempty(idx) % Todos las soluciones Enteras
        if j<FOmin, xInicial=round(x); FOmin=j; end % Nuevo optimo Entero
        return % problem solved
    end
    % Recursion del metodo por aca nuevo nodo con sus nuevas restricciones.
    xnlb = xlb; xnlb(idx(1)) = ceil(x(idx(1))); % Toma el x<--entero. mayor
    [xInicial,FOmin] = Banch_and_Bound(c,A,b,xnlb,xub,xInicial,FOmin);
    xnub = xub; xnub(idx(1)) = floor(x(idx(1))); % Toma el x<--entero. menor
    [xInicial,FOmin] = Banch_and_Bound(c,A,b,xlb,xnub,xInicial,FOmin);
end

%Ejemplo
%c=[1;10]
%A=[-66 -14;82 -28]
%b=[-1430;-1306]
%Solucion No Entera
%[xreal,jreal]=linprog(c,A,b)
%Solucion Entera Usando Branch_and_Bound
%[xEntero,FOentera] = Banch_and_Bound(c,A,b)

