function [path] = dijkstra( grid,start,stop )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
dist=eye(64);
parent=eye(64);
sptSet=eye(64);
for i=1:1:64
    dist(i)=1000;
    sptSet(i)=0;
    parent(i)=start;
end
dist(start)=0;
for count=1:1:64
    if count==0
        u=start;
    else
        u=minDistance(dist,sptSet);
    end
    sptSet(u) =1;
    r=mod(u-1,8)+1;
    c=ceil(u/8);
    
    if c~=8
    [parent,dist] = update(grid,u,r+(c)*8,parent,sptSet,dist); 
    end
    if c~=1
    [parent,dist] = update(grid,u,r+(c-2)*8,parent,sptSet,dist);
    end
    if r~=1     
    [parent,dist] = update(grid,u,(r-1)+(c-1)*8,parent,sptSet,dist);
    end
    if r~=8
    [parent,dist] = update(grid,u,(r+1)+(c-1)*8,parent,sptSet,dist);
    end
end

siz= size(stop);
for i=1:length(stop)
    u=stop(i);
    r=mod(u-1,8)+1;
    c=ceil(u/8);
    min=64;
    if c~=8 && grid(r,c+1)==0 && dist(r+(c)*8)<min
    min=dist(r+(c)*8);
    parent(u)=r+(c)*8;
    dist(u)=dist(parent(u))+1;
    end
    if c~=1 && grid(r,c-1)==0 && dist(r+(c-2)*8)<min
    min=dist(r+(c-2)*8);
    parent(u)=r+(c-2)*8;
    dist(u)=dist(parent(u))+1;
    end
    if r~=1 && grid(r-1,c)==0 && dist(r-1+(c-1)*8)<min
    min=dist((r-1)+(c-1)*8);
    parent(u)=(r-1)+(c-1)*8;
    dist(u)=dist(parent(u))+1;
    end
    if r~=8 && grid(r+1,c)==0 && dist((r+1)+(c-1)*8)<min
    min=dist((r+1)+(c-1)*8);
    parent(u)=(r+1)+(c-1)*8;
    dist(u)=dist(parent(u))+1;
    end
end
current = stop(1);
for i=1:length(stop)
    if(dist(stop(i))<dist(current))
        current = stop(i);
        
    end
end
i = dist(current)+1; 
while(current~=start)
    path(i) = current;
    current = parent(current);
    i = i-1;
end
path(i) = start;
    



end




                    
