%%Cette fonctione permet d'identifier la personne la plus vraisemblable de
%%la représentation compacte de l'image requête en utilisant la
%%classification bayésienne.
%paramètres: x: z1 et z2 ses coordonnées,d: dénominateur de la classe i
% en sortie: la vraissemblance: vrs et d2: dénominateur de classe

function [vrs, d2] = bayesien(x,z1,z2,d)

[mu, S] = estimation_mu_Sigma(x);

if (d == -1) 
    P = zeros(length(z1),length(z2));
 
    for i = 1:length(z1)
        for j = 1:length(z2)
            
            x_centre = [z1(i);z2(j)] - mu;

            vrs(j,i) = exp(-(x_centre.')*(S \ x_centre)/2);
        end
    end

    d2= 2*pi*sqrt(det(S)); 
else

gaussienne(x, mu, S);
end

end