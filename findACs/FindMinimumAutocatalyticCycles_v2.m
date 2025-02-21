%%%%20241210checkOK%%%%
%%%%20220902checkOK%%%%
function [listMAC,listMACcoef]=FindMinimumAutocatalyticCycles_v2(Rcoef,listAC,listACcoef)

NumR=size(Rcoef,1);
Num2powR=(2^NumR);

listMAC=zeros(Num2powR,1);
listMACcoef=zeros(Num2powR,NumR);

listACids=find(listAC(:,1)==1);
NumlistACids=length(listACids);


vecIDlist=zeros(NumlistACids,NumR);
for IDc=1:1:NumlistACids
    IDa=listACids(IDc,1);
    [~,~,vecID]=GetIDs(IDa,NumR);
    vecIDlist(IDc,:)=vecID';
end


for IDc=1:1:NumlistACids
%if ( listAC(IDa,1)==1 )
    disp(['FindMinimumAutocatalyticCycles: ',num2str(IDc),'/',num2str(NumlistACids)]);
    IDa=listACids(IDc,1);

    vecIDlist_diff=(ones(NumlistACids,1)*vecIDlist(IDc,:)) - vecIDlist;

    vecIDlist_diff_min=min(vecIDlist_diff,[],2);

    Num_innerAC=sum(vecIDlist_diff_min==0);

%%each row of vecIDlist_diff:
%%if each AC is strictly contained this AC of IDc,  (vecIDlist(IDc,:)-vecIDlist) >= 0 (0 or 1)
%%if each AC is                    this AC of IDc,  (vecIDlist(IDc,:)-vecIDlist) =  0 (only 0)
%%if each AC is not contained in   this AC of IDc,  (vecIDlist(IDc,:)-vecIDlist) >= -1 (-1, 0, or 1)

%%each row of vecIDlist_diff_min:
%%if each AC is contained this AC of IDc,        min(vecIDlist(IDc,:)-vecIDlist) = 0
%%if each AC is not contained in this AC of IDc, min(vecIDlist(IDc,:)-vecIDlist) = -1

%%if Num_innerAC > 1, this AC of IDc contains itself and other ACs.
%%if Num_innerAC == 1, this AC of IDc contains only itself.
%%if Num_innerAC < 1, ERR


    if (Num_innerAC>1)
    elseif  (Num_innerAC==1)
        listMAC(IDa,1)=1;
         listMACcoef(IDa,:)= listACcoef(IDa,:);
    else
        disp('ERR')
        pause
    end

%end%if ( listAC(IDa,1)==1 )
end% for IDa=1:1:(2^NumR)
       

end