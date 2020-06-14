function [ min_index ] = minDistance( dist,sptSet )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
min = 1000;
min_index=-1;

for v = 1:1:64
    if sptSet(v) == 0 && dist(v) <= min
        
        min = dist(v);
        min_index = v;
    end
end
end

