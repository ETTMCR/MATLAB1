
c = (fileread('email txt.txt'));
str = c;
%% gives indexes of where exp is
exp_mail =('<cite class="ng-binding">'); %25 chars
a= strfind(c,exp_mail); % this line gives the indexes of where
  %a=strfind(c,'<cite class="ng-binding">+[aeiou]+</cite>');% ans = 0
 start_here = a(1) ;
 %aa= [1:(length(a))];
 aa = repmat('',[(length(a))])
 %aa = '';
 %i=0;
 str_b=('');
  y =('');
 for i=1:(length(a))
     temp =  ((a(i)))+25 % exp_mail # of chars
     %while c((a(i))+1) ~='<'
     while c(temp) ~='<'      
         
         y =(c(temp));
         temp = temp + 1;
         %str_b=str_b+(c(temp)); % writing a word
         str_b = [str_b y];
        %disp( str_b)
     end
      y =('');
      strr = string(str_b)
     aa{i}=char(strr);
     str_b=('');

 end
      
