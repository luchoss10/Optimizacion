function [xstar,Jmin] = Banch_and_Bound(c,A,b,xlb,xub,xstar,Jmin)
% Integer linear programming by (recursive) branch & bound
% This algorithm uses linprog.m from the optimisation toolbox
    tol = 1e-5; % anything less is considered zero
    if ~exist('xlb','var'), xlb = 0*c; end % canonical form (for the moment)
    if ~exist('xub','var'), xub = Inf*ones(size(c)); end % Upper bound defaults
    if ~exist('xstar','var'), xstar = []; end
    if ~exist('Jmin','var'), Jmin = Inf; end % Try to minimise this
        % Use the following two line if you prefer OPTI Optimization toolbox
        % LPrelax = opti(’f’,c,’ineq’,A,b, ’bounds’, xlb, xub);
        % [x,j,exitflag] = solve(LPrelax);
    optns = optimset('display','off'); % turn off diagnostics in Linprog
    [x,j,exitflag] = linprog(c,A,b,[],[],xlb,xub,[],optns);
    if exitflag~=1, return, end % if infeasible, branch ended
    if j>Jmin, return, end % if current cost J=cT x is worse, drop
    idx = find(abs(x-round(x)) > tol); % which are non-integers ?
    if isempty(idx) % All integer solutions
        if j<Jmin, xstar=round(x); Jmin=j; end % New integer optimum
        return % problem solved
    end
    % Depth first recursion
    xnlb = xlb; xnlb(idx(1)) = ceil(x(idx(1))); % Take x<--int. greater than x
    [xstar,Jmin] = Banch_and_Bound(c,A,b,xnlb,xub,xstar,Jmin);
    xnub = xub; xnub(idx(1)) = floor(x(idx(1))); % Take x<--int. less than x
    [xstar,Jmin] = Banch_and_Bound(c,A,b,xlb,xnub,xstar,Jmin);
end