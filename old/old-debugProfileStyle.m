%% Debugging, Profiling, & Style Guidelines
% Matlab code is very flexible, particularly with respect to its dynamic
% typing, however, this can also lead to enormous headaches when it comes
% time to debug a crashing program. You may have overwritten or misspelled
% an important variable without knowing it, or inadvertently expanded the
% size of your matrix, and Matlab will happily continue executing without
% warning until your program grinds to a halt. Trying to discover the
% original problem that started dozens of lines before or in another
% function is not always easy. 
%
% In this section, we describe a number of tools and techniques that can
% help as well as ways to assess the speed of your code and find potential
% bottlenecks. We finish by discussing a few stylistic points and best
% practices that can make your code more readable and less prone to bugs in
% the first place.
% 
% <html> 
% <A NAME="Debugging"></A>
% </html>
%% Debugging
% Here are some useful functions which we will explain below
%dbstop, dbquit, dbclear, dbstep, dbstep nlines, dbstep in, dbstep out,
%dbcont, dbstatus, keyboard, workspace
%% M-lint Warnings & Errors
% Matlab automatically checks for certain problems and suggests fixes as
% you edit your m-files. The problem code is underlined in red much like
% word processors underline misspelled words. It is worthwhile paying
% attention to these as they can often point out problems before you run
% your code and frequently suggest ways to speed up execution. The
% suggestions appear when you hover your mouse over the underlined text,
% and you can quickly find these spots by looking for the red markers to
% the right of the document. The warnings and errors _M-lint_ warns you
% about can be set under _File->Preferences->M-lint_.
%%
% In newer versions of Matlab, you can generate a full M-lint html report
% by going to _Tools->Save and Show M-lint Report_. You can also bring up a
% file dependency report or compare two versions of a file from the Tools
% drop down menu.
%% Stop! if Errors/Warnings...
% If your program is crashing or displaying cryptic warnings, it is very
% useful to have it automatically halt execution right at the point where
% it ran into trouble. Type *dbstop if error*
% and *dbstop if warning*.
% Or you can use the GUI: Select _Debug --> Stop if Errors/Warnings_ to turn
% this on, as shown below.
%%
% <<stopiferror.png>>
%% Break Points 
% Break points can be set at any line in the document that executes code by
% pressing just right of the line number. A small circle will appear and
% will turn red when the file is saved. 
%%
% <<breakpoint.png>>
%%
% These can be temporarily disabled by right clicking on them and selecting
% _disable_. To clear them all, type *dbclear all* or press the equivalent
% tool bar button.
%%
% You can set a condition on the breakpoints so that it is only triggered
% if a variable takes on a certain value, by right clicking on the variable
% and selecting 'Set/Modify Condition'.
%%
% <<conditionalBreakpoint.png>>
%%
% Once your code has stopped at a breakpoint, you can step one line at a
% time, continue on until the next break point, or exit debug mode
% completely using the tool bar buttons at the top of the editor. 
%
% The _step in_ and _step out_ buttons, let you enter into, or leave a
% function called at the current line. 
%%
% <<debugToolbar.png>>
%%
% There are function equivalents to these commands if you prefer, namely
% *dbstep*, *dbstep nlines*, *dbstep in*, *dbstep out*, *dbcont*, and
% *dbquit*. The _dbstop()_ function can be used to set breakpoints and the
% _dbstatus()_ function displays all of the breakpoints currently set. You
% can save these into a variable as in *s = dbstatus()*, clear the
% breakpoints and then reset them at a later point with *dbstop(s)*. 
%%
% When you are in debug mode, the command window prompt will look slightly
% different: it will have a _k_ in front.
%%
% <<debugprompt.png>>
%%
% The _keyboard()_ function can also be used to stop execution of a program,
% temporarily relinquishing control back to the command window. Simply add
% the line *keyboard* anywhere in your file to stop at that point. To
% return execution, type *return*. 
%% Variable Stacks
% Once execution has stopped because of a break point or _keyboard()_
% command, you can inspect the current values of the variables by just typing
% their name, as usual. Or you can open a GUI by typing *workspace*.
% Typically functions call other functions, and the variables get pushed
% on the stack. To change stackframes, use *dbup* or *dbdown*,
% or click the stack bottom on the GUI.
%%
% <<debugWorkspace.png>>
%%
% You can also execute commands at the command prompt while execution has
% stopped, and assign new values to existing variables.
%%
% <html> 
% <A NAME="Profiling"></A>
% </html>
%% Profiling & Timing Code
% We have already seen the _tic()_ and _toc()_ functions, which can be used
% to time how long your code takes to run. Simply run _tic()_ before your
% code and _toc()_ after. Matlab, however, has a much more powerful
% framework, called profiling, which gives you a detailed report about how
% long was spent executing each subfunction. You can use this report to
% find bottlenecks that you might be able to improve. 
%%
% You can turn on profiling with the *profile on* command and turn it off
% again with *profile off*. Once profiling is on, execute your code, and
% then type *profile viewer* to see the report.
%%
% <<profile.png>>
%%
% The report shows a breakdown of all the functions called from your
% function, the number of times they were called, and the total time spent
% executing them. Self-time, denoted by a dark blue band, is the the time
% spent within a function not including how long was spent in functions
% called from here. This is really the statistic you should pay attention
% to. You can click on a function name to bring up its sourcecode.
%% Guidelines on programming style
% Writing your code in a clear fashion can help you find bugs,
% and makes it easier for other people to read and modify.
% Programming style, like writing style in general, is something you
% learn over time, mostly by immitating good examples.
% There are lots of good books with suggestions on programming style.
% Some  Matlab-centric advice can be found in
% Richard Johnson's_
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
%% Example of Good and Bad program layout
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
%% Example of Good and Bad comments
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
%% One function, one purpose
% One of Ledgard's mantras is "one function, one purpose".
% Below we give an example of a function that seems well-defined -- it
% deletes empty items from a list of playing cards -- but in reality it does this and 
% much more besides. (Again, the language is Pascal, not Matlab,
% but that is irrelevant.)
%%
% <html>
% <img src=ledgardTooMuch.png height="600"></td>
% </html>
%% 
% Here are some of the odd things about this function.
%%
% * If the list is empty, it creates a new desk of cards. This seems odd.
% Surely reorganizing an empty list should not create a full one!
% It is best to separate out construction of an object (such as a full list) from other forms
% of object manipulation.
% * If the list is full, it prints a warning message. Again this seems odd.
% Surely a reorganized full list is just the list itself? 
% In addition, it is better to raise an exception (using *warning* in
% Matlab) than to print messages to the screen.
% * If you think
% about the *type signature* of this function, it is f: List -> List.
% Empty and full lists are still lists, so should return themselves.
%% Names 
% It is important to pick names that are meaningful, even if that makes
% them long. A common convention is to use underscores, as in
% hidden\_markov\_model, or to use 'camel back', as in hiddenMarkovModel.
% Here are some more tips.
%%
% * Use verbs for function names, and nouns for variable/ constant names.
% * Short, single letter variables should only be used in one of three
%   cases: where the structure of the algorithm is important, as in a
%   mathematical derivation; for local temporary variables such as loop
%   indices; or when well defined conventions exist. In all of these cases,
%   document their meaning through comments. 
% * Capitalize constant variables whose values will not change. 
% * Prefix variables denoting a number of elements with the letter _n_ as
%   in _nvalues_ for the number of values. 
% * Suffix variables storing indices with _NDX_ as in dataNDX
% * Prefix logical functions with _is_ as in _isfinite()_.
% * Use i,j,k for loop variables.
% * Do not use any *magic numbers*, i.e. constant values appearing out of
%   nowhere. Rather, assign these values to variables with descriptive
%   names and use these instead. 
% * Be consistent with pluralization for non-scalar data, i.e. pick one of
%   _value(j)_ or _values(j)_ and use that convention throughout. 
% * Resuse variables names only when the data is related and even then,
%   with caution. It can be very confusing when a variable you have been
%   tracing through a program suddenly changes role.

