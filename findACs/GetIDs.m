%%%%20241210checkOK%%%%
%%%%20220902checkOK%%%%
function [nowIDs,dimR,vecID]=GetIDs(IDa,NumR)

biID = dec2bin(IDa-1,NumR);    
%disp(biID);

vecID=zeros(NumR,1);
for IDb=1:1:NumR
    vecID(IDb,1)=str2double(biID(IDb));
end
nowIDs=(find(vecID==1));%%indices of active reactions
 
dimR=length(nowIDs);
%pause

end
