%% loading l file manualy
%other option to develope
%complete_load(name_of_file) %by specific name
%complete_load(set_start ,set_end) %manual parameters of time
function complete_load()

clc
clear all
%close all

%[primes] = uigetfile('*.l','MultiSelect','on');  % for MultiSelect
[the_l,path] =uigetfile('*.l');
%uiwait
cd (path)
%fname1='*.l'; % for MultiSelect
d=dir(the_l);
c = (fileread(the_l));
et_globals; py_globals;  xplot_globals;

if nargin==0 % i.e. et_plot_all_xline_events() % no et_set_trange(); was declared
   condi=0;
   py_load_all(the_l);
else 
    condi=1;
    et_set_trange([set_start ,set_end]); % 
    py_load_all(['*' , name_of_file , '*']);
end

%% -----little statistic of obs- ----
All_a(:) = { ETRepochs.obs };
All_names = unique(All_a);
All_names_length=length(unique(All_a));
uniq_obs_size=length(unique(extractBefore((All_names(:)),5)));

All_exp(:) = { ETRepochs.exp };
exp_name = char(unique(All_exp));

uniq_obs_size
exp_name

end %of fun