function [ ledC ] = ledColor( instant,cover2,rgbR,rgbG)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
redI = detect(instant,rgbR);
greenI = detect(instant,rgbG);
redI = bwareaopen(redI,100);
greenI = bwareaopen(greenI,100);
redI = bwmorph(redI, 'erode', 5);
redI = bwmorph(redI, 'dilate', 5);
redI = (imfill(redI,'holes'));
greenI = bwmorph(greenI, 'erode', 5);
greenI = bwmorph(greenI, 'dilate', 5);
greenI = (imfill(greenI,'holes'));
ledX = floor(cover2(1)+(cover2(3)/2));
ledY = floor(cover2(2)+(cover2(4)/2));
if(redI(ledY,ledX)==1)
    ledC = 'R';
elseif(greenI(ledY,ledX)==1)
    ledC = 'G';     
end

end

