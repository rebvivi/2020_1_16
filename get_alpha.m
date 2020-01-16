function [alpha]=get_alpha(t)
min_alpha=0.1;
ada_divisor=25;
alpha=max(min_alpha,min(1,1-log10((t+1)/ada_divisor)));

end