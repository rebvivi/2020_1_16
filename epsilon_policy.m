function [choose_action]=epsilon_policy(state,epsilon,Q)
actions =[1,2,3,4,5];
a=state(1);
b=state(2);
c=state(3);
d=state(4);

r=randi([0 1]);
if r<=epsilon
    choose_action=datasample(actions,1);
else
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


end