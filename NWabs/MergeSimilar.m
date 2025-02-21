%%%%20241210checkOK%%%%
%%%%checkOK20230119%%%%
function [ NWlist,SpeGroups, Species]= MergeSimilar( NWlist , SpeGroups, Species ) 

%SpeGroups=SpeGroups_in;
%[NWlist , Species] = ArrangeNWlist( NWlist_in, SpeGroups ) ;

bi_dir_ID=find(NWlist(:,4)==0);
Rlist=[NWlist(:,1:2);zeros(length(bi_dir_ID),1),NWlist(bi_dir_ID,3)];
Plist=[zeros(size(NWlist,1),1),NWlist(:,3);NWlist(bi_dir_ID,1:2)];





for IDa =1:1:length(Species)
for IDb=1:1:length(Species)
if (IDa~=IDb) 
    [ flag1 ]= SimilarityCondition( IDa , IDb , Plist, Rlist, Species ); 
    [ flag2 ]= SimilarityCondition( IDb , IDa , Plist, Rlist, Species ); 
    [ flag3 ]= SimilarityCondition( IDa , IDb , Rlist, Plist, Species ); 
    [ flag4 ]= SimilarityCondition( IDb , IDa , Rlist, Plist, Species ); 

    merge_flag=0;

    if (flag1==1 && flag2==1)%Psim
        merge_flag=merge_flag+1;
    end
    if (flag3==1 && flag4==1)%Rsim
        merge_flag=merge_flag+1;
    end
    if (flag2==1 && flag4==1)%PRinc
        merge_flag=merge_flag+1;
    end


    if (merge_flag>=1)
        SpeGroups_tmp=[SpeGroups,zeros(size(SpeGroups,1),2)];
        SpeGroups_tmp=[SpeGroups_tmp;Species(IDa),Species(IDb),zeros(1,size(SpeGroups_tmp,2)-2)];

        [ SpeGroups ]= ArrangeGroups( SpeGroups_tmp ) ;
        [NWlist , Species] = ArrangeNWlist( NWlist, SpeGroups ) ;
        return
    end

end
end
end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ flag ]= SimilarityCondition( IDa , IDb , SetA, SetB, Species ) 
    flag=-1;
    for IDc=1:1:size(SetA,1)
    if (  max( SetA(IDc,:) == Species(IDa) )==1 )
        sub_flag=0;
        for IDd=1:1:size(SetA,1)
        if (  max( SetA(IDd,:) == Species(IDb) )==1 )

            sub_flag=sub_flag+...
            (  max(abs(  sort(SetB(IDc,:))-sort(SetB(IDd,:)) ))==0 )...
            *(...
            max(abs( ...
            sort(   SetA(IDc,:).*( SetA(IDc,:) ~= Species(IDa) )    )- ...
            sort(   SetA(IDd,:).*( SetA(IDd,:) ~= Species(IDb) )    )...
            ))==0 ...
            );

        end
        end           
        flag=abs(flag)*(sub_flag>0);
    end
    end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

