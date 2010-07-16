%% Flow of Control 
%
% Matlab's constructs for controlling the conditional execution of commands
% are very similar to those found in most popular programming languages.
% One major difference, however, is that variables created within the if,
% for, while, switch, and try statements, are not locally scoped but
% instead share their scope with all variables in the same function. This
% is quite unlike java, for example, where a variable created inside a loop
% can only be used inside that loop. 
%%
% <html>
% <META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
% </html>
%% if, else, elseif
% Matlab _if_ statements allow you to execute different code depending on the
% current state of the program, i.e. the values of certain variables. 
test1 = true;
test2 = false;
test3 = false;
%%
if(test1), A = 1; end       % simple if statement on one line. A=1 executed if test1 is true
%%
if(test1)
    A = 2;                  % executed if test1 = true
else
    A = 3;                  % executed if test1 = false
end
%%
if(test1)
    A = 3;                  % executed if test1 = true
elseif(test2)
    A = 4;                  % executed if test1 = false and test2 = true
elseif(test3)
    A = 5;                  % executed if test1 = false, test2 = false, test3 = true
else
    A = 6;                  % executed if test1=test2=test3=false
end
%%
% All if statements must end with an _end_ statement.
%% switch statements
% Switch statements are useful when what code to execute depends on a
% variable that takes on a countable number of values. Most commonly, this
% value is an integer or a string. Switch statements can be replaced by a
% long series of if-else statements but this usually results in less
% readable code. Note that unlike languages such as C or java, switch
% statements do not _fall through_; that is, the code from, (at most), one
% case statement is executed. As such, break statements are not necessary.
color = 'blue';        
switch color                    % switching variable
    case 'red'                  
        A = 1;                  % code for case 'red'
    case 'blue'
        A = 2;
    case {'green','purple'}     % either 'green' or 'purple'
        A = 3;
    otherwise                   % optional 'catch all'
        A = 4;
end            
%% for loops
% For loops allow you to execute a block of code a specified number of
% times. That number can be determined dynamically as the program runs.
n = ceil(100*rand);                 % can be set dynamically
A = zeros(n,1);                     % improve speed by preallocating space
for i=1:n                           % set i = 1, then loop and increment i by 1, until i = n
    A(i,1) = max(i,50);             % execute code within the loop - usually depends on i.
end                                 % both i and A can then be accessed outside the loop.
%%
% We can terminate for loops early in several ways.
% *Continue* instructs Matlab to skip directly to the next iteration of
% the current loop without  executing the lines directly below 
% the continue command.
% *Break* breaks from the current loop completely. *Return*
% breaks completely from the current script or function without executing
% any further code. 
A = rand(20,20,20);
counter = 0;
for i=1:size(A,1)
    for j=2:size(A,2)
        for k=3:size(A,3)
            %if k is even, go immediately to beginning of loop
            if(mod(k,2) == 0),          continue; end
            %if j+k is prime, break from this inner loop completely
            if(isprime(j+k)),           break   ; end    
            %if all three of i,j,k prime, stop all further execution.
            if(all(isprime([i,j,k])) && false),  return  ; end 
            if(isprime(floor(100*A(i,j,k))))
                counter = counter + 1;
            end
        end
    end
end
%%
% The continue, break, and return statements should be used sparingly as
% they can easily obscure the code and can almost always be replaced by
% if,else,elseif statements.
%% while loops
% While loops are used to execute a block of code until some condition is
% satisfied. This condition is usually more complicated than simply
% reaching a set number of iterations as with a for loop. The comments on
% scope, and the continue, break and return statements apply equally to
% while loops. 
A = true; B = true; C = true;
val = 1;
while(A || B || C)
    val = 2*val +1;
    A = isprime(val);
    B = val < 10;
    C = ((round(sqrt(val)))^2) == val; 
end
%%
% Here is common code idiom involving break. This effectively allows us to
% test at the end of the loop, (or in multiple spots).
%%
%  while(true)
%      %execute code
%      if(condition)
%          break;
%      end
%  end
%%
% <html> 
% <A NAME="tryCatch"></A>
% </html>
%% try/catch statements
% Try/catch blocks give you some control over Matlab error handling. They
% are useful for executing code that might potentially fail, such as
% writing to a file, allowing you to perform cleanup or recover gracefully.
% In the example below, ME stands for 'matlab exception'; this
% is an object of type Exception.

a = rand;
b = a*(a< 0.5);
try
    c = a / b;
    assert(true);                       % set to false to have code throw an error
catch ME                                % disaster recovery, cleanup, inform user, etc...
    display('Something went wrong');    
    warning('WARNING:ID','my own warning message');
    display(ME.message);                % ME is a structure with info on the error
    %error('my own error message');     % stops execution
    %rethrow(ME);                       % rethrows the original error and stops execution
end


