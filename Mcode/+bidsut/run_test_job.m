function run_test_job
% run_test_job Entry point for CI execution of jobs
%
% This will fetch the necessary upstream code, initialize the
% bids-matlab-ut library, and run all the tests in it.
%
% This is the main function entry point that our Matlab CI jobs will call.
%
% TODO: This will have to become CI-provider-specific, since Travis,
% Circle, and Azure Pipelines will all want different output formats.

mcode_dir = fileparts(fileparts(mfilename('fullpath')));
addpath(mcode_dir);
% TODO: This is hinky that we have to fetch the upstream code before
% loading the bidsut library. Figure out something nicer here.
% Note: This is disabled for now, because we've included the full upstream
% source in this repo, so codecov.io works.
%bidsut.Common.fetchUpstreamCode;
init_bids_matlab_ut;
rslts = bidsut.run_all_tests;

% We have to force Matlab's exit status to communicate our results to CI
trslt = rslts.table;
nBad = numel(find(trslt.Failed | trslt.Incomplete));
if nBad == 0
    exit;
else
    exit(1);
end

end
