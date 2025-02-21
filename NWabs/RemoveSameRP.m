%%%%20241210checkOK%%%%
%%%%%%%%
function [ NWlist  ]= RemoveSameRP( NWlist_in ) 

NWlist=NWlist_in;

for IDa =1:1:size(NWlist,1)
    if (  NWlist(IDa,2)==NWlist(IDa,3)  && NWlist(IDa,1)==0 ) %&& NWlist(IDa,4)==0)
        NWlist(IDa,4) = -1;
    end
end

NWlist=NWlist( find( NWlist(:,4)>=0 )  , :);
end