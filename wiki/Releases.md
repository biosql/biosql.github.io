---
title: Releases
permalink: wiki/Releases
layout: page
---

BioSQL release v1.0.2 plans
---------------------------

This could be a small release adding an SQLite3 version of the schema,
which is already in the repository and supported by Biopython. What
remains to be done is updating the BioSQL Perl scripts (e.g. the
taxonomy loader) to support SQLite.

BioSQL release v1.0.1
---------------------

This is an update release of the v1.0 core BioSQL schema (code-named
Tokyo), not including recent extensions.

Note: open questions are in *italics.* If you have thoughts or feedback
on any of the below, please email them to biosql-l@lists.open-bio.org.

1.  Update INSTALL file *Done. --[Hilmar](http://lappland.io)
    05:02, 1 August 2008 (UTC)*
    -   Fix inconsistencies in naming of the BioSQL database instance
        (here and with Bioperl-db). Will name it simply biosql from
        now on.
    -   Add note about current incompatibility with PostgreSQL v8.3+.

2.  Implement [scheduled
    changes](Enhancement_Requests#scheduled-for-v10x "wikilink")
    *Done. --[Hilmar](http://lappland.io) 02:24, 2 August
    2008 (UTC)*
    -   Widen column width constraint of dbxref.accession and
        correspondingly bioentry.accession. Will use 128 chars for now.
    -   Add migration scripts at least for Pg, MySQL, and Oracle.

3.  Fix load\_ncbi\_taxonomy.pl to not rely on primary key and NCBI
    taxon ID to be identical. *Done. --[Hilmar](http://lappland.io)
    02:24, 2 August 2008 (UTC)*
4.  Update Changes file. *Done. --[Hilmar](http://lappland.io)
    05:02, 1 August 2008 (UTC)*
5.  Merge changes to biosql-release-1-0 branch. *Done.
    --[Hilmar](http://lappland.io) 12:21, 2 August 2008 (UTC)*
6.  Write release announcement. *Done.
    --[Hilmar](http://lappland.io) 12:21, 2 August 2008 (UTC)*
7.  Tag release with biosql-rel-1.0.1 *Done.
    --[Hilmar](http://lappland.io) 13:42, 2 August 2008 (UTC)*
8.  Package BioSQL for release, upload to download
    site (http://biosql.org/DIST) *Done.
    --[Hilmar](http://lappland.io) 13:42, 2 August 2008 (UTC)*
9.  Release: *Done on Aug 2, except for the news post which was done by
    Peter Cock a few days later.*
    -   Add download and release link to wiki on front page.
    -   Post announcement to biosql-l and news.open-bio.org.

BioSQL release v1.0.0
---------------------

This is a release of the core BioSQL schema, not including recent
extensions.

Note: open questions are in *italics.* If you have thoughts or feedback
on any of the below, please email them to biosql-l@lists.open-bio.org.

1.  Update license for BioSQL and all its DDL and software scripts.
    *Done. This is now the LGPL license for all schema files.
    --[Hilmar](http://lappland.io) 20:23, 21 February 2008 (EST)*
    -   The current license refers to the 'same terms as Perl' and the
        Perl Artistic Licence. Not only does Perl now dual-license under
        Artistic License v2.0 or GPL (because the original Perl Artistic
        License v1.0 has problems), but also there isn't a good reason
        to tie the BioSQL license to that of Perl.

2.  Update, fix, or remove various ancillary files that don't seem to
    have been touched in a long time.
    -   biosql-accelerators-pg.sql *Updated/fixed, and now also retired.
        --[Hilmar](http://lappland.io) 23:40, 22 February
        2008 (EST)*
    -   biosqldb-views-pg.sql *Done. --[Hilmar](http://lappland.io)
        20:31, 21 February 2008 (EST)*

3.  Rename biosql-ora to biosqldb-ora for consistency with the other
    schema versions *Done. --[Hilmar](http://lappland.io) 20:31, 21
    February 2008 (EST)*
4.  Regenerate HTML documentation from schema DDL (using sqlt) *Doesn't
    work, sqlt seems to be broken at present.
    --[Hilmar](http://lappland.io) 21:11, 21 February 2008 (EST)*
5.  Update Changes file. *Done. --[Hilmar](http://lappland.io)
    23:41, 22 February 2008 (EST)*
6.  Update documentation in the repository. *Done, for
    [Biopython](http://code.open-bio.org/svnweb/index.cgi/biosql/browse/biosql-schema/trunk/doc/biopython)
    (see
    [PDF](http://code.open-bio.org/svnweb/index.cgi/biosql/checkout/biosql-schema/trunk/doc/biopython/python_biosql_basic.pdf))
    and
    [BioJava/Oracle](http://code.open-bio.org/svnweb/index.cgi/biosql/checkout/biosql-schema/trunk/doc/bj_and_bsql_oracle_howto.htm).
    Unfortunately, realized this not before, but only after branching
    off, so need to merge all changes to the branch.
    --[Hilmar](http://lappland.io) 12:06, 24 February 2008 (EST)*
7.  Create biosql-release-1-0 branch. *Done.
    --[Hilmar](http://lappland.io) 23:43, 22 February 2008 (EST)*
8.  Remove from biosql-release-1-0 branch all schema modules or versions
    and all scripts that aren't release-ready yet, or are not yet or no
    longer supported. *Done. --[Hilmar](http://lappland.io) 23:43,
    22 February 2008 (EST)*
    -   This includes the following:
        -   phylodb module DDLs
        -   phylodb ERD
        -   phy\* scripts (depend on phylodb, and not up-to-date)
        -   load\_itis\_taxonomy.pl, tree-precompute.pl scripts (depend
            on phylodb, and not up-to-date)
        -   phylodb-topo-queries.sql (depends on phylodb)
    -   *Can the HSQLDB version be tested by anyone for syntactic
        correctness and compatibility with a current revision of
        HSQLDB?*

9.  Write release announcement. *Done.
    --[Hilmar](http://lappland.io) 10:52, 5 March 2008 (EST)*
10. Tag release with biosql-rel-1.0.0 *Done.
    --[Hilmar](http://lappland.io) 10:53, 5 March 2008 (EST)*
11. Package BioSQL for release, upload to download
    site (http://biosql.org/DIST) *Done, with MD5 signatures.
    --[Hilmar](http://lappland.io) 17:07, 6 March 2008 (EST)*
12. Release: *Done. --[Hilmar](http://lappland.io) 22:02, 6 March
    2008 (EST)*
    -   Add download and release link to wiki on front page (also add
        Downloads page ot sidebar).
    -   Post announcement to biosql-l and news.open-bio.org.


