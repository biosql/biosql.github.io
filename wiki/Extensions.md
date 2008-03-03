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
Hackathon](http://hackathon.nescent.org/Phylohackathon_1)).

The module is in pre-release status. An [ERD is in the
repository](http://code.open-bio.org/svnweb/index.cgi/biosql/checkout/biosql-schema/trunk/doc/biosql-phylodb.pdf),
as are a number of [topological queries against the
schema](http://code.open-bio.org/svnweb/index.cgi/biosql/view/biosql-schema/trunk/sql/phylodb-topo-queries.sql).
The schema module has undergone considerable extensions at the
[BioHackathon 2008](http://hackathon.dbcls.jp), and is still subject to
changes.
