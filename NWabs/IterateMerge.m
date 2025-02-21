%%%%20241210checkOK%%%%
%%%%%%%%
function [ NWlist,SpeGroups, Species]= IterateMerge( NWlist ,SpeGroups, Species,zc, MERGE_TYPE ) 



tmp_count=0;
while 1
    tmp_count=tmp_count+1;
    NWlist_pre=NWlist;


    switch MERGE_TYPE
    case 'iso' 
        [ NWlist,SpeGroups, Species]= MergeIso( NWlist ,SpeGroups, Species ); 
    case 'sim'
        [ NWlist,SpeGroups, Species]= MergeSimilar( NWlist ,SpeGroups, Species ); 
    case 'ter'
        [ NWlist,SpeGroups, Species]= RemoveBranches( NWlist ,SpeGroups, Species ); 

    
    end

    
    
    if ( size(NWlist,1)==size(NWlist_pre,1) )
    if ( max(max(abs(NWlist-NWlist_pre)))==0 )
        if (strcmp(MERGE_TYPE,'rand')==0)
        break
        end
    end
    end

    [ err ]= SaveNW( NWlist,SpeGroups, ['graph_',MERGE_TYPE,num2str(tmp_count)],zc ) ;    
end
[ err ]= SaveNW( NWlist,SpeGroups, ['graph_',MERGE_TYPE],zc ) ;



end