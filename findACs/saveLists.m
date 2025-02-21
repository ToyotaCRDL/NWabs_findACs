%%%%20241210checkOK%%%%
function [err]=saveLists(myfilename,HEADER_ON,latexEq,FeedIDs,NumR,listC,listAC,listMAC,listMACcoef)
err=0;

fileID = fopen(myfilename,'w'); 

if (HEADER_ON==1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf(fileID,'%s \n\n','\documentclass[letter, 12pt]{article}');	
fprintf(fileID,'%s \n\n','\usepackage[top=20truemm,bottom=20truemm,left=20truemm,right=20truemm]{geometry}');	
fprintf(fileID,'%s \n\n','\usepackage[cmex10]{amsmath}');	
fprintf(fileID,'%s \n\n','\title{List of MACs}');	
fprintf(fileID,'%s \n\n','\author{Yuji Ito}');	
fprintf(fileID,'%s \n\n','\date{\today}');	

fprintf(fileID,'%s \n\n','\begin{document}');
fprintf(fileID,'%s \n\n','\maketitle');
fprintf(fileID,'%s \n\n',['\section{Feedstocks: ', num2str(FeedIDs),'}']);

fprintf(fileID,'%s \n','List of reactions: ');
fprintf(fileID,'%s \n','\begin{equation*}\begin{aligned}');
for IDb=1:1:NumR
    fprintf(fileID,'%s \n',[' & ',latexEq{IDb,1},' \\ ' ]);
end%for IDb=1:1:NumR
fprintf(fileID,'%s \n\n','\\ \end{aligned}\end{equation*}');

if(sum(listMAC)>0)    
    fprintf(fileID,'%s \n',['List of minimum autocatalytic cycles: ']);
    for IDa=1:1:(2^NumR)
    if ( listMAC(IDa,1)==1 )
        fprintf(fileID,'%s \n','\begin{equation}\begin{aligned}');    
        for IDb=1:1:NumR
            if (  listMACcoef(IDa,IDb)>0 )       
            fprintf(fileID,'%s \n',[num2str(listMACcoef(IDa,IDb)),' & ','\times \quad ',latexEq{IDb,1},' \\ ' ]);
            end            
        end%for IDb=1:1:NumR
        fprintf(fileID,'%s \n','\\ \end{aligned}\end{equation}');
    end%if ( listMAC(IDa,1)==1 )
    end%for IDa=1:1:solCount

else%if(sum(listMAC)>0)
    fprintf(fileID,'%s \n','There is no minimum autocatalytic cycle.');
end%if(sum(listMAC)>0)


fprintf(fileID,'%s \n\n','');
fprintf(fileID,'%s \n\n',['The number of cycles: $',num2str(sum(listC)),'$']);
fprintf(fileID,'%s \n\n',['The number of autocatalytic cycles: $',num2str(sum(listAC)),'$']);
fprintf(fileID,'%s \n\n',['The number of minimum autocatalytic cycles: $',num2str(sum(listMAC)),'$']);
fprintf(fileID,'%s \n\n','');
fprintf(fileID,'%s \n','\end{document}');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif (HEADER_ON==0)

if(sum(listMAC)>0)    
    for IDa=1:1:(2^NumR)
    if ( listMAC(IDa,1)==1 )
        newline=0;
        fprintf(fileID,'%s \n','\begin{align*}\begin{cases}');         
        for IDb=1:1:NumR
        if (  listMACcoef(IDa,IDb)>0 )  
            if (newline==1)
                fprintf(fileID,'%s \n',[' \\ ']);
            end
            newline=1;

            fprintf(fileID,'%s',[latexEq{IDb,1}]);
       
        end            
        end%for IDb=1:1:NumR
        fprintf(fileID,'%s \n','\end{cases}\end{align*}');

    end%if ( listMAC(IDa,1)==1 )
    end%for IDa=1:1:solCount
end%if(sum(listMAC)>0) 

end%elseif (HEADER_ON==0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fclose(fileID);

return




