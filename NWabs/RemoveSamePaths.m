%%%%20241210checkOK%%%%
%%%%checkOK20230119%%%%
function [ NWlist  ]= RemoveSamePaths( NWlist_in ) 

NWlist=NWlist_in;


for IDa =1:1:size(NWlist,1)
for IDb =IDa+1:1:size(NWlist,1)
    if (  max(abs(NWlist(IDa,1:3)-NWlist(IDb,1:3) )) ==0 && min( NWlist(IDa,4),NWlist(IDb,4) ) >=0 )
       NWlist(IDa,4) = min( NWlist(IDa,4),  NWlist(IDb,4) );
       NWlist(IDb,4) = -1;
    end
end
end
NWlist=NWlist( find( NWlist(:,4)>=0 )  , :);



end