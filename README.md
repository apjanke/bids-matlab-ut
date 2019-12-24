# bids-matlab-ut

Modern unit testing for BIDS-MATLAB

[![Build Status](https://travis-ci.org/apjanke/bids-matlab-ut.svg?branch=master)](https://travis-ci.org/apjanke/bids-matlab-ut)  [![CircleCI](https://circleci.com/gh/apjanke/bids-matlab-ut.svg?style=svg)](https://circleci.com/gh/apjanke/bids-matlab-ut)  [![Build Status](https://dev.azure.com/apjanke/bids-matlab-ut/_apis/build/status/apjanke.bids-matlab-ut?branchName=master)](https://dev.azure.com/apjanke/bids-matlab-ut/_build/latest?definitionId=1&branchName=master)

[![codecov](https://codecov.io/gh/apjanke/bids-matlab-ut/branch/master/graph/badge.svg)](https://codecov.io/gh/apjanke/bids-matlab-ut)

The bids-matlab-ut project is an effort to add modern unit tests and code coverage analysis to the [BIDS-MATLAB](https://github.com/bids-standard/bids-matlab) project. This is being done in conjunction with the [FieldTrip](http://www.fieldtriptoolbox.org/) project, which has an interest in using BIDS-MATLAB in their projects.

# License

GPL 3.0, the same as BIDS-MATLAB.

# Usage

To use bids-matlab-ut, clone its repo to your local hard drive using git:

```
git clone https://github.com/apjanke/bids-matlab-ut
```

Load the library by running `bids_unittest.init_bids_matlab_ut` from the `Mcode` directory.

Then run the unit tests found in `Mcode/+bids_unittest/+tests` using Matlab's Unit Testing framework.

# Author

The primary author for this project is [Andrew Janke](https://apjanke.net). The project home page is temporarily https://github.com/apjanke/bids-matlab-ut, but it will be moved to an organization once it's in working order.
