classdef JUnitXmlOutputter
    % Creates JUnit XML format reports from test results
    
    properties
        outputDir
    end
    
    methods
        function this = JUnitXmlOutputter(outputDir)
            if nargin == 0
                return;
            end
            this.outputDir = outputDir;
        end
        
        function writeReport(this, testSuite, results)
            bids_unittest.Util.mkdir(this.outputDir);
            reportFile = fullfile(this.outputDir, 'results.xml');
            writeXmlReport(reportFile, testSuite, results);
        end
    end
end

% These are written as local functions just so I don't have to deal with so
% much indentation.

function writeXmlReport(file, allTests, allRslts)
[fid,msg] = fopen(file, 'w');
if fid < 1
    error('Failed opening file ''%s'' for writing: %s', file, msg);
end
RAII.fid = onCleanup(@() fclose(fid));

    function p(fmt, varargin)
        % Just an abbreviation for fprintf()
        fprintf(fid, fmt, varargin{:});
    end

% Each test class is presented as a different test suite
suites = testResultsToSuites(allTests, allRslts);
p('<?xml version="1.0" encoding="UTF-8"?>\n');
p('<testsuites>\n');
for iSuite = 1:numel(suites)
    suite = suites(iSuite);
    tests = suite.tests;
    rslts = suite.rslts;
    tbl = table(suite.rslts);
    nTests = size(tbl, 1);
    nFailed = numel(find(tbl.Failed));
    duration = sum(tbl.Duration);
    p(['  <testsuite id="%d" name="%s" tests="%d" failures="%d" ' ...
        'time="%f" hostname="%s">\n'], ...
        iSuite-1, suite.testClass, nTests, nFailed, duration, bids_unittest.Util.hostname);
    for i = 1:numel(tests)
        test = tests(i);
        rslt = rslts(i);
        fullTestName = test.Name;
        shortTestName = fullTestName((numel(suite.testClass)+2):end);
        p('    <testcase name="%s" classname="%s" time="%f">', ...
            shortTestName, test.TestClass, rslt.Duration);
        if rslt.Failed
            p('<failure/>');
        elseif rslt.Incomplete
            p('<skipped/>');
        end
        p('</testcase>\n');
    end
    p('  </testsuite>\n');
end
p('</testsuites>\n');

fprintf('Wrote tests results to %s\n', file);
end


function out = testResultsToSuites(tests, rslts)

testClasses = [tests.TestClass];
uTestClass = unique(testClasses);
for i = 1:numel(uTestClass)
    testClass = uTestClass{i};
    tf = strcmp(testClasses, testClass);
    suite.testClass = testClass;
    suite.tests = tests(tf);
    suite.rslts = rslts(tf);
    out(i) = suite; %#ok<AGROW>
end

end