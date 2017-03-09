---
title:  "Coarray Fortran Goes Mainstream: GCC 5.1"
tags: ['fortran', 'hpc', 'gcc']
---

This past week's release of [GCC 5.1](https://gcc.gnu.org/gcc-5/) contains at least [two new features](https://gcc.gnu.org/gcc-5/changes.html) that are important to the big technical computing community: [OpenMP4/OpenACC offloading](https://gcc.gnu.org/wiki/Offloading ) to Intel Phi/NVIDIA accellerators, and compiler support for [Coarray Fortran](https://gcc.gnu.org/wiki/Coarray), with the communications layer provided by the [OpenCoarrays Project](http://opencoarrays.org).

While I don't want to downplay the importance or technical accomplishment of the OpenMP 4 offloading now being available, I think it's important to highlight the widespread availability for the first time of a tried-and-tested post-MPI programming model for HPC; and one that, since it is now part of the Fortran standard, is largely immune to fears that it might go away due to lack of interest. Here I'll give a quick history of Coarray Fortran (CAF), some examples, and the pros and cons of CAF versus other approaches.

## A quick history of Coarray Fortran

Coarray Fortran first became widely known as Co-array Fortran, described in a [1998 paper](https://scholar.google.ca/scholar?cluster=8719640223898917361&hl=en&as_sdt=0,5) which described an implementation on Cray systems (T3Es and X1s) of a minimal extension to Fortran 95 which included distributed memory computing of enough complexity to allow real applications.  

The basic idea is simple enough from a developer's point of view.  As with most MPI programs, a single program is launched across many processors.  Each "image" has its own local variables, as usual.  However, variables can also be defined to have a "co-dimension"; that is, a dimension which indexes that variable across all images.  

```fortran
program coarray1
  implicit none
  integer :: me, right, i
  integer, dimension(3), codimension[*] :: a

  me = this_image()

  right = me + 1
  if (right > num_images()) right = 1

  a(:) = [ (me**i, i=1, 3) ]

  sync all

  print *, "Image ", me, " has a(2) = ", a(2)[me], "; neighbour has ", a(2)[right]
end program coarray1
```
where square brackets refer to the co-index across images; recall that Fortran, somewhat unfortunately, uses parenthesis both for array indexing and for function arguments.  Note also that, in Fortran fashion, image numbers begin at 1.

Running this on 4 images gives:

```bash
$ ./coarray1
Image            2  has a(2) =            4 ; neighbour has            9
Image            3  has a(2) =            9 ; neighbour has           16
Image            4  has a(2) =           16 ; neighbour has            1
Image            1  has a(2) =            1 ; neighbour has            4
```

While it's often the case that coarrays are also arrays &ndash; as is the case here with `a` &ndash; that needn't be true.  Scalar variables - variables with out array dimensions - can nonetheless have codimensions and thus be coarrays.

Co-indexes needn't be linear; one can also define co-dimensions of co-rank 2 or higher, to impose a grid-like pattern over the ranks.

Co-array Fortran continued to be used on Cray systems, and was submitted as a proposal for inclusion into Fortran 2008.  A stripped-down version of the original proposal (losing such things as image "teams", and the hyphen in Co-array) made it through, with some minor syntax changes.  The Cray Fortran compiler quickly adopted the standard, and [Intel's fFortran compiler](https://software.intel.com/en-us/articles/distributed-memory-coarray-fortran-with-the-intel-fortran-compiler-for-linux-essential) has since version 12 supported SMP coarrays, and distributed-memory coarrays as part of the "Cluster suite" that includes Intel MPI.  IBM and PGI are said to be working on Coarray support. In less widely-used compilers, [OpenUH](http://web.cs.uh.edu/~openuh/) supported Coarrays quite early on, as did the now-defunct [G95](http://www.g95.org).

A [technical specification](http://isotc.iso.org/livelink/livelink?func=ll&objId=17064344&objAction=Open) which is expected to make it into a future Fortran standard largely unscathed re-instates support for teams (giving overlapping functionality with MPI communicators for coordinating subsets of processes), and adds some collective operations, some atomic operations, and Events, which are something like [condition variables](http://en.wikipedia.org/wiki/Monitor_(synchronization)).  GCC 5.1 supports many of these features already.

## Examples

Let's take a look at a couple of simple examples to see how Coarray Fortran works in some familiar cases, and how the code complexity compares to MPI.

We'll see in part that, unlike with (say) Spark or Chapel examples from earlier in the month, in Coarray Fortran the developer is still responsible for explicitly decomposing the problem.  That means a lot that part of the boilerplate of the MPI versions of the code remains.  However, as communication patterns become more complex, the code can still simplify quite a bit.

However, having the communications built into the language has another completely different advantage, one we've gotten used to not thinking about as we're more used to using external libraries.  Communication being part of the language means that the compiler itself can perform high-level optimization on commuincations, just as it would with memory access.  

### 1D diffusion equation

Let's take a look at a simple example I've used before, [1d diffusion](https://github.com/ljdursi/coarray-examples/tree/master/diffusion).  Here, we have a 1D domain broken up across images, or MPI ranks, exchanging data just with nearest neighbours.

Taking a look at the [CAF code](https://github.com/ljdursi/coarray-examples/blob/bc356ec1dce3493c59800f1845c93bf18a6e7403/diffusion/diffusion-coarray.f90#L108), we have the data exchange part:

```fortran
!
! exchange boundary information
!

   sync images(neighbours(1:nneighbours))
   if (this_image() /= 1) then
       temperature(1,old) = temperature(locnpoints+1,old)[left]
   endif
   if (this_image() /= num_images()) then
      temperature(locnpoints+2,old) = temperature(2,old)[right]
   endif

!
! update solution
!
   forall (i=2:locnpoints+1)
       temperature(i,new) = temperature(i,old) + &
             dt*kappa/(dx**2) * (                &
                  temperature(i+1,old) -         &
                2*temperature(i,  old) +         &
                  temperature(i-1,old)           &                           )
   end forall
````

There's a synchronize statement at the beginning, to make sure we don't get ahead of any of our neighbours (or vice versa), and then we pluck the necessary data for our guardcells out of the coarray of temperature.

This seems familiar, and indeed it's not that different than the obvious [MPI implementation](https://github.com/ljdursi/coarray-examples/blob/bc356ec1dce3493c59800f1845c93bf18a6e7403/diffusion/diffusion-mpi.f90#L107):

```fortran
   !...

   call MPI_Sendrecv(temperature(locnpoints+1,old), 1, MPI_REAL, right, righttag,  &
             temperature(1,old), 1, MPI_REAL, left,  righttag, MPI_COMM_WORLD, rstatus, ierr)

   call MPI_Sendrecv(temperature(2,old), 1, MPI_REAL, left, lefttag,  &
             temperature(locnpoints+2,old), 1, MPI_REAL, right,  lefttag, MPI_COMM_WORLD, rstatus, ierr)

   !...
```

(and the update is exactly same).

But having the exchange done in facilities built into the language has another benefit.  Let's look back to the coarray version.  There's a synchronization point, communications, computation, and (although we don't see it here), a loop back to the synchronization point, as part of the iteration.

The compiler will, as it does, perform reorderings that it can prove to itself don't change the meaning of the code but will likely improve performance.  With memory increasingly a bottleneck, compilers frequently perform some sort of prefetch optimization to move requests for data from slow main memory forward, perform computations on data already cache for the ~200 cycles that access will take, and only then work on the data that hopefully has loaded.  

This optimization is familiar in the MPI world, of course; it's overlapping communication with computation, and is performed using non-blocking Sends and Receives.  But because the communication is explicit to the compiler, it's a difference of degree, not of kind, that the data is coming from over the network rather than from main memory.  Thus, this optimization is straightforwardly performed automatically by the compiler.

On the other hand, it is much less automatic for a developer to rewrite [the MPI code](https://github.com/ljdursi/coarray-examples/blob/1acda1378398f3973a0066e09d89498a36769839/diffusion/diffusion-mpi-nonblocking.f90#L105):

```fortran
!
! begin exchange of boundary information
!

           call MPI_Isend(temperature(locnpoints+1,old), 1, MPI_REAL, &
                          right, righttag, MPI_COMM_WORLD, requests(1), ierr)
           call MPI_Isend(temperature(2,old), 1, MPI_REAL, &
                          left, lefttag,  MPI_COMM_WORLD, requests(2), ierr)
           call MPI_Irecv(temperature(1,old), 1, MPI_REAL, &
                          left,  righttag, MPI_COMM_WORLD, requests(3), ierr)
           call MPI_Irecv(temperature(locnpoints+2,old), 1, MPI_REAL, &
                          right, lefttag, MPI_COMM_WORLD, requests(4), ierr)

!
! update solution
!
           forall (i=3:locnpoints)
               temperature(i,new) = temperature(i,old) + &
                     dt*kappa/(dx**2) * (                &
                          temperature(i+1,old) -         &
                        2*temperature(i,  old) +         &
                          temperature(i-1,old)           &
                     )
           end forall
           time = time + dt

!
! wait for communications to complete
!
           call MPI_Waitall(4, requests, statuses, ierr)
!
! update solution
!
           temperature(2,new) = temperature(2,old) + dt*kappa/(dx**2) *  &
                        ( temperature(1,old) - 2*temperature(2, old) + temperature(3,old) )
           temperature(locnpoints+1,new) = temperature(locnpoints+1,old) + dt*kappa/(dx**2) *  &
                        ( temperature(locnpoints,old) - 2*temperature(locnpoints+1, old) + &
                          temperature(locnpoints+2,old) )
```



### Block matrix multiplication

Let's take a look at another example, a simple [block matrix multiplication](https://github.com/ljdursi/coarray-examples/tree/master/blockmatrixmult) where each image/task has one block of the A and B matrices, and we're calculating $$C = A \times B$$.  

In the [CAF version](https://github.com/ljdursi/coarray-examples/blob/bc356ec1dce3493c59800f1845c93bf18a6e7403/blockmatrixmult/blockmatrix-coarray.f90#L38), this is almost embarrasingly easy:

```fortran
    sync all
    c = 0.
    do k=1,ncols
        c = c + matmul(a[myrow,k],b[k,mycol])
    enddo
    sync all
```

and the exchange not that bad in [the MPI version, either](https://github.com/ljdursi/coarray-examples/blob/bc356ec1dce3493c59800f1845c93bf18a6e7403/blockmatrixmult/blockmatrix-mpi.f90#L53), using the SUMMA algorithm (Cannon's, which can be better for small $P$, would have been messier):

```fortran
    do k=0,ncols-1
        aremote = a
        bremote = b
        call MPI_Bcast(aremote, blockrows*blockcols, MPI_INTEGER, k, rowcomm, ierr)
        call MPI_Bcast(bremote, blockrows*blockcols, MPI_INTEGER, k, colcomm, ierr)
        c = c + matmul(aremote, bremote)
    enddo
```

although it did take us a lot more boilerplate to get there; three communicators, explicit temporary arrays, etc:

```fortran
    call MPI_Init(ierr)
    call MPI_Comm_size(MPI_COMM_WORLD, comsize, ierr)

	!...

    allocate(aremote(blockrows,blockcols))
    allocate(bremote(blockcols,blockrows))

	!...

    call MPI_Cart_create(MPI_COMM_WORLD, 2, dims, [1,1], 1, cartcomm, ierr)
    call MPI_Comm_rank(cartcomm, rank, ierr)
    call MPI_Cart_coords(cartcomm, rank, 2, coords, ierr)

    ! create row, column communicators
    call MPI_Comm_split( cartcomm, myrow, mycol, rowcomm, ierr )
    call MPI_Comm_split( cartcomm, mycol, myrow, colcomm, ierr )
```

and this is still a fairly straightforward communications pattern.  As communications become more complex, the advantage of it being performed implicitly becomes more clear.

### Coarray Pros

We've only looked at two examples, but that's enough to get some feelings about the strengths and weaknesses of CAF vs other options:

#### Part of the Language

Compilers are enormously more sophisticated than they were twenty+ years ago, and using those optimization engines to our advantage in generating fast communications code is an enormous advantage.  Having the communications be explicit in the language enables the compiler to perform entire suites of automatic optimizations (prefetching, batching, memory/time tradeoffs) that can't easily done with library-based approaches.

#### Stable

One concern in the HPC community about trying new approaches is lingering doubt about whether a given new tool or language will be around five or ten years later; a concern that can become self-fulfilling.  

As part of the Fortran standard, Coarray Fortran is quite definitely here to stay; there are now several competing implementations, and competition will only improve them.

#### Incremental

Because Coarray Fortran uses a familiar model &mdash; Single Program, Multiple Data, with data manually decomposed &mdash; and only changes how the communications are expressed, there is very modest learning curve for developers already familiar with MPI, and very modest porting effort required.

The familiarity extends in another dimension, as well; Coarray fortran is about as "authentically HPC" as it's possible to get (Cray!  T3Es!  Fortran!) for a community that is sometimes skeptical of ideas from the outside.

In addition, this incremental approach also makes interoperability with MPI relatively straightforward, for those requiring MPI-based library support.

#### Already Quite Fast

OpenCoarrays, which provides the communications support for gfortran's coarray implementation, is [already comparable to and sometimes faster than](http://opencoarrays.org/yahoo_site_admin/assets/docs/pgas14_submission_7.30712505.pdf) typical MPI code and even faster in some cases the very-well tested Cray coarray implementation(!).  While this is still the first major release of gfortran coarrays, and performance improvements and doubtless bug fixes remain to be made, this is already a fairly solid and fast piece of software.

### Coarray Cons

On the other side of the ledger are primarily points we've already considered as Pros, but viewed from the glass-half-empty side:

#### Part of _A_ Language

Being built into a language means that it necessarily isn't available to users of other languages.  I think this is largely inevitable for next-gen HPC approaches, to take full advantage of the compilers and runtimes that are now available, but it certainly will affect adoption; I can't imagine too many C++ programmers will migrate to Fortran for their next project.  (Although it does start looking intriguing for Matlab or Python/Numpy users).

#### Stable

As I've mentioned in the context of MPI, too much stability can be a bad thing, and the Fortran committee makes the MPI Forum look like a squirrel on cocaine.  I'm less concerned about that here in the short term, since the Coarrays that went into the standard were based on a model that had been used for years successfully, and new features are already in the works; but any additional new features that are seen to be needed may well be a long time coming.

#### Incremental

That Coarrays are incremental certainly makes it easier to port existing code, but it means that many of my concerns about MPI as a development environment remain unaddressed.  A researcher or application developer still has to perform the manual decomposition of a problem.  This requires an enormous amount of eminently automatable boilerplate and zillions of opportunities for meaningless bugs like off-by-one errors.  (That sort of bookkeeping is precisely what computers are better at than developers!)  That burden also means that substantial amounts of code must be rewritten if the decomposition changes.

#### Already Quite Fast

...Ok, it's hard to see much of a downside here.

### Conclusion

The release of gcc-5.1 with coarray support is going to be the first time a huge number of HPC developers have ready access to coarrays.  From my point of view, it's notably less ambitious than a large number of projects out there, but that may well make it easier to adopt for a sizable community.  Certainly anyone planning to start a new project in Fortran should give it very serious consideration.

My own hope is that Coarray Fortran will have a large number of delighted users, some of whose appetite then becomes whetted for other still more productive languages and environments for large-scale technical computing.  In the next few posts, I'll take a closer look at some of those.
