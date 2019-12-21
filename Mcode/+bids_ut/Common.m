classdef Common
    % Common Properties and common code for the bids-matlab-ut library
    
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
            out = fullfile(bids_ut.Common.repoRootDir, 'upstream');
        end
        
        function out = examplesDir
            out = fullfile(bids_ut.Common.upstreamDir, 'bids-examples');
        end
        
        function out = dataDir
            out = fullfile(bids_ut.Common.repoRootDir, 'data');
        end
        
        function fetchUpstreamCode
            repos = {
                'bids-matlab'
                'bids-examples'
                };
            upstream_dir = bids_ut.Common.upstreamDir;
            origDir = pwd;
            RAII.cd = onCleanup(@() cd(origDir));
            cd(upstream_dir);
            fprintf('Fetching upstream code\n');
            for i = 1:numel(repos)
                repo = repos{i};
                if exist(repo, 'dir')
                    rmdir(repo, 's');
                end
                repo_url = ['https://github.com/bids-standard/' repo];
                cmd = sprintf('git clone %s', repo_url);
                [status,msg] = system(cmd);
                if status ~= 0
                    error('Failed cloning repo %s: %s', repo_url, msg);
                end
                fprintf('Fetched repo %s from %s\n', repo, repo_url);
            end
        end
    end
    
end