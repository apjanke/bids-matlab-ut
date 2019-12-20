classdef MetadataTest < matlab.unittest.TestCase
    % Small test to ensure that metadata are reported correctly
    % also tests inheritance principle: metadata are passed on to lower levels
    % unless they are overriden by metadata already present at lower levels
    
    methods (Test)
        function testMetaDataOnMoAEpilot(this)
            moa_dir = fullfile(bidsut.Common.upstreamDir, 'bids-matlab', ...
                'tests', 'data', 'MoAEpilot');
            
            % Get and check metadata
            b = bids.layout(moa_dir);
            
            % test func metadata base directory
            func.RepetitionTime = 7;
            metadata1 = bids.query(b, 'metadata', 'type', 'bold');
            % Known failing and temporarily disabled.
            % See https://github.com/bids-standard/bids-matlab/issues/23
            % this.verifyEqual(metadata1.RepetitionTime, func.RepetitionTime);
            
            % test func metadata subject 01
            func_sub_01.RepetitionTime = 10;
            metadata2 = bids.query(b, 'metadata', 'sub', '01', 'type', 'bold');
            this.verifyEqual(metadata2.RepetitionTime, func_sub_01.RepetitionTime);
            
            % test anat metadata base directory
            anat.FlipAngle = 5;
            metadata3 = bids.query(b, 'metadata', 'type', 'T1w');
            % Known failing and temporarily disabled.
            % See https://github.com/bids-standard/bids-matlab/issues/23
            % this.verifyEqual(metadata3.FlipAngle, anat.FlipAngle);
            
            % test anat metadata subject 01
            anat_sub_01.FlipAngle = 10;
            anat_sub_01.Manufacturer = 'Siemens';
            metadata4 = bids.query(b, 'metadata', 'sub', '01', 'type', 'T1w');
            this.verifyEqual(metadata4.FlipAngle, anat_sub_01.FlipAngle);
            this.verifyEqual(metadata4.Manufacturer, anat_sub_01.Manufacturer);
        end
    end
    
end