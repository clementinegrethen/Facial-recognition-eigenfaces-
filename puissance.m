function B = puissance(A,n)
 if (n == 1)
    B = A;
 else
    if (mod(n,2) == 0)
        B = puissance(A,n/2) * puissance(A,n/2);
    else
        B = puissance(A,((n-1)/2)) * puissance(A,((n-1)/2)) * A;
    end
 end
end

