%% Object Oriented Programming in Matlab: More advanced topics
%
%% Precedence relations
% When multiple objects are passed to a method, Matlab determines which
% class's method to call based on the _superior-inferior_ relation. The
% most superior class's method is invoked and if all of the classes have
% equal superiority, the left most object takes precedence. 
%
%% 
% We specify these relationships when creating classes, right in the 
% classdef statements as follows:
%%
% *classdef(InferiorClasses = {?class1, ?class2})*
%%
% The ? marks are used to construct metaclass instances but this detail is
% not particularly important; class1 and class2 are instances of the
% inferior classes. We discuss meta classes in a later section. 
% 
% Arrays of objects can be passed to methods as well but the class of an
% array of objects is the same as the class of the objects stored inside,
% (which must all be the same), and this class is used to determine
% precedence. See the section on _Object Arrays_ for more information.
%%
% <html> 
% <A NAME="SetAndGet"></a>
% </html>
%% Set and Get
% Matlab supports special kinds of setter and getter functions for
% assigning and accessing properties that are executed whenever an attempt
% to set or get the corresponding property is made. Use of these is
% optional; they are only called if they exist. By taking this approach, we
% can make properties public so that clients can use the convenient dot
% notation, while still maintaining a level of indirection by effectively
% intercepting the call (although this is much slower than the regular dot
% notation).
%
% We will add get and set methods for the public day property of the date
% class as an example. We write _get_ followed by a dot and the property
% name, similarly for _set_ . 
%%
% <html>
% <hr>
% </html>
%% 
%   function day = get.day(obj)
%       day = obj.day;              % We could execute other code as well.
%   end
% 
%   function obj = set.day(obj,newday)
%       obj.day = newday;           
%   end
%%
% <html>
% <hr>
% </html>
%%
% We then assign and query the value as we did before using the dot
% notation, but the call is intercepted by these functions. We must take
% care as before to return the object in the setter methods, (as the
% objects are by default passed by value). 
%%
d1 = mydate(1,4,22,3,2008);   % create another mydate
day = d1.day;
d1.day = 5;
%%
% Unfortunately, as of Matlab version 2008a, it was not possible to
% override get and set methods in subclasses, severely limiting the use
% value of this approach in complex projects. Furthermore, these methods
% are called even when properties are accessed or set from within the
% class, making their use for input checking a frustrating exercise. Keep
% this in mind when initializing variables in the constructor; these
% functions, if present, are invoked during construction and so must be
% able to deal with cases in which the variables are not yet set. 
%
% <html> 
% <A NAME="OperatorOverloading"></a>
% </html>
%% Operator Overloading
% Every use of a Matlab operator, such as 
%%
%  + - .* * ./ .\ / \ .^ ^ < > <= >=
%  == ~ ~= & | && || : ' .' [] [;] () .
%%
% is actually short hand or syntactic sugar for a call to a named function
% like plus(), minus(), times(), power(), lt(), eq(), not(), etc. Section
% 7.32 of the Matlab OO documentation lists all of these operators with
% their corresponding function names. 
%%
% We can define custom behavior for any of these operators by witting
% class methods by the same name. Since class methods are dynamically
% dispatched, our own versions of these functions will execute when we use
% the corresponding operators with our objects. We could write our own
% _plus()_ method in the date class, for example, to add dates together and
% then call the function with *d1 + d2*. Or, we could write our own _lt()_
% function, (for less than) to compare dates, calling it with *d1 < d2*. 
% Such calls get converted automatically to _plus(d1,d2)_ and _lt(d1,d2)_,
% and our own implementations of these functions are then invoked. 
%
% Operators retain their natural precedence so that * takes precedence over
% + in order of operations, even if one or both have been overloaded. 
%
% Another useful method to overload is _display()_ - the function that
% automatically displays objects when we do not suppress the output with a
% semicolon. Writing our own _display_ function allows us to display
% objects in any way we like. 
%
% Sometimes it is useful to simply reuse concise informative names that
% belong to built in functions like _plot()_. While plot is never
% automatically invoked, nor does it correspond to an operator, it is used
% so frequently in Matlab that reusing this name with our own objects can
% serve to self document their behavior extremely well, (assuming our plot
% function does something reasonable). 
%
%%
% If you overload an operator or function but want to use the original
% implementation for some reason, use the _builtin()_ function, which takes
% the string name of the function as the first input, followed by that
% function's inputs. 
%%
%%  subsref and subsasgn
% There are two very important functions that are frequently overloaded and
% deserve specific mention: subsref, and subsasgn. When the dot operator, 
% parentheses, or curly braces, . () {}, are used in indexing operations,
% subsasgn is called, and when they are used in assignment operations,
% subsasgn is called. By overloading these functions, we can create
% customized behavior for our classes. 
%
% Suppose we write our own data structure class, for instance, and want
% calls like obj(3) to retrieve the third element in our structure, we
% could achieve this by overloading subsref.
%
%%
% Here are the definitions of these functions:
%%
%    function obj = subsasgn(obj, S, value)
%    function value = subsref(obj, S)
%
%%
% * obj is the calling object as in obj.prop or obj(3)
% * value is the new or returned value as in obj.prop = value or value = obj.prop
% * S is a structure with two fields: type and subs
%%
%   Type is one of '()' '{}' or '.' depending on the call.
%   Subs is a cell array or a string of the actual subscripts used.
%%
% In complicated calls involving multiple operators like 
% *obj(5,9).prop(1:19)=value*, a single call to subsasgn is made and all of
% the information in the call is passed to the function. In this case, S
% is an array of structs with the following values.
%%
%  S(1).type='()'	S(2).type='.'	    S(3).type='()'
%  S(1).subs={5,9}	S(2).subs='prop'	S(3).subs={1:19}
%%
% Note that as of 2008a, overloaded operators do not work within the class 
% methods, only from outside of the class, although this could, and
% hopefully will change in future versions. This includes any function
% included in the @ directory (if any) or any subdirectories. You can still
% call the functions by name, (i.e. _plus()_ instead of +). 
%
%
%%
% <html> 
% <A NAME="HandleSuperclass"></a>
% </html>
%% Handle Superclass
% We previously mentioned that objects in Matlab are, (by default) passed
% by value, meaning that full copies are passed back and forth in method
% calls. Matlab graphics objects, however, are passed by reference, (via 
% handles). If we subclass the built in *handle* class as in 
% 
% *classdef myclass < handle*
%
% then objects of our class will be passed by reference too, not value.
% Doing so has a number of benefits and consequences, which we will now
% discuss. 
%
%%
% When we construct a handle object as in *h = myclass()*, h stores a
% pointer or handle to the object not the object itself. If we then execute
% *h2 = h*, we simply create another pointer to the same underlying
% object. For example, we could call *h.prop = 3* , and then *p = h2.prop*
% and p would equal 3. 
%
%%
% In handle method calls, there is no need to return the object because
% assignments occur _in place_, (although returning a handle to the object
% does no harm).
%%
% If our objects will be very large, it can be much more space efficient to
% use handle objects because we no longer need to copy the entire object in
% every method call. (Note, however, that Matlab does a lot of optimization
% under the surface and only actually copies objects or variables when it
% absolutely has to). 
%
% Only handle classes support events; we will discuss events shortly. 
%
%%
% The major advantage, however, is that it is much easier to write data
% structures, (particularly recursive structures) such link lists or binary
% trees. We give a very simple implementation of a binary tree class now
% and illustrate how we can easily recurse over all of the nodes by simply
% _following_ handles. 
%%
% <html>
% <hr>
% </html>
%%
%  classdef bnode < handle               % subclass handle
%      
%      properties
%         left;        % left  child
%         right;       % right child
%         data;        % data stored at the node
%      end
%     
%      methods
%          function obj = bnode(data)
%              obj;
%              if(nargin > 0)
%                  obj.data = data;
%              end
%          end
%      end
%  end
% 
% 
%  function labelNodes(node,depth)
%  % recursively label the depth of the nodes
%      if(isempty(node)),return,end
%      node.data = depth;
%      labelNodes(node.left,depth+1);
%      labelNodes(node.right,depth+1);
%  end
%%
% <html>
% <hr>
% </html>
%%
%
% It is much more complicated to create an identical copy of a
% handle object as we cannot simply go *h2 = h1*. We can use the following
% code, however, to create a shallow copy of any object we like. It needs
% full access to all of the properties and so should be added as a class
% method. Another approach is to use the _struct()_ function to convert
% an object to a struct and then write the constructor to optionally take a
% struct, building a new object from its fields.
%%
% <html>
% <hr>
% </html>
%%
%   function copy = copyobj(obj)
%   % Create a shallow copy of the calling object.
%       copy = eval(class(obj));
%       meta = eval(['?',class(obj)]);
%       for p = 1: size(meta.Properties,1)
%           pname = meta.Properties{p}.Name;
%           try
%               eval(['copy.',pname,' = obj.',pname,';']);
%           catch 
%               fprintf(['\nCould not copy ',pname,'.\n']);
%           end
%       end
%   end
%%
% <html>
% <hr>
% </html>
%%
% When there are no more handles to an object left on the stack, the object
% is declared invalid and the Matlab garbage collector will free the memory
% when it gets a chance. We can test if a handle to an object is valid with
% the _isvalid(h)_ method and delete the object, causing all of its handles
% to become invalid with _delete(h)_.
%
%%
% <html> 
% <A NAME="dynamicpropsAndhgsetget"></a>
% </html>
%% dynamicprops & hgsetget
%
% Handle has two subclasses, which you can subclass instead yielding
% addtional functionality. By subclassing *dynamicprops* you get all of the
% benefits of subclassing handle plus the ability to dynamically attach
% temporary data to objects without modifying the class definition. You
% simply call the inherited _addprop()_ function, as in
% *P = obj.addprop('newProperty')* and you can then make calls like
% *obj.newProperty = 3* or *val = obj.newProperty*. The return value of
% _addprop()_ ,P, can be used to set attributes of the property, (i.e. make
% it hidden, etc.), or to delete the property via *delete(P)*.
%
% The *hgsetget* class, (also a subclass of handle), lets you use Matlab
% graphics style set and get methods as in *set(h,'property',value)*. See
% section 4.19 in the Matlab OO documentation for more details). 
% 
 
