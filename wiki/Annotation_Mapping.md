---
title: Annotation Mapping
permalink: wiki/Annotation_Mapping
layout: wiki
---

This page documents the recommended BioSQL-standard of mapping sequence
annotations (through Bio\* object models) to the BioSQL relational
model.

GenBank
-------

|                   |                                                                                                                                                                                                      |
|-------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| DIVISION          | column division in table bioentry                                                                                                                                                                    |
| accession numbers | secondary accession numbers go into bioentry qualifier value table. Primary accession maps to column accession in table bioentry                                                                     |
| TITLE             | this is part of a publication reference, and should map to column title in table reference                                                                                                           |
| VERSION           | in BioPerl we parse this apart into a version for the accession (which is column version in table bioentry) and the GI number, which maps to column identifier in table bioentry                     |
| REFERENCE         | table reference (and bioentry\_reference for association with the bioentry)                                                                                                                          |
| KEYWORDS          | map to bioentry\_qualifier\_value                                                                                                                                                                    |
| GI                | column identifier in table bioentry                                                                                                                                                                  |
| SIZE              | if it is the length of the sequence, it should map to column length in table biosequence                                                                                                             |
| DEFINITION        | column description in table bioentry                                                                                                                                                                 |
| ORGANISM          | this is the organism and maps to the table taxon (and taxon\_name), with a foreign key in bioentry pointing to the taxon                                                                             |
| JOURNAL           | this is part of a reference, see 'references'                                                                                                                                                        |
| ACCESSION         | the primary accession, maps to column accession in table bioentry                                                                                                                                    |
| LOCUS             | in the file itself this is an entire line consisting of multiple fields; BioPerl/bioperl-db maps the locus name (the first token after the literal token LOCUS) to column name in table bioentry     |
| SOURCE            | this is the organism, see 'ORGANISM'                                                                                                                                                                 |
| PUBMED            | this is part of a literature reference, and maps to a foreign key in the reference table (reference.dbxref) to a dbxref entry with PUBMED or PMID as the database and the pubmed ID as the accession |
| AUTHORS           | part of a literature reference, maps to column authors in table reference                                                                                                                            |
| TYPE              | if this is the alphabet, it maps to table biosequence, column alphabet                                                                                                                               |
| CIRCULAR          | this at present maps to bioentry\_qualifier\_value, though there are plans to make it a column in table biosequence.                                                                                 |
||

