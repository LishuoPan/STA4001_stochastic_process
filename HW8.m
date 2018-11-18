clear;clc;
%% HW8
P = [.5, .5, 0;
    .3, 0, .7;
    1, 0, 0];

pi = stationary_dist(P)

%% T3
u = [0.70024, 0.91764, 0.48056, 0.39341, 0.91562]';
exp_dist = -10*log(u);
sum_time = zeros(length(exp_dist),1);
for i = 1:length(exp_dist)
    for j = 1:i
        sum_time(i) = sum_time(i) + exp_dist(j);
    end
end

function pi = stationary_dist(P)
    dim = size(P,1);
    one_row = ones(1,dim);
    I = eye(dim);
    A = [P'-I;one_row];
    z = [zeros(dim,1);1];
    pi = linsolve(A,z)';
end