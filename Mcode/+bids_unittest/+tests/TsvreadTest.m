classdef TsvreadTest < matlab.unittest.TestCase
    % TsvreadTest Tests bids.util.tsvread
    
    % TODO: Create some sample data files so we can exercise its real code
    
    methods (Test)
        function testBogusInputs(this)
            this.verifyError(@() bids.util.tsvread(), '', 'Missing input errors');
            this.verifyError(@() bids.util.tsvread('/no/such/file/blah/blah.txt'), '', ...
                'tsvread(''/no/such/file'') errors');
        end
        
        function testBasicReading(this)
            orig_cd = pwd;
            RAII.cd = onCleanup(@() cd(orig_cd));
            % TODO: Would probably be better to use full paths instead of a
            % cd
            cd(fullfile(bids_unittest.Common.dataDir, 'tsvread'));
            
            % These tests of reading magic should condense correctly
            % because the values are all numeric
            m = magic(4); % I hope this is deterministic -apjanke
            
            x = bids.util.tsvread('magic.csv');
            this.verifyEqual(x, m, 'magic.csv worked');
            
            x = bids.util.tsvread('magic.csv.gz');
            this.verifyEqual(x, m, 'magic.csv.gz worked');
            
            x = bids.util.tsvread('magic.mat');
            this.verifyEqual(x, m, 'magic.mat worked');
            
            x = bids.util.tsvread('magic.txt');
            this.verifyEqual(x, m, 'magic.txt worked');
            
            foo = struct(...
                'a', {{'foo','bar','baz'}'}, ...
                'b', {[1 3 5]'}, ...
                'c', {[2 4 6]'});
            x = bids.util.tsvread('foo.csv');
            this.verifyEqual(x, foo, 'foo.csv worked');
            
            x = bids.util.tsvread('foo.json');
            this.verifyNotEmpty(x, 'foo.json returned something');
            
            this.verifyError(@() bids.util.tsvread('helloworld.markdown'), '', ...
                'Unrecognized file format errors');

            this.verifyError(@() bids.util.tsvread('helloworld.markdown.gz'), '', ...
                'Unrecognized file format inside .gz errors');
            
        end
        
    end
end