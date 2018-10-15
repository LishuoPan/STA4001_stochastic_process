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
%% T2
%(a)
p1 = 1 - 1/(1+3+3^2+3^3)
p2 = p1 - 3*(1-p1)
%(b)
A = [0,-0.6,0.8;-0.6,0.8,-0.2;0.4,-0.2,-0.2];
b = [1;1;1];
N = linsolve(A,b)

%% T5
P = [0, 0, 0, 1/6, 1/6, 1/6, 1/6, 1/6, 1/6;
     0, 0, 1/6, 1/6, 1/6, 1/6, 1/6, 1/6, 0;
     0, 1/6, 1/6, 1/6, 1/6, 1/6, 1/6, 0, 0;
     1/6, 1/6, 1/6, 1/6, 1/6, 1/6, 0, 0, 0;
     1/6, 1/6, 1/6, 1/6, 1/6, 1/6, 0, 0, 0;
     1/6, 1/6, 1/6, 1/6, 1/6, 1/6, 0, 0, 0;
     0, 1/6, 1/6, 1/6, 1/6, 1/6, 1/6, 0, 0;
     0, 0, 1/6, 1/6, 1/6, 1/6, 1/6, 1/6, 0;
     0, 0, 0, 1/6, 1/6, 1/6, 1/6, 1/6, 1/6];
C = [30;70;110;150;175;200;190;180;170];
v0 = e(1,9)' * sumup_power(9,P) * C
%% T6
elem_vec = zeros(3,396);
count = 1;
for i = 0:10
    for j = 0:5
        for k = 0:5
            elem_vec(:,count) = [i;j;k];
            count = count+1;
        end
    end
end
P_matrix = zeros(396,396);
for i = 1:396
    for j = 1:396 
        V_1 = elem_vec(:,i);
        V_2 = elem_vec(:,j);
        for An = 0:min(V_1(1),5)
            
            if (V_2(2) == V_1(3)) && ...
               (V_2(3) == max(0,5-V_1(1))) && ...
               ((max(V_1(1)-An,0) + V_1(2) + max(0,(5-V_1(1)-V_1(2)))) == V_2(1))
                if An == min(V_1(1),5)
                    P_matrix(i,j) = (6-min(V_1(1),5))/6;
                else
                    P_matrix(i,j) = 1/6;
                    
                end
            end
        end
    end
end

C = zeros(396,1);
for i = 1:396
    a = elem_vec(1,i);
    b = elem_vec(2,i);
    C(i,1) = 250-10*a-15*max(5-a,0)-5*max(5-a-b,0);
end
len_ab = length(C);
v0_T6 = e(1,len_ab)' * sumup_power(9,P_matrix) * C
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

