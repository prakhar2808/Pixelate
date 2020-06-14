
p = getsnapshot(vid);
if(run==0) 
    [p,pcrop] = imcrop(p);
    rgbb=crop1(p);
end
 if(run == 1) 
     p = imcrop(p,pcrop);
 end
ib = detect(p,rgbb);
se = strel('square',5);
ib = ~ib;
ib = bwareaopen(ib,400);
ib = bwmorph(ib,'dilate',4);
ib = imfill(ib,'holes');
[L,num]=bwlabel(ib);
stats=regionprops(L,'basic'); 
x=[stats.Area];
x=sort(x);
imtool(ib);
for k=1:1:num
    if stats(k).Area==x(num-1)
        bp=imcrop(p,stats(k).BoundingBox);
        cover=stats(k).BoundingBox;
        imtool(bp);
        hj = size(bp);
    end
    if stats(k).Area==x(num-2)
        led=imcrop(p,stats(k).BoundingBox);
        imtool(led);
        cover2 = stats(k).BoundingBox;
    end
    if stats(k).Area==x(num)
        arena=imcrop(p,stats(k).BoundingBox);
        cover1 = stats(k).BoundingBox;
        imtool(arena);
        hi = size(arena);
    end
end

%drawing grids
rgbImage=p;
redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);
r=redChannel;
[a, b, c]=size(rgbImage);

%imshow(r);
for i=1:floor(a/8)+1:a
rgbImage(i, :, :) = 255;
end
for j=1:floor(b/8)+1:b
rgbImage(:, j, :) = 255;
end
%imshow(rgbImage);
y=rgbImage;
y=y(:,:,1)==255 & y(:,:,2)==255 & y(:,:,3)==255;
y=~y;
%\imshow(y);
%labelling and centroids of grids
[G,numg]=bwlabel(y);
%imshow(G);
stats=regionprops(G,'basic');
 if(run == 0)
    rgbR1 = crop1(p);
    rgbR2 = crop1(p);
    vmax = max([rgbR1; rgbR2]);
    vmin = min([rgbR1; rgbR2]);
    rgbR(1:2:5) = vmin(1:2:5);
    rgbR(2:2:6) = vmax(2:2:6);
    p = getsnapshot(vid);
    p = imcrop(p, pcrop);
    rgbG1 = crop1(p);
    rgbG2 = crop1(p);
    vmax = max([rgbG1; rgbG2]);
    vmin = min([rgbG1; rgbG2]);
    rgbG(1:2:5) = vmin(1:2:5);
    rgbG(2:2:6) = vmax(2:2:6);
    rgbO = crop1(p);
    rgbB = crop1(p);
    run = 1;
end
redI = detect(p,rgbR);
greenI = detect(p,rgbG);
bluI = detect(p,rgbB);
oraI = detect(p,rgbO);
redI=imerode(redI,se);
greenI=imerode(greenI,se);
bluI=imeronwde(bluI,se);
oraI=imerode(oraI,se);
redI=imdilate(redI,se);
greenI=imdilate(greenI,se);
bluI=imdilate(bluI,se);
oraI=imdilate(oraI,se);
imtool(redI)
imtool(greenI)
ledX = floor(cover2(1)+cover2(3)/2);
ledY = floor(cover2(2)+cover2(4)/2);

if(redI(ledY,ledX)==1) 
    ledC = 'R';  glow('w',scra); pause(3); glow('o',scra);
    
elseif(greenI(ledY,ledX)==1) 
    ledC = 'G';  glow('g',scra); pause(3); glow('o',scra);
end
