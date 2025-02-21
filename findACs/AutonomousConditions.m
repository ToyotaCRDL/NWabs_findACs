%%%%20241210checkOK%%%%
%%%%20220615checkOK%%%%
function [Rcoef,NumR]=AutonomousConditions(Rcoef_wtC1Retro,SpeIDs)

%Each reaction must have at least one reactant and product in species.
NumR_all=size(Rcoef_wtC1Retro,1);
autonomous_cond=zeros(NumR_all,1);
for IDa=1:1:NumR_all                
    if ( min(Rcoef_wtC1Retro(IDa,SpeIDs))<0 && max(Rcoef_wtC1Retro(IDa,SpeIDs))>0 )
        autonomous_cond(IDa,:)=1;        
    end
end
Rcoef=Rcoef_wtC1Retro(find(autonomous_cond==1),:);
NumR=size(Rcoef,1);

end