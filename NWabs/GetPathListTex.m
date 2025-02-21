%%%%20241210checkOK%%%%
%%%%20230119checkOK%%%%
function [err]=GetPathListTex(NWlist,FileName,HEADER)
err=0;

NumPath=size(NWlist,1);

fileID = fopen(FileName,'w'); 

if (HEADER==1)
    fprintf(fileID,'%s \n','\documentclass[letter, 12pt]{article}');
    fprintf(fileID,'%s \n','\usepackage[top=20truemm,bottom=20truemm,left=20truemm,right=20truemm]{geometry}');
    fprintf(fileID,'%s \n','\usepackage{amsmath}');
    fprintf(fileID,'%s \n','\usepackage{amssymb}');
    fprintf(fileID,'%s \n','\usepackage{amsthm}');
    fprintf(fileID,'%s \n','\usepackage{cases}');
    fprintf(fileID,'%s \n','\usepackage[usenames]{color}');
    fprintf(fileID,'%s \n','\begin{document}');
end

fprintf(fileID,'%s \n','\begin{align*}');

for IDa=1:1:NumPath
    Name1=GetSpeName_formose(NWlist(IDa,1));
    Name2=GetSpeName_formose(NWlist(IDa,2));
    Name3=GetSpeName_formose(NWlist(IDa,3));
    if (NWlist(IDa,4)==1)
        Arrow='\rightarrow';
    else
        Arrow='\leftrightarrows';
    end

    if (strcmp(Name1,''))
        fprintf(fileID,'%s \n',[                     ' \mathrm{',Name2,'} & ',Arrow,' \mathrm{',Name3,'}']);  
    elseif (strcmp(Name1,Name2))
        fprintf(fileID,'%s \n',['              2       \mathrm{',Name2,'} & ',Arrow,' \mathrm{',Name3,'}']);  
    else
        fprintf(fileID,'%s \n',[' \mathrm{',Name1,'} + \mathrm{',Name2,'} & ',Arrow,' \mathrm{',Name3,'}']);  
    end


    if (IDa<NumPath)
        fprintf(fileID,'%s \n',[',\\']);  
    else
        fprintf(fileID,'%s \n',['.']);  
    end

end%for IDa=1:1:NumPath

fprintf(fileID,'%s \n','\end{align*}');

if (HEADER==1)
    fprintf(fileID,'%s \n','\end{document}');
end

fclose(fileID);
return
