%% Debugging
% Matlab code is very flexible, particularly with respect to its dynamic
% typing, however, this can also lead to enormous headaches when it comes
% time to debug a crashing program. You may have overwritten or misspelled
% an important variable without knowing it, or inadvertently expanded the
% size of your matrix, and Matlab will happily continue executing without
% warning until your program grinds to a halt. Trying to discover the
% original problem that started dozens of lines before or in another
% function is not always easy. 
% Fortunately, Matlab has several tools that can help, which we discuss
% below.
% More information can be found online
% <http://www.mathworks.com/support/tech-notes/1200/1207.html?s_cid=MLD0506na2TS1
% here>.
%% M-lint Warnings & Errors inside the editor
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
%% Keyboard command
% The _keyboard()_ function can  be used to stop execution of a program
% at any given place, 
% temporarily relinquishing control back to you at the command window. Simply add
% the line *keyboard* anywhere in your file to stop at that point.
% You can print or modify variables, run scripts, etc.
% To return execution, type *return*.
%%
% When you are in debug or keyboard mode, the command window prompt will look slightly
% different: it will have a _k_ in front.
%%
% <<debugprompt.png>> 
%
%% Turning on the debugger
% If your program is crashing or displaying cryptic warnings, it is very
% useful to have it automatically halt execution right at the point where
% it ran into trouble. Type *dbstop if error*
% and *dbstop if warning*.
% Or you can use the GUI: Select _Debug --> Stop if Errors/Warnings_ to turn
% this on.
%%
% <html> 
% <A NAME="breakpoints"></A>
% </html>
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
% Once your code has stopped at a breakpoint, you can step one line at a
% time, continue on until the next break point, or exit debug mode
% completely using the tool bar buttons at the top of the editor. 
%
% The _step in_ and _step out_ buttons, shown on the right of the editor toolbar below,
% let you enter into, or leave a
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
%% Variable Stacks
% Once execution has stopped because of a break point or _keyboard()_
% command, you can inspect the current values of the variables by just typing
% their name, as usual. Or you can open a GUI by typing *workspace*.
% Typically functions call other functions, and the variables get pushed
% on the stack. To change stackframes (step into other the scope of other functions),
% use *dbup* or *dbdown*,
% or click the stack button on the GUI.
% You can also execute commands at the command prompt while execution has
% stopped, and assign new values to existing variables.
%