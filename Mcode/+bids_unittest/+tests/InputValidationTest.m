classdef InputValidationTest < matlab.unittest.TestCase
    % Tests various input-validation scenarios
    
    methods (Test)
        function testBadLayoutInputs(this)
            aMap = containers.Map;
            this.verifyError(@() bids.layout(aMap), '', ...
                'bids.layout(containers.Map) errors');

            this.verifyError(@() bids.layout('/blah/blah/no/such/directory'), '', ...
                'bids.layout(''/no/such/dir'') errors');
            
        end
        
        function testBogusDescriptionJson(this)
            pid = feature('getpid');
            myTempDir = fullfile(tempname, 'bids_unnittest', num2str(pid));
            layoutDir = fullfile(myTempDir, 'bogus_layout');
            bids_unittest.Util.mkdir(layoutDir);
            descrFile = fullfile(layoutDir, 'dataset_description.json');
            
            not_json = 'blah blah blah';
            bids_unittest.Util.spew(descrFile, not_json);
            this.verifyError(@() bids.layout(layoutDir), '', ...
                'bids.layout(x) with non-JSON description errors');
            
            bids_unittest.Util.spew(descrFile, '{}');
            this.verifyError(@() bids.layout(layoutDir), '', ...
                'bids.layout(x) with empty description JSON field errors');
            
            bids_unittest.Util.spew(descrFile, '{"Name":"foo"}');
            this.verifyError(@() bids.layout(layoutDir), '', ...
                'bids.layout(x) with description missing BIDSVersion field errors');
            
            bids_unittest.Util.spew(descrFile, '{"BIDSVersion":"1.0"}');
            this.verifyError(@() bids.layout(layoutDir), '', ...
                'bids.layout(x) with description missing Name field errors');
        end
        
        function testBadLayouts(this)
            % Test that various bad layout dir structures error correctly
            
            % Test empty dir error
            pid = feature('getpid');
            myTempDir = fullfile(tempname, 'bids_unnittest', num2str(pid));
            bids_unittest.Util.mkdir(myTempDir);

            emptyDir = fullfile(myTempDir, 'empty_dir');
            bids_unittest.Util.mkdir(emptyDir);
            this.verifyError(@() bids.layout(emptyDir), '', ...
                'bids.layout(someEmptyDir) errors');
            
            noSubjectsLayoutDir = fullfile(myTempDir, 'bad_layout');
            bids_unittest.Util.mkdir(noSubjectsLayoutDir);
            bids_unittest.Util.spew(fullfile(noSubjectsLayoutDir, 'dataset_description.json'), ...
                '{"BIDSVersion":"1.0", "Name":"NoSubjects"}');
            try
                [~] = bids.layout(noSubjectsLayoutDir);
                this.verifyFail('bids.layout(noSubjectsLayoutDir) errors');
            catch err
                this.verifyTrue(true, 'bids.layout(noSubjectsLayoutDir) errors');
                this.verifyMatches(err.message, 'No subjects found in BIDS dir');
            end
        end
    end
    
end



    