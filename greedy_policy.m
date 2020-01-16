function [choose_action]=greedy_policy(state,Q)
a=state(1);
b=state(2);
c=state(3);
d=state(4);
if Q(a,b,c,d,1)==max(Q(a,b,c,d,:))
    choose_action= 1 ;
elseif Q(a,b,c,d,2)==max(Q(a,b,c,d,:))
    choose_action= 2 ;
elseif Q(a,b,c,d,3)==max(Q(a,b,c,d,:))
    choose_action= 3 ;
elseif Q(a,b,c,d,4)==max(Q(a,b,c,d,:))
    choose_action= 4 ;
elseif Q(a,b,c,d,5)==max(Q(a,b,c,d,:))
    choose_action= 5 ;
end
end