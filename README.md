# bids-matlab-ut

Modern unit testing for BIDS-MATLAB

[![Build Status](https://travis-ci.org/apjanke/bids-matlab-ut.svg?branch=master)](https://travis-ci.org/apjanke/bids-matlab-ut)

The bids-matlab-ut project is an effort to add modern unit tests and code coverage analysis to the [BIDS-MATLAB](https://github.com/bids-standard/bids-matlab) project. This is being done in conjunction with the [FieldTrip](http://www.fieldtriptoolbox.org/) project, which has an interest in using BIDS-MATLAB in their projects.

# License

GPL 3.0, the same as BIDS-MATLAB.

# Usage

To use bids-matlab-ut, clone its repo to your local hard drive using git:

```
git clone https://github.com/apjanke/bids-matlab-ut
```

Load the library by running `init_bids_matlab_ut` from the `Mcode` directory.

Fetch the upstream repos by running `bidsut.Common.fetchUpstreamCode`, or manually clone the `bids-standard` repos for `bids-matlab` and `bids-examples` into the `upstream/` directory.

Then run the unit tests found in `Mcode/+bidsut/+tests` using Matlab's Unit Testing framework.

# Author

The primary author for this project is [Andrew Janke](https://apjanke.net). The project home page is temporarily https://github.com/apjanke/bids-matlab-ut, but it will be moved to an organization once it's in working order.
