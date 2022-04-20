%% the function generate
% figures 1 & 2 : pdif in Left & Right Respectively
%figure 3  :
%RED: what is the amplitude of the (L/R) pdif's, i.e. as long the curve is greater, the diffs are stronger
%BLUE: how much the diffs of pupil Left and Right are equel, i.e. mirror as long the curve is overlapping the x axis
%yellow: how much in total the diffs (L/R) are strong

% !!!! next step ET's idea
% to analays the different / p value between a critical time zone, as we think consider the effect
%
%  1. as long the diff_L-diff_R (diff_diffs) is close to zero - the simetrical the effct is
% AND
% 2. the diff themselves bigger (sum_diffs), the effect is greater , in the critical area
% AND
% 3.   the difference 1 to 2 is greater  (combined_diffs),  in the critical area, the more we have a sure effect, compared to other individual obs plots
%
% what about anisocoria affecting the diff ?

function pdif_amplitude

close all

%et_plot_ERE('pdif','%pre','','.',{'^L$','^R$'},1,0,1,0,0);  %both of below

et_plot_ERE('pdif','%pre','','.','^L$',1,0,1,0,0);
title(["'pdif','%pre' L$ file ", sessions(1).lname]) % + observers(1))
f1_L = findobj(gca,'Type','line');
y1_L=get(f1_L,'Ydata') ;
y1_L_val=y1_L{2,1};
%close all
%y1=get(f1,'Ydata') ;

et_plot_ERE('pdif','%pre','','.','^R$',1,0,1,0,0);
title("'pdif','%pre' R$ file "+ sessions(1).lname) % + observers(1))
f1_R = findobj(gca,'Type','line');
y1_R=get(f1_R,'Ydata') ;
y1_R_val=y1_R{2,1};
%y1=get(f1,'Ydata') ;

%diff_diffs
%diff_diffs=y1_R(2,1)-y1_L(2,1)
%diff_diffs=y1_R_val-y1_L_val;
diff_diffs=abs(y1_R_val)-abs(y1_L_val); % ????
figure;
x1_L=get(f1_L,'Xdata') ;
x1_L_val=x1_L{2,1};
plot (x1_L_val,diff_diffs)
title ('diff_diffs=y1_R_val-y1_L_val')

hold on
%sum_diffs
% the diff themselves bigger (sum_diffs)
sum_diffs=abs(y1_R_val)+abs(y1_L_val);
%figure;
%x1_L=get(f1_L,'Xdata') ;
x1_L_val=x1_L{2,1};
plot (x1_L_val,sum_diffs)
title ('sum_diffs=y1_R_val+y1_L_val')

%hold on
%combined_diffs
% both conditions, the greater the effect --> in the critical area
%combined_diffs=sum_diffs-diff_diffs;
combined_diffs=sum_diffs-abs(diff_diffs) ; % ???abs
%figure;
%x1_L=get(f1_L,'Xdata') ;
x1_L_val=x1_L{2,1};
plot (x1_L_val,combined_diffs)
title ('combined_diffs=sum_diffs-diff_diffs')

hold off

autoArrangeFigures(3,1,1); %https://uk.mathworks.com/matlabcentral/fileexchange/48480-automatically-arrange-figure-windows
h = findobj('type','figure'); %Figure count
%n =length(h)
for i=1:length(h); %makes them also to jump
    %legend('hide');
    legend('Location','northeast')%legend('Location','northwestoutside')%legend('Location','best')%legend('Location','northwest')
    xline(0,'--k')%,'LabelVerticalAlignment','middle')
        %for j=0:5
        j=0;
        yline(j*10,'--k')%,'LabelVerticalAlignment','middle')
        %end
    set( figure(i), 'MenuBar', 'none'); %more space on screen, but then you cannot make a zoom
    %set( figure(i), 'FigureToolbar', 'remove') %Error using matlab.ui.Figure/set - Unrecognized property FigureToolbar for class Figure.
    %figure('Name',trialnum,'NumberTitle','off')
end

hl = legend;
hl.String{1} = 'diff_diffs=y1_R_val-y1_L_val';
hl.String{2} = 'sum_diffs=abs(y1_R_val)+abs(y1_L_val)';
hl.String{3} =  'combined_diffs=sum_diffs-abs(diff_diffs)';
hl.String{4}=''; hl.String{5}='';
%legend({'Vert','Hor'});

pause (1.5)
fig_num=fig_num+1;
  % Take screen capture
fun_printme(fig_num)




end