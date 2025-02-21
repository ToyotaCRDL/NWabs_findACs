%%%%20241210checkOK%%%%
%%%%20220902checkOK%%%%
function [listAC,listACcoef]=FindAutocatalyticCycles(Rcoef,FeedIDs,listC)

NumR=size(Rcoef,1);
NumC=size(Rcoef,2);

Num2powR=(2^NumR);

listAC=zeros(Num2powR,1);
listACcoef=zeros(Num2powR,NumR);

for IDa=1:1:Num2powR
if ( listC(IDa,1)==1 )
    disp(['FindAutocatalyticCycles: ',num2str(IDa),'/',num2str(Num2powR)]);

    [nowIDs,dimR,vecID]=GetIDs(IDa,NumR);
    %disp(vecID');
    Ccandi=Rcoef(nowIDs,:);%%list of active reactions

   
    %%%%check connection conditions%%%%
    %%%%check feed conditions%%%%
    feed_cond=0;
    if ( dimR>1 )%&& connect_cond>0
        feed_cond=1;
        for IDb=1:1:length(FeedIDs)
            if (   min(Ccandi(:,FeedIDs(IDb))) >=0 )% if IDb-th feed is not used in the cycle
                feed_cond=0;                
            end
        end
    end
    %%%%check feed conditions%%%%
    
    %%%%solve LP%%%%%%%%solve LP%%%%%%%%solve LP%%%%%%%%solve LP%%%%
    if ( feed_cond>0)

    
        Aineq=-Ccandi';
        Aineq(FeedIDs,:)=-Aineq(FeedIDs,:);
        bineq=zeros(NumC,1);
        bineq(FeedIDs,1)=-1;
        xUB=inf*ones(dimR,1);
        xLB=ones(dimR,1);
    
        [x_sol,fval,exitflag] = linprog(ones(dimR,1),Aineq,bineq,[],[],xLB,xUB);
        if (exitflag==1)%%if there exists a feasible solution
            listAC(IDa,1)=1;
            
            tempV=zeros(1,NumR);
            tempV(1,nowIDs)=x_sol;
                   
            normalizingVal=(min( abs(tempV).*(abs(tempV)>1.0e-6)+ 100.*(abs(tempV)<=1.0e-6)  ));
            listACcoef(IDa,:)=tempV/normalizingVal;
            
        else%if (exitflag==1)
            exitflag
            disp('Check the exactness of finding feasible initial solutions in LP of MATLAB!!');
            
            Ccandi

             
            [x_sol2,fval,exitflag2] = linprog([zeros(dimR,1);1],[Aineq,-1*ones(NumC,1)],bineq,[],[],[xLB;-1],[xUB;inf]);
            if (exitflag2==1)
                if (x_sol2(dimR+1)<=0.1)
                x_sol2
                disp('ERR: A feasible initial solution is found');
                pause
                else
                x_sol2
                disp('OK: A feasible initial solution is not found');
                %pause
                end
            else
                exitflag2
                disp('exitflag2 Check the exactness of finding feasible initial solutions in LP of MATLAB!!');
                pause
            end



        end%if (exitflag==1)

        
    end % if ( connect_cond*feed_cond*reverse_cond>0)
    %%%%solve LP%%%%%%%%solve LP%%%%%%%%solve LP%%%%%%%%solve LP%%%%

end%if ( listC(IDa,1)==1 )
end% for IDa=1:1:(2^NumR)
       

end