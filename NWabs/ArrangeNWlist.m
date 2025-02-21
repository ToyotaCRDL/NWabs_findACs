%%%%20241210checkOK%%%%
%%%%checkOK20230119%%%%
function [ NWlist, Species ]= ArrangeNWlist( NWlist_in, SpeGroups ) 




NWlist=NWlist_in;
for IDa=1:1:size(SpeGroups,1)
    for IDb=2:1:size(SpeGroups,2)
        if (SpeGroups(IDa,IDb)>0)
            IDs=find( NWlist==SpeGroups(IDa,IDb) );
            NWlist(IDs)=SpeGroups(IDa,1);
        end
    end
end

%%%%for check%%%%%%%%for check%%%%
NWlist_v=reshape(NWlist_in(:,1:3),[],1);
for IDa=1:1:size(SpeGroups,1)
    for IDb=2:1:size(SpeGroups,2)
        IDs=find( (NWlist_v==SpeGroups(IDa,IDb)).*(NWlist_v>0) );
        NWlist_v(IDs)=SpeGroups(IDa,1);
    end
end
NWlist_check=[reshape(NWlist_v,size(NWlist_in,1),3),NWlist_in(:,4)];
if ( max(max(abs(NWlist_check-NWlist)))>0  )
    disp('err');
    pause;
end
%%%%for check%%%%%%%%for check%%%%

NWlist= RemoveSamePaths( NWlist );
NWlist= RemoveSameRP( NWlist );


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%sort reaction pathways%%%%
NWlist=[sort(NWlist(:,1:2),2,'ascend'),NWlist(:,3:4)];

[~,Myidx]=sort(NWlist(:,3),'ascend');
NWlist=NWlist(Myidx,:);
[~,Myidx]=sort(NWlist(:,2),'ascend');
NWlist=NWlist(Myidx,:);
[~,Myidx]=sort(NWlist(:,1),'ascend');
NWlist=NWlist(Myidx,:);
[~,Myidx]=sort(NWlist(:,4),'ascend');
NWlist=NWlist(Myidx,:);
%%%%sort reaction pathways%%%%





%%%%get all species in NWlist%%%%
Species=sort(unique(reshape(NWlist(:,1:3),[],1)));
Species=Species(find(Species>0));
%%%%get all species in NWlist%%%%

%%%%for check%%%%
if(   max(max( sort(Species) - sort(SpeGroups(:,1)) ))>0     )   
Species
SpeGroups
disp('err')
pause
end

%%%%%%%%%%%%%%%%%

%%%%Error if some species is contained in both reactant and product in some path%%%%
for IDa=1:1:size(NWlist,1)
    IS=intersect(NWlist(IDa,1:2),NWlist(IDa,3));
    if (length(IS)>0)
        NWlist
        disp('err')
        pause
    end
end
%%%%Error if some species is contained in both reactant and product in some path%%%%

end