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
import matlab.unittest.plugins.XMLPlugin;

suite = TestSuite.fromPackage('bids_ut.tests', 'IncludingSubpackages', true);

runner = TestRunner.withTextOutput;
reportFile = 'coverage.xml';
coveragePlugin = CodeCoveragePlugin.forPackage('bids', ...
    'Producing',CoberturaFormat(reportFile), ...
    'IncludingSubpackages', true);
runner.addPlugin(coveragePlugin);
% This JUnit XML plugin is only in Matlab R2015b+
% TODO: This should maybe be done wrt Common.repoRootDir instead of pwd
mkdir('test-output/junit/bids-matlab');
junitXmlPlugin = XMLPlugin.producingJUnitFormat(...
    'test-output/junit/bids-matlab/results.xml');
runner.addPlugin(junitXmlPlugin);

out = runner.run(suite);

% This is our DIY JUnit XML output
%junitOutputter = bids_ut.JUnitXmlOutputter('test-output/junit/bids-matlab');
%junitOutputter.writeReport(suite, out);

end
