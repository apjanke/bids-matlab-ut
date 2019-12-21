classdef Discovery
    % Discovery Methods for test discovery
    
    methods (Static)
        function out = getExampleNames
            bids_examples_dir = fullfile(bids_ut.Common.upstreamDir, ...
                'bids-examples');
            [files,d] = bids_ut.Util.readdir(bids_examples_dir);
            tf_dir = [d.isdir];
            subdirs = files(tf_dir);
            tf_exclude = startsWith(subdirs, '.');
            out = subdirs(~tf_exclude);
        end
    end
    
end