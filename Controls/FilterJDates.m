function [output, burntime] = FilterJDates(time)

exclude = [];
include = [];
burn = [];

for count = 2:length(time)
    if(time(count)-time(count-d)=1)
        include = [include, count];
    elseif(time(count)-time(count-1)>0)
        if(time(count)-time(count-2)=1)
            include = [include, count];
        else
            burn = [burn,count];
        end
    end
end

output = time(include);
burntime = time(burn)

        
        
        
