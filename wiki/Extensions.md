---
title: Extensions
permalink: wiki/Extensions
layout: wiki
---

Extension modules are optional, and only needed for storing or
retrieving the respective data types it accommodates. Language mappings
should not expect these modules to be present if only core-schema data
types are being persisted or retrieved.

PhyloDB
-------

A PhyloDB extension module for storing phylogenetic trees and taxonomies
has been under development since December 2006 (started by Bill Piel and
Hilmar Lapp at the [Phyloinformatics
Hackathon](http://informatics.nescent.org/wiki/Phylohackathon_1)). The
[schema overview](PhyloDBSchema "wikilink") is a good place to start.

The module is in pre-release status and is only available via
[Git](http://github.com/biosql/biosql).

-   [schema in
    PostgreSQL](http://github.com/biosql/biosql/blob/master/sql/biosql-phylodb-pg.sql)
-   [entity-relationship
    diagram](http://github.com/biosql/biosql/blob/master/doc/biosql-phylodb.pdf)
-   [topological queries against the
    schema](http://github.com/biosql/biosql/blob/master/sql/phylodb-topo-queries.sql).

The schema module has undergone considerable extensions at the
[BioHackathon 2008](http://hackathon.dbcls.jp), and is still subject to
changes.
