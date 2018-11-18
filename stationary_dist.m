function pi = stationary_dist(P)
    dim = size(P,1);
    one_row = ones(1,dim);
    I = eye(dim);
    A = [P'-I;one_row];
    z = [zeros(dim,1);1];
    pi = linsolve(A,z)';
end