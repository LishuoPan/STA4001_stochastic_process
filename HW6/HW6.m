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

pi_T1 = linsolve(A,z)'
%% T2
    sum = sum_array(1000);
    T2 = 1/3-sum*2/9

%% T3
P = [0, 0, 0, 1/6, 1/6, 1/6, 1/6, 1/6, 1/6;
     0, 0, 1/6, 1/6, 1/6, 1/6, 1/6, 1/6, 0;
     0, 1/6, 1/6, 1/6, 1/6, 1/6, 1/6, 0, 0;
     1/6, 1/6, 1/6, 1/6, 1/6, 1/6, 0, 0, 0;
     1/6, 1/6, 1/6, 1/6, 1/6, 1/6, 0, 0, 0;
     1/6, 1/6, 1/6, 1/6, 1/6, 1/6, 0, 0, 0;
     0, 1/6, 1/6, 1/6, 1/6, 1/6, 1/6, 0, 0;
     0, 0, 1/6, 1/6, 1/6, 1/6, 1/6, 1/6, 0;
     0, 0, 0, 1/6, 1/6, 1/6, 1/6, 1/6, 1/6];
dim = size(P,1);
one_row = ones(1,dim);
I = eye(dim);

A = [P'-I;one_row];
z = [zeros(dim,1);1];

pi_T3 = linsolve(A,z)'
g = [30;70;110;150;175;200;190;180;170];
P = pi_T3*g

%% T4
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
        i_state = elem_vec(:,i);
        j_state = elem_vec(:,j);
        a = i_state(1);
        b = i_state(2);
        c = i_state(3);
        d = j_state(1);
        e = j_state(2);
        f = j_state(3);
        if a == 0 && d == b+max(0,5-b) && e == c && f==5
            P_matrix(i,j) = 1;
        end
        
        if (1 <= a) && (a <= 4)
            for u = 0:(a-1)
                if d == a-u+b+max(0,5-a-b) && e==c && f==5-a
                    P_matrix(i,j) = 1/6;
                end
            end
            for u = a:5
                if d==max(0,5-a-b)+b && e==c && f==5-a
                    P_matrix(i,j) = (6-a)/6;
                end
            end
        end
        if a >= 5
            for u = 0:5
                if d==a-u+b && e==c && f==0
                    P_matrix(i,j) = 1/6;
                end
            end
        end
    end
end
dim = size(P_matrix,1);
one_row = ones(1,dim);
I = eye(dim);

A = [P_matrix'-I;one_row];
z = [zeros(dim,1);1];

pi_T4 = linsolve(A,z)';

g = zeros(396,1);
for i = 1:396
    g(i) = g_val(elem_vec(:,i));
end

Long_turn_profit = pi_T4*g

%% function
function result = sum_array(n)
    result = 0;
    for i = 2:n
        result = result + 1/(i*3^(i-2));
    end
end

function g_i = g_val(state)
    Cstand = -15;
    Crust = -5;
    Cs = -10;
    
    Xn = state(1);
    Rn1 = state(2);
%     Rn2 = state(3);
    L = min(Xn,5);
    part1 = 0;
    for i = 0:(L-1)
        part1 = part1+1/6*i*100;
    end
   
    g_i = max(0,5-Xn-Rn1)*Cstand + max(0,5-Xn)*Crust + Xn*Cs ...
          + part1 + (6-L)/6*L*100;
end