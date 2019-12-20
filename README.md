# bids-matlab-ut

Modern unit testing for BIDS-MATLAB

The bids-matlab-ut project is an effort to unit tests and code coverage analysis to the bids-matlab project. This is being done in conjunction with the FieldTrip project, which has an interest in using BIDS-MATLAB in their projects.

# License

GPL 3.0, the same as BIDS-MATLAB.

# Usage

To use bids-matlab-ut, clone its repo to your local hard drive using the `--recursive` option for git:

```
git clone --recursive https://github.com/apjanke/bids-matlab-ut
```

Load the library by running `init_bids_matlab_ut` from the `Mcode` directory.

Then run the unit tests found in `Mcode/+bidsut/+tests` using Matlab's Unit Testing framework.

# Author

The primary author for this project is [Andrew Janke](https://apjanke.net). The project home page is temporarily https://github.com/apjanke/bids-matlab-ut, but it will be moved to an organization once it's in working order.
