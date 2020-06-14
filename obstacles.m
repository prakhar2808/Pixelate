function [obs] = obstacles(p,redI,greenI)

%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
[red,green] = redandgreenobs( p,redI,greenI);
sR = length(red);
obs = zeros(8);
for i=1:sR
    obs(mod(red(i)-1,8)+1,ceil(red(i)/8)) = 1;
end
sG = length(green);
for i=1:sG
    obs(mod(green(i)-1,8)+1,ceil(green(i)/8)) = 1;
end

end

