---
title: BioJava BioSQL ORM
permalink: wiki/BioJava_BioSQL_ORM
layout: wiki
---

[BioJava](http://biojava.org) provides object relational mapping
(ORM) to BioSQL 1.0 using [Hibernate](http://www.hibernate.org) bindings
to objects in the `org.biojavax` packages.

BioJavaX Design
===============

[BioJavaX](http://biojava.org/wikis/BioJava:BioJavaXDocs/) was officially
released with BioJava1.5. It extends the `org.biojava` API's and was
designed to very closely match the BioSQL schema. This made ORM of
[BioJava](http://biojava.org) to BioSQL much more straight forward
and brought the BioJava object model much closer to that used by
[BioPerl](http://bioperl.org).

Hibernate Mapping
=================

[Hibernate](http://www.hibernate.org) is currently used as the ORM
provider for BioJava. Mapping is defined using xml config files. These
files formally define where objects are written in the database.

Hibernate mappings are currently defined for the following RDBMS's:

-   [PostGres](http://code.open-bio.org/svnweb/index.cgi/biojava/browse/biojava-live/trunk/src/org/biojavax/bio/db/biosql/pg)
-   [Oracle](http://code.open-bio.org/svnweb/index.cgi/biojava/browse/biojava-live/trunk/src/org/biojavax/bio/db/biosql/oracle)
-   [MySQL](http://code.open-bio.org/svnweb/index.cgi/biojava/browse/biojava-live/trunk/src/org/biojavax/bio/db/biosql/mysql)
-   [HyperSonic](http://code.open-bio.org/svnweb/index.cgi/biojava/browse/biojava-live/trunk/src/org/biojavax/bio/db/biosql/hsqldb)
-   Derby (comming soon)

JPA and Annotations
===================

In the near future it would be desirable to update BioJava to make use
of JPA and Annotations to define entity mappings. This would offer
several advantages.

1.  It would be possible to define a JPA entity manager which would not
    need to know which ORM system is being used. Currently we are
    limited to Hibernate.
2.  Annotations could be used in classes that form entities removing the
    need for XML configuration.
3.  If XML configuration is prefered then there would not be a need for
    one per RDBMS.

Legacy Mapping
==============

BioJava does contain a legacy mapping to the Singapore release of the
BioSQL Schema. This is outdated, buggy, deprecated and not maintained.
We retain it only for backwards compatability and reserve the right to
drop this support at any time in the future. The mapping is not
compatable with any other Bio\* project. We strongly advise against
using it.
