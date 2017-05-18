---
title:  "Spark, Chapel, TensorFlow: Workshop at UMich"
tags: ['spark', 'chapel', 'tensorflow']
---

The kind folks at the University of Michigan's [Center for Computational Discovery and Engineering (MICDE)](http://micde.umich.edu), which is just part of the very impressive [Advanced Research Computing](http://arc.umich.edu) division, invited me to give a workshop there a couple of months ago about the rapidly-evolving large-scale numerical computing ecosystem.  

There's lots that I want to do to extend this to a half-day length, but the workshop materials &mdash; including a VM that can be used to play with [Spark](http://spark.apache.org), [Chapel](http://chapel.cray.com) and [TensorFlow](https://www.tensorflow.org), along with Jupyter notebooks for each &mdash; can be found [on GitHub](https://github.com/ljdursi/Spark-Chapel-TF-UMich-2016) and may be of some use to others as they stand.

The title and abstract follow.

> #### Next Generation HPC?  What Spark, TensorFlow, and Chapel are teaching us about large-scale numerical computing

> For years, the academic science and engineering community was almost alone in pursuing very large-scale numerical computing, and MPI - the 1990s-era message passing library - was the lingua franca for such work.  But starting in the mid-2000s, others became interesting in large-scale computing on data.  First internet-scale companies like Google and Yahoo! started performing fairly basic analytics tasks at enormous scale, and now many others are tackling increasingly complex and data-heavy machine-learning computations, which involve very familiar scientific computing tasks such as linear algebra, unstructured mesh decomposition, and numerical optimization.  But these new communities have created programming environments which emphasize what we’ve learned about computer science and programmability since 1994 - with greater levels of abstraction and encapsulation, separating high-level computation from the low-level implementation details, and some in HPC are starting to notice.  This talk will give a brief introduction to Apache Spark environment and Google’s Tensor Flow machine-learning package for high-level numerical computation, as well as the HPC-focused Chapel language from Cray, to show where each can be used today and how they might be used in the future.   The slides for this talk, and examples for each package along with a virtual machine which can be used for running them, will be available at https://github.com/ljdursi/Spark-Chapel-TF-UMich-2016 .
