function out = run_all_tests
% run_all_tests Run all the tests in bids-matlab-ut
%
% rslt = bids_ut.run_all_tests
%
% Examples:
% bids_ut.run_all_tests

import matlab.unittest.TestSuite
import matlab.unittest.TestRunner
import matlab.unittest.plugins.CodeCoveragePlugin
import matlab.unittest.plugins.codecoverage.CoberturaFormat

suite = TestSuite.fromPackage('bids_ut.tests', 'IncludingSubpackages', true);

runner = TestRunner.withTextOutput;
reportFile = 'coverage.xml';
coveragePlugin = CodeCoveragePlugin.forPackage('bids', ...
    'Producing',CoberturaFormat(reportFile), ...
    'IncludingSubpackages', true);
runner.addPlugin(coveragePlugin);

out = runner.run(suite);

end