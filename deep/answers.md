# From the Deep

In this problem, you'll write freeform responses to the questions provided in the specification.

## Random Partitioning

The observations will be evenly distributed.
The researcher will need to run the query on all of the boats.
+: Maximizes the memory storage.
-: Non-organized data, more difficult to query.

## Partitioning by Hour

The observations will not be evenly distributed.
The researcher will need to run the query on only some of the boats.
+: Easier querying if your main interest is to study differences in time.
-: Not optimizing storage capacity.

## Partitioning by Hash Value

The observations will be evenly distributed.
The researcher will likely need to run the query on all of the boats.
The researcher will need to run the query on only some of the boats.
+: Same as randomly distributed, BUT with better organization (more ordered)
-: Not as organized as "Partitioning by Hour". It's like a middle point. 
