%%%%20241210checkOK%%%%
%%%%20220902checkOK%%%%

clear all
set(0,'defaultAxesFontName','Times New Roman');
set(0,'defaultTextFontName','Times New Roman');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



ANWlist = readcell('abstractedNWlist_20241210.txt')
SpeName=ANWlist(1,:)'
SpeName = strrep(SpeName,'I','i');%%Because 'i' is regarded as a complex number, we read 'I' and modify it as 'i'.%%

NumC=length(SpeName);
Rcoef_read=cell2mat(ANWlist(2:end,:))

FeedIDs=[1];%%must be a scalar or row vector [1,2,...]%%
if (strcmp(SpeName{FeedIDs},'C1'))
else
    disp('err')
    pause 
end
SpeIDs=[2:1:NumC]';%%remove FeedIDs from [1:NumC]%%

[Rcoef,NumR]=AutonomousConditions(Rcoef_read,SpeIDs);
 

[latexEq]=MakeLatexEqs(Rcoef,SpeName);

[listC]=FindCycles(Rcoef,FeedIDs);
[listAC,listACcoef]=FindAutocatalyticCycles(Rcoef,FeedIDs,listC);
[listMAC,listMACcoef]=FindMinimumAutocatalyticCycles_v2(Rcoef,listAC,listACcoef);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[err]=saveLists('MAC_list_standalone.tex',1,latexEq,FeedIDs,NumR,listC,listAC,listMAC,listMACcoef);
[err]=saveLists('MAC_list.tex'           ,0,latexEq,FeedIDs,NumR,listC,listAC,listMAC,listMACcoef);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

return


