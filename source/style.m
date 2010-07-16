%% Guidelines on programming style
% Writing your code in a clear fashion can help you find bugs,
% and makes it easier for other people to read and modify.
% Programming style, like writing style in general, is something you
% learn over time, mostly by immitating good examples.
% There are lots of good books with suggestions on programming style.
% Some  excellent Matlab-centric advice can be found in
% Richard Johnson's
% <http://www.datatool.com/downloads/matlab_style_guidelines.pdf Programming Style Guidelines>.
% We summarize some of these suggestions below.
% In addition, we include some concrete examples
% from Henry Ledgard's 1984 book,
% _Guidelines on programming practice_.
% The examples in his book are in Pascal, but the principles are the same.
%% Layout
% The layout of your code is one of the simplest ways to improve clarity.
% Use indentation to denote scope, indenting the code in function bodies,
% and further indenting the code within loops, switch statements, try/catch
% blocks as well as nested functions. (Most editors will do this
% automatically.)
%
% Include spaces around operators like ||, &&, ==, etc and consider
% breaking long commands into multiple lines by using ellipses, (...). Keep
% lines to less than say 80 characters long and be consistent throughout. 
%
% Align variables and values by equal signs and commas to show parallel 
% structure, as in this example.
%%
%   plot(Xequal,f(Xequal), 'o' ,'MarkerFaceColor' , 'g'...     
%                              ,'MarkerEdgeColor' , 'k'...     
%                              ,'LineWidth'       ,  2 ...     
%                              ,'MarkerSize'      , 10);   
%
% Below we give an example from Henry Ledgard's 1984 book,
% _Guidelines on programming practice_, of mediocre (left) and good (right)
% program layouts. It is clear that the layout on the right is preferable:
% it makes the structure and meaning of the program much clearer,
% mostly by the more generous use of whitespace, and by
% grouping together conceptually related pieces of code.
% (The local procedure SETMONTHNAMES has been removed from
% the figure on the right to make the comparison easier.)
%%
% <html>
% <table>
% <tr>
% <th width=50%>Mediocre Layout</th>
% <th width=50%>Good Layout</th>
% </tr>
% <tr>
% <td><img src=ledgardMediocreLayout.png height="800"></td>
% <td><img src=ledgardGoodLayout.png height="800"></td>
% </tr>
% </table>
% </html>
%% Comments
% Matlab's commenting conventions are discussed
% <writingFunctions.html#comments here>.
% It is often thought that 'good style' means lots of comments.
% This is rarely true: comments often go 'stale', meaning they become
% inconsistent with the way the code actually works.
% It is best to try to make your code 'self documenting'
% by judicious choice of names, good organization and layout, etc.
% Save comments for obscure things, like vectorization tricks.
% Of course, there should be a comment at the start of every function,
% so that _help_ has something to print.
%
% Below we give an example from Henry Ledgard's 1984 book,
% _Guidelines on programming practice_, of bad (left) and good (right)
% comments. The purpose of the function is irrelevant.
% The point is that the good comments are substantive --- 
% they include examples of what
% a function should do, and discuss exceptional cases.
% The bad ones are 'dribbling': unstructured prose that goes on and on.
%%
% <html>
% <table>
% <tr>
% <th width=50%>Bad comments</th>
% <th width=50%>Good comments</th>
% </tr>
% <tr>
% <td><img src=ledgardBadComments.png height="600"></td>
% <td><img src=ledgardGoodComments.png height="600"></td>
% </tr>
% </table>
% </html>
%% Names 
% It is important to pick names that are meaningful, even if that makes
% them long. Here are some tips.
%%
% * We recommend you use *camel back* notation, as in hiddenMarkovModel.
% CamelBack always starts with a lower case letter, and then uses an upper
% case letter for each new word. Acronyms, such as GaussianHMM, also follow this
% convention, so would be written as gaussianHmm.
% * Capitalize constant variables whose values will not change. 
% Capitals are also often used to denote class definitions.
% * Use verbs for function names, and nouns for variable/ constant names.
% * Prefix logical functions (predicates) with _is_ as in _isfinite()_.
% * Do not use any *magic numbers*, i.e. constant values appearing out of
%   nowhere. Rather, assign these values to variables with descriptive
%   names and use these instead. 
% * Short, single letter variables should only be used in one of three
%   cases: where the structure of the algorithm is important, as in a
%   mathematical derivation; for local temporary variables such as loop
%   indices; or when well defined conventions exist. In all of these cases,
%   document their meaning through comments. 
% * Prefix variables denoting a number of elements with the letter _n_ as
%   in _nvalues_ for the number of values. 
% * Suffix variables storing indices with _NDX_ as in dataNDX
% * Use i,j,k for loop variables.
% * Be consistent with pluralization for non-scalar data, i.e. pick one of
%   _value(j)_ or _values(j)_ and use that convention throughout. 
% * Resuse variables names only when the data is related and even then,
%   with caution. It can be very confusing when a variable you have been
%   tracing through a program suddenly changes role.
%% Making html documentation
% The *publish* command can be used to automatically generate
% html pages, or latex documents, from matlab code:
% it will print the source code and then run it, and include any generated
% output, including figures, into a single document.
% For example, this tutorial was made with publish.
% You are required to use cell mode to specify the desired markup.
% Type *doc publish* for details.
%
% See also the <objectOriented.html#viewClassTree viewClassTree> function
% for visualizing complex class hierarchies.

