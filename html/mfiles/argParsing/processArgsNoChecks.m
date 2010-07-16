function varargout = processArgsNoChecks(args,varargin)    
% Exactly like processArgs except it does no error checking at all and is
% thus slightly faster. This is only worth using if the outer function will
% be called thousands of times, and is not designed to be used directly by
% end users. THIS VERSION DOES NOT SUPPORT TYPE CHECKING OR ENFORCEMENT OF
% REQUIRED ARGS.
    PREFIX = '-';   % prefix that must precede the names of arguments. 
    argnames  = varargin(1:2:end);
    defaults = varargin(2:2:end);
    varargout = defaults;
    if numel(args) == 0, return; end
    userArgNamesNDX = find(cellfun(@(c)ischar(c) && ~isempty(c) && c(1)==PREFIX,args));
    if isempty(userArgNamesNDX)
        positionalArgs = args;
    elseif userArgNamesNDX(1) == 1
        positionalArgs = {};
    else
        positionalArgs = args(1:userArgNamesNDX(1)-1); 
    end
    for i=1:numel(positionalArgs)
        if ~isempty(args{i})  % don't overwrite default value if positional arg is empty, i.e. '',{},[]
           varargout{i} = args{i};
        end
    end
    userArgNames = args(userArgNamesNDX);
    positions = zeros(1,numel(userArgNames));
    used = false(1,numel(argnames));
    for i=1:numel(userArgNames)
       for j=1:numel(argnames)
          if ~used(j) && strcmpi(userArgNames{i},argnames{j})
              positions(i) = j;
              used(j) = true;
              break;
          end
       end
    end
    values = args(userArgNamesNDX + 1);
    varargout(positions) = values;