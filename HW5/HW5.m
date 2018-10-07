clc;clear;
%% T1
C = [-5;1;10];
P = [.25, .5, .25;
     .5, 0, .5;
     .25, .25, .5];
d = length(C);
%(a)
Q1 = e(1,d)' * sumup_power(10,P) * C;

%(b)
L = 208000;
gen_matrix = zeros(11,L);
value_list = zeros(L,1);

for j = 1:L
    gen_list = zeros(11,1);
    gen_list(1) = 1;
    for i = 2:11
        gen_list(i) = gen_next(gen_list(i-1),P);
    end
    gen_matrix(:,j) = gen_list;
    value_list(j) = evalue_value(gen_list,C);
end

sd = std(value_list);
half_wild = 1.96*sd/sqrt(L)
CI = [mean(value_list)-half_wild, mean(value_list)+half_wild]
                                                                                                               
%(c)
back_time = 10;
beta = .9;
v = beta^10*C;
v_0 = backward_induction(v, back_time, C, P, beta)


%(d)
v_inf = inv(eye(3)-beta*P)*C

%(e)
v_k = C;
k = 75;
for i = 1:k
    v_k = beta*P*v_k + C;
end

if abs(v_k(1) - v_inf(1))<=0.01
    disp('Optimal v_k find: ');
    Optimal = v_k(1)
else
    disp('Optimal not find')
end


%% test part
% for i = 1:2
%     1
% end


 %% Functions
function sum = sumup_power(n,P)
    sum = 0;
    for i = 0:n
        sum = sum + P^i;
    end
end

function e_i = e(n, size)
    e_i = zeros(size,1);
    e_i(n) = 1;
end

function next = gen_next(current, P)
    stage_one = P(current,1);
    stage_two = P(current,1)+P(current,2);
    random = rand;
    if random < stage_one
        next = 1;
    elseif (stage_one<random) && (random<stage_two)
        next = 2;
    else
        next = 3;
    end
end

function value = evalue_value(gen_list, C)
    len = length(gen_list);
    value = 0;
    for i = 1:len
        if gen_list(i) == 1
            value = value + C(1);
        elseif gen_list(i) == 2
            value = value + C(2);
        else
            value = value + C(3);
        end
    end
end

function v = backward_induction(v, back_time, g, P, beta)
    for i = 1:back_time
        v = beta^(10-i)*g + P*v;
    end
end

