 classdef mydate < handle  % inherit from handle so that we can pass by reference
% An example class using the new OO syntax

        properties(SetObservable = true)
        % These properties are public by default
            minute = 0;    % we can specify default values if we want
            hour;
            day;
            month;
            year;
        end
        
        properties(GetAccess = 'private', SetAccess = 'private')
            tmpdate; 
        end
        
        properties(GetAccess = 'public', SetAccess = 'private')
        % These properties can be accessed but not set from outside the class
           numsecs; 
           valid = true;
        end
        
        properties(Constant = true)
        % These properties are constant and cannot be changed. 
            DAYS_PER_YEAR =  365;
            MONTHS_PER_YEAR = 12;
            WEEKS_PER_YEAR  = 52;
        end
     
        methods
        % These methods are public by default. 
        
            function obj = mydate(minute,hour,day,month,year)
            % class constructor
                if(nargin > 0) % don't have to initialize the fields
                    obj.minute = minute;
                    obj.hour   = hour;
                    obj.day    = day;
                    obj.month  = month;
                    obj.year   = year;
                end
            end
            
            function obj = rollDay(obj,numdays)
            % increment the day by a specified amount
                obj.day = obj.day + numdays;
            end    
            
            function obj = set.day(obj,day)
            % special setter method
                obj.day = day;
                obj.checkDate();
            end
            
             function day = get.day(obj)
             % special getter method
                day = obj.day;          
             end
        end
        
        
        methods(Static = true)
        % These methods are static and called like this:
        % date.printCurrentDate().
            function printCurrentDate()
                display(datestr(now));
            end
        end
        
        
        methods(Access = 'private')
        % These methods are private, (i.e. only accessible from methods of
        % this class).
        
            function sec = calcSecs(obj)
            % calcSecs
                sec = obj.minute*60 + obj.hour*60*60 + obj.day*24*60*60;
            end

            function TF = isValid(obj)
            % isValid
                TF = obj.minute >= 0 && obj.minute <= 60;
            end
            
            function checkDate(obj)
            % checkDate
                if(isempty(obj.year) || isempty(obj.month) || isempty(obj.day))
                    return;
                end
                if(obj.year == 2000 && obj.month == 1 && obj.day == 1)
                     obj.notify('y2k');          % fire an event
                end
                if(obj.year == 2010 && obj.month == 2 && obj.day == 12)
                    obj.notify('olympicsStart'); % fire an event
                end
            end
        end
        
       
       events(ListenAccess = 'public', NotifyAccess = 'protected')
       % events fired by objects of this class
           y2k;
           olympicsStart;
       end
end