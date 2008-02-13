---
title: Enhancement Requests
permalink: wiki/Enhancement_Requests
layout: wiki
---

References
==========

BioSQL reference table cannot store more than one db\_xref. This causes
an inadequacy in parsing Uniprot where references often contain Pubmed
id, Medline id and DOI.

Circular Sequences
==================

It would be desirable to have a flag to indicate a circular sequence in
the BioSequence table.

Bioentry Date Stamping
======================

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

Sequence redundancy
===================

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

Feature set versioning
======================

Could already be accomplished with "dated" source ontology terms, but
that seems like a bastardization. Suggestions welcome.
