%% Operations on matrices
%
% Matlab stands for 'matrix laboratory'. Not surprisingly,
% matrices, vectors and multidimensional arrays are at
% the heart of the language.
% Here we describe how to create, access, modify and otherwise manipulate
% matrices - the bread and butter of the Matlab programmer. 

%% Creating Matrices
% There are a number of ways to create a matrix in Matlab. We begin by
% simply entering data directly. Entries on each row are separated by a
% space or comma and rows are separated by semicolons, (or newlines). We
% say that this matrix is of size 4-by-3 indicating that it has 4 rows and
% 3 columns. We, (and Matlab) always refer to rows first and columns
% second. 
A = [1 3 5 ; 2 4 1 ; 3 3 3 ; 2 1 9]
%%
% We can often exploit patterns in the entries to create matrices more
% succinctly.
A = 1:10                        % start at 1,  increment by 1, stop at 10
B = 1:2:10                      % start at 1,  increment by 2, stop at 10
C = 10:-1:3                     % start at 10, decrement by 1, stop at 3
%%
% We can also create an empty matrix.
D = [];
%%
% Alternatively, there are several functions that will generate matrices
% for us.
A = zeros(4,5)                  % 4-by-5 matrix of all zeros
B = ones (2,3)                  % 2-by-3 matrix of all ones
C = rand(3,3)                   % 3-by-3 matrix of uniform random numbers in [0,1]
D = randn(2,5)                  % 2-by-5 matrix of standard normally distributed numbers
[E,F] = meshgrid(1:5)           % 5-by-5 grids of numbers
G = eye(4)                      % 4-by-4 identity matrix
H = diag(1:4)                   % 4-by-4 diagonal matrix
I = logspace(0,2,6)             % 1-by-6 matrix of log-spaced numbers from 10^0 to 10^2 
J = blkdiag(rand(2,2),ones(3,2))% 5-by-4 block diagonal matrix
K = tril(ones(3,4))             % 3-by-4 matrix whose lower triangular part is all ones. 
L = triu(ones(3,4))             % 3-by-4 matrix whose upper triangular part is all ones.                     
M = magic(6)   % Create a magic square in which sum(A,1) = sum(A,2) = trace(A) = trace(rot90(A))
%%
% The functions _true()_ and _false()_, act just like _ones()_ and _zeros()_ but create
% logical arrays whose entries take only 1 byte each rather than 32. 
%%
clear all
A = false(3,3)
B = zeros(3,3)
whos
%%
%% The Size of a Matrix
% We can determine the size of a matrix by using the _size()_ command
[nrows,ncols] = size(A)
%%
% and the number of elements by using the _numel()_ command.
n = numel(A)
%%
% We refer to dimensions of size 1 as singleton dimensions. 
% The _length()_ command gives the number of elements in the first
% non-singleton dimension, and is frequently used when the input is
% a row or column vector; however, it can make code less readable as it
% fails to make the dimensionality of the input explicit. 
%%
% We can also determine the size along a specific dimension with _size()_. 
n = size(A,2)
%% Transposing a Matrix
% A m-by-n matrix can be transposed into a n-by-m matrix by using the
% transpose operator '.
A = [1 2 3 4 ; 5 6 7 8]
B = A'
%% Sums and Means
% You can use the _sum()_ and _mean()_ functions to sum up or take the
% average of entries along a certain dimension. 
C = sum(A,1)            % Sum out dimension 1, (rows)
D = sum(A,2)            % Sum out dimension 2, (cols)
E = mean(A,1)           % Take the average along dimension 1, (rows)
%% 
% The [] argument to the min and max functions indicates that you will
% specify a dimension. 
F1 = max(A, 2)          % Larger of A and 2 elementwise
F = max(A,[],2)         % Find the max of each row (collapse dim 2)
G = min(A,[],1)         % Find the min of each column (collapse dim 1)
%% Concatenating Matrices
% Matrices can be concatenated by enclosing them inside of square
% brackets and using either a space or semicolon to specify the dimension.
% Care must be taken that the matrices are of the right size or Matlab will
% return an error. 
A = [[1 2 3],ones(1,3)] % concatenate [1 2 3], [1 1 1] along columns
B = [[1 2 3];ones(1,3)] % concatenate [1 2 3], [1 1 1] along rows
C = [99 A 42]           % add a number at the beginning or end of an array
D = [A ; A]             % duplicate the whole row 
%% Basic Indexing
% Individual entries can be extracted from a matrix by simply specifying
% the indices inside round brackets. We can also extract several entries
% at once by specifying a matrix, or matrices of indices or use the :
% operator to extract all entries along a certain dimension. The 'end'
% statement stands for the last index of a dimension.
A = magic(6);
B = A(3,5);              % extract the entry 3 rows down, 5 cols over
C = A([1,2,3],4);        % extract the entries (1,4) ; (2,4) ; (3,4)
D = A(4,[1,1,1]);        % extract the entry (4,1) three times
E = A([2,5],[3,1]);      % extract the entries (2,3) ; (2,1) ; (5,3) ; (5,1)
F = A(:,4);              % extract the fourth column
G = A(4,:);              % extract the fourth row
H = A(:);                % extract every entry as a column vector 
I = A(end,3);            % extract the entry in the last row, 3rd column
J = A(end-1,end-1);      % extract the entry in the second to last row & col
K = A(end-4:end,1);      % extract the last three entries from the first col
L = A(2:end,2:end);      % extract everything except the first row and col
M = A(end:-1:1,:);       % extract everything with the order of the rows reversed.
N = diag(A);             % extract the main diagonal of A
O = diag(rot90(A));      % extract the counter diagonal of A
P = diag(A,-2) ;         % extract the diagonal entries two diagonals left and below the main
%% Logical Indexing
% We can also extract entries using a bit pattern, i.e. a matrix of logical
% values. Only the entries corresponding to true are returned. This can be
% particularly useful for selecting elements that satisfy some logical
% criteria such as being larger than a certain value. We can create a
% logical matrix by relating a numeric matrix to either a scalar value or
% matrix of the same size via one of the logical operators, < > <= >= == ~=
% or by a binary function such as _isprime()_ or _isfinite()_.
B = A > 30
%%
% We can then use this logical matrix to extract elements from A. In
% the following line, we repeat the call to A > 30 but pass the result
% directly in, without first storing the interim result. 
B1 = A(A > 30)                 % get all elements in A greater than 30
B = A(isprime(A) & (A > 30))   % get all prime elements in A greater than 30
%%
% We could also achieve the same result using the _find()_ function, which
% returns the indices of all of the non-zero elements in a matrix. While
% this command is useful when the indices themselves are of interest, using
% _find()_ can be slightly slower than logical indexing although it is a
% very common code idiom. 
B2 = A(find(A > 30))           % same result as A(A>30) but calculated differently
%%
% We can check that two matrices are equal, (i.e. the same size with the
% same elements) with the _isequal()_ function. Using the == relation
% returns a matrix of logical values, not a single value.
test = isequal(B1,B2)
test2 = all(B1==B2)
%% Assignment
% Assignment operations, in which we change a value or values in a matrix,
% are performed in a very similar way to the indexing operations above. 
% Both parallel and logical indexing can be used. We indicate which entries
% will be changed by performing an indexing operation on the left hand side
% and then specify the new values on the right hand side. The right must be
% either a scalar value, or a matrix with the same dimensions as the
% resulting indexed matrix on the left. Matlab automatically expands scalar
% values on the right to the correct size.
A(3,2) = 999;            % assign 999 to entry (3,2) 
A(:,1:3:end) = 999;      % assign 999 to every third column 
A(:,1) = [2;3;5;9;8;7];  % assign new values to the first column.
A(A == 999) = 444;       % assign all entries equal to 999 the value 444
%%
% We can assign every value at once by using the colon operator. The
% following command temporarily converts A to a column vector, assigns the
% values on the right hand side and converts back to the original
% dimensions.
A(:) = 1:36
%%
% Recall from the indexing section that indices can be repeated returning
% the corresponding entry multiple times as in A([1,1,1],3). You can also
% repeat indices in assignments but the results are not what you might
% expect. 
A = ones(3,5);
A([1,2,3,1,1],1) = A([1,2,3,1,1],1) + 1
%%
% You may have expected the entry A(1,1) to now have a value of 4 instead
% of 2 since we indexed entry A(1,1) three times. Matlab calculates the
% right hand side completely before assigning the values and so the value
% of 2 is simply assigned to A(1,1) three times. 
%% Deletion
% Assigning [] deletes the corresponding entries from the matrix. Only
% deletions that result in a rectangular matrix are allowed.
A([1,3],:) = []         % delete the first and third rows from A
A(:,end) = []           % delete the last column from A
%% Expansion
% When the indices in an assignment operation exceed the size of the
% matrix, Matlab, rather than giving an error, quietly expands the matrix
% for you. If necessary, it pads the matrix with zeros. Using this feature
% is somewhat inefficient, however, as Matlab must reallocate a
% sufficiently large chunk of contiguous memory and copy the array. It is
% much faster to preallocate the maximum desired size with the zeros
% command first, whenever the maximum size is known in advance:
% see <speedup.html#prealloc here> for details.
%%
[nrows,ncols] = size(A)
A(4,10) = 222
%%
A = 3
A(1:5,1:5) = 3
%% Linear Indexing
% When only one dimension is specified in an indexing or assignment
% operation, Matlab performs linear indexing by counting from top to bottom
% and then left to right so that the last entry in the first column comes
% just before the first entry in the second column. 
A = zeros(3,5);         % create an empty matrix
A(4) = 99               % assign 99 to the fourth entry (row 3, col 1)
A(1:15) = 1:15          % assign vals 1:15 to their corresponding entries. 
%%
% The functions _ind2sub()_ and _sub2ind()_ will convert from a linear
% index to regular indices and vice versa, respectively. In both cases, you
% must specify the size of the underlying matrix. 
%%
[rowNDX, colNDX] = ind2sub(size(A),12)
linearNDX = sub2ind(size(A),rowNDX,colNDX)
%%
% Sometimes, when dealing with multi-dimensional arrays,
% it is annoying that these functions return/ require multiple separate
% arguments.
% We therefore provide the following alternative
% functions: 
% <mfiles/ind2subv.m ind2subv>
% and 
% <mfiles/subv2ind.m subv2ind>
%%
ndx = ind2subv(size(A),12)
linearNDX = subv2ind(size(A),ndx)
%%
%% Reshaping and Replication
% It is sometimes useful to reshape an array of size m-by-n to size p-by-q
% where m*n = p*q. The _reshape()_ function lets you do just that. The
% elements are placed in such a way so as to preserve the order induced by
% linear indexing. In other words, if a(3) = 3 before reshaping, a(3) will
% still equal 3 after reshaping.
A = zeros(5,6); 
A(1:30) = 1:30
B = reshape(A,3,10)
check = A(11) == B(11)
%% 
% Further, the _repmat()_ function can be used to tile an array m-by-n
% times. 
A = [1 2 ; 3 4]
B = repmat(A,3,6)       % copy A vertically 3 times and horizontally 6 times
%% Element-Wise Matrix Arithmetic
% We can perform the arithmetical operations, addition, subtraction,
% multiplication, division, and exponentiation on every element of a
% matrix. In fact, we can also use functions such as _sin()_, _cos()_,
% _tan()_, _log()_ , _exp()_ , etc to operate on every entry but we will
% focus on the former list for now. 
%
% If one operand is a scalar value, an element-wise operation is
% automatically performed. However, if both operands are matrices, a dot
% must precede the operator as in .* , .^ , ./, and further, both matrices
% must be the same size. 

