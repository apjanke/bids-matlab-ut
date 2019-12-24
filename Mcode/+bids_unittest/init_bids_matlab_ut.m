function init_bids_matlab_ut
% init_bids_matlab_ut Initialize the bids-matlab-ut library
%
% bids_unittest.init_bids_matlab_ut()
%
% Call this function to initialize the bids-matlab-ut library. You need to
% do this before running any of its other code.

mcode_dir = fileparts(fileparts(mfilename('fullpath')));
repo_root_dir = fileparts(mcode_dir);
bids_matlab_dir = fullfile(repo_root_dir, 'upstream', 'bids-matlab');

addpath(mcode_dir);
addpath(bids_matlab_dir);

fprintf('bids-matlab-ut initialized from: %s\n', repo_root_dir);
