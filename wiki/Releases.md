---
title: Releases
permalink: wiki/Releases
layout: wiki
---

BioSQL release v1.0.0
---------------------

This is a release of the core BioSQL schema, not including recent
extensions.

### Release schedule

Note: open questions are in *italics.* If you have thoughts or feedback
on any of the below, please email them to biosql-l@lists.open-bio.org.

1.  Update license for BioSQL and all its DDL and software scripts.
    *Done. This is now the LGPL license for all schema files.
    --[Hilmar](User%3AHlapp "wikilink") 20:23, 21 February 2008 (EST)*
    -   The current license refers to the 'same terms as Perl' and the
        Perl Artistic Licence. Not only does Perl now dual-license under
        Artistic License v2.0 or GPL (because the original Perl Artistic
        License v1.0 has problems), but also there isn't a good reason
        to tie the BioSQL license to that of Perl.

2.  Update, fix, or remove various ancillary files that don't seem to
    have been touched in a long time.
    -   biosql-accelerators-pg.sql *Updated/fixed, and now also retired.
        --[Hilmar](User%3AHlapp "wikilink") 23:40, 22 February
        2008 (EST)*
    -   biosqldb-views-pg.sql *Done. --[Hilmar](User%3AHlapp "wikilink")
        20:31, 21 February 2008 (EST)*

3.  Rename biosql-ora to biosqldb-ora for consistency with the other
    schema versions *Done. --[Hilmar](User%3AHlapp "wikilink") 20:31, 21
    February 2008 (EST)*
4.  Regenerate HTML documentation from schema DDL (using sqlt) *Doesn't
    work, sqlt seems to be broken at present.
    --[Hilmar](User%3AHlapp "wikilink") 21:11, 21 February 2008 (EST)*
5.  Update Changes file. *Done. --[Hilmar](User%3AHlapp "wikilink")
    23:41, 22 February 2008 (EST)*
6.  Update documentation in the repository. *Done, for
    [Biopython](http://code.open-bio.org/svnweb/index.cgi/biosql/browse/biosql-schema/trunk/doc/biopython)
    (see
    [PDF](http://code.open-bio.org/svnweb/index.cgi/biosql/checkout/biosql-schema/trunk/doc/biopython/python_biosql_basic.pdf))
    and
    [BioJava/Oracle](http://code.open-bio.org/svnweb/index.cgi/biosql/checkout/biosql-schema/trunk/doc/bj_and_bsql_oracle_howto.htm).
    Unfortunately, realized this not before, but only after branching
    off, so need to merge all changes to the branch.
    --[Hilmar](User%3AHlapp "wikilink") 12:06, 24 February 2008 (EST)*
7.  Create biosql-release-1-0 branch. *Done.
    --[Hilmar](User%3AHlapp "wikilink") 23:43, 22 February 2008 (EST)*
8.  Remove from biosql-release-1-0 branch all schema modules or versions
    and all scripts that aren't release-ready yet, or are not yet or no
    longer supported. *Done. --[Hilmar](User%3AHlapp "wikilink") 23:43,
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
    --[Hilmar](User%3AHlapp "wikilink") 10:52, 5 March 2008 (EST)*
10. Tag release with biosql-rel-1.0.0 *Done.
    --[Hilmar](User%3AHlapp "wikilink") 10:53, 5 March 2008 (EST)*
11. Package BioSQL for release, upload to download
    site (http://biosql.org/DIST) *Done, with MD5 signatures.
    --[Hilmar](User%3AHlapp "wikilink") 17:07, 6 March 2008 (EST)*
12. Release: *Done. --[Hilmar](User%3AHlapp "wikilink") 22:02, 6 March
    2008 (EST)*
    -   Add download and release link to wiki on front page (also add
        Downloads page ot sidebar).
    -   Post announcement to biosql-l and news.open-bio.org.


