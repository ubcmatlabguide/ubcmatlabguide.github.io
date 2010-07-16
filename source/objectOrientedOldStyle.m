%% Object oriented programming using the old (pre 2008a) syntax
% We now describe how to create classes and use objects using the old OO
% style. Although this was replaced in the 2008a edition,
% it is still supported. The old framework is much more
% limited and cumbersome but in some ways it is more consistent with the
% rest of the Matlab syntax. It does bridge the inherent connection with
% structs much more explicitly, for example. 
%
% Keep in mind that if you write classes in the old style, the following
% features, available in the new framework, are not supported:
% protected, abstract, static/constant, sealed, or hidden methods or
% properties; single file class definitions; events; handle classes;
% packages; special set and get methods; object.method() syntax; or
% meta-classes. However, you can still perform operator overloading; in
% fact, if anything, it plays a more prominent role. 
%
%%
% <html> 
% <A NAME="oldDefiningAclass"></a>
% </html>
%% Defining a Class  
%
% To begin, every method must be saved in its own file, including the
% constructor, and these files must be stored in a directory with the same
% name as the class but preceded by the @ symbol as in @date. The parent
% directory containing this @ directory, must be on the Matlab path. 
%% 
% Every class needs to have a constructor method, which _constructs_ the 
% objects of the class. The constructor must have the same name as the
% class and be saved in an m-file by the same name, (e.g. create a function
% called _date_ and save it in date.m stored in the @date directory). Here
% is a sample definition:
%%
% *function obj = date(minute, hour, day, month, year)*
%
%%
% We define the properties of the class by creating a struct with fields by
% the same name and we must add one field for every property, even if we leave
% the data initially blank, (i.e. equal to []). We then convert the struct
% to an object by using the _class()_ function.
%%
% <html>
% <hr>
% </html>
%%
%   function obj = mydate(minute, hour, day, month, year)
%   % constructor saved in file date.m
%         
%         obj = struct;
%         obj.minute = [];                % leave blank for whatever reason
%         obj.hour = hour; 
%         obj.day = day;
%         obj.month = month; 
%         obj. year = year;
%         obj = class(obj,'date');
%   end
%%
% <html>
% <hr>
% </html>
%%
% We can create objects by calling the constructor.
% 
%%
%   obj = mydate(12,2,3,11,2008);         % create a new date object
%%
% Note that in earlier versions of Matlab, special care had to be taken to
% allow for objects to be saved and loaded from disk. This is no longer the
% case, even when using the old syntax. If you are using an older version
% of Matlab and run into this problem, check out the following site for a
% work around:
% <http://www.cs.ubc.ca/~murphyk/Software/matlabObjects.html>
%%
% When changes are made to a class definition, existing objects of that
% class are not automatically updated; they must be cleared and recreated.
% In older version of Matlab, it was necessary to use the *clear classes*
% command after making definitional changes. If you experience odd
% behavior, this can sometimes help. Also in older versions, date objects, 
% for example, could not be created if @mydate were the current directory. 
% Moving up one level may do the trick.
%%
% <html> 
% <A NAME="oldPropertyAccess"></a>
% </html>
%% Property Access
% 
% Technically, the creation of the constructor method in the @ directory is
% sufficient to create a class and objects from it, however, our date
% objects are not yet very useful because Matlab protects the properties
% from access outside of the class. They are effectively private. Only
% class methods can access properties in the old style, which includes any
% function stored inside of the @ directory. 
%
%%
% <html> 
% <A NAME="oldSubsrefAndSubsasgn"></a>
% </html>
%% Subsref & Subsasgn
% 
% As we mentioned in the section on _Operator Overloading_ ,every use of a
% dot such as *obj.prop*, is actually shorthand for a call to either the
% _subsasgn()_ or the _subrsref()_ function just like calls involving the
% '+' operator are shorthand for the _plus()_ function. Subsref is called
% in indexing operations, (i.e. when data is requested) and subsasgn is
% used in assignment operations, (i.e. when data is changed). These same
% functions are called when parentheses are used as well, as in _a =
% date(3,2)_ , or _date(3,2) = 5_ ,(and similarly with {} braces when
% dealing with structs). 
%
% One of the most powerful features of OOP in Matlab is the ability to
% *overload* such functions so that they perform customized behavior when
% used with objects of our class. If we create functions by these names and
% store them inside of the @ directory containing our class files, these
% functions will be executed when calls involving a . or () are made as
% opposed to the default implementations. We can then use these as our
% getter and setter methods so that users can access and set object
% properties with the same syntax as they would struct fields, for instance. 
% More complicated behavior is certainly possible too. 
%
%% 
% The default behavior of these functions, for objects, is to restrict
% access to properties completely, but we can 'recover' the lax behavior we
% enjoyed with structs and effectively make the all of the properties
% public with the following simple implementations. We make use the the
% _builtin()_ function to do so, which bypasses the redefined or
% 'overloaded' object versions, (versions overriden by Mathworks in this
% case). In general _builtin()_ can be very useful when a function has been
% overloaded but you want the original behavior. Here we simply pass the
% inputs to the functions directly to _builtin()_. For more detail on 
% these functions, (e.g. on the S arguement), see the
% _Operator Overloading_ section above. 
%%
% <html>
% <hr>
% </html>
%%
%    function obj = subsasgn(obj, S, value)
%       obj = builtin('subsasgn', obj, S, value);
%    end
%   
%    function value = subsref(obj, S)
%        value = builtin('subsref', obj, S);
%    end
%%
% <html>
% <hr>
% </html>
%%
% With these functions in place, properties of our object can then be
% accessed and assigned values as follows.
%%
d1 = mydate(0,3,27,2,1998);        % construct a new object
min = d1.minute                  % get the minute property using . notation
d1.hour = 4;                     % set the hour property using the . notation
%%
% <html> 
% <A NAME="oldDisplayingObjects"></a>
% </html>
%% Displaying Objects
% In the old OO style, objects are not displayed for you. You can overload
% the _display()_ function so that basic info about the object is displayed
% in calls that do not suppress output with a semicolon. Here is a simple
% implementation. The _struct()_ function when applied to an object,
% converts that object into a struct with fields corresponding to the
% properties of the object. Struct can also be used with objects created 
% via the new OO framework. 
%
%   function display(obj) 
%       disp(sprintf('%s object', class(obj)))
%       disp(struct(obj))
%   end
%%
% The section on _Operator Overloading_ discusses several other functions
% that can be overloaded.
%%
% <html> 
% <A NAME="oldMethods"></A>
% </html>
%% Methods
%
% To define methods, we simply create functions with definitions like
% the following and save them in the @ directory. The first argument should
% be an object of the containing class. Methods that change object
% properties must return the object, (because they are passed by value).
% We do not have the option in the old framework, as we do with the new, of
% writing classes whose objects can be passed by reference. 
%%
% <html>
% <hr>
% </html>
%%
%   obj = rollDay(obj,3);
%
%   function obj = rollDay(obj,numdays)
%        obj.day = obj.day + numdays;
%   end
%%
% <html>
% <hr>
% </html>
%%
%% 
% Similarly, calls such as obj2 = obj, result in a copy of the object _obj_
% stored in the variable _obj2_. 
%%
% If you choose not to overload _subsasgn()_ and _subsref()_ but still want
% to provide outside access to certain properties you will need to write
% java style get and set functions as in the following. This approach,
% while less concise, does maintain the separation between implementation
% and interface without necessitating complicated implementations of subasgn 
% and subsref. 
%%
% <html>
% <hr>
% </html>
%%
%   function day = getDay(obj)
%      % we could change this code later without affecting users of getDay.
%      day = obj.day;                   
%   end
%   
%   function obj = setDay(obj,newDay)
%       obj.day = newDay;
%   end
%%
% <html>
% <hr>
% </html>
%%
%%
% <html> 
% <A NAME="PrivateMethods"></a>
% </html>
%% Private Methods
%
% Private methods are functions that can only be called by other methods of
% the class, not end users; they are not intended to act as part of
% the class interface. To make a method private in the old OO framework,
% create a sub-directory called 'private' in the @ directory and save it
% inside. You can call private methods, (from within other class methods)
% as you would any other method. 
% 
%%
% <html> 
% <A NAME="oldInheritanceSyntax"></a>
% </html>
%% Inheritance Syntax
% Inheritance in the old OO framework is quite limited and you cannot
% subclass built in classes like handle. Superclasses are specified as
% inputs to the _class()_ function called in the constructor. You must pass
% in instances of the superclass objects. 
%%
%
%   p1 = parent1(); p2 = parent2();   % create instances of the parent classes
%   obj = class(obj,'date',p1,p2);    % pass these instances into the class function
%
%%
% Type *doc class* for additional calling sequences including an option to
% create an array of objects from an array of structs.
%%
% For more general information on inheritance, see the several related
% sections written regarding the new OO style.
%%
% <html> 
% <A NAME="oldDynamicDispatch"></a>
% </html>
%% Dynamic Dispatch
% The old OO framework supports dynamic dispatch in much the same way as
% the new framework. When multiple objects of different types are passed to
% a method, the superior-inferior relation is used to determine which
% method to invoke, just as with the new OO design. However, in the old
% style, we must specify this relation by using the using the 
% _inferiorto()_ ,and _superiorto()_ functions from within the constructor
% as in the following. 
%
%%
%  inferiorto('class1','class2');
%%
% Again, when the superiority of two classes is the same, the left most
% takes precedence. 
%%
