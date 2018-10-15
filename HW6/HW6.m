clear;clc;
%% T1
P = [0, 1/2, 1/2, 0, 0;
     1/2, 0, 0, 1/2, 0;
     0, 0, 0, 1/2, 1/2;
     1/3, 1/3, 1/3, 0, 0;
     0, 1, 0, 0, 0];
dim = size(P,1);
one_row = ones(1,dim);
I = eye(dim);

A = [P'-I;one_row];
z = [zeros(dim,1);1];

pi = linsolve(A,z)
%% T2

