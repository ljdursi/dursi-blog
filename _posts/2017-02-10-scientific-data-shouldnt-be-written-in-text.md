---
title:  "Floating-Point Data Shouldn't Be Serialized As Text"
---

Write data files in a binary format, unless you're going to actually be reading the output - and you're not going to be reading a millions of data points.

The reasons for using binary are threefold, in decreasing importance:

* Accuracy
* Performance
* Data size

Accuracy concerns may be the most obvious.  When you are converting a (binary) floating point number to a string representation of the decimal number, you are inevitably going to truncate at some point.  That's ok if you are sure that when you read the text value back into a floating point value, you are certainly going to get the same value; but that is actually a subtle question and requires choosing your format carefully.  Using default formatting, various compilers perform this task with varying degrees of quality.  [This blog post][1], written from the point of view of a games programmer, does a good job of covering the issues; but note that for technical computing, we generally must be much more demanding about accuracy.

Let's consider a little program which, for a variety of formats, writes a single-precision real number out to a string, and then reads it back in again, keeping track of the maximum error it encounters.  We'll just go from 0 to 1, in units of machine epsilon.  The code follows:

```c
#include <stdio.h>
#include <math.h>
#include <float.h>

int main(int argc, char **argv) {

    const int nformats=5;
    char *formats[] = { "%11.4f", "%13.6f", "%15.8f", "%17.10f", "%f" };
    float maxerrors[nformats];

    for (int fmt=0; fmt<nformats; fmt++)
        maxerrors[fmt] = 0.;

    float input = 0;
    while (input < 1) {
        for (int fmt=0; fmt<nformats; fmt++) {
            char stringrep[128];
            sprintf(stringrep, formats[fmt], input);

            float output;
            sscanf(stringrep, "%f", &output);

            float err = fabs(output-input);
            if (err > maxerrors[fmt])
                maxerrors[fmt] = err;
        }

        input += FLT_EPSILON;
    }

    printf("Maximum errors: \n");
    for (int fmt=0; fmt<nformats; fmt++)
        printf("%12s\t", formats[fmt]);
    printf("\n");
    for (int fmt=0; fmt<nformats; fmt++)
        printf("%12.6f\t", maxerrors[fmt]);
    printf("\n");

    return 0;
}
```

and when we run it, we get:

```bash
$ ./accuracy
Maximum errors:
      %11.4f	      %13.6f	      %15.8f	     %17.10f	          %f
5.000830e-05	5.066395e-07	7.450581e-09	5.820766e-11	5.066395e-07
```

Note that even using a format with 8 digits after the decimal place - which we might think would be plenty, given that [single precision reals are only accurate to 6-7 decimal places][2] - when the data makes a round trip through string-formatting  we don't get exact copies back, off by approximately $10^{-8}$.  And this compiler's default format does *not* give us accurate round-trip floating point values; some error is introduced!  If you're a video-game programmer, that level of accuracy may well be enough.  For scientific/technical work, however, that might absolutely not be ok, particularly if there's some bias to where the error is introduced, or if the error occurs in what is supposed to be a conserved quantity.

