---
title: Releases
permalink: wiki/Releases
layout: wiki
---

BioSQL release v1.0
-------------------

This is a release of the core BioSQL schema, not including recent
extensions.

### Release schedule

Note: open questions are in *italics.* If you have thoughts or feedback
on any of the below, please email them to biosql-l@lists.open-bio.org.

1.  Update license for BioSQL and all its DDL and software scripts.
    -   The current license refers to the 'same terms as Perl' and the
        Perl Artistic Licence. Not only does Perl now dual-license under
        Artistic License v2.0 or GPL (because the original Perl Artistic
        License v1.0 has problems), but also there isn't a good reason
        to tie the BioSQL license to that of Perl.

2.  Rename biosql-ora to biosqldb-ora for consistency with the other
    schema versions
3.  Regenerate HTML documentation from schema DDL (using sqlt)
4.  Create biosql-release-1.0 branch.
5.  Remove from biosql-release-1.0 branch all schema modules or versions
    and all scripts that aren't release-ready yet, or are not yet or no
    longer supported.
    -   This includes the following:
        -   phylodb module DDLs
        -   phylodb ERD
        -   phy\* scripts (depend on phylodb, and not up-to-date)
        -   load\_itis\_taxonomy.pl, tree-precompute.pl scripts (depend
            on phylodb, and not up-to-date)
        -   phylodb-topo-queries.sql (depends on phylodb)
    -   *What about biosqldb-derby.sql? Has this been tested enough?*
    -   *Can the HSQLDB version be tested by anyone for syntactic
        correctness and compatibility with a current revision of
        HSQLDB?*

6.  Write release announcement.
7.  Package BioSQL for release, upload to download site. *Which site
    should we use? Is there a common one for Open-Bio? Create separate
    one for BioSQL?*
8.  Release:
    -   Add download and release link to wiki on front page (also add
        Downloads page ot sidebar).
    -   Post announcement to biosql-l (*there is no biosql-announce,
        right?*) and news.open-bio.org.


