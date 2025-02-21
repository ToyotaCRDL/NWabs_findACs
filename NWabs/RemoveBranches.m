%%%%20241210checkOK%%%%
%%%%%%%%
function [ NWlist,SpeGroups, Species]= RemoveBranches( NWlist , SpeGroups, Species ) 


bi_dir_ID=find(NWlist(:,4)==0);
Rlist=[NWlist(:,1:2);zeros(length(bi_dir_ID),1),NWlist(bi_dir_ID,3)];

remove_flag=zeros(size(NWlist,1),1);
remove_flag_check=remove_flag;

for IDa =1:1:length(Species)
    if (    max(max( (Rlist(:,:)==Species(IDa) ) ))==0      )

        SpeGroups(SpeGroups==Species(IDa))=0;
        SpeGroups(    (SpeGroups(:,1)==0)  , :)=0;%%If SpeGroups(:,1)==0, the entire group is removed.%%


       % SpeGroups=sort(SpeGroups,2,'descend');%%%%20230119added%%%%

        remove_flag      =remove_flag      +(NWlist(:,3)==Species(IDa));    
        remove_flag_check=remove_flag_check+(NWlist(:,3)==Species(IDa)).*(NWlist(:,4)==1);    
    end
end

if ( max(abs(remove_flag-remove_flag_check))>0 )
    disp('err')
    remove_flag
    remove_flag_check
    pause
end

[ SpeGroups ]= ArrangeGroups( SpeGroups ) ;
NWlist=NWlist((  remove_flag == 0 ),:);
[NWlist, Species ] = ArrangeNWlist( NWlist, SpeGroups ) ;


end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Remark: 
%If NWlist(IDb,1) or NWlist(IDb,2) = Species(IDa), we have either of
%1. If NWlist(IDb,4)=0, Species(IDa) is both reactant and product.
%2. If NWlist(IDb,4)=1, Species(IDa) is a reactant.
%
%If NWlist(IDb,3)=Species(IDa), we have either of
%1. If NWlist(IDb,4)=0, Species(IDa) is both reactant and product.
%2. If NWlist(IDb,4)=1, Species(IDa) is a product. %% path may be removed %%
%
%Therefore, we find the case satisyfing NWlist(IDb,3)=Species(IDa) and NWlist(IDb,4)=1.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%