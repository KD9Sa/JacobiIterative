clear all; clc;

%------------------------Part 1------------------------
% Initialize variables

N = input('Enter matrix size: ');
P = input('Enter maximum approximations: ');
T = input('Enter accepted tolerance value: ');

A = zeros(N);    % Coefficients Matrix
B = zeros(N, 1); % Results Matrix
C = zeros(N, P); % Approximations Matrix
D = zeros(N, 1); % Temporary Matrix

%------------------------Part 2------------------------
% Take coefficient values from the user

fprintf('\nChoose an option: (Type 1 or 2)\n');
fprintf('1) Enter values element by element.\n');
fprintf('2) Enter matrices directly.\n');

choice = input('');

if choice == 1
    fprintf('\n');
    for i = 1:N
        for j = 1:N
            message = ['Enter a' num2str(i) ',' num2str(j) ': '];
            A(i, j) = input(message);
        end
        message = ['Enter b' num2str(i) ': '];
        B(i, 1) = input(message);
    end
elseif choice == 2
    A = input('Enter matrix A (Coefficients): ');
    B = input('Enter matrix B (Results): ');
else
    fprintf('Invalid choice. Please only type 1 or 2.')
end

%------------------------Part 3------------------------
% Print the system in a readable form

fprintf('\nThe system you entered is: \n');
for i = 1:N
    for j = 1:N
        % Add '+' sign before x2, x3, x4..etc if coefficient is positive
        if (sign(A(i, j)) == 1) && (j > 1)
            fprintf('+ %3dx%d  ', A(i, j), j);
        
        % Add '-' sign before x2, x3, x4..etc if coefficient is negative
        elseif (sign(A(i, j)) == -1) && (j > 1)
            fprintf('- %3dx%d  ', -A(i, j), j);
        
        else
            fprintf('%4dx%d  ', A(i, j), j);
        end
    end
    fprintf('= %3d', B(i, 1));
    fprintf('\n');
end

%------------------------Part 4------------------------
% Generate table of approximations

for i = 1:P
    for j = 1:N
        D(j, 1) = B(j, 1);
        for k = 1:N
            if j == k
                continue
            end
            D(j, 1) = D(j, 1) - A(j, k) * C(k, i);
        end
        D(j, 1) = D(j, 1) / A(j, j);
        C(j, i+1) = D(j, 1);
    end
end

%------------------------Part 5------------------------
% Check for accepted tolerance value

TC = P;
stop = 0;
for j = 2:P
    if stop == 1
        break
    end
    for i = 1:N
        if abs(C(i, j) - C(i, j-1)) <= T
            TC = j;
            stop = 1;
            break
        end
    end
end
P = TC;
C = C(1:N, 1:TC);

%------------------------Part 6------------------------
% Print the approximations table

fprintf('\nThe approximations table generated is: \n');

fprintf('%4s ', 'n');
for i = 1:P
    fprintf('%5d ', i);
end

fprintf('\n');

for i = 1:N
    fprintf('  x%d ', i);
    for j = 1:P
        if sign(C(i, j)) == 1
            fprintf('%6.3f ', C(i, j));
        else
            fprintf('%5.3f ', C(i, j));
        end
    end
    fprintf('\n');
end

%------------------------Part 7------------------------
% Print Jacobi's Iterative solutions

fprintf('\n');
fprintf('Jacobi Iterative solution is: \n');
for i = 1:N
    fprintf('x%d = %3f\n', i, C(i, P));
end

%------------------------Part 8------------------------
% Get the exact solutions

X = linsolve(A, B);

%------------------------Part 9------------------------
% Print the exact solutions

fprintf('\n');
fprintf('Exact solution is: \n');
for i = 1:N
    fprintf('x%d = %3f\n', i, X(i, 1));
end

%------------------------Part 10-----------------------
% Calculating absolute error

fprintf('\n');
fprintf('Absolute error is: \n');
for i = 1:N
    fprintf('x%d Error = %3f\n', i, abs(C(i, P) - X(i, 1)));
end