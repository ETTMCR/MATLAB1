%%plot3
    clc
ttt=0;
%hold all
while true
 t1 = datetime('now','Format','HH:mm:ss'); %ss.SSS
[h,m,s] = hms(t1)
h2= plot3 (h,m,s,'.')
%while  ~(ttt==5)
 t1 = datetime('now','Format','HH:mm:ss'); %ss.SSS
[h,m,s] = hms(t1)
%plot3 (h,m,s)  %,'.'
set(h2,'Visible','off')
h1= plot3 (h,m,s,'.')
h2= plot3 (h,m,s,'O')
 % plot3 (h,m,s,'.') % ORG works 1!!!
   hold on

 pause(1);
 ttt=1+ttt;
 xlabel('hours')
ylabel('minutes')
zlabel('seconds')
set(gca, 'XTick', unique(round(h)))
%set(gca, 'XTick', [1 2 3])
end

hold off

%% bar
close all
    clc
ttt=0;
%hold all
while true
somenames={'hours' 'minutes' 'seconds' };

%while  ~(ttt==120)
 t1 = datetime('now','Format','HH:mm:ss'); %ss.SSS
 
[h,m,s] = hms(t1)
yyy=[h,m,s]
bar(yyy)
   hold on
 pause(1);
 ttt=1+ttt;
 
%  xlabel('hours')
% ylabel('minutes')
% zlabel('seconds')

set(gca,'xticklabel',somenames)

end

hold off

%% polarplot
close all
    clc
ttt=0;
%hold all
%while true
while  ~(ttt==7)
 t1 = datetime('now','Format','HH:mm:ss'); %ss.SSS
 
[h,m,s] = hms(t1)
yyy=[h,m,s]

polarplot(450,yyy(3),'o')
%polarplot(yyy(2),yyy(3),'o')
 %view([90 -90])


   hold on
 pause(1);
 ttt=1+ttt;
 
%  xlabel('hours')
% ylabel('minutes')
% zlabel('seconds')


end

hold off

%% compass
M = randn(20,20);
Z = eig(-45,10);

figure
compass(Z)
%% compass
close all
    clc
ttt=0;
%hold all
%while true
while  ~(ttt==10)
 t1 = datetime('now','Format','HH:mm:ss'); %ss.SSS
 
[h,m,s] = hms(t1)
yyy=[h,m,s]
M = [m,s];
%Z = eig(M);
compass(s);
%compass(m,360/s);
%compass(m,s*6);

 hold on
 pause(1);
 ttt=1+ttt;
 view([90 -90])

%  xlabel('hours')
% ylabel('minutes')
% zlabel('seconds')

end

hold off

%% ESC breaks
DlgH = figure;
H = uicontrol('Style', 'PushButton', ...
                    'String', 'Break', ...
                    'Callback', 'delete(gcbf)');
while (ishandle(H))
   disp(clock);
   pause(0.5);
end

set(h,'WindowKeyPressFcn',@KeyPressFcn);