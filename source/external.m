%% Compiling and calling other languages
% Matlab is an extremely powerful programming environment, but
% it can still be useful to call other languages for various
% reasons, such as speed (C) or existence of pre-canned packages (R) or
% data structures (Java). In this chapter, we show how to do this.


%% System Commands 
% You can execute system commands from Matlab using the _system()_ function
% or, equivalently, the ! operator. 
%%
%system('mspaint');                     % launch mspaint.exe
%!mspaint
system('echo hello world > tmp.txt');  % low level pipe to a file
system('type tmp.txt');                % low level display of a file
system('del tmp.txt');                 % delete the file
%% Eval
% Often we do not know precisely which system commands to execute until
% run time. The _eval()_ function can be very useful in these cases. Eval
% executes a string specified command as if it were typed at the command
% prompt or executed in a script or function.
%%
% Create 5 files tmp1.txt through tmp5.txt using low level system commands
for i=1:5
   cmd = sprintf('!echo ''%s'' > %s',  sprintf('this is filenum %d', i), sprintf('tmp%d.txt', i))
   eval(cmd)
end
% Now look at the contents of the first file
type tmp1.txt
%%
% While extremely powerful, eval should only be used when other options have
% been exhausted as it can result in code that is very difficult to debug.
% If you want to dynamically determine which _function_ to execute as your
% program runs, it is much better to pass around
% <writingFunctions.html#funHandles function handles>.
%%

