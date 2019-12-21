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
            bids_ut.Util.mkdir(this.outputDir);
            reportFile = fullfile(this.outputDir, 'results.xml');
            writeXmlReport(reportFile, testSuite, results);
        end
    end
end

% These are written as local functions just so I don't have to deal with so
% much indentation.

function writeXmlReport(file, tests, rslts)
[fid,msg] = fopen(file, 'w');
if fid < 1
    error('Failed opening file ''%s'' for writing: %s', file, msg);
end
RAII.fid = onCleanup(@() fclose(fid));

    function p(fmt, varargin)
        % p Just an abbreviation for fprintf()
        fprintf(fid, [fmt '\n'], varargin{:});
    end

% TODO: Should each test class be presented as a different test suite?
tbl = table(rslts);
nTests = size(tbl, 1);
nFailed = numel(find(tbl.Failed));
duration = sum(tbl.Duration);
p('<?xml version="1.0" encoding="UTF-8"?>');
p('<testsuites>');
p(['  <testsuite id="%d" name="BIDS-MATLAB Unit Tests" tests="%d" failures="%d" ' ...
    'time="%f" hostname="%s">'], ...
    0, nTests, nFailed, duration, bids_ut.Util.hostname);
for i = 1:numel(tests)
    test = tests(i);
    rslt = rslts(i);
    p('    <testcase name="%s" classname="%s" time="%f">', ...
        test.Name, test.TestClass, rslt.Duration);
    if rslt.Failed
        p('      <failure/>');
    elseif rslt.Incomplete
        p('      <skipped/>');
    end
    p('    </testcase>');
end
p('  </testsuite>');
p('</testsuites>');
end

