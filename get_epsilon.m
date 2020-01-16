function [epsilon]=get_epsilon(t)
ada_divisor=25;
min_epsilon =0.1;
epsilon=max(min_epsilon,min(1,1-log10((t+1)/ada_divisor)));

end