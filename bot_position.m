function [ botpos,botvec] = bot_position( i,rgbB,rgbO )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

se=strel('square',5);
botc1=detect(i,rgbB);
botc2=detect(i,rgbO);
botc1=imerode(botc1,se);
botc2=imerode(botc2,se);
botc1=imdilate(botc1,se);
botc2=imdilate(botc2,se);


[C1,num1]=bwlabel(botc1);
imshow(C1)
statc1=regionprops(C1,'basic');
x=[statc1.Area];
x=sort(x);
for k=1:1:num1
if statc1(k).Area==x(num1)
        centc1=statc1(k).Centroid;
end
end


[C2,num2]=bwlabel(botc2);
imshow(C2)
statc2=regionprops(C2,'basic');
y=[statc2.Area];
y=sort(y);
for k=1:1:num2
if statc2(k).Area==y(num2)
        centc2=statc2(k).Centroid;
end
end

botpos=[(centc2(1)+centc1(1))/2,(centc2(2)+centc1(2))/2];

botvec=[centc2(1)-centc1(1),centc2(2)-centc1(2)];
end

