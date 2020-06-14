function [ledC,ledCNew,botpos,botvec] = bot_move2(node,stats, vid,rect,cover2,cover,rgbB, rgbO, rgbR, rgbG,scra)
%UNTITLED3 Summary of this function on goes here
%   Detailed explanation goes here

while(1)
    disp('bot_move2');
    se=strel('square',5);
    pause(0.4);
    instant = getsnapshot(vid);
    instant = imcrop(instant,rect);
    xFact = rect(3);
    yFact = rect(4);
    xFact = 240/xFact;
    yFact = 240/yFact;
    [botpos,botvec] = bot_position(instant,rgbB,rgbO);
    %led=imcrop(instant,cover2);
    redI = detect(instant,rgbR);
    greenI = detect(instant,rgbG);
%     imtool(redI)
%     imtool(greenI)
    
    redI = bwareaopen(redI,100);
    greenI = bwareaopen(greenI,100);
    redI=imerode(redI,se);
    greenI = imerode(greenI,se);
    redI=imdilate(redI,se);
    greenI = imdilate(greenI,se);
    redI = bwmorph(redI, 'erode', 5);
    redI = bwmorph(redI, 'dilate', 5);
    redI = (imfill(redI,'holes'));
    greenI = bwmorph(greenI, 'erode', 5);
    greenI = bwmorph(greenI, 'dilate', 5);
    greenI = (imfill(greenI,'holes'));
    imtool(redI)
    imtool(greenI)
    ledX = floor(cover2(1)+(cover2(3)/2));
    ledY = floor(cover2(2)+(cover2(4)/2));
    redInew = redI;
    imtool(redInew);
    redI(cover2(2):cover2(2)+cover2(4),cover2(1):cover2(1)+cover2(3))=0;
    redI(cover(2):cover(2)+cover(4),cover(1):cover(1)+cover(3))=0;
    [redO,redN] = bwlabel(redI);
    disp('botmove2')
    disp(node)
    rnodeCen = stats(node).Centroid;
    redCen = revgridNumber(rnodeCen,redO,redN);
    disp('redcen')
    disp(redCen);
    
    greenInew = greenI;
    imtool(greenInew);
    greenI(cover2(2):cover2(2)+cover2(4),cover2(1):cover2(1)+cover2(3))=0;
    greenI(cover(2):cover(2)+cover(4),cover(1):cover(1)+cover(3))=0;
    [greenO,greenN] = bwlabel(greenI);
    disp('green')
    disp(node)
    gnodeCen = stats(node).Centroid;
    disp(gnodeCen)
    greenCen = revgridNumber(gnodeCen,greenO,greenN);
    disp('greencen');
    disp(greenCen)
%     imtool(greenI)
    
    if(redInew(ledY,ledX)==1)
        ledC = 'R';
        disp(ledC);
        x = redCen;
    elseif(greenInew(ledY,ledX)==1)
        ledC = 'G';
        disp(ledC);
        x = greenCen;
    end
    
    disp('botpos')
    disp(botpos)
    nodevec=[x(1)-botpos(1),x(2)-botpos(2)];
    botcom = complex(botvec(1),botvec(2));
    nodecom = complex(nodevec(1),nodevec(2));
    a=angle(botcom/nodecom);
    
    a=(180/pi)*a;
    
    d = floor(((((x(1))-botpos(1))*xFact)^2+(((x(2)-botpos(2))*yFact)^2))^0.5);
    disp(d)
    disp(a)
    if d<=20&&a>=-5 && a<=5
        instant1 = getsnapshot(vid);
        instant1 = imcrop(instant1,rect);
        ledC1 = ledColor(instant1,cover2,rgbR,rgbG);
        disp('LedC1');
        disp(ledC1);
        disp('LedC');
        disp(ledC) 
        
        if(ledC1==ledC) 
        disp('Grabbing Starts');
        botmech('a',scra);
        pause(1.5);
        disp('Grabbed');
        ledCNew = ledC1;
        else
           botback(scra,d);
            ledC = ledC1;
        end
        [botpos,botvec] = bot_position(instant,rgbB,rgbO);
        break;
        
    else
        
    botm(a(1),d-18,scra);
    %moveforward
    end
end

end
