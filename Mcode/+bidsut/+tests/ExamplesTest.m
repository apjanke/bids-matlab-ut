classdef ExamplesTest < matlab.unittest.TestCase
    % ExamplesTest Tests all the examples in bids-examples
    
    properties (TestParameter)
        exampleName = bidsut.tests.ExamplesTest.getExampleNames;
    end
    
    methods (Static)
        function out = getExampleNames
            bids_examples_dir = fullfile(bidsut.Common.upstreamDir, ...
                'bids-examples');
            [files,d] = bidsut.Util.readdir(bids_examples_dir);
            tf_dir = [d.isdir];
            subdirs = files(tf_dir);
            tf_exclude = startsWith(subdirs, '.');
            out = subdirs(~tf_exclude);
        end
    end
    
    methods
        function this = ExamplesTest()
        end
    end
    
    methods (Test)
        function testExample(this, exampleName)
            bids_examples_dir = fullfile(bidsut.Common.upstreamDir, ...
                'bids-examples');
            example_dir = fullfile(bids_examples_dir, exampleName);
            try
                b = bids.layout(example_dir);
            catch err
                this.verifyFail(sprintf('Error raised when reading BIDS directory: %s', ...
                    err.message));
            end
        end
    end
    
end