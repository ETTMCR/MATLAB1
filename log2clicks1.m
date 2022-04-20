%% the whole process - any section is marked by !!!!!!
%!!!!!!! loading l file,
clc
clear all
close all

%[prime_non_ass] = uigetfile('*.l','MultiSelect','on');  % for MultiSelect
[the_l,path] =uigetfile('*.l');
%uiwait
cd (path)
%fname1='*.l'; % for MultiSelect
d=dir(the_l);
c = (fileread(the_l));

et_globals;
py_globals;
py_load_all(the_l);

% WORKS only for time stamps
% %ev0=[ 1 3837 -1 4306 2 4732 -2 4902 1 5754 -1 6010 2 6522 -2 7161 1 7374 -1 8482 2 8737 -2 9121 1 9504 -1 10569 1 11975 -1 12231 1 12487 -1 12743 2 12913 -2 13808 1 15214 -1 16024 1 19305 -1 19433 1 19603 -1 20498 2 20669 -2 21947 1 22288 -1 23012 1 23609 -1 24589 2 24887 -2 25143 1 25186 -1 25484 2 25569 -2 26592 1 26762 -1 27657 2 29873 -2 31024 2 31493 -2 32388 2 35924 -2 36733 1 37287 -1 38054 2 40270 -2 40952 2 45724 -2 46363 1 50326 -1 51178 1 58546 -1 59781  ]
% newStr2 = {};
%
% startIndex = (regexp(ev0_str,' ')); %where are the ' ' (spaces)
% startIndex = startIndex{1,:}
% for i=2:2:length(startIndex)%every second ' ' is the time stamp
% newStr2 =[newStr2,extractBetween(ev0_str,startIndex(i)+1,' ')]; % the clicks' type
% end

% % % %!!!! function et_crop_ETR()
% % % % crop the ETR fields to the part from the time experimt started
% % % % TO BE TESTED... 26 May 2021 YB, ET
% % % et_globals;
% % % fl0='H V P P2 H2 V2 pdif';
% % % fl=parsetxt(fl0);
% % % tmargin=1; % 1 sec 
% % % for ei=1:numel(ETR)
% % %     t0=0; 
% % %     if (isfield(ETR,'event')) && ( ~isempty(ETR(ei).event))
% % %         t0=ETR(ei).event(1).time;
% % %     end
% % %     s0=(t0-tmargin)*ETR(ei).srate; s0=max(s0,1);
% % %     for i=1:numel(fl), ETR(ei).(fl{i})=ETR(ei).(fl{i})(s0:end); end
% % % end

newStr = eraseBetween(the_l,length(the_l)-1,length(the_l))  
save(newStr) ; 

%@@@@@@@ the real issue starts here  @@@@@@@@@
%!!!!!! extracting the  '3837' '1'  couples from mouse clicks - the original method !!!!!!!mouse
% extracting from the l file the ev0=[....] line containing the time stamps of the clicks.
%%gives indexes of where exp is
c = (fileread(the_l));
exp_mail =('ev0=[ '); %6 chars
a= strfind(c,exp_mail); % this line gives the indexes of where
ev0_str=extractBetween(c,a+5,' ]');

newStr2 = {};
newStr2(2,:) = {[]};
startIndex = (regexp(ev0_str,' ')); %where are the ' ' (spaces)
startIndex = startIndex{1,:};
for i=2:2:length(startIndex)%every second ' ' is the time stamp
    newStr2(1,i) =[extractBetween(ev0_str,startIndex(i)+1,' ')]; %time stamps
    newStr2(2,i) =[extractBetween(ev0_str,startIndex(i-1)+1,' ')]; %time stamps
end
newStr2(:,1:2:end) = []; %delete every even culomn
% ans :
%   {'3837'}    {'4306'}
%     {'1'   }    {'-1'  } and so on....
newStr2=str2double(newStr2); %str2double
% ans :
%   '3837'    '4306'
%     '1'       '-1'   and so on....

%!!! how many clicks

num_clicks = ((length(newStr2) / 2))
disp1 = ['there were ',num2str(num_clicks),' clicks'];
disp (disp1);

disp2= ['with an avg of ' ,(num2str(num_clicks/blocks.tdu)), ' clicks per sec'];
disp (disp2);

disp3= ['or, one click, every ' ,(num2str(1/(num_clicks/blocks.tdu))),  ' sec'];
disp (disp3);

%!!!!!!!!! ploting
ind=1; % observer number
et_plot_raw1({'P','P2'},ind)
title(" (et_plot_raw1({'P','P2'},ind)  of the file " + the_l ) % + observers(1))

%plt=the_clicks()

