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

suite = TestSuite.fromPackage('bidsut.tests', 'IncludingSubpackages', true);

runner = TestRunner.withTextOutput;
reportFile = 'coverage.xml';
coveragePlugin = CodeCoveragePlugin.forPackage('bids', ...
    'Producing',CoberturaFormat(reportFile), ...
    'IncludingSubpackages', true);
runner.addPlugin(coveragePlugin);

out = runner.run(suite);

end