%% Calling Java
% It is possible to call Java directly from Matlab.
% To create an object of a java class, you simply need to call the
% constructor. You must use the fully qualified name, even for classes
% under java.lang, unless you first import the name space with the
% _import()_ function, as in this example.
S = java.lang.String('hello')
import java.lang.*;       % import the java.lang namespace
S = String('hello')       % Create a java String object
A = S.substring(0,2)      % Call a method from the java.lang.String class
%%
% Recall, that java indexes from 0, not 1 as in Matlab
%%
I = Integer(3);            % Create a java.lang.Integer object
%%
% When the type returned by a java method is either of type
% java.lang.Object or a java primitive type, such as int, double, char,
% boolean, etc, Matlab automatically converts to a Matlab type for you.
% Similarly, you can pass Matlab data directly to java methods or
% constructors and Matlab will usually convert the data in a 'reasonable'
% way as we saw above. If you want to explicitly convert from a java type
% to a Matlab type, use the _char()_ , _double()_ , _cell()_ , or
% _struct()_ functions. To use _char()_ , the java class must have an
% *obj.toChar()* method and to use _double()_ ,it must have an
% *obj.toDouble()* method.
B = char(A)               % convert to a Matlab char array
C = double(I)             % convert to a Matlab double
%% 
% Java objects can be stored in arrays, cell arrays and structs. When you
% concatenate two java objects, the type of the resulting matrix is the
% lowest common superclass. 
D = [A,I]
%% 
% You can of course, pass java objects to the methods of other java
% objects.
H = java.util.HashMap();
H.put(S,I);
H.get(S)
%%
% Use the _javaArray()_ function to create a java array. Suppose we
% wanted a 2D array of Strings as would be created by the java code,
% String[][] myArray = new String[4][5];
JA = javaArray('java.lang.String',4,5)      % Create a java array of Strings 
%%
% You must specify the fully qualified name here, even if you have imported the
% name space. 
%%
% While Java indexes from 0, when using Matlab syntax as in the following
% command, Matlab automatically converts for you and indexing is once again
% from 1.
JA(3,2) = String('hello') 
K = char(JA(3,2))
%% 
% The _methods()_ and _methodsview()_ functions can be useful for viewing
% the public methods of a java object's class. 
methods(JA)
%%
% Static methods can be used as well
Math.random()
%%
% To create objects of java classes, the classes must be on the Matlab java
% class path. Matlab uses both a static and dynamic path. The static path
% is loaded when Matlab is started and is defined in the *classpath.txt*
% file. To include classes you have written to the static path, edit this
% file, add the directory name containing your .class files at the bottom, 
% and restart Matlab. They will then be available every time you load
% Matlab. Classes added to the dynamic path are available right away
% without having to restart Matlab, but are cleared when Matlab is closed.
% Also, using classes loaded dynamically is slightly less efficient. To add
% a directory to the dynamic path use the _javaaddpath()_ function.
javaaddpath(pwd);          % add a directory to the dynamic path
clear java;                                             % clear the dynamic path
%%
% <html> 
% <A NAME="javaHash"></a>
% </html>
%% Java hash tables
% Hash Tables are very useful, and are supported in Java. One can call them easily from Matlab
% as illustarted in the following example.
hTable = java.util.Hashtable;
hTable.put(0, rand(2,2));
hTable.put(1, 41.287);
hTable.put(2, 'test string');
hTable.put('foo', 'bar');
hTable
hTable.get('foo')
hTable.get(0)
%%
% However, Matlab now (as of 2008b) has a 
% <dataStructures.html#Containers.map containers.map> class, which
% does the same thing, without requiring you to call Java.
%
%% Calling R
% <http://www.r-project.org/ R> is a programming environment and language similar to 
% Matlab but containing 
% somewhat different functionality, and with an emphasis on statistics
% rather than general numerical computing. Here we
% describe how to call R functions and obtain the results from within
% Matlab. 
%%
% There are three approaches we can take to interface with R.  
%
% # Since we can execute system commands from Matlab and easily write
%   to files, we could take a file based approach to calling R.
% # We can bring up an R command prompt in Matlab by typing *! R --no-save* 
%   at the command prompt - *q()* to quit - but we cannot transfer data this
%   way.
% # A better approach, in Windows at least, is to use the DCOM interface.
%% Calling R using the DCOM interface (Windows only)
% This is how you set it up.
%%
% # Install R version 2.62 or later from <http://www.r-project.org/>
% # Add R.exe to the windows path. 
% # Install the RCom Server available at
% <http://lib.stat.cmu.edu/R/CRAN/contrib/extra/dcom/RSrv250.exe>
% # Reboot Matlab
%%
% You can add the R directory to your windows path for the duration of the
% Matlab session with the command below: alter the *2.6.2* accordingly.
% To add it permanently, add the directory to Control Panel ->
% System -> (Advanced System Settings) -> Environment Variables -> Path, or
% similar, depending on the version of Windows. 
setenv('PATH',[getenv('PATH') ';C:\Program Files\R\R-2.6.2\bin']);
%%
% You can then use the COM interface as in this example
Rcon = actxserver('StatConnectorSrv.StatConnector')  % setup connection
Rcon.Init('R');                                      % open R
Rcon.Evaluate('A <- 3');                             % execute an R command, (in R memory space)
A = Rcon.GetSymbol('A')                              % import R data into Matlab
B = [1,2,3];                                         % some Matlab data
Rcon.SetSymbol('B',B);                               % export Matlab data to R
C = Rcon.Evaluate('B <- B +1')                       % execute an R command, get returned data
Rcon.Close;                                          % close connection (remember to do this!)
%% 
%% Matlab-R link (Windows only)
% There is much simpler way to call Matlab. First install
%   <http://www.mathworks.com/matlabcentral/fileexchange/loadFile.do?objectId=5051&objectType=FILE this matlab package>.
% This provides the following m-files:
% openR, closeR, evalR, getRdata, putRdata.
% We give an example of use below.
%
% The interface can be finicky and will return highly cryptic error
% messages when anything goes wrong. When exporting Matlab matrices to R
% for example, it is sometimes necessary to create the variable in R first, 
% assigning it a dummy scalar value. 
%
% Here we demonstrate how to use the openR, closeR, evalR, getRdata, and
% putRdata files. We attempt to classify data using R's randomForest
% function. The R randomForest package must first be installed *in R* by going
% to packages -> install Packages -> (choose a server) -> randomForest
%%
rand('twister',1);                       % seed rand num generator
load fisherIris                          % builtin dataset
[j,j,species] = unique(species);         % convert to numeric class labels instead of strings
ntrain  = 120;                           % number of training cases to use
ntest   = 30;                            % number of test cases to use
perm   = randperm(size(meas,1)        ); % randomly divide data into training and test sets
Xtrain = meas    (perm(1:ntrain    ),:); 
Xtest  = meas    (perm(ntrain+1:end),:);
ytrain = species (perm(1:ntrain    ),:);
ytest  = species (perm(ntrain+1:end),:);
%%
openR;                                % open the R connection
evalR('library(randomForest)');       % load the already installed randomForest package
putRdata('Xtrain',Xtrain);            % export the Matlab data to R
evalR('Xtrain <- data.frame(Xtrain)') % randomForest expects an R data frame, create it.
putRdata('ytrain',ytrain);            % export to R
evalR('ytrain <- data.frame(ytrain)');% build frame
putRdata('Xtest',Xtest);              % export to R
evalR('Xtest <- data.frame(Xtest)');  % build frame
%%
% Here we call the actual randomForest function in R and ask the
% constructed forest to predict the class labels given the training data.
evalR('rf <- randomForest(Xtrain[1:120,],ytrain[1:120,])');
evalR('yhat <- predict(rf,Xtest[1:30,])');
yhat = getRdata('yhat');                     % import the predictions into Matlab
closeR;                                      % close the R connection
numWrong = sum(round(yhat') ~= ytest)        % How many, out of 30, did it get wrong?
%%
% Note, the R random forest function performed regression here not
% classification so we round the results to approximate the class labels. 
%% Calling Perl
% Perl scripts can be run using the _perl()_ function. 
fid = fopen('hello.pl','w');
fprintf(fid,'$input = $ARGV[0];\nprint "Hello $input.";');
fclose(fid);
perl('hello.pl','World')
%%
% <html> 
% <A NAME="mex"></A>
% </html>
%% Mex: Calling C, C++, Fortran
% Matlab can be extremely fast if you are able to vectorize the code, but
% when you are faced with loops, executing many many times, Matlab code can be
% prohibitively slow. It is sometimes necessary, for the sake of speed, to
% write certain time intensive parts of a Matlab application in a low level
% language like C. Unfortunately, the process of interfacing with C, C++
% and Fortran can be somewhat complicated. We explain here, how to write a
% simple C function and make it work in Matlab. For more detailed
% information consult the online documentation at 
% <http://www.mathworks.com/access/helpdesk/help/techdoc/matlab.html>
%%
% We use the _mex()_ function to compile C code for use in Matlab
% but we must first add the required components to the C source file
% itself. We import the mex library, which gives us access to various error 
% checking and matrix creation utilities in C.
% 
% # type *mex -setup* and follow the simple instructions to setup the compiler.
% # start writing your C function and include the line *#include "mex.h"*
% # add a Matlab mex gateway function with the definition given below. This
%   function will be called when you execute the function from within Matlab.
% # perform any error checking in the gateway function, setup the output
%   parameters using say  the _mxCreateDoubleMatrix_ function available from mex.h. 
%   and call out to whatever function does the real work. 
% # save the C file and make sure its on the Matlab path
% # type *mex filename.C* at the Matlab command prompt to compile the
%   function, creating, (in windows at least) a file called
%   filename.mexw32. The extension differs in different operating systems.
% # call the function as you would any other Matlab function.
%
%%
% The gateway function must have the following definition:
%
% *void mexFunction(int nlhs, mxArray *plhs[],int nrhs, const mxArray*prhs[])*
%
% * nlhs is the number of output arguments 
% * nrhs is the number of input arguments
% * plhs is a pointer array to mxArrays created using the _mxCreateDoubleMatrix_ function
% * prhs is a pointer array of mxArrays passed from Matlab
%%
% For an example, see
% <mfiles/yprime.c yprime.c>.
% For information on _mxCreateDoubleMatrix_ and other related functions go
% to help -> contents -> Matlab -> C and Fortran API Reference
%
% <html> 
% <A NAME="mcc"></A>
% </html>
%% Mcc: Exporting Matlab Code to standalone code (requires compiler)
% Matlab code can be exported as a stand-alone application or as a shared
% library for use in Excel, java, C, C++, or .NET applications.
% The standalone code needs the free Matlab Compile Runtime (MCR)
% environment.
% Thus, code that you write in Matlab can be distributed and used by users
% who do not have Matlab installed, or used inside of larger applications.
% Furthermore, deployed code is encrypted and thus protected should you not
% wish to make it open-source.
%
%% 
% To create standalone code,
% you can either type *mcc* or launch the GUI by typing *deploytool*.
% Note that both of these methods
% require you buy
% the
% <http://www.mathworks.com/access/helpdesk/help/toolbox/compiler matlab
% compiler>.
%%
% <html> 
% <A NAME="emlmex"></A>
% </html>
%% Emlmex: compiling to C for fixed memory functions (requires simulink)
% In a certain restricted set of cases, we can compile Matlab m-code to C,
% for use within Matlab, improving speed. The compiler function is
% _emlmex()_ and as above, it creates a mexw32 file. As long as this file
% is on the path, it shadows the original m-code function and is called in
% its place. The compiler is designed to produce embedded code and compiles
% functions that do not require any dynamic memory. Such code is extremely
% fast but requires that the type and size of all of the variables be
% pre-declared at compile time. This is quite a strong precondition; when
% it cannot be met, consider the previous approach, or try compiling in 
% 'real time' as described below. The mex compiler must be first setup by
% following step one of the previous section.
%%
% Note that _emlmex()_ is only available if you have either the simulink or
% fixed-point toolboxes installed. 
%%
% _emlmex()_ currently does not support: cell arrays, objects, sparse matrices,
% try/catch blocks, nested functions, matrix element deletion, variables
% that change size or type, and java.
%%
% You must include the following comment as the first line below the
% function header: *%#eml*. This  affects the warning messages
% displayed in the editor.
%%
% Matlab is usually able to automatically infer the type and size of
% variables used. Sometimes, however, the _assert()_ function must
% be used. 
m = ones(3,3);                      % suppose this data is passed to the function.
assert(isa(m,'double'));            % declare the type
assert(all (size(m) == [3 3]));     % declare the size
%%
% Alternatively, the size and type of the input variables can be specified at
% compile time using the -eg switch. Below we compile
% <mfiles/LassoShootingFast.m LassoShootingFast>,
% which is a coordinate ascent method for solving
% L1 regularized least squares,
% using the following sized of inputs
% 
% * X is 1000-by-16,
% * y is 1000-by-1,
% * lambda is 1-by-1,
% * w0 is 16-by-1. 
%%
%emlmex('LassoShootingFast','-eg','{zeros(1000,16),zeros(1000,1),0,zeros(16,1)}');
%%
% We could also parameterize the dimensions as follows:
%n = 1000; d = 16;
%emlmex('LassoShootingFast','-eg',[' {zeros(',num2str(n),',',num2str(d),'),zeros(',num2str(n),',1),0,zeros(',num2str(d),',1)}']);
%%
% We can call the compiler using the above syntax within another
% parent function and have it determine the size of the inputs as it runs,
% before it compiles the subfunction. This gives us the flexibility of
% determining the input sizes at run time but the speed of a compiled
% subfunction.
% Matt Dunham wrote two functions to make this easier:
% <mfiles/compileAndRun.m compileAndRun>,
% which compiles the function, calls it, then deletes it;
% and
% <mfiles/compileRunAndSave.m compileRunAndSave>,
% which compiles the function (for a specific sized input),
% and saves it.
%%
% However, compilation can take a few seconds and so you must
% be sure that the gain obtained from compilation outweighs the overhead.
% Use the _tic()_ and _toc()_ functions to time your code both ways and
% compare. 
% Moreover, compilation is only likely to speed up a function if it
% contains loops and executes a sufficiently large, (i.e. time consuming)
% chunk of code. It will not reduce the asymptotic running time of
% your algorithm and writing emlmex complaint code can be a tedious
% process; be sure its both possible and worth the effort before you begin.
% In the case of LassoShootingFast, however, compiling the function did
% result in code that was about 10 to 100 times faster.  
%%
% If the m-file to be compiled calls additional functions, _emlmex()_ tries
% to compile these as well unless they are first declared extrinsic with
% the command
% *eml.extrinsic('myFunction')*
%% Summary of Useful Functions
% * system, eval
% * import, char, double, cell, struct, javaArray, methods, methodsView
% * javaAddPath, setenv, getenv, 
% * actxserver, openR, closeR, evalR, getRdata, putRdata
% * mex, emlmex, assert, eml.extrinsic
% * perl

