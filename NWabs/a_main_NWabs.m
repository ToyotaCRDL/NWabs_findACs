%%%%20241210checkOK%%%%
%%%%%%%%
clear all
close all
format short

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Remark:
%The stoichiometric coefficients in the Formose reaction are simply defined.
%All coefficients of NWlist(:,1:3) are 1.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Remark:
%Stoichiometric consistent condition is not needed to be checked in the
%Formose reaction because each group in SpeGroups contain the same number
%of Carbons.
% This is sufficient for the stoichiometric consistent condition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

zc=zc20230112;

mkdir(zc.FolderName);

NWlist0= readmatrix('formose_path_list_formose1_20241112.txt');
%NWlist0= readmatrix('formose_path_list_formose1_20231128.txt');

[ SpeGroups ]= ArrangeGroups( reshape(NWlist0(:,1:3),[],1) );
SaveNW( NWlist0,SpeGroups, 'ori_graph',zc ) ;

[ SpeGroups ]= ArrangeGroups( reshape(NWlist0(:,1:3),[],1) );
[ NWlistA, Species ]= ArrangeNWlist( NWlist0, SpeGroups ); 
SaveNW( NWlistA,SpeGroups, 'graphA',zc ) ;

[ NWlistB,SpeGroups, Species]= IterateMerge( NWlistA ,SpeGroups, Species,zc, 'iso' ) 
[ NWlistC,SpeGroups, Species]= IterateMerge( NWlistB ,SpeGroups, Species,zc, 'sim' )
[ NWlistD,SpeGroups, Species]= IterateMerge( NWlistC ,SpeGroups, Species,zc, 'ter' ) 

SaveNW( NWlistD,SpeGroups, 'abs_graph',zc ) ;

disp('finished')
return