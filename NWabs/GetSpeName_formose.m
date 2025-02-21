%%%%20241210checkOK%%%%
%%%%checkOK20230119%%%%
function [ NameText  ]= GetSpeName_formose( Species ) 


if (Species==0)
    NameText='';
else
    subname='abcdefghijklmn';
    modref=[1,1,2,3,6,11]';
    
    if (fix(Species/100)>=3)
    NameText=['C',num2str(fix(Species/100)),subname(  1+modref(fix(Species/100),1)-mod(Species,100)   )];
    else
    NameText=['C',num2str(fix(Species/100))];
    end

end

end