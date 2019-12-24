classdef JsonRoundtripTest < matlab.unittest.TestCase
    % Tests roundtripping of jsonencode/jsondecode
    
    properties (TestParameter)
        data = {
            []
            struct
            struct('foo', 42)
            struct('foo', 'bar')
            };
    end
    
    methods (Test)
        function testRoundtrip(this, data)
            temp_file = [tempname '.json'];
            bids.util.jsonencode(temp_file, data);
            this.verifyTrue(exist(temp_file, 'file') == 2, 'Output JSON file does not exist');
            try
                got_back = bids.util.jsondecode(temp_file);
                this.verifyEqual(got_back, data, 'Round-tripped data is same as input');
            catch err
                this.verifyFail('Error while decoding JSON data: %s', err.message);
            end
        end
    end
end