%%

%%
% <html> 
% <A NAME="Events"></a>
% </html>
%% Events
% Matlab now has quite good support for event based programming in which
% objects trigger events in response to a change in state, notifying one or
% more other objects that have registered as listeners. This can be
% particularly useful when the appropriate flow of control depends upon
% things external to the program such as a user's interaction with a
% graphical interface or environmental sensors. It can be a useful paradigm
% in its own right, however, particularly for simulations. Chapter 8 of the
% Mathworks OO documentation covers events. 
%%
% To begin, all classes involved must inherit from the handle class, (or
% one of its subclasses). The triggering class must declare an events block
% in its class definition. Event blocks have attributes just like method
% and property blocks, defining event access control. 
%
% The ListenAccess attribute determines where you can create event
% listeners and NotifyAccess determines where events can be triggered. In
% the below example, we set ListenAccess to public so that we can register
% an object as a listener anywhere we like, and NotifyAccess to protected
% so that only methods of the date class, (or any subclasses of date) can
% trigger the events. 
%
% Within the block, we define the events by simply specifying a name. Here
% we continue with the date example and will trigger events when the date
% is equal to either Jan 1, 2000 or the Vancouver Olympics start date of
% February 12, 2010. 
%%
% <html>
% <hr>
% </html>
%%
%  events(ListenAccess = 'public', NotifyAccess = 'protected')
%       y2k;                            % define a couple of events
%       olympicsStart;
%  end
%%
% <html>
% <hr>
% </html>
%%
% Now that we have defined two events, we have to decide when to trigger
% them. Lets add a line to the set.day method we discussed earlier, (which
% is called whenever the day property is set). We will have it call a new
% method we will write called _checkDate()_ , which will fire the events if
% the current date matches one we are looking for. We use the _notify()_
% method, (inherited from handle) to fire the event and simply pass it the
% name of the event we want to trigger. 
%%
% <html>
% <hr>
% </html>
%%
%     function checkDate(obj)
%         if(isempty(obj.year) || isempty(obj.month) || isempty(obj.day))
%             return;        % this function may be called before all fields initialized.
%         end
%         if(obj.year == 2000 && obj.month == 1 && obj.day == 1)
%             obj.notify('y2k');
%         end
%         if(obj.year == 2010 && obj.month == 2 && obj.day == 12)
%             obj.notify('olympicsStart');
%         end
%     end
%%
% <html>
% <hr>
% </html>
%%
% Notify will send an event notification to every object that is
% 'listening'. By default the event object will have the name, (as
% specified in the events block, e.g. 'y2k' or 'olympicsStart') and a
% handle to the source object itself - the object that triggered the event. 
%
% You can create customized event objects with whatever information you
% like by subclassing _event.EventData_ and passing an instance along with
% the event name to _notify()_. For more information see section 8.9 of the
% Mathworks OO documentation. 
%%
% Now that we have objects of our date class sending events, we need to add
% listeners - objects that will be informed when events are triggered. Note
% that objects of our date class will not necessarily know who is
% listening, unless we go out of our way to tell them, (which we will not). 
%
% There are two ways to register an object as a listener but we will only
% discuss one here: using the _addlistener()_ method inherited from handle.
%%
% (The other approach involves creating an object of type event.listener -
% see the Matlab OO documentation for more details). 
% 
%%
% Every class that inherits from handle has an _addlistener()_ method that
% takes three arguments: a handle to an object that will generate events,
% the name of the event to listen for, (e.g. 'y2k'), and a handle to a
% function that should execute when the event is 'heard'. This function,
% called a *callback* function, must take two arguments: src - the object
% that generated the event, and evnt - the event object. Here is a possible
% class definition for listening objects. Note, we can call _addlistener()_
% at any point, not just in the constructor as we do here. 
%%
% <html>
% <hr>
% </html>
%%
%   classdef snoopingClass < handle
%     
%     properties
%        snoopOn; 
%     end
% 
%      methods
%      
%          function obj snoopingClass(dateObj)
%          % class constructor
%             obj.snoopOn = dateObj;
%
%             y2kListener = addlistener(dateObj,'y2k',@(src,evnt)fixY2Kbugs(obj,src,evnt));
%             olympicsListener = addlistener(dateObj,'olympicsStart',@(src,evnt)gossip(obj,src,evnt));
%          end
%      
%          function fixY2Kbugs(obj,src,evnt)
%          % This will be executed when a y2k event is fired by the date object.
%             display(evnt.EventName);
%          end
%          
%          function gossip(obj,src,evnt)
%          % This will be executed when a olympicsStart event is fired by the date object
%             display(evnt.EventName);
%          end
%      end
%%
% <html>
% <hr>
% </html>
%%
% The execution of a callback can be temporarily deactivated by setting the
% Enabled property of the listener object to false. 
%%
%  y2kListener.Enabled = false
%%
% Four types of events are automatically fired in response to the access or
% assignment of observable properties: PreSet, PostSet, PreGet, & PostGet.
% The 'pre' events are fired just before a value is changed or serviced,
% and the 'post' events are fired just after. Observable properties are
% those defined in a properties block with the setObservable or
% getObservable attributes set to true as in 
%
% *properties(SetObservable = true)* . 
%
% These events are not listed in the event block. 
%%
% To add a listener for the PostSet event of the day property, for example,
% use the following syntax.
%%
% lh = addlistener(obj,'propertyName','PostSet',@(src,evnt)callbackFunction(obj,src,evnt));
%%
% See section 8.14 of the Matlab OO documentation for more details on
% listening for property changes.  Finally, note that subclasses inherit
% the events of their superclasses. 
%%
% <html> 
% <A NAME="MetaClasses"></a>
% </html>
%% Meta Classes
% Matlab has quite a novel feature, meta classes, which allow you to
% dynamically inspect the properties of a particular class. Each class,
% defined using the classdef syntax, has a corresponding metaclass which
% you can invoke using the ? operator. The resulting object stores
% information about the class methods, properties, events, superclasses,
% etc, as well as their attributes. Metaclasses can be used to write highly
% generic code. For example, <objectOriented.html#viewClassTree viewClassTree>
% makes extensive use of metaclasses.
%%
% The following example function, finds all of the superclasses of a
% particular class, including the superclasses of its superclasses. The
% _metaclass()_ function operates just like the ? operator but can be used
% with string names, whereas ? requires an instance of the object. 
%%
% <html>
% <hr>
% </html>
%%
%     function list = ancestors(class)
%     % input is the string name of the base class
%     % output is a cell array of ancestor class names
%         list = {};
%         meta = metaclass(class);
%         parents = meta.SuperClasses;
%         for p=1:numel(parents)
%             list = [parents{p}.Name,ancestors(parents{p}.Name)];
%         end
%     end
%%
% <html>
% <hr>
% </html>
%%
% Here is a look at the kind of data available.
%%
metadata = ?mydate
%%
