%%%%20241210checkOK%%%%
%%%%checkOK20230119%%%%
function [ SpeGroups ]= ArrangeGroups( SpeGroups ) 
SpeGroups=sort(SpeGroups,2,'descend');
SpeGroups_pre=SpeGroups;    

SpeGroups=[SpeGroups,zeros( size(SpeGroups,1) , length(unique(SpeGroups))  )];


%maxunion=1;
while 1
    for IDa=1:1:size(SpeGroups,1)
    for IDb=IDa+1:1:size(SpeGroups,1)
        interSet=intersect(SpeGroups(IDa,:),SpeGroups(IDb,:));
        interSet=interSet(find(interSet>0));
        if (length(interSet)>0)        
            unionSet=unique(union(SpeGroups(IDa,:),SpeGroups(IDb,:))); 
            unionSet=unionSet(find(unionSet>0));
            SpeGroups(IDa,:)=0;
            SpeGroups(IDa,1:length(unionSet))=unionSet;
            SpeGroups(IDb,:)=0;
            %maxunion=max(maxunion,length(unionSet));
        end
    end
    end

    SpeGroups=sort(SpeGroups,2,'descend');%%%%20230119added%%%%


    columnsize=sum(max(SpeGroups>0));%maxunion
    SpeGroups=SpeGroups(find(sum(SpeGroups,2)>0),1:columnsize); 
    
    if (size(SpeGroups,1)==size(SpeGroups_pre,1))
    if (max(max(abs(SpeGroups-SpeGroups_pre)))==0)
        break
    end
    end

    SpeGroups_pre=SpeGroups;    
end


SpeGroups=sort(SpeGroups,2,'descend');


%[~,Myidx]=sort(SpeGroups(:,1),'ascend');%%%%20231121added%%%%
%SpeGroups=SpeGroups(Myidx,:)%%%%20231121added%%%%



end