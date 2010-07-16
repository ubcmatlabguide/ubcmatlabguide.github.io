%% Symbolic Toolbox and Related Functions
% The Symbolic Math Toolkit is a Mathworks package that augments Matlab's
% existing functionality with the core Maple(R) symbolic kernel. With this
% package, you can solve and simplify systems of symbolic equations, find
% symbolic expressions for the inverse of a function, integrate,
% differentiate, take limits, and perform Taylor expansions, sums, variable
% precision arithmetic, or linear algebraic operations. If you have the
% extended symbolic toolkit, (which we do not discuss here), all of Maple's
% non-graphics packages are available. 
%%
% There is more to this package than we can describe here. For more
% information, see the online documentation.
%%
% <html>
% <A HREF="http://www.mathworks.com/access/helpdesk/help/pdf_doc/symbolic/symbolic_tb.pdf">Online Documentation</A>
% </html>
%% Working with Symbolic Variables
% Symbolic variables are treated differently than regular variables in
% Matlab and must be created using the _sym()_ or _syms()_ functions. 
syms A B lambda X Y Z a
%%
% Constant symbols can be defined too, which are not evaluated numerically.
%%
r = sym(sqrt(2)/2)                          
rr = r^2
t = sym(2/3)                        % Need to use sym here, not syms
v = r + t
w = r*2-3/t                         % notice that r is not evaluated
q = sym(22/14 + 18/402)             % add two fractions exactly
%%
% To convert a constant symbolic expression to a regular Matlab double
% value, use the _double()_ function.
double(r)                           % numerically evaluate r
%%
% We can build up more complicated symbolic expressions by defining
% functions of these variables. Note that these too are symbolic
% expressions, not function handles. 
f = cos(X)
g = exp(X^2 - 2*X)                
h = compose(f,g)                   % functional composition: f(g(X))
%%
% Functions of multiple variables can also be created. 
f = X^2 + Y^2 - 2*cos(X)    
g = sqrt(X^2 + Y^2) + Z^2 - lambda
%%
% The _pretty()_ function tries to display a symbolic expression in a
% _prettier_ way. It takes a bit of getting used to. Exponents, for example
% are printed on the line above, trying to mimic how you might write them
% by hand
pretty(g)
%%
% You can convert an expression to latex as follows
latex(g)
%%
% You can convert an expression to C code as follows
ccode(g)
%%
% Symbolic matrices are created in much the same way numeric matrices are. 
syms E F G H I J
mat = [E F G ; H I J]
%%
% We will make use of these in the sections to come.
%%
% The _subs()_ function can be used to substitute one value for another,
% including a numeric value for symbolic one.
subs(f,X,3)             % substitute 3 for X in f
%%
% Once all of the symbolic variables are numeric, the result is numerically
% evaluated. We can prevent this by substituting sym(3) and sym(10) instead.
subs(f,{X,Y},{3,10})    % substitute 3 for X, 10 for Y in f
%%
subs(f,X,lambda-Y)      % substitute (lambda - Y) for X in f
%%
% Many operations on symbolic expressions are ambiguous unless the
% independent variable is specified. If this is not given explicitly,
% Matlab chooses the variable closest in alphabetical order to x, (ties
% broken in favor of the end of the alphabet). You can see how Matlab will
% order the variables in an expression with the _findsym()_ function. 
findsym(f)
%% Basic Algebra
% There are a number of functions that we can use to perform basic
% high school algebra that might be tedious or error prone to do by hand. We
% have already seen _compose()_, which belongs on this list. 
S = (((2*X + 8*X^2)/(2*X)+(2*X^2 - 2*X + X)*(X+2)-(2*X^2 + 2)/(4*X^2 - 2*X^2)*(X+2))/(X+1))+1;
pretty(S);
%%
% We can then factor or expand S.
Sf = factor(S);                  % factor S
pretty(Sf);             
%%
Se = expand(S);                  % expand s
pretty(Se);
%%
% The _simple()_ and _simplify()_ functions can be used to try and find the
% simplest representation: _simple_ tends to do better with trigonometric
% expressions. Surprisingly, we can sometimes get simpler expressions by
% applying the function multiple times. 
%% 
T = 1/2*(2*tan(1/2*X)/(1+tan(1/2*X)^2)              *...
    (1-tan(1/2*Y)^2)/(1+tan(1/2*Y)^2)-2             *...
    (1-tan(1/2*X)^2)/(1+tan(1/2*X)^2)               *...
    tan(1/2*Y)/(1+tan(1/2*Y)^2))/tan(1/2*X-1/2*Y)   *...
    (1+tan(1/2*X-1/2*Y)^2);
