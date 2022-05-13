function [KStateOut]= KMarkovChainFraction_STN(V, KStateIn, t,dt)
tswitch = t;
Kstate = KStateIn;
  % Update Channel States
  while (tswitch < (t+dt)) 

    % Determine which state switches by partitioning total rate into its 28 components

    rate(1) = 4.*an_STN(V) * Kstate(1);
    rate(2) = rate(1) + 3.*an_STN(V) * Kstate(2);
    rate(3) = rate(2) + 2.*an_STN(V) * Kstate(3);
    rate(4) = rate(3) + 1.*an_STN(V) * Kstate(4);
    rate(5) = rate(4) + 4.*bn_STN(V) * Kstate(5);
    rate(6) = rate(5) + 3.*bn_STN(V) * Kstate(4);
    rate(7) = rate(6) + 2.*bn_STN(V) * Kstate(3);
    rate(8) = rate(7) + 1.*bn_STN(V) * Kstate(2);

    % Total Transition Rate
    totalrate = rate(8);

    % Exponential Waiting Time Distribution
    tupdate = -log(rand()) / totalrate;

    % Time of Next Switching Event (Exp Rand Var)
    tswitch = tswitch + tupdate;

    if (tswitch < (t+dt)) 

      % Scaled Uniform RV to determine which state to switch
      r = totalrate*rand();

      
      if (r < rate(1)) 
       Kstate(1) = Kstate(1)-1;
       Kstate(2) = Kstate(2)+1;
      elseif (r < rate(2)) 
       Kstate(2) = Kstate(2)-1;
       Kstate(3) = Kstate(3)+1;
      elseif (r < rate(3)) 
       Kstate(3) = Kstate(3)-1;
       Kstate(4) = Kstate(4)+1;
      elseif (r < rate(4)) 
       Kstate(4) = Kstate(4)-1;
       Kstate(5) = Kstate(5)+1;
      elseif (r < rate(5)) 
       Kstate(5) = Kstate(5)-1;
       Kstate(4) = Kstate(4)+1;
      elseif (r < rate(6)) 
       Kstate(4) = Kstate(4)-1;
       Kstate(3) = Kstate(3)+1;
      elseif (r < rate(7)) 
       Kstate(3) = Kstate(3)-1;
       Kstate(2) = Kstate(2)+1;
      else
       Kstate(2) = Kstate(2)-1;
       Kstate(1) = Kstate(1)+1;
      end % End if statement

    end % end if tswitch<dt
 
end % end while tswitch<dt
KStateOut = Kstate;
end % end Markov chain Gillespie update function