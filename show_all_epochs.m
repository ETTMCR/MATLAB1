%% showing all the  et_plot_ERE('p p2') for each event, in a tiled way across the screen
% to_save 1 XOR 0 : 1 means if to make new sub folder, in order to save all the fig's / png's & etc. .(selected by file_type)
%Shipur - selcet xcase et_plot_ERE('pdif','npre','',{'^L$','^R$'},trialnum,1,0,1,0,0); OR p p2

function show_all_epochs(to_save,file_type) 
py_globals; et_globals;

%%
if to_save 
    newStr = sessions(1).lname ; %ETRepochs(1).exp;
    path_save = pwd ;   % mention your path
    %myfolder = ['saves',the_l] ;   % new folder name
    myfolder = ['saves-',newStr] ;   % new folder name
    %folder = mkdir([path_save,filesep,myfolder]) ;
    mkdir([path_save,filesep,myfolder]) ;
    path_save  = [path_save,filesep,myfolder] ;
    cd (path_save)
end
%%

et_set_events_in_epochs_from_psy('eind','cmnt');
close all
for i=1: length(trials) %  20

    et_plot_ERE('p p2','%pre','1',['^',ETRepochs(i).cond,'$'],['^' num2str(i) '$'],1,0,1,0,0); % check for et_set_events_in_epochs_from_psy('eind','cmnt');
    title (['epoch # ',num2str(ETRepochs(i).epn),' of ',(ETRepochs(i).cond),' obs ',num2str(ETRepochs(i).obs)])

    hold on
    %legend('hide');
    xlabel('')
    ylabel('')
    xline(0,'--k')%,'LabelVerticalAlignment','middle')
    yline(0,'--k')
    hold off
    
    if to_save 
        saveas(gcf,[ sessions(1).lname ,'_',num2str(i), '.',file_type]) %observers(1)
    end    
end

end % ob function