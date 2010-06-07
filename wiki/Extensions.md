---
title: Extensions
permalink: wiki/Extensions
layout: wiki
---

Extension modules are optional, and only needed for storing or
retrieving the respective data types it accommodates. Language mappings
should not expect these modules to be present if only core-schema data
types are being persisted or retrieved

PhyloDB
-------

A PhyloDB extension module for storing phylogenetic trees and taxonomies
has been under development since December 2006 (started by Bill Piel and
Hilmar Lapp at the [Phyloinformatics
Hackathon](http://hackathon.nescent.org/Phylohackathon_1)). The [schema
overview](PhyloDBSchema "wikilink") is good place to start.

The module is in pre-release status and is only available via
[Subversion](http://code.open-bio.org/svnweb/index.cgi/biosql/browse/biosql-schema/trunk)
(see [instructions for downloading code from anonymous
svn](http://open-bio.org/wiki/SourceCode#Downloading_and_updating_code_via_Anonymous_SVN)
on the O|B|F wiki; the URL for the main trunk of BioSQL is
[`svn://code.open-bio.org/biosql/biosql-schema/trunk`](svn://code.open-bio.org/biosql/biosql-schema/trunk)).

-   [schema in
    PostgreSQL](http://code.open-bio.org/svnweb/index.cgi/biosql/view/biosql-schema/trunk/sql/biosql-phylodb-pg.sql)
-   [entity-relationship
    diagram](http://code.open-bio.org/svnweb/index.cgi/biosql/checkout/biosql-schema/trunk/doc/biosql-phylodb.pdf)
-   [topological queries against the
    schema](http://code.open-bio.org/svnweb/index.cgi/biosql/view/biosql-schema/trunk/sql/phylodb-topo-queries.sql).

The schema module has undergone considerable extensions at the
[BioHackathon 2008](http://hackathon.dbcls.jp), and is still subject to
changes.
