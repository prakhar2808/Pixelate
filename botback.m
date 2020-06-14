function [] = botback(scra,d)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
gd = [0,20,30];
td= [0,.495,.755];
timed =0;
for i=1:2
    if d>gd(i) && d<=gd(i+1)
    timed = (d/gd(i+1))*td(i+1);
    break;
    end
end
if(d>30)
    timed = .755;
end
timed
fwrite(scra,'b');
disp('b');
pause(timed);
fwrite(scra,'s');
end

