classdef MetadataTest < matlab.unittest.TestCase
    % Small test to ensure that metadata are reported correctly
    % also tests inheritance principle: metadata are passed on to lower levels
    % unless they are overriden by metadata already present at lower levels
    
    methods (Test)
        function testMetaDataOnMoAEpilot(this)
            moa_dir = fullfile(bidsut.Common.upstreamDir, 'bids-matlab', ...
                'tests', 'data', 'MoAEpilot');
            
            % Expected output from bids query metadata
            func.RepetitionTime = 7;
            func_sub_01.RepetitionTime = 10;
            anat.FlipAngle = 5;
            anat_sub_01.FlipAngle = 10;
            anat_sub_01.Manufacturer = 'Siemens';
            
            % Get and check metadata
            b = bids.layout(moa_dir);
            
            metadata1 = bids.query(b, 'metadata', 'type', 'bold');
            this.verifyEqual(metadata1.RepetitionTime, func.RepetitionTime);
            
            metadata2 = bids.query(b, 'metadata', 'sub', '01', 'type', 'bold');
            this.verifyEqual(metadata2.RepetitionTime, func_sub_01.RepetitionTime);
            
            metadata3 = bids.query(b, 'metadata', 'type', 'T1w');
            this.verifyEqual(metadata3.FlipAngle, anat.FlipAngle);
            
            metadata4 = bids.query(b, 'metadata', 'sub', '01', 'type', 'T1w');
            this.verifyEqual(metadata4.FlipAngle, anat_sub_01.FlipAngle);
            this.verifyEqual(metadata4.Manufacturer, anat_sub_01.Manufacturer);
        end
    end
    
end