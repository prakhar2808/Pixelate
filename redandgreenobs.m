function [ red,green ] = redandgreenobs( p,redI,greenI )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
clear red green;
x = size(p);
se=strel('square',2);
redChannel = p(:, :, 1);
greenChannel = p(:, :, 2);
blueChannel = p(:, :, 3);
for k=1:floor(x(1,2)/8)+1:x(1,2)
redChannel(:,k) = 240;
greenChannel(:,k) = 240;
blueChannel(:,k) = 240;
end
for k=1:floor(x(1,1)/8)+1:x(1,1)
redChannel(k,:) = 240;
greenChannel(k,:) = 240;
blueChannel(k,:) = 240;
end
out = cat(3, redChannel, greenChannel, blueChannel);
imshow(out)
y=out;
y=y(:,:,1)==240 & y(:,:,2)==240 & y(:,:,3)==240;
y=~y;
%imtool(y);
[G,num]=bwlabel(y);
%imtool(G);
stats=regionprops(G,'basic');
%ledcolur = red
r=redI;
r=imerode(r,se);
[redO,redN] = bwlabel(r);
staRed=regionprops(redO,'basic');
j = 1;
redGrid = [];
greenGrid = [];
for o=1:redN
    if(staRed(o).Area>100)
    redCen = staRed(o).Centroid;
    redGrid(j) = gridNumber(redCen,stats); 
    j=j+1;
    end
end
j =1;

g=greenI;
g=imerode(g,se);
[greenO,greenN] = bwlabel(g);
staGreen=regionprops(greenO,'basic');
for o=1:greenN
    if(staGreen(o).Area>100)
    greenCen = staGreen(o).Centroid;
    greenGrid(j) = gridNumber(greenCen,stats);
    j = j+1;
    end
end
red = redGrid;
green = greenGrid;


end

