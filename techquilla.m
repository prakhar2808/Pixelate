run = 0;

scra = serial('COM4','BaudRate',9600);
fopen(scra);
pause(2)
vid = videoinput('winvideo', 2, 'MJPG_1280x960');
vid.ReturnedColorspace = 'rgb';
src = getselectedsource(vid);
flag = 0;


src.Brightness = 28;

src.Saturation = 82;



vid.FramesPerTrigger = 1;

preview(vid);

while(1)
    video
    takla=0;
    [botpos,botvec] = bot_position(p,rgbB,rgbO);
    botgrid = gridNumber(botpos,stats);
    obs = obstacles(p,redI,greenI);
    flag=1;
    [red,green] = redandgreen(p,cover2,cover,cover1,redI,greenI);
    if(ledC == 'G')
        if length(green)==0
            glow('k',scra);
            flag=0;
        elseif(flag ==10)  flag = 1;  botmech('t',scra); pause(1.5); 
        elseif(flag ==20)  continue;
        else
            path = dijkstra(obs,botgrid,green);
            for i=2:length(path)-1
                if(path(i)==0)
                    takla=1;
                    takla
                    break;
                end
                ledC = bot_move(path(i),stats,vid,pcrop,cover2,rgbB,rgbO,rgbR,rgbG,scra);
                
                if(ledC == 'R')
                    botpos = stats(path(i)).Centroid();
                    glow('w',scra);
                    pause(3);
                    glow('o',scra);
                    break;
                end
                takla = 1;
            end
            if(length(path)==2) takla = 1; end
            
            disp(takla)
            disp('green');
            if(takla==1)
                takla
                [ledC,ledCNew,botpos] =bot_move2(path(end),stats,vid,pcrop,cover2,cover,rgbB,rgbO,rgbR,rgbG,scra);
                flag = 20;
            end
        end
    end
    takla=0;
    if(ledC == 'R')
        if length(red)==0
            glow('k',scra);
            flag=0;
        elseif(flag ==20)  flag = 1;  botmech('t',scra); pause(1.5); %degrabbing
        elseif(flag ==10)  continue;
            
        else
            clear path
            path = dijkstra(obs,botgrid,red);
            for i=2:length(path)-1
                if(path(i)==0)
                    takla=1;
                    break;
                end
                ledC = bot_move(path(i),stats,vid,pcrop,cover2,rgbB,rgbO,rgbR,rgbG,scra);
                if(ledC == 'G')
                    botpos = stats(path(i)).Centroid();
                    glow('g',scra);
                    pause(3);
                    glow('o',scra);
                    break;
                end
                takla = 1;
            end
            if(length(path)==2) takla = 1; end
            
            disp(takla);
            disp('red');
            if(takla==1)
                takla
                [ledC,ledCNew,botpos,botvec] = bot_move2(path(end),stats, vid,rect,cover2,cover,rgbB, rgbO, rgbR, rgbG,scra);
                flag = 10;
            end
            
            
        end
    end
end