Tsimple = simple(T)
TverySimple = simple(simple(T))
%%
% If you call _simple()_ without saving the output, i.e. just *simple(T)*
% as opposed to *t = simple(T)*, it displays many equivalent
% expressions. 
%%
% The _collect()_ function can be used to collect like terms. Here we
% collect all of the Y variables together and find we have (3X - 3Z) of
% them
t = (X + Y)*(2*X-3*Z)+Z+X*Y-(3*X+4);
pretty(t);
%%
t = collect(t,Y);
pretty(t);
%% Function Inverse
% We can find the inverse of a function, (if it exists) with _finverse()_.
f = 2*sin(cos(3*log(X)/4))+1
finv = finverse(f)
%% Solving Symbolic Equations
% The _solve()_ function can be used to solve systems of equations,
% symbolically. Its inputs are either symbolic expressions or strings, with
% each equation separated by a comma followed by the variable or variables
% you wish to solve for. The output is a struct with a field
% for each variable. 
S = solve('k = a/(a-b+p)','p = k*(1+k)^2/(2*a + b+ 1)','a','b')
%%
pretty(S.a)
%%
pretty(S.b)
%%
% If the equations do not contain an equals sign, they are assumed equal to
% 0.
pretty(solve('a*X^2+b*X+c','X'))
%%
%
S = solve('X = 2*Y-1','Y=3*Z','Z=X+Y','X','Y','Z');
S.X
S.Y
S.Z
%% Limits
% We can take limits of functions, (two-sided, as well as left and
% right) as they approach specific values, (symbolic or numeric) or as they
% tend to inf or -inf.
limit((X-1)/(sqrt(X)-1),1)              % limit as X --> 2
limit(X^X/(exp(X)^log(X)),inf)          % limit as X --> inf
limit(cos(X)-2*3^X,X,a)                 % limit as X --> a
limit(cos(X*Y)^X-2*3^Y,Y,0)             % limit as Y --> 0
limit(exp(Y-X),Y,-inf)                  % limit as Y --> -inf  
%%
f = 1/(1 + 2^(-1/X));
limit(f,0)                              % two sided limit as X --> 0 (D.N.E.)
limit(f,X,0,'left')                     % left  sided limit: X-->0-
limit(f,X,0,'right')                    % right sided limit: X-->0+
%% Symbolic Sums
% The _symsum()_ function performs symbolic sums. We specify the summand
% w.r.t. the indexing variable, followed by the start and end indices. The
% end index can be inf, in which case an infinite sum is performed. 
symsum(2^(-X),0,inf)
symsum((-1)^(X+1)*(1/X),1,inf)
symsum(1/(X^2),1,inf)
symsum((-1)^(X+1)*(1/(2*X-1)),1,inf)
symsum(1/X,1,10)
%% Taylor Series Expansions
% We can perform a Taylor expansion of a function. We specify the function,
% and optionally, the degree of the expansion, (default is 6), and a symbol
% or numeric value about which the expansion is performed. 
taylor(sin(X))                      % 6th order Taylor expansion of sin(X)
taylor(exp(X))                      % 6th order Taylor expansion of exp(X)
%%
syms A                             
pretty(taylor(sin(X),10,A))         % 10th order expansion about the point A
%%
pretty(taylor(int(normpdf(X)),10)); % 10th order expansion of the integral of the normal distribution
%% Differentiation
% The _diff()_ function performs differentiation.
diff(log(X))               % differentiate with respect to X
diff(log(X),3)             % take the 3rd derivative of log(X) w.r.t. X
diff(Y*sin(X)+2*X^Y,'Y')   % differentiate w.r.t Y
%%
% We can combine _diff()_ with _solve()_ to find maxima and minima
solve((diff(sqrt(log(3*X^3-2*X)))))
%%
% Here we attempt to find the MLE for the product of N univariate
% Gaussians. Unfortunately, we have to specify a value for N and proceed
% via induction.
syms mu s2 pi
normconst = sqrt(2*pi*s2);                                % s2 for sigma^2
NormPDF = (1/normconst)*exp((-(X-mu)^2)/(2*s2));          % single Gaussian distribution
prodNorm = 1;                   
N = 5;                                                    % we will start with N=5
for i=1:N
   syms(['X',num2str(i)]);
   prodNorm =  prodNorm*subs(NormPDF,X,['X',num2str(i)]); % take product of N Gaussians
