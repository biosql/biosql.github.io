---
title: Main Page
permalink: wiki/Main_Page
layout: wiki
---

About BioSQL
------------

BioSQL is a generic relational model covering sequences, features,
sequence and feature annotation, a reference taxonomy, and ontologies
(or controlled vocabularies).

While in its original incarnation (in 2001) conceived by Ewan Birney as
a local relational store for GenBank, the project has since become a
collaboration between the [BioPerl](bp:Main_Page "wikilink"),
[BioPython](biopython:Main_Page "wikilink"),
[BioJava](bj:Main_Page "wikilink"), and [BioRuby](http://bioruby.org)
projects. The goal is to build a sufficiently generic schema for
persistent storage of sequences, features, and annotation in a way that
is interoperable between the Bio\* projects. Each Bio\* project has a
[language binding](#Language_Bindings "wikilink") (object-relational
mapping, ORM) to BioSQL.

Schema Overview
---------------

A good introduction to BioSQL and it's intended use is the [schema
overview](Schema_Overview "wikilink") document. This was originaly
copied from SVN, and it isnow being maintained as a live document in
this wiki.

### Extension Modules

Extension modules are optional, and only needed for storing or
retrieving the respective data types it accommodates. Language mappings
should not expect these modules to be present if only core-schema data
types are being persisted or retrieved.

### PhyloDB

A PhyloDB extension module for storing phylogenetic trees and taxonomies
has been under development since December 2006 (started by Bill Piel and
Hilmar Lapp at the [Phyloinformatics
Hackathon](http://hackathon.nescent.org/Phylohackathon_1)).

The module is in pre-release status. It has undergone considerable
extensions at the [BioHackathon 2008](http://hackathon.dbcls.jp), and is
still subject to changes.

### Supported RDBMs

At present there are versions for PostgreSQL, MySQL, Oracle, HSQLDB, and
Apache Derby for the core schema.

Language Bindings
-----------------

The Bio\* projects provide object relational mapping from their
respective object models to BioSQL. Details for each project can be
obtained from the links below.

-   [BioJava](BioJava_BioSQL_ORM "wikilink")
-   [BioPerl](bp:Bioperl-db "wikilink")
-   BioRuby
-   [BioPython](http://cvs.biopython.org/cgi-bin/viewcvs/viewcvs.cgi/biopython/BioSQL/?cvsroot=biopython)

In Progress
-----------

*Work is underway to migrate the documentation from the code repository
to this website.*

See [schema SVN
repository](http://code.open-bio.org/svnweb/index.cgi/biosql/browse/biosql-schema/trunk)
and [BioPerl-DB
implementation](http://code.open-bio.org/svnweb/index.cgi/bioperl/browse/bioperl-db/trunk/)
for starters.

To Do
-----

[Bugs](Bugs "wikilink") and suggestions for
[improvement](Enhancement_Requests "wikilink")

Contacts
--------

Project lead is [Hilmar Lapp](bp:Hilmar_Lapp "wikilink"). Questions
should be sent to the BioSQL mailing list at
[biosql-l@lists.open-bio.org](mailto:biosql-l%40lists%2eopen-bio%2eorg).
