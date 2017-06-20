---
title: Enhancement Requests
permalink: wiki/Enhancement_Requests
layout: wiki
---

Scheduled for v1.1
------------------

BioSQL v1.1 may have changes that may not be fully backwards compatible,
such as new or dropped tables, or changes in the cardinality of
relationships. At a minimum it will require language bindings to be
extensively tested for compatibility with the changes.

### Circular Sequences

It would be desirable to have a flag to indicate a circular sequence in
the BioSequence table.

### Surrogate primary keys on all tables

The current BioSQL unique keys enforce constraints upon the data. Most
have primary keys in addition but in some tables there is no primary
key. Here it is implied that the unique key is the primary key, but
using compound keys such as this is not 'tidy' (because some columns in
the key may be mutable, whereas normally a primary key is assumed to be
immutable by most generic ORMs) and causes problems when attempting to
auto-generate code using tools such as Java's recent JPA system.

The proposal is to have a separate surrogate primary key on such tables,
just as one would if that table were being referenced elsewhere in the
db schema (even though in this case it isn't).

This should fit nicely with general relational db design - unique key
(in MySQL, for example) is just a type of constraint over the data,
whereas in general primary keys are a method of uniquely identifying an
individual row. Primary keys are a subset of unique keys but they should
not be used to enforce data business rules.

### Synonym is a reserved word in some RDBMSs

The column synonym in table term\_synonym is a reserved word in at least
Oracle. Rename the column synonym to name, which would also be more
consistent with column naming in other tables (as the fact that it is a
synonym is already in the table name).

### Term\_Relationship\_Term can be folded into Term\_Relationship

The Term\_Relationship\_Term table links a relationship between two
terms to a first-class term that is equivalent to the relationship
(reification). As this is a 1-1 relationship, it should be folded into
the Term\_Relationshop column (as a foreign key).

The Oracle version demonstrates that this can actually be fully mapped
back to a Term\_Relationship\_Term view (for backwards compatibility,
for example), using triggers (or RULEs for PostgreSQL) to make it fully
writable.

### Comment is a reserved word in some RDBMSs

There is a table named 'comment' (for holding comment-type annotation),
which is a reserved in some RDBMSs, for example HSQLDB and Oracle.

The proposal is to rename the table to 'anncomment'. For the sake of
consistency, this would also mean to rename the primary key of the table
to anncomment\_id.

### References

BioSQL reference table cannot store more than one db\_xref. This causes
an inadequacy in parsing Uniprot where references often contain Pubmed
id, Medline id and DOI.

References may also have additional attributes (remarks, GeneRIFs, etc),
and thus one needs a Reference\_Qualifier\_Value table to store those.
Furthermore, it would be good to be able to store the type of a
reference (eg. journal, book, article, conference paper, etc.).

### Check constraint on biosequence.alphabet

The Bio\* toolkits turn out to use slight variations of the set of valid
alphabet names. Consistency could be enforced through a check
constraint.

BioPerl uses protein, dna, and rna. Biojava reportedly uses
all-uppercase for all three.

Scheduled for v1.0.x
--------------------

All BioSQL v.1.0.x schemas at a minimum can be expected to work with all
language bindings and software that ran with a recent, but pre-release
schema (the so-called 'post-Singapore' schema). As such, there will be
no changes in tables, table names, column names, or relationship
cardinalities. Except if necessitated to fix a serious bug, column type
changes will be limited to changing the width (or precision) of columns.

Other allowable changes include additional indexes, or changing the
column order in existing compound indexes to increase performance.
Unique key changes do not, however, fall into this category, as language
bindings may frequently rely on them for uniquely locating records.

Pending scheduling
------------------

### Need additional attributes for taxon

The NCBI taxonomy has a isTaxonHidden attribute determining whether a
taxon is included in the lineage information given in GenBank entries:

`GenBank hidden flag (1 or 0) -- 1 if name is suppressed in GenBank entry lineage`

On hand at this point this applies only to the NCBI taxonomy and not to
any other, but also the other attributes of the taxon table are pretty
specific to the NCBI taxonomy, so we might as well add this one. In
addition, one might in fact want to search by it (for instance, for
pulling out all ancestors of a given taxon that are visible). (See the
[respective thread on the BioSQL mailing list for
reference](http://lists.open-bio.org/pipermail/biosql-l/2006-July/001015.html).)

Alternatively, we could generalize the taxon model to be as applicable
to other taxonomies, and move special attributes to a
taxon\_qualifier\_value table.

### Bioentry Date Stamping

Possible table structure:

``` sql
 CREATE TABLE bioentry_history (
   bioentry_history_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
   bioentry_id INT UNSIGNED NOT NULL FOREIGN KEY REFERENCES 
   (bioentry.bioentry.id)
   startdate DATE NOT NULL DEFAULT CURRENT_DATE,
   enddate DATE NULL
 );
```

Example SQL - give me all the entries from GenBank as they existed on
Jan 1, 2002

``` sql
 SELECT bioentry.*
 FROM   bioentry
        JOIN biodatabase USING (biodatabase_id)
        JOIN bioentry_history USING (bioentry_id)
 WHERE  biodatabase.name = 'GenBank'
   AND  bioentry_history.startdate <= 2002-01-01 
   AND  (bioentry_history.enddate IS NULL
         OR bioentry_history.enddate > 2002-01-01)
```

Alternative, if you want db history info as well:

``` sql
 CREATE TABLE biodatabase_history (
   biodatabase_history_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
   biodatabase_id INT UNSIGNED NOT NULL FOREIGN KEY REFERENCES 
   (biodatabase.biodatabase_id)
   entrydate DATE NOT NULL DEFAULT CURRENT_DATE   -- date db was updated
   comment TEXT -- optional; maybe you want versioning here, I dunno
 );

 CREATE TABLE bioentry_history (
   bioentry_history_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
   bioentry_id INT UNSIGNED NOT NULL FOREIGN KEY REFERENCES 
   (bioentry.bioentry_id)
   entered INT UNSIGNED NOT NULL FOREIGN KEY REFERENCES 
   (biodatabase_history.biodatabase_history_id)
   removed INT UNSIGNED NULL FOREIGN KEY REFERENCES 
   (biodatabase_history.biodatabase_history_id)
 );

 ALTER TABLE bioentry_history ADD CONSTRAINT check_entered_removed (
   bioentry_history.removed IS NULL OR bioentry_history.entered 
  <> bioentry_history.removed
 );
```

Example SQL - same as before, retrieve all bioentries from GenBank as
they were on Jan 1, 2002

``` sql
 SELECT bioentry.*
 FROM   bioentry
        JOIN biodatabase USING (biodatabase_id)
        JOIN bioentry_history USING (bioentry_id)
        LEFT JOIN biodatabase_history AS enter
         ON (bioentry_history.entered = entered.bioentry_history_id)
        LEFT JOIN biodatabase_history AS exit
        ON (bioentry_history.removed = exit.bioentry_history_id)
 WHERE  biodatabase.name = 'GenBank'
   AND  entered.entrydate <= 2002-01-01
   AND  (exit.entrydate IS NULL OR exit.entrydate > 2002-01-01)
```

Advantage: you don't need to store N\*M rows for every M database
updates, only N rows of date ranges (or database version refs).

Disadvantage: all historical bioentries remain in the database, even
ones that are no longer "current" - simple SELECTs must specify enddate
IS NULL (optionally, a "is\_current" flag can be added to bioentry) -
again, a bioentry\_current VIEW may be the best solution.

### Sequence redundancy

There is no utility here for handling biosequence redundancy; i.e. the
biosequence table cannot be easily used to generate non-redundant
sequence views. An accessory table "biosequence\_redundancy" could be
used to store redundant pairs (including a self-self pair) for those who
need it.

``` sql
 CREATE TABLE biosequence_redundancy (
   biosequence_redundancy_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
   biosequence_a INT UNSIGNED NOT NULL FOREIGN KEY REFERENCES 
   (biosequence.biosequence_id),
   biosequence_b INT UNSIGNED NOT NULL FOREIGN KEY REFERENCES 
   (biosequence.biosequence_id),
   UNIQUE(biosequence_a, biosequence_b)
 );
```

This redundancy table could be further "typed" by ontology terms.
Alternatively, all redundancies could be stored as pairwise seqfeatures.

Example SQL: Give me all nonredundant biosequences from GenPept (i.e.
the NCBI "nr" database)

Nasty cross-joining SQL to be delivered ...

### Feature set versioning

Could already be accomplished with "dated" source ontology terms, but
that seems like a bastardization. Suggestions welcome.

### Ability to fully represent contig assembly

The ability to fully represent [EMBL format's CO
lines](http://ftp.ebi.ac.uk/pub/databases/embl/doc/usrman.txt#3_4_14)
in a BioSQL record would be desirable. The CO line is essentially a join
of segments of other sequences, like this:

` join(MySeq:1..40,ThisSeq:5..8,gap(unk100),ThatSeq:90..154,gap(4000),TheirSeq:100..2000)`

This describes the sequence as being constructed of the first 40 bases
of MySeq, followed by bases 5 to 8 of ThisSeq, followed by a gap of
unknown length, followed by bases 90-154 of ThatSeq, followed by a gap
of length 4000, followed by bases 100-2000 of TheirSeq. All entries in
the join statement are immediately adjacent, but owing to the use of
gaps of unknown length it is not possible to map components that occur
after that gap to a specific location in the assembled contig sequence.

The 'unk100' keyword used to represent the unknown length gap as the
keyword specified by the EMBL format docs, but it does not explain why
this keyword is used or what it means, or how it affects the overall
computation of the sequence length.

This join statement takes the place of any actual sequence data
associated with the EMBL entry. The length of the sequence the join
represents is computed by an unknown function using the above join
statement as input.

The approach to store this in BioSQL would be via features on the contig
(a bioentry) which have remote locations.

However, the gaps do not have a remote location, and they do not have a
direct location on the contig either (if the first one had a known
length, the locations could be inferred). While BioSQL itself does
permit location-less features, some of the Bio\* toolkits may have
difficulty dealing with this. The only way to represent that the first
gap feature has unknown length is through its annotation
(seqfeature\_qualifier\_value).

While the second gap has a known length, BioSQL (and, for example,
neither BioPerl) can't represent the length of a feature other than by
its coordinates (which aren't known in the example above, due to the
preceding gap of unknown length). One could work around that by giving
the second gap a remote location to a fictitious 'gap' sequence (which
would only consist of gap characters, and be virtual).

Should there be a better way of doing this?

Related to CO lines, [EMBLs AS
lines](http://ftp.ebi.ac.uk/pub/databases/embl/doc/usrman.txt#3_4_13)
store assembly path information. In essence, these could be stored as
feature pairs, one feature on the source contig (or read, another
bioentry), the other feature on the assembled contig (the entry with the
AS line), and both linked by seqfeature\_relationship. The complicating
factor is that the location of the source contig feature may not be
known, resulting in a location-less feature. This should be fine from
BioSQL's standpoint, but may cause trouble when processed with on of the
Bio\* toolkits.

### Support for chimeric sequences

BioSQL only allows a single taxon link for a species. This creates a
difficulty for representing chimeric sequences. See a [BioSQL-l thread
in March
2008](http://lists.open-bio.org/pipermail/biosql-l/2008-March/001176.html)
discussing an example.

It should be noted that currently probably none of the Bio\* toolkits
supports multiple species for sequences either, so there isn't a need
(or possible use) for that capability in BioSQL from that side. There
are plans to change this, though.

### Abstracts and Full Text on References

As an enhancement for a future version of BioSQL it would be nice to
have CLOB rows for abstract and full text (Full text might need to be a
BLOB depending on format). Obviously they could both be null.

Another column could indicate the MIME type of the BLOB:

`BLOB abstract`  
`VARCHAR abstract_mime_type`

Then if you stored a PDF in it you could set abstract\_mime\_type to
'application/x-pdf', or if it was plain text, you could set the
abstract\_mime\_type to 'text/plain'.

See also the [respective thread on the BioSQL mailing
list](http://lists.open-bio.org/pipermail/biosql-l/2006-July/001026.html).

### Normalized bibliographic metadata for References

There should be individual author records instead of a single string,
and possibly a full bibliographic record model.

Applied or fixed
----------------

### Some character column widths are too narrow

[Erik Jan reports](https://redmine.open-bio.org/issues/2389)
that some varchar(n) type columns are constrained too narrow to
accommodate the latest UniProt database.

Fix: expanded the column width of dbxref.accession and
bioentry.accession to 128 in v1.0.1.
