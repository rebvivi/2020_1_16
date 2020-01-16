% hyperparameters
n_episodes=1500;
n_steps=200;
n_test=30;
gamma=1;

% create q table
Q =zeros(3,3,6,12,5);
rewards=double.empty;
p= double.empty;
pdot=double.empty;
theta=double.empty;
thetadot=double.empty;
%% training phase
for episode=1:n_episodes
    
    [current_state] = myResetFunction();
    % continuous current state
    a=current_state(1);
    b=current_state(2);
    c=current_state(3);
    d=current_state(4);
    
    p=[p,a];
    pdot=[pdot,b];
    theta=[theta,c];
    thetadot=[thetadot,d];
    
    current_state_d=discretise(current_state);
    alpha=get_alpha(episode);
    epsilon=get_epsilon(episode);
    episode_rewards=0;
    for t=1: n_steps
        choose_action=epsilon_policy(current_state_d,epsilon,Q);
        [new_state,reward,IsDone] = myStepFunction(choose_action,current_state);
        % continuous new_state
        e=new_state(1);
        f=new_state(2);
        g=new_state(3);
        h=new_state(4);
        p=[p,e];
        pdot=[pdot,f];
        theta=[theta,g];
        thetadot=[thetadot,h];
        
        % discretised state
        new_state_d=discretise(new_state);
        a1=current_state_d(1);
        b1=current_state_d(2);
        c1=current_state_d(3);
        d1=current_state_d(4);
        e1=new_state_d(1);
        f1=new_state_d(2);
        g1=new_state_d(3);
        h1=new_state_d(4);
        
        
        Q(a1,b1,c1,d1,choose_action)=Q(a1,b1,c1,d1,choose_action)+alpha*(reward+gamma*max(Q(e1,f1,g1,h1,:))-Q(a1,b1,c1,d1,choose_action));
        current_state=new_state;
        current_state_d=new_state_d;
        episode_rewards=episode_rewards+reward;
        
        if IsDone
            break;
        end
        
        
    end
    rewards=[rewards,episode_rewards];
end
subplot(2,1,1);
x=1:n_episodes
plot(x,rewards);
%%
test_reward=double.empty;
%% testing phase
for episode=1:n_test
    
    [current_state] = myResetFunction();
    % continuous current state
    a=current_state(1);
    b=current_state(2);
    c=current_state(3);
    d=current_state(4);
    
    p=[p,a];
    pdot=[pdot,b];
    theta=[theta,c];
    thetadot=[thetadot,d];
    
    current_state_d=discretise(current_state);
    episode_rewards=0;
    for t=1: n_steps
        choose_action=greedy_policy(current_state_d,Q);
        [new_state,reward,IsDone] = myStepFunction(choose_action,current_state);
        % continuous new_state
        e=new_state(1);
        f=new_state(2);
        g=new_state(3);
        h=new_state(4);
        p=[p,e];
        pdot=[pdot,f];
        theta=[theta,g];
        thetadot=[thetadot,h];
        
        % discretised state
        new_state_d=discretise(new_state);
        a1=current_state_d(1);
        b1=current_state_d(2);
        c1=current_state_d(3);
        d1=current_state_d(4);
        e1=new_state_d(1);
        f1=new_state_d(2);
        g1=new_state_d(3);
        h1=new_state_d(4);
        
        
        Q(a1,b1,c1,d1,choose_action)=Q(a1,b1,c1,d1,choose_action)+alpha*(reward+gamma*max(Q(e1,f1,g1,h1,:))-Q(a1,b1,c1,d1,choose_action));
        current_state=new_state;
        current_state_d=new_state_d;
        episode_rewards=episode_rewards+reward;
        
        if IsDone
            break;
        end
        
        
    end
    test_reward=[test_reward,episode_rewards];
end
%%
subplot(2,1,2);
y=1:n_test
plot(y,test_reward);