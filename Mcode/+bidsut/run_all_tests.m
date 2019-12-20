function out = run_all_tests
% run_all_tests Run all the tests in bids-matlab-ut
%
% rslt = bidsut.run_all_tests
%
% Examples:
% bidsut.run_all_tests

import matlab.unittest.TestSuite
import matlab.unittest.TestRunner
import matlab.unittest.plugins.CodeCoveragePlugin
import matlab.unittest.plugins.codecoverage.CoberturaFormat

% This doesn't work because "Package folders are invalid inputs for
% creating test suites." according to Matlab
%tests_dir = fullfile(bidsut.Common.repoRootDir, 'Mcode', '+bidsut', '+tests');
%suite = TestSuite.fromFolder(tests_dir)

% So we'll just list them all manually
% suites = {
%     TestSuite.fromClass(?bidsut.tests.ExamplesTest)
%     TestSuite.fromClass(?bidsut.tests.QueryTest)
%     TestSuite.fromClass(?bidsut.tests.MetadataTest)
%     };
% suite = [suites{:}];

% Oh, wait, this seems to work:

suite = TestSuite.fromPackage('bidsut.tests');

runner = TestRunner.withTextOutput;
reportFile = 'coverage.xml';
coveragePlugin = CodeCoveragePlugin.forPackage('bids', ...
    'Producing',CoberturaFormat(reportFile));
runner.addPlugin(coveragePlugin);

out = runner.run(suite);

end