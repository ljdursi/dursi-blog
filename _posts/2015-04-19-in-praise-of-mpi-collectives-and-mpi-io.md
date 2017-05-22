---
title:  "In Praise of MPI Collectives and MPI-IO"
tags: ['hpc', 'MPI', 'MPI-IO']
---

While I have a number of posts I want to write on other topics and technologies, there is one last followup I want to make to [my MPI post](http://www.dursi.ca/hpc-is-dying-and-mpi-is-killing-it/).

Having said what I think is wrong about MPI (the standard, not the implementations, which are of very high quality), it's only fair to say something about what I think is very good about it.  And _why_ I like these parts gives lie to one of the most common pro-MPI arguments I've been hearing for years; that application programmers coding at low levels is somehow essential - or even just a good idea - for performance.

## Two great things about MPI

### Collective Operations
Since the very beginning, MPI has defined a suite of [collective communications](https://computing.llnl.gov/tutorials/mpi/#Collective_Communication_Routines) that include operations like scatter, gather, [prefix scan](http://en.wikipedia.org/wiki/Prefix_sum), and reduce.  While these weren't invented by MPI &ndash; many were already implemented as "global communications" routines in the [CM-2's](http://en.wikipedia.org/wiki/Connection_Machine) [Connection Machine Scientific Software Library](http://ieeexplore.ieee.org/xpl/articleDetails.jsp?arnumber=365582), for instance, and there is lots of literature on implementing those operations on other architectures like the iPSC/860-based hypercube systems &ndash; it's certainly fair to say that it was MPI that popularized them to the point that they've started getting [hardware support in network cards](http://www.mellanox.com/page/products_dyn?product_family=104&menu_section=73). The popularization stems partly from how widely taught MPI is, but also from useful generalizations that the MPI Forum made, like user-defined reduction operations, or being able to perform these operations on user-defined subsets of tasks.

A classic use of MPI collective operations would be using a reduce to find a global sum (or max, or min, or a user defined operation) of local values:

```python
from mpi4py import MPI
import random

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
nprocs = comm.Get_size()

local = random.random()

globalsum = comm.reduce(local, op=MPI.SUM, root=0)
globalmin = comm.reduce(local, op=MPI.MIN, root=0)
globalmax = comm.reduce(local, op=MPI.MAX, root=0)

if rank == 0:
    print "Min, mean, max = ", globalmin, globalsum/nprocs, globalmax
```

### MPI-IO

[MPI-IO](http://beige.ucs.indiana.edu/I590/node86.html) is the foundational middleware for HPC parallel I/O.  [Parallel HDF5](https://hdfgroup.org/HDF5/PHDF5/) (and thus [Parallel NetCDF4](http://www.unidata.ucar.edu/software/netcdf/docs_rc/parallel_io.html)), [ADIOS](https://www.olcf.ornl.gov/center-projects/adios/), and others are built on top of it.  As a result, even application software that doesn't explicitly use MPI sometimes relies on MPI-IO for reading and writing large files in parallel.

The key concept in MPI-IO is a "file view", which describes (in terms of MPI data layouts) where in the file a process will be writing.  Once that's done, writing data to the file just looks like sending a message to the file.  A trivial example follows below; more complex data layouts like (as often happens in scientific computing) non-contiguous slices of large multidimensional arrays being read and written would look exactly the same:

```python
from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
nprocs = comm.Get_size()

myString = 'Hello ' if rank % 2 == 0 else 'World!'
stringSize = 6

subarray = MPI.CHAR.Create_subarray( (stringSize*nprocs,), (stringSize,), (stringSize*rank,))
subarray.Commit()

filehandle = MPI.File.Open(comm, 'ioexample.txt', MPI.MODE_CREATE | MPI.MODE_WRONLY)
filehandle.Set_view(0, MPI.CHAR, subarray)
filehandle.Write_all(myString)

filehandle.Close()
```

## Why they're great

These two very different parts of the MPI standard have three important features in common for this discussion.

* They're at much higher levels of abstraction than most of the API
* Application programmers would get worse performance, not better, if they tried to implement their own at lower levels.
* Original implementations of these APIs didn't perform nearly as well as current implementations.  But algorithmic and implementation work done by software engineers greatly sped the low level implementations up without applications programmers needing to rewrite their code.

### Collectives and MPI-IO are higher levels of abstraction

Calls to MPI collective operations or MPI-IO describe what should be done, not how to do it, and at a much higher level than `MPI_Send()/MPI_Put()`.  

Operations like "All processes sum their results and distribute the result to all processes", or "Each process writes to their slice of the file" are enormously broader than "Send this message to process X".  There's a large number of ways they could be implemented, and in fact there's a huge literature on both [collectives](https://scholar.google.ca/scholar?q=mpi+collectives) and [MPI-IO](https://scholar.google.ca/scholar?q=mpi-io) on various approaches to doing so.

###Application programmers reimplementing them would be worse for performance

If the "low-level application programming is essential for high performance" argument was true, then of course we would be actively dissuading researchers from using these high-level tools.  But we don't, and we're right not to.  

Most of us who have worked with enough researchers writing their own HPC codes have had the experience of someone coming into our office who was broadcasting data with a loop over `MPI_Send()`s, or trying to write to a shared file using `fseek()` or the like, and we've directed them to collective operations or MPI-IO instead.  We do the same, of course, when someone is trying to type in some Gaussian Elimination code from Numerical Recipes (no link; that book has done enough damage) and we guide them to our local [LAPACK](http://en.wikipedia.org/wiki/LAPACK) implementation instead.

And we do this because even we don't believe that scientists implementing these things at low level will give better performance.  It's not about it being "too hard"; it's something else entirely.  We know that it would be a huge amount of wasted effort for a *worse*, *slower*, result.

MPI collective operation implementations make run-time decisions behind the researchers back, based on the size of the data, and the structure of the communicator being used, to decide whether to use k-ary trees, or hyper-cubes, or split-ring approaches, and in one, two, or multiple phases of communications, to perform the operation.  MPI-IO implementations uses approaches like data-sieving or two-phase I/O to trade off network communication for disk I/O, and use close integration with the filesystem to inform that tradeoff.

Somebody had to do all that challenging low-level work, yes.  But the idea that those optimizations and algorithmic work is properly the job of the researcher/application programmer is absurd.

###Implementations got faster and faster

These highly optimized implementations of these high-level abstractions did not, of course, spring fully formed from nowhere, any more than the [reference implementation of LAPACK/BLAS](http://www.netlib.org/lapack/) was blazingly fast.  The abstractions were created with an understanding of both what application programmers needed and what was implementable, and then years and years of work went into developing the algorithms and implementations that we make use of today.

Initial implementations of MPI-1 collectives were (naturally!) not super optimized, and there were certainly developers who scoffed at the performance and who pointed out they could do better writing low-level network code on their own.  They were, in that snapshot in time, narrowly correct; but more broadly and in the longer term, they were flat-out wrong.  The most useful and productive approach to a researcher finding out that early versions of those collective operations (say) were slow in some situations was not to break down and re-implement it themselves at low level; it was to file an issue with the library provider, and help them fix it so that it would be faster for everyone.

## These points generalize

I don't think anything I've said above is particuarly controversial. Performance, as well as productivity, for researchers and applications programmers has clearly improved as a result of MPI's collectives and MPI-IO.  

But for some reason, the idea that this generalizes &mdash; that performance as well as productivity of scientific software development would improve if applications developers spent their time using other, newer higher-level constructs while more tool-builders implemented those constructs in efficient ways &mdash; is anathaema to a section of our HPC community.

I've yet to hear compelling reasons why operations on distributed multidimensional arrays, or hash tables, or trees, are completely different from collectives or IO; why application programmers have to implement them directly or indirectly in a low-level tool like MPI sends and receives or gets and puts rather than having them implemented by experts in higher-level environments like Chapel, or Spark, or Ignite, or any of a zillion other projects from within or outside of the HPC community.
