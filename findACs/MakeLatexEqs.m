%%%%20241210checkOK%%%%
%%%%20220615checkOK%%%%
function [latexEq]=MakeLatexEqs(Rcoef,SpeName)

NumR=size(Rcoef,1);
NumC=size(Rcoef,2);

latexEq=cell(NumR,1);
for IDa=1:1:NumR    
    latexEqLHS=[];
    latexEqRHS=[];
    for IDb=1:1:NumC  

        if ( abs(Rcoef(IDa,IDb))>1  )
            strCoef=num2str(abs(Rcoef(IDa,IDb)));
        elseif ( abs(Rcoef(IDa,IDb))==1  )
            strCoef=' ';
        else
            strCoef='NotUsed';
        end

        if     (  Rcoef(IDa,IDb)<0 )     

            if (isempty(latexEqLHS))
                str_plus=' ';
            else
                str_plus=' +';
            end

            latexEqLHS=[latexEqLHS,str_plus,strCoef, ' \mathrm{ ', SpeName{IDb} ' } '];        
        elseif (  Rcoef(IDa,IDb)>0 ) 

            if (isempty(latexEqRHS))
                str_plus=' ';
            else
                str_plus=' +';
            end

            latexEqRHS=[latexEqRHS,str_plus,strCoef, ' \mathrm{ ', SpeName{IDb} ' } '];
        end

    end%for IDb=1:1:NumC        
    latexEq{IDa,1}=[latexEqLHS,' \to ',latexEqRHS];
end%for IDa=1:1:NumR    

end
