%% HW 10
clc;clear;
%% T1
jumps = 6;
path = zeros(1,jumps+1);
path(1) = 2;
for i=1:jumps
    path(i+1) = jump(path(i));
end
Q1_path = path;
Q1_path
%% T2
%(a)
G = [-12, 4, 8;
    5, -6, 1;
    2, 0, -2];

P_0dot2 = expm(0.2*G)
%(b)
P_1 = expm(G)
%(c)
P_1dot2 = P_1*P_0dot2;
AtoC_1dot2 = P_1dot2(1,3)
P_1__2 = P_1^2;
BtoA_2 = P_1__2(2,1)
%(d)
P_5 = expm(5*G)
%% T5
%(a)
G = [-1, 1, 0, 0, 0;
    1/2, -3/2, 1, 0, 0;
    0, 3/2, -5/2, 1, 0;
    0, 0, 7/4, -11/4, 1;
    0, 0, 0, 2, -2];
%(b)
P_2 = expm(2*G);
P_2_14 = P_2(1,4)
%(c)
expect_2 = [0,1,2,3,4]*P_2(1,:)'
%(d)
pi = [21/115,42/115,28/115,16/115,8/115];
U_J=pi*[0,1,1,1,1]'
U_M=pi*[0,0,1,1,1]'
%(e)
que_len = pi*[0,1,2,3,4]'
%(f)
g = [0, 1/2, 3/2, 3/2, 3/2]';
TP = pi*g
function next = jump(state)
    if state == 1
        if exprnd(1/4)<exprnd(1/8)
            next = 2;
        else
            next = 3;
        end
        
    elseif state == 2
        if exprnd(1)<exprnd(1/5)
            next = 3;
        else
            next = 1;
        end
        
    else
        next = 1;
    end
end