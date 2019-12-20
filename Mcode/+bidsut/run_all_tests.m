function run_all_tests
% run_all_tests Run all the tests in bids-matlab-ut
%
% Examples:
% bidsut.run_all_tests

import matlab.unittest.TestSuite

% This doesn't work because "Package folders are invalid inputs for
% creating test suites." according to Matlab
%tests_dir = fullfile(bidsut.Common.repoRootDir, 'Mcode', '+bidsut', '+tests');
%suite = TestSuite.fromFolder(tests_dir)


suites = {
    TestSuite.fromClass(?bidsut.tests.ExamplesTest)
    TestSuite.fromClass(?bidsut.tests.QueryTest)
    TestSuite.fromClass(?bidsut.tests.MetadataTest)
    };
suite = [suites{:}];

suite.run;

end