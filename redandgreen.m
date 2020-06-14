function [red,green] = redandgreen( bp,cover2,cover,cover1,redI,greenI)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
clear red green
x = size(bp);
se=strel('square',15);
redChannel = bp(:, :, 1);
greenChannel = bp(:, :, 2);
blueChannel = bp(:, :, 3);
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
%imshow(out)
y=out;
y=y(:,:,1)==240 & y(:,:,2)==240 & y(:,:,3)==240;
y=~y;
%%imtool(y);
[G,num]=bwlabel(y);
%%imtool(G);
stats=regionprops(G,'basic');
%ledcolur = red
r=redI;
%imtool(r);
r(cover2(2):cover2(2)+cover2(4),cover2(1):cover2(1)+cover2(3))=0;
r(cover(2):cover(2)+cover(4),cover(1):cover(1)+cover(3))=0;
r(cover1(2):cover1(2)+cover1(4),cover1(1):cover1(1)+cover1(3))=0;
r=imerode(r,se);
r=imdilate(r,se);

%imtool(r)
[redO,redN] = bwlabel(r);
staRed=regionprops(redO,'basic');
%%imtool(redO);
j = 1;
redGrid = [];
greenGrid = [];
for o=1:redN
    if(staRed(o).Area>200)
    redCen = staRed(o).Centroid;
    redGrid(j) = gridNumber(redCen,stats); 
    j=j+1;
    end
end
j =1;
g=greenI;
%imtool(g);
g(cover2(2):cover2(2)+cover2(4),cover2(1):cover2(1)+cover2(3))=0;
g(cover(2):cover(2)+cover(4),cover(1):cover(1)+cover(3))=0;
g(cover1(2):cover1(2)+cover1(4),cover1(1):cover1(1)+cover1(3))=0;
g=imerode(g,se);
g=imdilate(g,se);
%imtool(g)
[greenO,greenN] = bwlabel(g);
staGreen=regionprops(greenO,'basic');
for o=1:greenN
    if(staGreen(o).Area>200)
    greenCen = staGreen(o).Centroid;
    greenGrid(j) = gridNumber(greenCen,stats);
    j = j+1;
    end
end
red = redGrid;
green = greenGrid;
end



