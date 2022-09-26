clear all;
close all;

load eigenfaces_part3;

% Dimensions du masque
ligne_min = 200;
ligne_max = 350;
colonne_min = 60;
colonne_max = 290;

Data = [];
for j = 1:nb_personnes_base,
	for k = nb_postures_base, 
        ficF = strcat('./Data/', liste_personnes_base{j}, liste_postures{k}, '-300x400.gif');
        img = imread(ficF);
        % Degradation de l'image
        img(ligne_min:ligne_max,colonne_min:colonne_max) = 0;
        Data = [Data ; double(transpose(img(:)))];
	end
end

% Tirage aleatoire d'une image de test :
personne = randi(nb_personnes)
posture = randi(nb_postures)


ficF = strcat('./Data/', liste_personnes{personne}, liste_postures{posture}, '-300x400.gif');
img = imread(ficF);
% Degradation de l'image pour le masque 
img(ligne_min:ligne_max,colonne_min:colonne_max) = 0;
image_test = double(transpose(img(:)));

% Nombre q de composantes principales à prendre en compte 
q = 2;

% dans un second temps, q peut être calculé afin d'atteindre le pourcentage
% d'information avec q valeurs propres (contraste)
% Pourcentage d'information 
% on doit utiliser les deux classifieur
%% Commençons par le classifieur kppv:
% per = 0.75;
% prise en compte N compo principales
W_masque = W_masque(:,1:q);
dataT = (image_test-X_centre)*W_masque;
C_base = Data*W_masque;

labelA_p = 1:(nb_personnes_base*nb_postures_base);
ListeClass_p = 1:(nb_personnes_base*nb_postures_base);
labelA = 1:nb_postures_base;
ListeClasse = 1:nb_postures_base;


dpers = C_base(1:nb_postures_base:end,:);
[Partition] = kppv(dpers, labelA_p, dataT, 1, 1, ListeClass_p)
personne_p = Partition(1);

dpost = C_base(nb_postures_base*(personne_p-1)+1:nb_postures_base*personne_p,:);
[Partition] = kppv(dpost, labelA, dataT, 1, 1, ListeClasse)
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


ficF = strcat('./Data/', liste_personnes_base{personne_proche}, liste_postures{posture_proche}, '-300x400.gif');
img = imread(ficF);
% Degradation de l'image
img(ligne_min:ligne_max,colonne_min:colonne_max) = 0;
        
subplot(1, 2, 2);
imagesc(img);
title({['Individu la plus proche : posture ' num2str(posture_proche) ' de ', liste_personnes_base{personne_proche}]}, 'FontSize', 20);
axis image;
