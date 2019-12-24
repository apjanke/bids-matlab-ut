function out = run_test_job
% run_test_job Entry point for CI execution of jobs
%
% bids_unittest.run_test_job
% status = bids_unittest.run_test_job
%
% This will fetch the necessary upstream code, initialize the
% bids-matlab-ut library, and run all the tests in it.
%
% This is the main function entry point that our Matlab CI jobs will call.
%
% If the return value is not captured, exits Matlab, setting exit status to
% 0 if all tests passed, and 1 if any failed. If return value is captured,
% returns what the exit status would have been (and does not exit Matlab).
%
% TODO: This may have to become CI-provider-specific, since Travis,
% Circle, and Azure Pipelines will all want different output formats.

mcode_dir = fileparts(fileparts(mfilename('fullpath')));
addpath(mcode_dir);
% TODO: This is hinky that we have to fetch the upstream code before
% loading the bids_unittest library. Figure out something nicer here.
% Note: This is disabled for now, because we've included the full upstream
% source in this repo, so codecov.io works.
%bids_unittest.Common.fetchUpstreamCode;
bids_unittest.init_bids_matlab_ut;
rslts = bids_unittest.run_all_tests;

% We have to set Matlab's exit status to communicate our results to CI
failed = [rslts.Failed];
incomplete = [rslts.Incomplete];
nBad = numel(find(failed | incomplete));
if nBad == 0
    exit_status = 0;
else
    exit_status = 1;
end
if nargout == 0
    exit(exit_status);
else
    out = exit_status;
end

end
