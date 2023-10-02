% fungsi timer
clear
clc

tsampling = 1; %second
tnext = tsampling;

tstart = tic;

x = 1:0.1:10;
y = sin(x);

plot(x,y);
drawnow;

index = 1;

while true
    telapsed = toc(tstart);
    if telapsed >= tnext
        tnext = tnext + tsampling;
        disp(x(index));
        hold on
        plot(x(index),y(index),'o','MarkerFaceColor','b');
        hold off
        drawnow;
        index = index + 1;
    end
    
    if index > length(x)
        break;
    end
end