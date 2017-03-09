---
title:  "Stopping your program at the first NaN"
tags: ['c', 'fortran', 'ieee754']
---

If you know that somewhere in your program, there lurks a catastrophic numerical bug that puts NaNs or Infs into your results and you want to know where it first happens, the search can be a little frustrating.   However, as before, the IEEE standard can help you; these illegal events (divide by zero, underflow or overflow, or invalid operations which cause NaNs) can be made to trigger exceptions, which will stop your code right at the point where it happens; then if you run your code through a debugger, you can find the very line where it happens.

We'll discuss using the gnu compilers here; other compiler suites have similar options.

Let's take a look at the following Fortran code:

```
program nantest
    real :: a, b, c

    a = 1.
    b = 2.

    c = a/b
    print *, c,a,b

    a = 0.
    b = 0.

    c = a/b
    print *, c,a,b

    a = 2.
    b = 1.

    c = a/b
    print *,c,a,b
end program nantest
```

If we compile this code with `-ffpe-trap=invalid` (I usually add `,zero,overflow` , and even `underflow` if I think that's causing me a problem in intermediate results), then the debugger can tell us the line where it all goes wrong:

```bash
$ gfortran -o nantest nantest.f90 -ffpe-trap=invalid,zero,overflow -g -static
$ gdb nantest
[...]
(gdb) run
Starting program: /scratch/ljdursi/Testing/fortran/nantest
  0.50000000       1.0000000       2.0000000    

Program received signal SIGFPE, Arithmetic exception.
0x0000000000400384 in nantest () at nantest.f90:13
13          c = a/b
Current language:  auto; currently fortran
```

With the intel fortran compiler (ifort), using the option `-fpe0` will do the same thing.

It's a little tricker with C code; we have to actually insert a call to `feenableexcept()`, which enables floating point exceptions, and is defined in fenv.h;

```c
#include <stdio.h>
#include <fenv.h>

int main(int argc, char **argv) {
    float a, b, c;
    feenableexcept(FE_DIVBYZERO | FE_INVALID | FE_OVERFLOW);

    a = 1.;
    b = 2.;

    c = a/b;
    printf("%f %f %f\n", a, b, c);

    a = 0.;
    b = 0.;

    c = a/b;
    printf("%f %f %f\n", a, b, c);

    a = 2.;
    b = 1.;

    c = a/b;
    printf("%f %f %f\n", a, b, c);

    return 0;
}
```
but the effect is the same:

```bash
$ gcc -o nantest nantest.c -lm -g
$ gdb ./nantest
[...]
(gdb) run
Starting program: /scratch/s/scinet/ljdursi/Testing/exception/nantest
1.000000 2.000000 0.500000

Program received signal SIGFPE, Arithmetic exception.
0x00000000004005d0 in main (argc=1, argv=0x7fffffffe4b8) at nantest.c:17
17	    c = a/b;
```

either way, you have a much better handle on where the errors are occuring.
