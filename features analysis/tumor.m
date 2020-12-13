%   Preparamos los datos
clear   %   Limpiamos el Workspace
clc     %   Limpiamos el Command Window
load('CasosTrainTestWisconsin.mat')
Casos(:,1)=[];  %   Eliminamos la primera columna (ID)

%   Caracteristicas
ftr = [string('Clump Thickness'),string('Uniformity of Cell Size'),string('Uniformity of Cell Shape'),string('Marginal Adhesion'),string('Single Epithelial Cell Size'),string('Bare Nuclei'),string('Bland Chromatin'),string('Normal Nucleoli'),string('Mitoses')];

%   Separamos los datos
bMap=(Casos(:,10))==2;  %   Generamos mapa logico de ambos tumores  
mMap=(Casos(:,10))==4;  
benigno=Casos (bMap,:); % Eliminamos los datos que no cumplan con el mapa
maligno=Casos (mMap,:); 

benigno(:,10)=[];   %   Eliminamos la ultima columna
maligno(:,10)=[];

%   Medidas
sB=size(benigno);
disp(string('Numero de tumores Benignos:'))
disp(sB(1))
sM=size(maligno);

disp(string('Numero de tumores Malignos:'))
disp(sM(1))

figure(1)   %   Creamos ventanas
figure(2)

%   Caracteristicas
for i=1:(sB(2)) %  De 1 a el numero de caracteristicas
    pause
    disp('Caracteristica: ')
    disp(i)
    disp(string('Media Benigno:'))
    mB=(mean (benigno(:,i)));   %   Calculamos su media
    disp(mB)
    disp(string('Desviacion Estandar Benigno:'))
    sB=(std (benigno(:,i)));   %   Calculamos su D. Estandar
    disp(sB)
    disp(string('Media Maligno:'))
    mM=(mean (maligno(:,i)));   %   Calculamos su media
    disp(mM)
    disp(string('Desviacion Estandar Maligno:'))
    sM=(std (maligno(:,i)));   %   Calculamos su D. Estandar
    disp(sM)
    
    %   Plot
    figure(1)   %   Seleccionamos para editar
    plot(benigno(:,i),'*')  %   Graficamos toda la primera columna
    title('Benigno')
    xlabel('Muestras')
    ylabel(ftr(i))
    
    figure(2)   %   Seleccionamos para editar
    plot(maligno(:,i),'*')  %   Graficamos toda la primera columna
    title('Maligno')
    xlabel('Muestras')
    ylabel(ftr(i))
    
    
end