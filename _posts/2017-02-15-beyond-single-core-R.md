---
title:  "Beyond Single Core R: Parallel Data Analysis"
tags: ['R', 'presentation']
---

I was asked recently to do short presentation for the [Greater Toronto R Users Group](https://www.meetup.com/Greater-Toronto-Area-GTA-R-Users-Group)
on parallel computing in R; My slides can be seen below or on [github](https://ljdursi.github.io/beyond-single-core-R), where [the complete materials can be found](https://github.com/ljdursi/beyond-single-core-R).

I covered some similar things I had covered in a half-day workshop
a couple of years earlier (though, obviously, without the hands-on
component):
* How to think about parallelism and scalability in data analysis
* The standard parallel package, including what was the snow and multicore facilities, using airline data as an example
* The foreach package, using airline data and simple stock data;
* A summary of best practices,

with some bonus material tacked on the end touching on a couple advanced topics.

I was quite surprised at how little had changed since late 2014, other than 
further development of [SparkR](http://spark.apache.org/docs/latest/sparkr.html) (which
I didn't cover), and the interesting but seemingly not very much used [future](https://cran.r-project.org/web/packages/future/index.html)
package.   I was also struck by how hard it is to find similar materials
online, covering a range of parallel computing topics in R - it's rare enough
that even this simple effort made it to the [HPC project view on CRAN](https://cran.r-project.org/web/views/HighPerformanceComputing.html) 
(under "related links").  R [continues to grow in popularity](http://spectrum.ieee.org/computing/software/the-2016-top-programming-languages) for data analysis; 
is this all desktop computing?  Is Spark siphoning off the clustered-dataframe
usage?

(This was also my first time with [RPres](https://support.rstudio.com/hc/en-us/articles/200486468-Authoring-R-Presentations) in RStudio;
wow, not a fan, RPres was _not_ ready for general release.  And I'm a big fan of RMarkdown.)

<iframe src="https://ljdursi.github.io/beyond-single-core-R" width="595" height="500" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe>
