function out = run_all_tests
% run_all_tests Run all the tests in bids-matlab-ut
%
% rslt = bids_ut.run_all_tests
%
% Runs all the tests in bids-matlab-ut, presenting results on the command
% line and producing results output files.
%
% The results output files are
% created in a directory named "test-output" under the current directory.
% Output files:
% test-output/
%   junit/
%     bids-matlab/
%       results.xml     - JUnit XML format test results
%   cobertura/
%     coverage.xml      - Cobertura format code coverage report
%
% Examples:
% bids_ut.run_all_tests

import matlab.unittest.TestSuite
import matlab.unittest.TestRunner
import matlab.unittest.plugins.CodeCoveragePlugin
import matlab.unittest.plugins.codecoverage.CoberturaFormat
import matlab.unittest.plugins.XMLPlugin;

baseDir = pwd;
testOutDir = [baseDir '/test-output'];
if exist(testOutDir, 'dir')
    rmdir(testOutDir, 's');
end
mkdir(testOutDir);

suite = TestSuite.fromPackage('bids_ut.tests', 'IncludingSubpackages', true);

runner = TestRunner.withTextOutput;
mkdir([testOutDir '/cobertura']);
coberturaOutFile = [testOutDir '/cobertura/coverage.xml'];
coveragePlugin = CodeCoveragePlugin.forPackage('bids', ...
    'Producing',CoberturaFormat(coberturaOutFile ), ...
    'IncludingSubpackages', true);
runner.addPlugin(coveragePlugin);
% This JUnit XML plugin is only in Matlab R2015b+
mkdir([testOutDir '/junit/bids-matlab']);
junitXmlPlugin = XMLPlugin.producingJUnitFormat(...
    [testOutDir '/junit/bids-matlab/results.xml']);
runner.addPlugin(junitXmlPlugin);

out = runner.run(suite);

% This is our DIY JUnit XML output
% TODO: Replace this with a custom version of XMLPlugin
%junitOutputter = bids_ut.JUnitXmlOutputter([testOutDir '/junit/bids-matlab']);
%junitOutputter.writeReport(suite, out);

end
