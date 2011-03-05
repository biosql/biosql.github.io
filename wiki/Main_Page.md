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

**Schema Overview:** A good introduction to the core BioSQL schema and
its intended use is the [schema overview](Schema_Overview "wikilink")
document.

-   [Extension modules](Extensions "wikilink") extend the core schema
    and are optional unless specifically needed for storing or
    retrieving the respective data types the module accommodates. At
    present, there is one extension module, PhyloDB, for storing
    phylogenetic trees and taxonomies.
-   Supported RDBMs are at present PostgreSQL, MySQL, Oracle, HSQLDB,
    and Apache Derby for the core schema.

Downloads & Releases
--------------------

The [current release of the BioSQL core schema is
v1.0.1](Downloads "wikilink"). [Release plans](Releases "wikilink") with
status information for upcoming releases are available, or will be
posted on this wiki.

The PhyloDB extension module has not been released yet and is only
available from the [Git repository](http://github.com/biosql/biosql).
[Instructions for downloading code from Git
anonymously](http://open-bio.org/wiki/SourceCode#Downloading_and_updating_code_via_Anonymous_Git)
are on the O|B|F wiki; the URL for the master branch of BioSQL is
[`git://github.com/biosql/biosql.git`](git://github.com/biosql/biosql.git).

The [Downloads](Downloads "wikilink") section has links to downloads for
current and past releases as well as pre/alpha-releases.

Documentation
-------------

*Work is underway to migrate the documentation from the code repository
to this website.*

-   See the [schema overview](Schema_Overview "wikilink") for an
    overview of the BioSQL model. In addition, see the documentation in
    the [schema Git repository](https://github.com/hlapp/biosql),
    especially
    [INSTALL](https://github.com/hlapp/biosql/blob/master/INSTALL), and
    documents in the
    [doc/](https://github.com/hlapp/biosql/tree/master/doc) subdirectory.
-   Instantiating the schema and pre-populating it with the NCBI
    taxonomy or other data are extensively documented in the
    [INSTALL](https://github.com/hlapp/biosql/blob/master/INSTALL) file
    in BioSQL (MySQL and PostgreSQL), the [BioSQL page at the BioPython
    wiki](biopython:BioSQL "wikilink") (MySQL), and the [Biojava/BioSQL
    HowTo](http://code.open-bio.org/svnweb/index.cgi/biosql/checkout/biosql-schema/trunk/doc/bj_and_bsql_oracle_howto.htm) (Oracle).
-   See [possible optimizations of local BioSQL
    installations](Optimizations "wikilink").
-   BioSQL add-on modules are documented as [Extension
    modules](Extensions "wikilink") (and the repository may hold
    additional documentation for them, too).

Bug Reports & Enhancement Requests
----------------------------------

The [O|B|F Bugzilla instance](http://bugzilla.open-bio.org) has a BioSQL
product [to which you can submit
bugs](http://bugzilla.open-bio.org/enter_bug.cgi?product=BioSQL).

You may also report issues directly to the
[BioSQL](http://lists.open-bio.org/mailman/listinfo/biosql-l) mailing
list at
[biosql-l@lists.open-bio.org](mailto:biosql-l%40lists%2eopen-bio%2eorg).

This wiki documents [enhancement requests and which BioSQL version they
are scheduled](Enhancement_Requests "wikilink") to be incorporated in
(if they have been scheduled yet).

Language Bindings
-----------------

The Bio\* projects provide object relational mapping from their
respective object models to BioSQL. Details for each project can be
obtained from the links below.

-   [BioJava](BioJava_BioSQL_ORM "wikilink")
-   [BioPerl](bp:Bioperl-db "wikilink")
-   [BioRuby](http://bioruby.open-bio.org/wiki/Tutorial#BioSQL)
-   [BioPython](biopython:BioSQL "wikilink") (this also contains
    excellent documentation for installing BioSQL)

See also the recommendations for [mapping sequence annotation to the
BioSQL relational model](Annotation_Mapping "wikilink").

Contacts
--------

Project lead is [Hilmar Lapp](bp:Hilmar_Lapp "wikilink"). Questions
should be sent to the BioSQL mailing list at
[biosql-l@lists.open-bio.org](mailto:biosql-l%40lists%2eopen-bio%2eorg).
You can also [subscribe](http://open-bio.org/mailman/listinfo/biosql-l)
to the mailing list to keep up to date with discussions and
announcements.

In addition, the [biosql-guts
list](http://open-bio.org/mailman/listinfo/biosql-guts-l) is for bug
tracking and commit messages.
