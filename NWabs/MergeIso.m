%%%%20241210checkOK%%%%
%%%%%%%%
function [ NWlist,SpeGroups, Species]= MergeIso( NWlist , SpeGroups, Species ) 


for IDa =1:1:length(Species)
for IDb=1:1:length(Species)
if (IDa~=IDb) 
    for IDc=1:1:size(NWlist,1)

        if (  NWlist(IDc,1)==0                                        && ...
              min( NWlist(IDc,2:3) )== min(Species(IDa),Species(IDb)) && ...
              max( NWlist(IDc,2:3) )== max(Species(IDa),Species(IDb)) && ...
              NWlist(IDc,4)==0                                        ) 
       
            [Species(IDa),Species(IDb) ]
            [NWlist(IDc,:) ]
    
            flag=0;
            for IDd=1:1:size(NWlist,1)
            if (IDc~=IDd) 
               I1=intersect(NWlist(IDd,1:2),[Species(IDa),Species(IDb)]);
               I2=intersect(NWlist(IDd,3),[Species(IDa),Species(IDb)]);
               if ( isempty(I1)==0 && isempty(I2)==0)
                   flag=1;
                   pause               
               end    
            end
            end
            
            if (flag==0)
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
end



end