%!!!!!!!!! drawing the vertical lines according to time and type of click
%function plt=the_clicks()
%click on the plot, in which you want the marks will be added
% update - done by et_plot_all_xline_events.m
clc
how_many_clicks = 0;
hold all
for i=1:length(newStr2)%every second ' ' is the time stamp
    % plot( (str2num(cell2mat(newStr2(1,i))/1000)),(str2num(cell2mat(newStr2(2,i)))))
    %plot( (newStr2(1,i))/1000,(newStr2(2,i)))
    %xline(xvalue,LineSpec) specifies either the line style, the line color, or both. For example, '-.' creates a dash-dot line, 'b' creates a blue line, and '-.b' creates a blue dash-dot line.
    %figure(1).LabelVerticalAlignment = 'top';
    switch (newStr2(2,i))
        case 1
            xl=xline((newStr2(1,i))/1000,'--b',{newStr2(2,i)})
            xl.LabelVerticalAlignment = 'bottom';
            %xl.LineWidth = 1;
            xl.LabelHorizontalAlignment = 'center';
            xl.LabelOrientation='horizontal'  ;    
            how_many_clicks=how_many_clicks+1;
        case -1
            xl=xline((newStr2(1,i))/1000,'--c',{newStr2(2,i)})%,'LabelVerticalAlignment','middle')
            xl.LabelVerticalAlignment = 'bottom';
            xl.LabelHorizontalAlignment = 'center';
            xl.LabelOrientation='horizontal'  ;
        case 2
            %               xline((newStr2(1,i))/1000,'--r',{newStr2(2,i)})%[0.4660 0.6740 0.1880])
            xl= xline((newStr2(1,i))/1000,'--r',{newStr2(2,i)})
            xl.LabelVerticalAlignment = 'bottom';
            xl.LabelHorizontalAlignment = 'center';
            xl.LabelOrientation='horizontal';
            
            %                        'LabelHorizontalAlignment ', 'right', ...
            %      'LabelVerticalAlignment', 'bottom');
             how_many_clicks=how_many_clicks+1;
        case -2
            %xline((newStr2(1,i))/1000,'m')%,{newStr2(2,i)})
            xl=xline((newStr2(1,i))/1000,'--m',{newStr2(2,i)})
            xl.LabelVerticalAlignment = 'bottom';
            xl.LabelHorizontalAlignment = 'center';
            xl.LabelOrientation='horizontal';
        case 4
            xl=xline((newStr2(1,i))/1000,'--y',{newStr2(2,i)})%[0.4660 0.6740 0.1880])
            xl.LabelVerticalAlignment = 'bottom';
            xl.LabelHorizontalAlignment = 'center';
            xl.LabelOrientation='horizontal'    ;    
        case -4
            xl=xline((newStr2(1,i))/1000,'--k',{newStr2(2,i)})
            xl.LabelVerticalAlignment = 'bottom';
            xl.LabelHorizontalAlignment = 'center';
            xl.LabelOrientation='horizontal';
    end
    %xline(4.5,'-',{'Acceptable','Limit'});
    %      text(Vb_ev, pH_ev,'Point X', ...
    %      'HorizontalAlignment', 'right', ...
    %      'VerticalAlignment', 'bottom');
end
%             x1.LabelVerticalAlignment = 'bottom';
%             x1.LabelHorizontalAlignment = 'center';
%             x1.LabelOrientation='horizontal'    
%legend('hide');
%https://www.google.com/search?q=how+to+show+onlt+specfific+data+legend+matlab&oq=how+to+show+onlt+specfific+data+legend+matlab&aqs=chrome..69i57.13999j0j4&sourceid=chrome&ie=UTF-8
hold off

% shg % focusing to the the last figure 

%clc

% how many clicks

num_clicks = ((length(newStr2) / 2))
disp1 = ['there were ',num2str(num_clicks),' clicks'];
disp (disp1)

disp2= ['with an avg of ' ,(num2str(num_clicks/blocks.tdu)), ' clicks per sec'];
disp (disp2)

disp3= ['or, one click, every ' ,(num2str(1/(num_clicks/blocks.tdu))),  ' sec'];
disp (disp3)

 disp (['there were ' num2str(how_many_clicks) ' indvidual visions clicks, i.e. 1 OR 2 '])

for  i = 99:-1:1,
    if ishandle(i),
        % close(i);
        %set(ishandle(3), 'HandleVisibility', 'on');
        %plt=figure(i)
        figure(i)
       % ff=figure(i)
        set(gcf, 'Position',  [0, 0,1920 , 1080/2])
        movegui( figure(i-1),'south');
                %ff=figure(i-1)
        set(gcf, 'Position',  [0, 0,1920 , 1080/2])
        movegui( figure(i),'north');
        %xline(0,'--k')
        return; %if this is commented, then all will be shown
    end;
end

% epoch analysis
ETRpar.epochs.trange_auto=0; ETRpar.epochs.trange=[-0.5 5]; % window time for the epoch 

% !!!!!!!!