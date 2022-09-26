clear;
close all;

load eigenfaces_part3;
Data = [];
for j = 1:nb_personnes_base,
	for k =1:nb_postures_base ,  
        ficF = strcat('./Data/', liste_personnes_base{j}, liste_postures{k}, '-300x400.gif');
        img = imread(ficF);
        Data = [Data ; double(transpose(img(:)))];
	end
end

% Tirage aleatoire d'une image de test :
personne = randi(nb_personnes)
posture = randi(nb_postures)


ficF = strcat('./Data/', liste_personnes{personne}, liste_postures{posture}, '-300x400.gif')
img = imread(ficF);
image_test = double(transpose(img(:)));



% Nombre q de composantes principales à prendre en compte 
q = 2;

% dans un second temps, q peut être calculé afin d'atteindre le pourcentage
% d'information avec q valeurs propres (contraste)
% Pourcentage d'information 
% on doit utiliser les deux classifieur
%% Commençons par le classifieur kppv:
 per = 0.75;

W = W(:,1:q);

dataT = (image_test-X_centre)*W;
C_base = Data*W;

labelA_p = 1:(nb_personnes_base*nb_postures_base);
ListeClass_p = 1:(nb_personnes_base*nb_postures_base);
labelA = 1:nb_postures_base;
ListeClass = 1:nb_postures_base;

K = 1;

dpers = C_base(1:nb_postures_base:end,:);
[Partition] = kppv(dpers, labelA_p, dataT, 1, 1, ListeClass_p)
personne_p = Partition(1);
dpost = C_base(nb_postures_base*(personne_p-1)+1:nb_postures_base*personne_p,:);
[Partition] = kppv(dpost, labelA, dataT, 1, 1, ListeClass_p)
posture_p = Partition(1);

% pour l'affichage (A CHANGER)
personne_proche = personne_p;
posture_proche = posture_p;

figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.8*L,0.5*H]);

subplot(1, 2, 1);
% Affichage de l'image de test :
colormap gray;
imagesc(img);
title({['Individu de test : posture ' num2str(posture) ' de ', liste_personnes{personne}]}, 'FontSize', 20);
axis image;

ficF = strcat('./Data/', liste_personnes_base{personne_proche}, liste_postures{posture_proche}, '-300x400.gif')
img = imread(ficF);
        
subplot(1, 2, 2);
imagesc(img);

title({['Individu la plus proche : posture ' num2str(posture_proche) ' de ', liste_personnes_base{personne_proche}]}, 'FontSize', 20);
axis image;
%% le classifieur bayésien n'est pas réalisable avec les données mais j'ai quand même réalisé la fonction demandée.
