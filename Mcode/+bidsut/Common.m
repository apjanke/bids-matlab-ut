classdef Common
    % Common Properties for the bids-matlab-ut library
    
    methods (Static)
        
        function out = repoRootDir
            persistent val
            if isempty(val)
                mcode_dir = fileparts(fileparts(mfilename('fullpath')));
                repo_root_dir = fileparts(mcode_dir);
                val = repo_root_dir;
            end
            out = val;
        end
        
        function out = upstreamDir
            out = fullfile(bidsut.Common.repoRootDir, 'upstream');
        end
        
        function out = examplesDir
            out = fullfile(bidsut.Common.upstreamDir, 'bids-examples');
        end
        
        function out = dataDir
            out = fullfile(bidsut.Common.repoRootDir, 'data');
        end
    end
    
end