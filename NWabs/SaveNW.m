%%%%20241210checkOK%%%%
%%%%checkOK20230119%%%%
function [ err ]= SaveNW( NWlist,SpeGroups, FileName ,zc) 

        [ err ]= GetPathListTex(NWlist,[zc.FolderName,FileName,'_list.tex'],0);
        [ err ]= GetPathListTex(NWlist,[zc.FolderName,FileName,'_list_standalone.tex'],1);


end