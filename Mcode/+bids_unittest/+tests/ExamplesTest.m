classdef ExamplesTest < matlab.unittest.TestCase
    % ExamplesTest Tests all the examples in bids-examples
    
    properties (TestParameter)
        exampleName = bids_unittest.tests.ExamplesTest.getExampleNames;
    end
    
    methods (Static)
        function out = getExampleNames
            bids_examples_dir = fullfile(bids_unittest.Common.upstreamDir, ...
                'bids-examples');
            [files,d] = bids_unittest.Util.readdir(bids_examples_dir);
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
            bids_examples_dir = fullfile(bids_unittest.Common.upstreamDir, ...
                'bids-examples');
            example_dir = fullfile(bids_examples_dir, exampleName);
            
            % Read the example directory layout
            try
                b = bids.layout(example_dir);
            catch err
                this.assertFail(sprintf('Error raised when reading BIDS directory: %s', ...
                    err.message));
            end
            
            % Do some basic queries
            % We'll just check that these queries run without error,
            % instead of checking their results; that's done in
            % MetadataTest.
            try
                md = bids.query(b, 'metadata');
                this.verifyNotEmpty(md, 'metadata from bids.query was empty');
            catch err
                this.verifyFail(sprintf('Error on bids.query(b, ''metadata''): %s', ...
                    err.message));
            end
            
            % See if report runs
            
            % These are known empty because they contain EEG data that is
            % not yet supported by bids.report.
            % See https://github.com/bids-standard/bids-matlab/issues/35
            expectedEmptyReports = {
                'ieeg_filtered_speech'
                'ieeg_motorMiller2007'
                };
            try
                rpt = evalc('bids.report(b)');
                if ismember(exampleName, expectedEmptyReports)
                    this.verifyEmpty(rpt, 'Report was empty, as expected');
                else
                    this.verifyNotEmpty(rpt, 'Report was not empty');
                end
            catch err
                this.verifyFail(sprintf('Error on bids.report(b): %s', ...
                    err.message));
            end
        end
    end
    
end