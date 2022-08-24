%% !!!! convert_txt2etns

msg1 = 'choose any file from the directory in which the Nova Sight log files to be converted are';
ttl1 = 'convert_txt2etns';
file_types = '*.1;*.2;*.3;*.4;*.log;*.txt'; % there are some file types
[the_l,directory] =uigetfile(file_types,ttl1,msg1);

cd (convertCharsToStrings(directory))
new_dir_path = [directory , 'etns_files'];
mkdir (new_dir_path)

fileList=[dir('*.1');dir('*.2');dir('*.3');dir('*.4');dir('*.log');dir('*.txt')] ;% https://it.mathworks.com/matlabcentral/answers/16173-dir-search-multiple-files
% List all file_types files
tStart = tic;   % for the total time % ends with the line :  total_time = toc(tStart)  % for the total time

tic 
% Loop through each .log file, copy it and give new extension: .etns
for i = 1:numel(fileList)
    file = fullfile(directory, fileList(i).name);
    [tempDir, tempFile] = fileparts(file); 
    %status = copyfile(file, fullfile([tempDir, '\etns_files'], [tempFile, '.etns']));
    oldy= fileList(i).name
    %newy = [tempDir, '\etns_files\',fileList(3).name, '.etns']
    newy = [fileList(i).name, '.etns'];
    pwdd = pwd;
    movefile (oldy,newy ) % this alone is the fastets approach, without copying first %  0.81744 sec for 200 files
end

% copying files to folder \etns_files
% the bottleneck section 
for i = 1:numel(fileList)
    %oldy= fileList(i).name
    newy = [fileList(i).name, '.etns'];
     fprintf ('Copying  %d of %d, etns File : %s........',i,numel(fileList),fileList(i).name);% notifying the process, since there cal'ibration and Tr'aining files, which are different in scales, there is no point to make % Displaying Progress Status bar
    copyfile ([tempDir,'\',newy] ,[tempDir, '\etns_files','\',newy] ) ;
    fprintf ('Done.\n');
end

% convert back to log in the tempDir
for i = 1:numel(fileList)
    
    file = fullfile(directory, fileList(i).name);
    [tempDir, tempFile] = fileparts(file); 
    newy= fileList(i).name;
    oldy = [fileList(i).name, '.etns'];
    pwdd = pwd;
    movefile( [tempDir,'\',oldy],[tempDir,'\',newy] ) % this alone is the fastets approach, without copying first %  0.81744 sec for 200 files
end

fprintf('Renamed & copied %d log files to .etns\n',numel(fileList)); 
disp (['in ' ,num2str(toc),'seconds'])

%% !!!! convert NS culomns' name into Tobii's name
new_dir = [directory, 'etns_files'];
cd (convertCharsToStrings(new_dir))
fileList = dir([new_dir, '\*.etns']); 
% Loop through each .etns file,and convert parts of it
version_type_1 =[];
for i = 1:numel(fileList)
    file = fullfile(new_dir, fileList(i).name);
    [tempDir, tempFile] = fileparts(file); 
    %status = copyfile(file, fullfile(new_dir, [tempFile, '.etns']));
    new_name=[tempFile, '.etns'];
    content_of_file = fileread(new_name);
    fileList(i).name
    % the date need to be added

    word=char(content_of_file);
    date_NS= word(1:10) ;%= 2021-02-04
    % date_OUR % = 13/04/2022
    date_OUR = [date_NS(6:7) ,'/',date_NS(9:10),'/',date_NS(1:4)];
    % work - inserting two line of string at once
    chr = date_OUR;
    NS_string="Date & Time:"; OUR_string=chr;
    
end

%% !!!! fixing rest of the etns file

capExpr = '([0-9])\w+';
for i = 1:numel(fileList)
    tic
    fprintf ('Fixing rest of the etns file, %d of %d. File name : %s........',i,numel(fileList),fileList(i).name);% notifying the process, since there cal'ibration and Tr'aining files, which are different in scales, there is no point to make % Displaying Progress Status bar
    nameeee = erase(fileList(i).name , '.etns' ) ; 
    fid = fopen([nameeee,'.etns']);
    tline = fgetl(fid);
    tlines = cell(0,1);
    jj=1;
    while ischar(tline)
         matchstartss=false;
        tlines{end+1,1} = tline;

            %  if jj>2%(jj==1 ) | (jj==2 ) % jumping upon the two first lines % can be form outside the while loop

                  % % removing timestamp lines contians not paremeters' values
                    %matchstarts1 = regexp(string(tlines(jj)), '[A-Z]'); % seems not need one of the two
                    matchstarts2 = regexp(string(tlines(jj)), '[a-z]'); 
                    if isempty(matchstarts2)
                            if tlines{jj}~="" % is Not empty, and filled with parameters values
                                capStartIndex = regexp(tlines{jj},capExpr);
                               if   numel(capStartIndex)>4 % 17:34:17.321 and filled with parameters values
                                
                                    ff=eraseBetween(string(tlines{jj}),1,11);
                                    tlines{jj}=ff;
                                    try
                                        ff=eraseBetween(string(tlines{jj}),13,14); %erasing the two spaces between the first and the second culomns
                                        tlines{jj}=ff;
                                    catch

                                    end
                               else % i.e. lines contains nor timestamp nither parameters (occurs at the end of files)
                                tlines(jj,:)=[];
                                jj=jj-1; 
                              end % of   numel(capStartIndex)>4
                            end
    %                      end
                    else      
                           % other line contains lower case letters which need to be deleted
                            % 
                            %fgetl(fid) ; % Read/discard line.
                           %matchstartss=true; %timestamp lines contians not paremeters' values
                          tlines{jj}="";
                    end % of ((~(isempty(matchstarts1))) || (~(isempty(matchstarts2))))

        tline = fgetl(fid);
       % if isempty(matchstarts2)
             ff= string(tlines{jj});            
        %else
        %end
        jj=jj+1;
    end % of while ischar
      
    fclose(fid);

    writecell(tlines,[nameeee,'.txt'])
    content_of_file = fileread([nameeee, '.txt']);
    fid = fopen([nameeee, '.etns'], 'w'); %!!!!!
    fwrite(fid, content_of_file);
    fclose(fid);

    delete([nameeee,'.txt'])  
    
    fprintf ('Done.\n');
    toc % each file
end % of filelist
%toc

%%  add the date_OUR &  parameters_row
cd (new_dir_path); % just for sure

for i = 1:numel(fileList)
        if isempty(strfind(fileList(i).name,'Tr_Raw')) %i.e. Tr_Raw type
           parameters_row = 'Timestamp	Left Raw X[px]	Left Raw Y[px]	Left Distance[mm]	Right Raw X[px]	Right Raw Y[px]	Right Distance[mm]	Left Data On Screen	Right Data On Screen	Display_Norm_Left Raw X[px]	Display_Norm_Left Raw Y[px]	Display_Norm_Right Raw X[px]	Display_Norm_Right Raw Y[px]	EyePose_TB_Norm_LX	EyePose_TB_Norm_LY	EyePose_TB_Norm_LZ	EyePose_TB_Norm_RX	EyePose_TB_Norm_RY	EyePose_TB_Norm_RZ	Left pupil size[mm]	Right pupil size[mm]	Eyeball_From_TRK_LX[mm]	Eyeball_From_TRK_LY[mm]	Eyeball_From_TRK_Left Distance[mm]	Eyeball_From_TRK_RX[mm]	Eyeball_From_TRK_RY[mm]	Eyeball_From_TRK_Right Distance[mm]	Valid_Eyeball_L	Valid_Eyeball_R	Eye_Pose_LX	Eye_Pose_LY	Eye_Pose_LZ	Eye_Pose_RX	Eye_Pose_RY	Eye_Pose_RZ	Valid_Eye_Pose_L	Valid_Eye_Pose_R';
        else  % i.e. Cal type 
           parameters_row ='Timestamp	Virtual_Left_Raw_X[px]	Virtual_Left_Raw_Y[px]	Virtual_Left_Visible	Virtual_Right_Raw_X[px]	Virtual_Right_Raw_Y[px]	Virtual_Right_Visible	Left Raw X[px]	Left Raw Y[px]	Left Distance[mm]	Right Raw X[px]	Right Raw Y[px]	Right Distance[mm]	Left Data On Screen	Right Data On Screen	Display_Norm_Left Raw X[px]	Display_Norm_Left Raw Y[px]	Display_Norm_Right Raw X[px]	Display_Norm_Right Raw Y[px]	EyePose_TB_Norm_LX	EyePose_TB_Norm_LY	EyePose_TB_Norm_LZ	EyePose_TB_Norm_RX	EyePose_TB_Norm_RY	EyePose_TB_Norm_RZ	Left pupil size[mm]	Right pupil size[mm]	Eyeball_From_TRK_LX[mm]	Eyeball_From_TRK_LY[mm]	Eyeball_From_TRK_Left Distance[mm]	Eyeball_From_TRK_RX[mm]	Eyeball_From_TRK_RY[mm]	Eyeball_From_TRK_Right Distance[mm]	Valid_Eyeball_L	Valid_Eyeball_R	Eye_Pose_LX	Eye_Pose_LY	Eye_Pose_LZ	Eye_Pose_RX	Eye_Pose_RY	Eye_Pose_RZ	Valid_Eye_Pose_L	Valid_Eye_Pose_R';
         end
        
        FileName = fileList(i).name;
        S = fileread(FileName);
        S = [date_OUR, newline, parameters_row, newline, S];
        fid = fopen(FileName, 'w');
        if fid == -1, error('Cannot open file %s', FileName); end
        fwrite(fid, S, 'char');
        fclose(fid);
    
end 

%% !!!! sound for finish
load gong.mat;
sound(y);
total_time = toc(tStart)  % for the total time
