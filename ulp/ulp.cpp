#include <octave/oct.h>
 #include <iostream>
#include <cmath>
#include <vector>
#include <algorithm>
#include <iomanip>
#include <bit>
#include <bitset>
#include <random>
using namespace std;
//

DEFUN_DLD(ulp, args, ,
          "Return ulp(x)")
{
   
    const double value = args(0).double_value();
    if (isnan(value)) {
        return octave_value(value);
    }
    double x = abs(value);
    if (isinf(x)) {
        return octave_value(x);
    }

     double nextvalue = nextafter(x, std::numeric_limits<double>::infinity());
    return octave_value(nextvalue - x);
}

