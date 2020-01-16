function [new_obs]=discretise(obs)
buckets=[3,3,6,12];
upper_bounds=[3,15,45*pi/180,15];
lower_bounds=[-3,-15,-45*pi/180,-15];
for i=1:length(obs)
    ratios=(obs(i)+abs(lower_bounds(i)))/(upper_bounds(i)-lower_bounds(i));
    new_obs(i)=round((buckets(i)-1).*ratios);
    new_obs(i)=min(buckets(i)-1,max(0,new_obs(i)))+1;
end

end