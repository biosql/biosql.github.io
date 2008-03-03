---
title: Optimizations
permalink: wiki/Optimizations
layout: wiki
---

This page lists optimizations that people have found useful in their
local BioSQL installations. Generally applicable optimizations may
eventually find their way into the BioSQL standard schema, whereas those
only available for one or a few RDBMS versions may not. Nonetheless,
they are listed here for others to take advantage of or try.

Optimizations adopted into standard BioSQL
------------------------------------------

RDBMS-specific optimizations
----------------------------

### Indexing only a substring of qualifier values

There is a possibility in MySQL to index only an initial substring,
which can be very effective for qualifier values, for example
seqfeature\_qualifier\_value: <sql> CREATE INDEX value\_ind ON
seqfeature\_qualifier\_value (term\_id, value(64)); </sql> This would
index only the first 64 characters of the value column. [Suggested by
Dmitry
Samborskiy](http://lists.open-bio.org/pipermail/biosql-l/2007-March/001064.html).

A similar functionality could by achieved in PostgreSQL and Oracle since
they support functional indexes, but these would only be used if the
query used the same function, and hence require specific query
rewriting, which is not transparent.
