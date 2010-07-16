classdef binaryTree < handle
     
    properties
        left;
        right;
        data = 0;
    end
    
    methods
        function set.data(obj,data)
            obj.date = data;
            if(obj.data < 0)
                notify(obj,'negative');
            end
        end
       
    
        
    end
    
    
    events(ListenAccess = 'public', NotifyAccess = 'public')
        negative;
    end
    
end