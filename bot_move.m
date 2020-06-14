function [ledC] = bot_move( node,stats, vid,rect,cover2, rgbB, rgbO, rgbR, rgbG,scra)
%UNTITLED3 Summary of this functii on goes here
%   Detailed explanation goes here
while(1)
    se=strel('square',5);
    pause(0.4);
    instant = getsnapshot(vid);
    
    instant = imcrop(instant,rect);
    sizeIN = size(instant);
    
    xFact = rect(3);
    yFact = rect(4);
    xFact = 240/xFact;
    yFact = 240/yFact;
    [botpos,botvec] = bot_position(instant,rgbB,rgbO);
    %     led=imcrop(instant,cover2);
    redI = detect(instant,rgbR);
    greenI = detect(instant,rgbG);
    redI = bwareaopen(redI,100);
    greenI = bwareaopen(greenI,100);
    redI=imerode(redI,se);
    greenI = imerode(greenI,se);
    redI=imdilate(redI,se);
    greenI = imdilate(greenI,se);
    redI = (imfill(redI,'holes'));
    greenI = (imfill(greenI,'holes'));
    ledX = floor(cover2(1)+cover2(3)/2);
    ledY = floor(cover2(2)+cover2(4)/2);
    
    if(redI(ledY,ledX)==1)
        ledC = 'R';
    elseif(greenI(ledY,ledX)==1)
        ledC = 'G';
    end
    disp(size(stats))
    disp('node')
    disp(node)
    x= stats(node).Centroid;
    nodevec=[x(1)-botpos(1),x(2)-botpos(2)];
    botcom = complex(botvec(1),botvec(2));
    nodecom = complex(nodevec(1),nodevec(2));
    a=angle(botcom/nodecom);
    
    a=(180/pi)*a;
    a
    d = floor(((((x(1))-botpos(1))*xFact)^2+(((x(2)-botpos(2))*yFact)^2))^0.5);
    disp(d)
    disp(a)
    if(d<=5)
        break;
    end
    botm(a(1),d,scra);
    %moveforward
end

end
