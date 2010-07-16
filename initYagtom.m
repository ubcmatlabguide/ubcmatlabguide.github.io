function initYagtom()
%% Add yagtom to the Matlab path

addpath(fullfile(yagtomRoot(), 'util')); 
addpath(genpathY(yagtomRoot()));
fprintf('YAGTOM Added to path\n'); 


end