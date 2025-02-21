%%%%20241210checkOK%%%%
%%%%20220902checkOK%%%%
function [listC]=FindCycles(Rcoef,FeedIDs)

NumR=size(Rcoef,1);
NumC=size(Rcoef,2);
Num2powR=(2^NumR);

listC=zeros(Num2powR,1);

for IDa=1:1:Num2powR
    disp(['FindCycles: ',num2str(IDa),'/',num2str(Num2powR)]);

    [nowIDs,dimR,vecID]=GetIDs(IDa,NumR);
    %disp(vecID');
    Ccandi=Rcoef(nowIDs,:);%%list of active reactions

    %%%%check connection conditions%%%%
    connect_cond=0;
    if ( dimR>1)
        connect_cond=1;
        for IDb=1:1:NumC
            if ( min(abs(FeedIDs-IDb))>0  ) %if IDb is not feed%
            if ( max(abs( Ccandi(:,IDb) ))>0  ) %if IDb is a reactant and/or product%
            if ( min( Ccandi(:,IDb) )*max( Ccandi(:,IDb) )==0  ) %if IDb is not both reactant and product%
                connect_cond=0;
            end
            end
            end
        end
    end
    %%%%check connection conditions%%%%
   
    if ( connect_cond>0)
        listC(IDa,1)=1;
    end % if ( connect_cond*feed_cond*reverse_cond>0)

end% for IDa=1:1:Num2powR
       

end