end
muMLE = solve(diff(prodNorm,mu),mu);                      % MLE w.r.t. mu
s2MLE = solve(diff(prodNorm,s2),s2);                      % MLE w.r.t. sigma^2
pretty(muMLE)
%%
% We can easily spot the pattern: (1/N)sum(X)
%%
% Unfortunately, s2MLE is not quite as pretty.
pretty(s2MLE)
%% Integration
% The _int()_ function can perform definite and indefinite integration.
int(log(X))                         %indefinite integral w.r.t X
int(sin(X)^2)                       %indefinite integral w.r.t X
int(int(log(X+Y),'X'),'Y')          %indefinite integral w.r.t Y
%%
result = int(2*X*log(X),1,10)       % definite integral
double(result)                      % convert exact to a double
%% Multivariate Calculus
%%
% Here we take the Jacobian of f with respect to v, where both are vectors.
syms r theta
v = [r theta];
x1 = r*cos(theta);
x2 = r*sin(theta);
f = [x1,x2];
J = jacobian(f,v)
%%
% We can calculate the determinant exactly.
detJ = (det(J))
%%
% Lets simplify the above expression.
detJ = simplify(detJ)
%%
% We can also use this function to compute a gradient, so long as our
% function f is scalar valued.
syms X Y Z
f = 2*sin(X) + cos(Y)^2 -3*log(Z)
J = jacobian(f,[X,Y,Z]);
pretty(J);
%% Linear Algebra
% We can create symbolic matrices as we saw above, and perform various
% operations. Constant symbols can be used to perform computations
% exactly.
clear
syms a b c d e f g h i j k l m n o p
A = [a b ; c d ; e f];
B = [g h i ; j k l];
C = A*B
%%
D = [a b ; c d];
inv(D)
%%
det(D)
%%
eig(D)
%%
E = sym([1/3 4/15 2/5 ; 2/3 1/3 0; 1/2 1/4 1/4])
E2 = E^2
%%
det(E)
%%
inv(E)
%%
% Here we try and compute the SVD exactly but to no avail. We can
% find a rational approximation to the entries, however, by using the
% _rats()_ function, which we discuss in more depth below.
[U S V] = svd(E)               % compute the SVD of E
U = rats(double(U))
S = rats(double(S))
V = rats(double(V))
%%
% Symbolic and non-symbolic expressions can be combined. 
[a b ; c d]*[2 0 ; 3 5]
%%
% Here we test the correctness of the Matrix Inversion Lemma. We define
% A,B,C, and D to be arbitrary square matrices. Unfortunately, their
% size is fixed and so the test is not perfectly general. 
%%
% Keep in mind that two symbolic equations are only considered equal if
% Matlab is able to _find_ identical representations of each. Its searches
% are not exhaustive and as such, it might claim that two expressions are
% unequal, when in fact they are, but not conversely. 

syms a b c d e f g h i j k l m n o p
A = [ a b ; c d]; B= [e f ; g h]; 
C = [ i j ; k l]; D = [m n ; o p];

lhs = inv([A B ; C D]);

rhs11 = inv(A) + inv(A)*B*inv(D-C*inv(A)*B)*C*inv(A);
rhs12 = -inv(A)*B*inv(D - C*inv(A)*B);
rhs21 = -inv(D-C*inv(A)*B)*C*inv(A);
rhs22 = inv(D-C*inv(A)*B);
rhs = [rhs11 rhs12 ; rhs21 rhs22];

test = simplify(lhs) == simplify(rhs)

%% Variable Precision Arithmetic
% The _vpa()_ function lets us perform variable precision arithmetic. The
% default is 32 digits, which can be changed for the current session with
% the _digits()_ function. 
PI = vpa(pi,80)                         % pi to 80 digits
s = vpa(sin(sqrt(2)/2),40)              % calculate to 40 digits
%% Rational Fraction Approximation
%%
% As the title suggests, we an approximate any real number as a rational
% fraction, (whose numerator and denominator are relatively prime). This is
% actually a Matlab function, (not from the symbolic toolbox).
q = rats((22/14) + (18/402))
e = rats(exp(1))
simplified = rats(940/40)
val = rats(9.352422118484)
%%
clear