function publishSource(fname)
%% Publish the tutorial to the html directory
% If fname is specified, only it is published
%  (run initYagtom before calling this function)
% e.g publishSource('gettingStarted)
%%
initYagtom(); 
cd(fullfile(yagtomRoot(), 'html')); 
src = fullfile(yagtomRoot, 'source'); 

if nargin > 0
    if ~endswith(fname, '.m')
        fname = [fname, '.m'];
    end
    publishFile(fullfile(src, fname));
else
    sfiles = filelist(src, '*.m');
    for i=1:numel(sfiles)
        publishFile(sfiles{i});
    end
end
close all;



end


function publishFile(f)
%% Publish a single file
opts.format = 'html';
opts.outputDir = fullfile(yagtomRoot(), 'html'); 
opts.createThumbnail = false; 
publish(f, opts); 
end