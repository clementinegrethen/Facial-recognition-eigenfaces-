function [mu, sigma] = estimation_mu_Sigma(X)
    n = size(X,1);
    mu = transpose(X).*(1/n)*ones(n,1);
    %mu = mean(X, 1)';
    Xc = X - mu';
    sigma = Xc'*Xc.*(1/n);
end