A = [1 2 3; 4 5 6];
B = A + 1;               % Add or subtract a scalar value from every entry
C = 3.*A;                % Multiply every entry by a scalar value
D = A ./ 3;              % Divide every entry by a scalar value
E = A .^ 3;              % Exponentiate every entry by a scalar value
F = A - [2 4 8 ; 9 1 2]; % Add or subtract two matrices of the same size, (element-wise)
G = A ./ B;              % Divide every entry in A by the corresponding entry in B
H = A .* B;              % Multiply every entry in A by the corresponding entry in B
I = A .^ B;              % Exponentiate every entry in A by the corresponding entry in B

%%
% Matlab also has the .\ operator which is the same as the ./ operator with
% the order of the operands reversed so that (A ./ B) = (B .\ A). As this
% is infrequently used, it should be avoided for the sake of clarity. 
%% Matrix Multiplication 
% We can also perform matrix multiplication of an m-by-n matrix and an
% n-by-p matrix yielding an m-by-p matrix. Suppose we multiple A*B = C,
% then C(i,j) = A(i,:)*B(:,j) , that is, the dot product of the ith row
% from A and the jth column from B. The dot, (or inner) product of a and b
% is just *sum(a.*b)*. Further, if A is a square matrix, we can multiply A by
% itself k times by the matrix exponentiation A^k. 
 A = [1 2 3 4 ; 5 6 7 8]
 B = 2*ones(4,3)
 C = A*B                 % Matrix multiplication of A,B       
 D = (A * A') / 100      % Matrix multiply A and A', divide every entry by 100
 E = D ^ 4               % Matrix multiply D by itself 4 four times
%% Solving linear systems
% Suppose we have the matrix equation Y = XW where X is an n-by-d matrix, W
% is a d-by-k matrix and thus Y is an n-by-k matrix. If X is invertible, we
% could solve for W= inv(X)*Y. The _inv()_ function returns the inverse of
% a matrix. If n ~= d, however, we can still solve for the least squares
% estimate of W by taking the pseudo inverse of X, namely inv(X'*X)*X', or
% more concisely using the Matlab function, _pinv(X)_. Matlab allows you to
% solve more directly, (and efficiently) for W, (i.e. the lsq estimate of
% W), however, by using the matrix division X \ Y. Both X and Y must have
% the same number of rows. (Below we specify a seed to the random number
% generators so that they return the same values every time this demo is
% run). 
seed = 1;       
rand('twister',seed);randn('state',seed);
X = randn(100, 8);
w = randn(8,1);                        % loading vector, Wtrue
y = X*w;                              % Target or output variable, (no noise)
%%
Wlsq = X \ y;                              % recommended way
Wlsq1 = inv(X'*X)*X'*y;                      % normal eqns - Not the recommended way
Wlsq2 = pinv(X)*y;                      % Not the recommended way
[w'; Wlsq'; Wlsq1'; Wlsq2']             % In this simple example, all same
%% 
% Matlab also supports matrix right division such that X \ Y = (Y' / X')'
% but as this is infrequently used, it should be avoided for the sake of
% clarity. 
%% More Linear Algebra
% Matlab was original designed primarily as a linear algebra package,
% and this remains its forte. Here we only list a few functions
% for brevity, do not display the results. Many functions can also take
% additional arguments: type *doc svd* for instance to see documentation
% for the _svd()_ function.
A = magic(5); 
B = det(A);              % The determinant of A
C = rank(A);             % The rank of A
E = trace(A);            % sum of diagonal entries
G = orth(A);             % an orthonormal basis for range of A
H = null(A);             % an orthonormal basis for the nullspace of A
I = chol(A*A');          % Cholesky decomposition s.t. if R = chol(X) then R'*R = X
[evecs,evals] = eig(A);  % eigen vectors and values of A, (use eigs on sparse matrices)
[U,S,V] = svd(A);        % singular value decomposition s.t. A = U*S*V'
[Q,R] = qr(A);           % QR decomposition of A
%% Multidimensional Arrays
% Numeric matrices in Matlab can extend to an arbitrary number of
% dimensions, not just 2. We can use the _zeros()_, _ones()_,
% _rand()_, _randn()_ functions to create n-dimensional matrices by simply
% specifying n parameters. We can also use _repmat()_ to replicate matrices
% along any number of dimensions, or the _cat()_ function, which is a
% generalization of the [] concatenation we saw earlier. Indexing,
% assignment,and extension work just as before, only with n indices, as
% opposed to just two. Finally, we can use functions like _sum()_, _mean()_,
% _max()_ or _min()_ by specifying the dimension over which we want the
% function to operate. _sum(A,3)_ for example, sums over, or marginalizes
% out, the 3rd dimension. 
A = ones(3,5,9,2,2);                % a 5 dimensional array
B = cat(3,[1 2 ; 4 5],[3 2 ; 1 1])  % concatenate two matrices along the third dimension
C = repmat([1 2 ; 3 4],[2,2,2,2]);  % tile a matrix in 4D, twice per dimension
D = C(1,1,1,1)                      % retrieve the entry (1,1,1,1)
A(1,2,2,1) = 99;                    % assign an entry
F = mean(C,4);                      % Take the mean along the 4th dimension
G = max(A,[],3);                    % Take the maximum along the 3rd dimension               
%%
% Taking the mean of say a 4-by-4-by-2-by-2 matrix along the 3rd dimension
% results in a matrix of size 4-by-4-by-1-by-2. If we want to remove the
% 3rd singleton dimension, (which is only acting now as a place holder) we
% can use the _squeeze()_ function.
size(C)
%%
E1 = mean(C,3); 
size(E1)
E2 = squeeze(E1);
size(E2)
%%
% The _ndims()_ functions indicates how many dimensions an array has. Final
% singleton dimensions are ignored but singleton dimensions occurring before
% non-singleton dimensions are not. 
F = ndims(A)
G = ndims(squeeze(mean(A,2)))
%%
% The _meshgrid()_ function we saw earlier extends to 3 dimensions. If you
% need to grid n-dimensional space, use the _ndgrid()_ function but keep in
% mind that the number of elements grows exponentially with the dimension.
a = 1:10;
n = numel(ndgrid(a,a,a,a,a,a))      % 1 million entries.

%% Sparse Matrices 
% When dealing with large matrices containing many zeros, you can save a
% great deal of space by using Matlab's sparse matrix construct. Sparse
% matrices can be used just like ordinary matrices but can be slower
% depending on the operation. The functions _full()_ and _sparse()_ convert
% back and forth. Currently Matlab supports double and logical sparse
% matrices.
A = zeros(100,100);
A([1,4,8],[7,9,33]) = reshape(1:9,3,3);
n = nnz(A)              % The number of non-zero entries in A
nzeros = nonzeros(A);   % All of the non-zero entries in one big column vector
A = sparse(A)           % Convert to a sparse matrix
check = issparse(A)     % Is is really a sparse data type?
B = A * rand(100,1);    % Perform operations as you would with a non sparse matrix
C = full(A);            % Convert back to a full matrix. 
%%
% The _spy()_ function can be used to visualize the sparsity pattern of a
% matrix. 
%%
% The _spalloc()_ function can be used to preallocate space for a sparse
% matrix. The following command creates a 100-by-100 matrix with room
% currently for 10 non-zero elements. More than 10 non-zero elements can be
% added later but this can be slow as Matlab will need to find a larger
% chunk of memory and copy the non-zero elements. 
A = spalloc(100,100,10) 
n = nzmax(A)             % how many non-zero elements do I have room for?
%% Other numeric data types
% Matlab has limited support for 11 numeric data types similar to those in
% the C programming language. Below we create matrices of each type and
% show the space each matrix requires. Matrices can also be created by
% using the commands _int8()_ , _single()_ , _int64()_ etc. The _cast()_
% command, converts from one data type to another. You can determine the
% class of a variable with the _class()_ command and the maximum or
% minimum values each class is able to represent with the _intmax()_ ,
% _intmin()_ , _realmax()_ , and _realmin()_ functions. The uint classes
% are unsigned and not able to represent negative numbers. Unfortunately 
% many Matlab functions do not support types other than double or logical.
% Functions such as _sum()_ have an optional parameter 'native', which
% performs summation without automatically casting to double. To perform
% variable precision arithmetic, check out the _vpa()_ function available
% in the symbolic math toolbox.
clear
A = zeros(100,100,'double');        % same as zeros(100,100)
B = zeros(100,100,'int64');         % signed 64 bit integer
C = zeros(100,100,'uint64');        % unsigned 64 bit integer
D = zeros(100,100,'single');        % single precision number
E = zeros(100,100,'int32');         % signed 32 bit integer
F = zeros(100,100,'uint32');        % unsigned 32 bit integer
G = zeros(100,100,'int16');         % signed 16 bit integer
H = zeros(100,100,'uint16');        % unsigned 16 bit integer
I = zeros(100,100,'int8');          % signed 8 bit integer
J = zeros(100,100,'uint8');         % unsigned 8 bit integer
K = false(100,100);                 % logical array
whos                                % display size of variables
AA = realmax('double');             % max sizes representable by different types
BB = intmax('int64');
CC = intmax('uint64');
DD = realmax('single');
EE = intmax('int32');
FF = intmax('uint32');
GG = intmax('int16');
HH = intmax('uint16');
II = intmax('int8');
JJ = intmax('uint8');

K = int32(100);                     % construct an int32 directly
check1 = class(K);                  % check its class
L = cast(K,'double');               % cast to a double() - also see typecast()
check2 = class(L);                  % check its class
M = int8([3,1,2,1,4]);              % create several int8s
N = sum(M,'native');                % sum ints in 'native' mode, i.e. don't cast to double
O = sum(M);                         % don't sum in 'native' mode to see the difference
class1 = class(N);                  % check the class type
class2 = class(O);                  % check the class type
%% Other Useful Functions
% The _cumsum()_ and _cumprod()_ functions can be useful for generating a
% running sum or product of an array. The _diff()_ function returns the
% differences between consecutive elements. You can specify the dimension
% over which you want them to operate. If you leave this blank, they operate
% over the first non-singleton dimension. 
A = cumsum(1:6)
C = cumprod(1:6)
D = diff(A)
%%
% The histc function is useful for, (among other things) counting the
% number of occurrences of numbers in an array. 
A = sort(floor(10*rand(1,10))+1) % random ints from 1 to 10
counts = histc(A,1:10)           % count how often each int occurs
%%
% The _filter()_ function can be used to calculate values that depend on
% previous values in an array. While it is quite a complicated function,
% here is an easy way to calculate the points halfway between each
% consecutive point in an array. The first result is just half the value of
% the first element. You can calculate a running average in which only a
% window of k elements are included with filter(ones(1,k)/k,1,data).
A = 1:10
B = filter([0.5,0.5],1,A);
 
