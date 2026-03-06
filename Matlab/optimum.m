% Iterative solution Using Newton method
alpha =[350; 500; 600];
beta = [7.2;7.3; 6.74]; gama=[.004; .0025; .003];
PD=1335;
DelP = 10;              % Error in DelP is set to a high value
lambda = input('Enter estimated value of Lambda = ');
fprintf('\n ')
disp(['   Lambda      P1       P2        P3        DP'...
      '     grad      Delambda'])
iter = 0;                                  % Iteration counter
while abs(DelP)  >= 0.001               % Test for convergence
iter = iter + 1;                           % No. of iterations
P = (lambda - beta)./(2*gama);
DelP =PD - sum(P);                                  % Residual
J = sum( ones(length(gama), 1)./(2*gama));      % Gradient sum
Delambda = DelP/J;                        % Change in variable
disp([lambda, P(1), P(2), P(3), DelP, J, Delambda])
lambda = lambda + Delambda;              % Successive solution
end
totalcost = sum(alpha + beta.*P + gama.*P.^2)
%Graphical Demonstration of Example 7.4
axis([0 600  6.5 10.5]);
P1=0:10:600; P2 = 0:10:600; P3=0:10:600;
IC1= 7.2 + 0.008*P1;
IC2= 7.3 + 0.005*P2;
IC3= 6.74 + 0.006*P3;
Px = 0:100:600;
plot(P1, IC1, P2, IC2, P3, IC3, Px, lambda*ones(1, length(Px)),'-m'),
xlabel('P, MW'), ylabel(' $/MWh'), grid