---
title:  "Spark in HPC clusters"
tags: ['hpc', 'spark']
---

Over the past several years, as research computing centres and others who run HPC clusters tried to accommodate other forms of computing for data analysis, [much](http://www.sdsc.edu/~allans/MyHadoop.pdf) [effort](http://www.hadoopsphere.com/2013/06/options-for-mapreduce-with-hpc.html) went into trying to incorporate Hadoop jobs into the scheduler along with other more traditional HPC jobs.  It never went especially well, which is a shame, because it seems that those past unsuccessful attempts have [discouraged](http://www.hadoopsphere.com/2013/06/options-for-mapreduce-with-hpc.html) experimentation with related next-generation technologies which are a much better fit for large-scale technical computing.

Hadoop v1 was always going to be a niche player and an awkward fit for big technical computing - and HPCers weren't the only ones to notice this.  Hadoop MapReduce's mandatory dumping of output to disk after every Map/Reduce stage rendered it nearly unusable for any sort of approach which required iteration, or interactive use. Machine learning users, who often rely on many of the same iterative linear algebra solvers that physical science simulation users need, equally found Hadoop unhelpful.  Hadoop v1 solved one set of problems &ndash; large single-pass data processing &ndash; very well, but those weren't the problems that the technical computing community needed solved.

The inefficiency of flushing to disk wasn't necessarily the difficulty that HPC centres had with incorporating Hadoop into their clusters, however.  Dumping to disk could be sped up with caching, or SSDs.  The real issue was with [HDFS](http://hadoop.apache.org/docs/r2.6.0/hadoop-project-dist/hadoop-hdfs/HdfsUserGuide.html), the filesystem which Hadoop relies on.  Because every job needed very rapid access to its data &ndash; to read the entire set in to the compute nodes, do minimal processing, then flush it back out &ndash; the file system was intimately tied to Hadoop cluster scheduling, which worked very hard (reasonably enough) to schedule the compute next to the data.  But with Hadoop "on demand" in a cluster, how is this to work?  One could spin up a new HDFS within each Hadoop job &ndash; but now the user has to have the new empty HDFS ingest the data files (probably with replication) initially, and then stage the data out of the doomed-to-be-shut-down HDFS afterwards.  But this staging in and out will certainly take substantially longer than even the rest of the job's I/O, which already likely dominates runtime.  One can reserve a number of nodes for Hadoop jobs and keep a persistent HDFS store there, but this now defeats the purpose of running Hadoop in the cluster; one might as well just hive off those nodes into a separate system.  Probably the best approach, which worked better than I think anyone had any right to expect, was to run [Hadoop on Lustre](http://wiki.lustre.org/index.php/Running_Hadoop_with_Lustre), but it remained awkward even for those who already were using Lustre for their cluster.

The HPC community's reaction to those problems &ndash; problems with a technology they were already skeptical of due to [Not Invented Here Syndrome](http://en.wikipedia.org/wiki/Not_invented_here) &ndash;  was largely to give up on anything that seemed "Hadoopy" as a sensible approach.  The large-scale machine learning community, which didn't necessarily have that luxury, was instead already looking for in-memory approaches to avoid this problem entirely.

Two very promising "post-Hadoop" in-memory approaches which are much better suited to large-scale technical computing than Hadoop v1 ever was are also Apache projects - [Spark](https://spark.apache.org) and [Flink](https://flink.apache.org).  Flink has some really interesting features - including using a database-like query optimizer for almost all computations - but there's no real question that currently, Spark is the more mature and capable of the offerings.

Spark can make use of HDFS, and other related file stores, but those aren't requirements; since iterative computation can be done in memory given enough RAM, there is much less urgency in having the data local to the computation if the computation is long enough.  Instead, Spark can simply use a POSIX interface to whatever filesystem is already running on your cluster.

Spark not only lacks hard HDFS-style requirements, but can also run in [standalone mode](http://spark.apache.org/docs/latest/spark-standalone.html) without a heavyweight scheduler like [Yarn](http://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/YARN.html) or [Mesos](http://mesos.apache.org/).   This standalone mode makes it quite easy to simply spin up a Spark "cluster" within a job, reading from the file system as any other job would.  (Earlier versions of Spark made this unnecessarily difficult, with the standalone startup scripts having hardcoded values that assumed only one such job at a time; this is somewhat easier now.)

Thus, below is a little job submission script for a Spark job on [SciNet](http://www.scinethpc.ca); it starts up a Spark master on the head node of the job, sets the workers, and runs a simple wordcount example.

Spark's well-thought-out python interface, standalone mode, and filesystem-agnostic approach, makes Spark a much better match for traditional HPC systems than Hadoop technologies ever were.

Spark is covered a little bit in my and Mike Nolta's [Hadoop-for-HPCers](http://www.dursi.ca/hadoop-for-hpcers/) workshop.

```
#!/bin/bash
#
#PBS -l nodes=3:ppn=8,walltime=0:20:00
#PBS -N spark-test

nodes=($( cat $PBS_NODEFILE | sort | uniq ))
nnodes=${#nodes[@]}
last=$(( $nnodes - 1 ))

cd $PBS_O_WORKDIR

export SPARK_HOME=/scinet/gpc/Libraries/spark/spark-1.0.2-bin-hadoop2/
ssh ${nodes[0]} "module load java; cd ${SPARK_HOME}; ./sbin/start-master.sh"
sparkmaster="spark://${nodes[0]}:7077"

for i in $( seq 0 $last )
do
    ssh ${nodes[$i]} "cd ${SPARK_HOME}; module load java; nohup ./bin/spark-class org.apache.spark.deploy.worker.Worker ${sparkmaster} &> ${SCRATCH}/work/nohup-${nodes[$i]}.out" &
done

rm -rf ${SCRATCH}/wordcounts

cat > sparkscript.py <<EOF
from pyspark import SparkContext

sc = SparkContext(appName="wordCount")
file = sc.textFile("${SCRATCH}/moby-dick.txt")
counts = file.flatMap(lambda line: line.split(" ")).map(lambda word: (word, 1)).reduceByKey(lambda a, b: a+b)
counts.saveAsTextFile("${SCRATCH}/wordcounts")
EOF

module load java
${SPARK_HOME}/bin/spark-submit --master ${sparkmaster} sparkscript.py

ssh ${nnodes[0]} "module load java; cd ${SPARK_HOME}; ./sbin/stop-master"
for i in $( seq 0 $last )
do
    ssh ${nodes[$i]} "killall java"
done
wait

```
