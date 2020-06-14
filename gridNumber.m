function [ botgrid ] = gridNumber(botpos,stats)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
for i=1:1:64
    a=stats(i).Centroid(1)-botpos(1);
    b=stats(i).Centroid(2)-botpos(2);
    f(i)=a^2+b^2;
    fk(i)=i;
end
%sorting the distances as nearest grid will be the block's grid
for i=1:1:64
    for j=1:1:64-i
        if f(j+1)<f(j)
            temp=f(j);
            f(j)=f(j+1);
            f(j+1)=temp;
            temp=fk(j);
            fk(j)=fk(j+1);
            fk(j+1)=temp;
        end
    end
end
botgrid = fk(1);

end

