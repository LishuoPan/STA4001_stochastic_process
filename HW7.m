%% HW7
clc;clear;
%%T3
P = [0, .2, .8;
    .5, 0, .5;
    .4, .6, 0];
c = [0,2,5;
    10,0,1;
    4,20,0];
pi_T3 = stationary_dist(P);
long_run_cost_per_unit = sum(sum((pi_T3*P).*c))
%%T4
P = [0, .5, 0, .5;
    .6, 0, .4, 0;
    0, .7, 0, .3;
    .8, 0, .2, 0];
pi_T4 = stationary_dist(P)
p100 = P^100;
p101 = P^101;
p_11 = 1/2*(p100(1,1)+p101(1,1))
pi = [33/96,27/96,15/96,21/96]
pi*P
