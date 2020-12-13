% LAB 3. Naive Bayes Clasificador

% En este lab programaremos un clasificador capaz de predecir el

% diagnostico de un caso nunca antes visto en base a los casos previamente

% observados.


%%      Preparacion de las clases


%   Preparamos los datos
clear   %   Limpiamos el Workspace
clc     %   Limpiamos el Command Window
addpath '/Users/catalan/Documents/Tareas/DataMining/Naive Bayes'
load('CasosTrainTestWisconsin.mat')
matfull=Train;
mat=Train;    
mat(:,11)=[];  %   Eliminamos las siguientes columnas
mat(:,1)=[];
mat(:,4)=[];
mat(:,4)=[];
mat(:,5)=[];
mat(:,5)=[];
mat(:,5)=[];

%   Separamos las clases
map_benigno=matfull(:,11)==2; %   Encontramos todas los renglones ==2
benigno=mat(map_benigno,:);   %   Creamos la matriz limpia

map_maligno=matfull(:,11)==4;
maligno=mat(map_maligno,:);

m_benigno=size(benigno,1);
m_maligno=size(maligno,1);

%%  1.- Dividir (Probabilidad a priori) 

m=size(mat,1);    %   Todas mis muestras

Prob_B= m_benigno/m;    %    Probabilidad de que sea Benigno
Prob_M= m_maligno/m;    
%%  2.- Tablas de freq & 3.- Correccion

%   Benigno

% Medidas
freqRb=size(unique(mat),1);   %    Medida de renglones
freqCb=size(mat,2)+1;         %    Medida calomnas + freq

% Tabla de freq

freqBenigno=zeros(freqRb,freqCb);

freqBenigno(:,1)=unique(mat);   %   Asignamos las freq

for i=1: (size(benigno,2))  % Nos movemos por las columnas
    
    for j=1 : freqRb        %   Nos movemos por los renglones
        
        x=freqBenigno(j,1); %   freq a buscar
        
        freqBenigno(j,(i+1))= (sum(benigno(:,i)==x))+1;   %   Correccion
        
    end

end

%   Maligno

% Medidas
freqRm=size(unique(maligno),1);   %    Medida de renglones
freqCm=size(maligno,2)+1;         %    Medida calomnas + freq

% Tabla de freq

freqMaligno=zeros(freqRm,freqCm);

freqMaligno(:,1)=unique(maligno);   %   Asignamos las freq

for i=1: (size(maligno,2))  % Nos movemos por las columnas
    
    for j=1 : freqRm        %   Nos movemos por los renglones
        
        x=freqMaligno(j,1); %   freq a buscar
        
        freqMaligno(j,(i+1))= (sum(maligno(:,i)==x))+1; 
        
    end

end

%% 4.- Normalizar

%   Sumas de clases

sumFreqB=sum(freqBenigno(:,2));
sumFreqM=sum(freqMaligno(:,2));

%   Modificamos las tablas

%   Benignos

for i=1: (size(benigno,2))  % Nos movemos por las columnas
    
    for j=1 : freqRb        %   Nos movemos por los renglones
        
        freqBenigno(j,(i+1))=  (freqBenigno(j,(i+1))) / sumFreqB;
        
    end

end

%   Malignos

for i=1: (size(maligno,2))  % Nos movemos por las columnas
    
    for j=1 : freqRm        %   Nos movemos por los renglones
        
        freqMaligno(j,(i+1))= (freqMaligno(j,(i+1)))/sumFreqM;
        
    end

end

%% 5.- Test (Calcular Test)

test=Test;
test(:,11)=[];   %   Eliminamos las siguientes columnas 
test(:,1)=[];  
test(:,4)=[];
test(:,4)=[];
test(:,5)=[];
test(:,5)=[];
test(:,5)=[];

medidaTest=size(test,1);    %   Numero de ejemplos 
ProbTestB=zeros(medidaTest,1);  % Creamos las tablas
ProbTestM=zeros(medidaTest,1);

%   Probabilidad
for j=1: medidaTest     %      De 1 a 239
%   Benigno
ProbTest=1;
for i=1: size(test,2)   %   De 1 a 9
    x=(test(j,i));      %   Valor a buscar
  
    ProbTest= ProbTest * (freqBenigno  (x,(i+1))  );
    
    
end

ProbTestB(j)=ProbTest*Prob_B; %   Prob Benigno

%   Maligno
ProbTest=1;
for i=1: size(test,2)
    x=(test(j,i));
    ProbTest=ProbTest * (freqMaligno(x,   (i+1)  )    );
    
end

ProbTestM(j)=ProbTest*Prob_M; %   Prob Maligno

end

%% 6.-  Accuaracy (Benigno = 2, Maligno = 4)

labelPrediction= ProbTestM>ProbTestB;   % 1= Maligno , 0 = Benigno

labelTest= Test(:,11)==4;               % 1 = Maligno

accuarancylabel=labelPrediction==labelTest;     
accuarancy=sum(accuarancylabel)/ medidaTest;    %	%
disp('Efectividad total:');
disp(accuarancy);  

error=accuarancylabel==0;
errorLabel=labelPrediction(error);

accuarancyB=(m_benigno-(sum(errorLabel==0)))/(m_benigno);
accuarancyM=(m_maligno-(sum(errorLabel==1)))/(m_maligno);

disp('Efectividad Benignos:');
disp(accuarancyB);  
disp('Efectividad Malignos:');
disp(accuarancyM);  










