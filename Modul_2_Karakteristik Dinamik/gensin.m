function [y,t] = gensin(vmax,vmin,half_period,repeat,tsampling)
    t = 0:tsampling:2*half_period*repeat;
    y = zeros(1,length(t));
    
    n_period = 1;
    
    for i=1:length(t)
       if t(i)<=n_period*half_period
           y(i) = vmax;
       else
           y(i) = vmin;
       end
       
       if t(i) ~= 0 && ~mod(t(i),half_period*2)
           n_period = n_period + 2;
       end
    end
end