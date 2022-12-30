function [detonate , missDistance ] = fuzeKin( xx )
% returns detonate = 1 and miss distance if fuzing conditions have been met.
% returns detonate = 0 and miss distance = Nan if fuzing conditions haven't been met

temp1a = (abs( xx(2:end,7) ) < 10); %Is R<10 in intersample?
temp1b = ( xx(2:end,7).*xx(1:end-1,7) < 0) ; % Is R crossing 0 in intersample?
temp1c = ( xx(2:end,7)-xx(1:end-1,7) > 0) ; % Is R increasing in intersample?
temp1bc = any( [temp1b temp1c] , 2 );
temp1 = all( [temp1a temp1bc] , 2 ); %Is R<10 AND R crossing 0 or Rdot>0 in intersample?
temp2 = xx(2:end,1) < 0; %Did pursuer hit the ground in intersample?
temp3 = xx(2:end,4) < 0; %Did evader hit the ground in intersample?  
temp = any( [temp1 temp2 temp3] , 2); %Is any fuzing condition satisfied in intersample?
if any(temp,1)
    fuze_index = 0;
    for kk = 1:length(temp)
        if temp(kk) == 1
            fuze_index = kk;
            break
        end
    end
    missDistance = xx(fuze_index,7);
    detonate = 1;
else
    missDistance = NaN;
    detonate = 0;
end

end

