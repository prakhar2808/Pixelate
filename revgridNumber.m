function [ grid ] = revgridNumber(redCen,redO,redN)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

staRed=regionprops(redO,'basic');
   
for i=1:1:redN
    a=staRed(i).Centroid(1)-redCen(1);
    b=staRed(i).Centroid(2)-redCen(2);
    f(i)=a^2+b^2;
    fk(i)=i;
end
%sorting the distances as nearest grid will be the block's grid
for i=1:1:redN
    for j=1:1:redN-i
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
grid = staRed(fk(1)).Centroid;

end
