---
title: Enhancement Requests
permalink: wiki/Enhancement_Requests
layout: wiki
---

Scheduled for v1.1
------------------

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

Scheduled for v1.0.x
--------------------

### Some character column widths are too narrow

[Erik Jan reports](http://bugzilla.open-bio.org/show_bug.cgi?id=2389)
that some varchar(n) type columns are constrained too narrow to
accommodate the latest UniProt database.

Though it isn't clear for the above bug report whether the issue is due
to a parsing error or not, and if it is a legitimate column value, which
column(s) is (are) affected, Hilmar Lapp did hit similar problems for
dbxref.accession when importing the Gene Ontology into the Oracle
version of BioSQL, which is why the width of that column is 64 (and not
40) in that version.

Pending scheduling
------------------

### References

BioSQL reference table cannot store more than one db\_xref. This causes
an inadequacy in parsing Uniprot where references often contain Pubmed
id, Medline id and DOI.

### Bioentry Date Stamping

Possible table structure: <sql>

`CREATE TABLE bioentry_history (`  
`  bioentry_history_id INT UNSIGNED NOT NULL AUTO_INCREMENT,`  
`  bioentry_id INT UNSIGNED NOT NULL FOREIGN KEY REFERENCES `  
`  (bioentry.bioentry.id)`  
`  startdate DATE NOT NULL DEFAULT CURRENT_DATE,`  
`  enddate DATE NULL`  
`);`

</sql> Example SQL - give me all the entries from GenBank as they
existed on Jan 1, 2002 <sql>

`SELECT bioentry.*`  
`FROM   bioentry`  
`       JOIN biodatabase USING (biodatabase_id)`  
`       JOIN bioentry_history USING (bioentry_id)`  
`WHERE  biodatabase.name = 'GenBank'`  
`  AND  bioentry_history.startdate <= 2002-01-01 `  
`  AND  (bioentry_history.enddate IS NULL`  
`        OR bioentry_history.enddate > 2002-01-01)`

</sql> Alternative, if you want db history info as well: <sql>

`CREATE TABLE biodatabase_history (`  
`  biodatabase_history_id INT UNSIGNED NOT NULL AUTO_INCREMENT,`  
`  biodatabase_id INT UNSIGNED NOT NULL FOREIGN KEY REFERENCES `  
`  (biodatabase.biodatabase_id)`  
`  entrydate DATE NOT NULL DEFAULT CURRENT_DATE   -- date db was updated`  
`  comment TEXT -- optional; maybe you want versioning here, I dunno`  
`);`

`CREATE TABLE bioentry_history (`  
`  bioentry_history_id INT UNSIGNED NOT NULL AUTO_INCREMENT,`  
`  bioentry_id INT UNSIGNED NOT NULL FOREIGN KEY REFERENCES `  
`  (bioentry.bioentry_id)`  
`  entered INT UNSIGNED NOT NULL FOREIGN KEY REFERENCES `  
`  (biodatabase_history.biodatabase_history_id)`  
`  removed INT UNSIGNED NULL FOREIGN KEY REFERENCES `  
`  (biodatabase_history.biodatabase_history_id)`  
`);`

`ALTER TABLE bioentry_history ADD CONSTRAINT check_entered_removed (`  
`  bioentry_history.removed IS NULL OR bioentry_history.entered `  
` <> bioentry_history.removed`  
`);`

</sql>

Example SQL - same as before, retrieve all bioentries from GenBank as
they were on Jan 1, 2002 <sql>

`SELECT bioentry.*`  
`FROM   bioentry`  
`       JOIN biodatabase USING (biodatabase_id)`  
`       JOIN bioentry_history USING (bioentry_id)`  
`       LEFT JOIN biodatabase_history AS enter`  
`        ON (bioentry_history.entered = entered.bioentry_history_id)`  
`       LEFT JOIN biodatabase_history AS exit`  
`       ON (bioentry_history.removed = exit.bioentry_history_id)`  
`WHERE  biodatabase.name = 'GenBank'`  
`  AND  entered.entrydate <= 2002-01-01`  
`  AND  (exit.entrydate IS NULL OR exit.entrydate > 2002-01-01)`

</sql> Advantage: you don't need to store N\*M rows for every M database
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

<sql>

`CREATE TABLE biosequence_redundancy (`  
`  biosequence_redundancy_id INT UNSIGNED NOT NULL AUTO_INCREMENT,`  
`  biosequence_a INT UNSIGNED NOT NULL FOREIGN KEY REFERENCES `  
`  (biosequence.biosequence_id),`  
`  biosequence_b INT UNSIGNED NOT NULL FOREIGN KEY REFERENCES `  
`  (biosequence.biosequence_id),`  
`  UNIQUE(biosequence_a, biosequence_b)`  
`);`

</sql>

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
lines](http://www.ebi.ac.uk/embl/Documentation/User_manual/usrman.html#3_4_14)
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
lines](http://www.ebi.ac.uk/embl/Documentation/User_manual/usrman.html#3_4_13)
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