Note that if you try running this code, you'll notice that it takes a surprisingly long time to finish.  That's because, maybe surprisingly, performance is another real issue with text output of floating point numbers.  Consider a following simple program, which just writes out a 2d array of a 5000 &times; 5000 floats as text (using `fprintf()` and as unformatted binary, using `fwrite()`.   The code will follow, but to start here's the timing outputs:

```bash
$ ./io-performance 5000
Text      : time = 20.229191
Raw Binary: time = 0.042213
```

Note that when writing to disk, the binary output is **479 times** as fast as text output.  There are two reasons for this - one is that you can write out data all at once, rather than having to loop; the other is that generating the string decimal representation of a floating point number is a surprisingly subtle operation which requires a significant amount of computing for each value.

Finally, is data size; the text file in the above example comes out (on my system - depends on compilers default floating string representation, etc) to about 4 times the size of the binary file.

Now, there are real problems with binary output.  In particular, raw binary output is very brittle.  If you change platforms, or your data size changes, your output may no longer be any good.  Adding new variables to the output will break the file format unless you always add new data at the end of the file, and you have no way of knowing ahead of time what variables are in a binary blob you get from your collaborator (who might be you, three months ago).   

Most of the downsides of binary output are avoided by using libraries which use binary output to serialize, but include enough metadata to describe the data.  For output of large scientific arrays, [NetCDF][3] -- which writes self-describing binary files that are much more "future proof" than raw binary -- is a good chioce.  Better still, since it's a standard, many tools read NetCDF files.  In other contexts, formats like [BSON](http://bsonspec.org) make a lot of sense.

There are many NetCDF tutorials on the internet; one I wrote is is [here][4].  A simple example using NetCDF gives IO performance results much closer to raw binary than to text:

```bash
$ ./io-performance
Text      : time = 20.504855
Raw Binary: time = 0.049945
NetCDF4   : time = 0.155822
```

but gives you a nice self-describing file:

```bash
$ ncdump -h test.nc
netcdf test {
dimensions:
	X = 5000 ;
	Y = 5000 ;
variables:
	float Array(X, Y) ;
		Array:units = "ergs" ;
}
```

and file sizes about the same as raw binary:

```bash
$ du -sh test.*
96M	test.dat
96M	test.nc
382M	test.txt
```

the code follows:

```c
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <netcdf.h>
#include <string.h>

void tick(struct timeval *t);
double tock(struct timeval *t);
void writenetcdffile(const char *filename, int n, float **data);

int main(int argc, char **argv) {

    if (argc < 2) {
        fprintf(stderr,"Usage: %s n -- test write speeds of n x n array\n", argv[0]);
        exit(1);
    }

    int n = atoi(argv[1]);
    const int defaultn = 5000;
    if (n < 1 || n > 10000) {
        fprintf(stderr, "Invalid n %s: using n = %d\n", argv[1], defaultn);
        n = defaultn;
    }

    float **data = malloc(n*sizeof(float *));
    float *p     = malloc(n*n*sizeof(float));
    for (int i=0; i<n; i++)
        data[i] = &(p[i*n]);

    for (int i=0; i<n; i++)
        for (int j=0; j<n; j++)
            data[i][j] = i*n+j;

    struct timeval timer;
    tick(&timer);
    FILE *txt = fopen("test.txt","w");
    for (int i=0; i<n; i++) {
        for (int j=0; j<n; j++)
            fprintf(txt, "%f ", data[i][j]);
        fprintf(txt, "\n");
    }
    fclose(txt);
    printf("Text      : time = %lf\n", tock(&timer));

    tick(&timer);
    FILE *bin = fopen("test.dat","wb");
    fwrite(data[0], sizeof(float), n*n, bin);
    fclose(bin);
    printf("Raw Binary: time = %lf\n", tock(&timer));

    tick(&timer);
    writenetcdffile("test.nc", n, data);
    printf("NetCDF4   : time = %lf\n", tock(&timer));

    free(data[0]);
    free(data);
}


void tick(struct timeval *t) {
    gettimeofday(t, NULL);
}

/* returns time in seconds from now to time described by t */
double tock(struct timeval *t) {
    struct timeval now;
    gettimeofday(&now, NULL);
    return (double)(now.tv_sec - t->tv_sec) + ((double)(now.tv_usec - t->tv_usec)/1000000.);
}

void writenetcdffile(const char *filename, int n, float **data) {
    /* identifiers */
    int file_id, xdim_id, ydim_id;
    int data_id;

    /* sizes */
    int datadims[2];

    /* name of units for data */
    const char *dataunits="ergs";

    /* return status */
    int status;

        /* Create a new file - clobber anything existing */
    status = nc_create(filename, NC_CLOBBER, &file_id);
    /* netCDF routines return NC_NOERR on success */
    if (status != NC_NOERR) {
        fprintf(stderr,"Could not open file %s\n", filename);
        return;
    }

    /* define the dimensions */
    nc_def_dim(file_id, "X", n, &xdim_id);
    nc_def_dim(file_id, "Y", n, &ydim_id);

    /* now that we've defined the dimensions, we can define variables on them */
    datadims[0] = xdim_id;  datadims[1] = ydim_id;
    nc_def_var(file_id, "Array",  NC_FLOAT, 2, datadims, &data_id);

    /* assign units to the variables */
    nc_put_att_text(file_id, data_id, "units", strlen(dataunits), dataunits);

    /* we are now done defining variables and their attributes */
    nc_enddef(file_id);

    /* Write out the data to the variables we've defined */
    nc_put_var_float(file_id, data_id, &(data[0][0]));

    nc_close(file_id);
    return;
}
```

(This post is crosslisted from a [StackOverflow Answer](http://stackoverflow.com/questions/24395686/best-way-to-write-a-large-array-to-file-in-fortran-text-vs-other/24396176#24396176).)

  [1]: http://randomascii.wordpress.com/2013/02/07/float-precision-revisited-nine-digit-float-portability/
  [2]: http://stackoverflow.com/questions/24377058/decimal-accuracy-of-binary-floating-point-numbers/24387402#24387402
  [3]: http://www.unidata.ucar.edu/software/netcdf/
  [4]: http://wiki.scinethpc.ca/wiki/images/a/af/Netcdfhdf5.pdf
