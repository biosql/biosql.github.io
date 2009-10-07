---
title: PhyloDBSchema
permalink: wiki/PhyloDBSchema
layout: wiki
---

This document describes some of the tables and fields in the PhyloDB
schema. It also aims to demonstrate functional capabilities using
example SQL. Design philosophies and expectations are presented with
reasoning. Most of this text has been cut-and-pasted from the comments
associated with the PhyloDB schema.

Tree Tables
===========

TREE
----

Tree stores information on individual bifurcating non-cyclic graphs.
Trees are uniquely identified by thier "tree\_id". They also have a
"name" and "identifier". They are associated with a BioSQL biodatabase
via their "biodatabase\_id". The Boolean field "is\_rooted" identifies
whether a node is rooted or not. The default is TRUE, i.e. rooted.
"Node\_id" identfies the *start* node which is usually the root node of
a rooted tree.

### Questions about TREE?

1.  Where do "identifier"s come from?
2.  What is the role of the *start* node except to identify the root?

TREE\_ROOT
----------

Tree\_root stores information on the root node of a tree. Tree roots are
uniquely identified by thier "tree\_root\_id". The tree the root is from
is identified by the "tree\_id" while the node table record is
identified by "node\_id". "is\_alternate" is TRUE if the root node is
the preferential (most likely) root node of the tree, and FALSE
otherwise. The "significance" (such as likelihood, or posterior
probability) with which the node is the root node. This only has meaning
if the method used for reconstructing the tree calculates this value.

TREE\_QUALIFIER\_VALUE
----------------------

This stores metadata associated with an entire tree. "tree\_id"
identifies the tree with which the metadata is associated. The name of
the metadata element as a BioSQL term from a controlled vocabulary (or
ontology) is identified by the foreign key "term\_id". The value of the
metadata element is stored as text in "value". The "rank" field stores
the index of the metadata value if there is more than one value for the
same metadata element. If there is only one value, this may be left at
the default of zero.

### Questions about TREE\_QUALIFIER\_VALUE

1.  Why is use rank and not tow tree qualifiers?

TREE\_Dbxref
------------

Stores information on database cross-references assigned to the tree.
"tree\_id" identifies the tree to which the database corss-reference is
being assigned. "dbxref\_id" is the database cross-reference assigned to
the tree. "term\_id" is the type of the database cross-reference as a
controlled vocabulary or ontology term. The type of a tree accession
should be 'primary identifier'.

Node Tables
===========

NODE
----

The node table stores information on the nodes within trees. Each node
is uniquely identified through its "node\_id". Nodes may ne "label"ed,
e.g. with the latin binomial of the taxon, taxonomic rank, the accession
number of a sequences, or any other construct that uniquely identifies
the node within one tree. "tree\_id" specifies which tree each node is a
part of. "left\_idx and "right\_idx" specify the left and right values
of the nested set optimization structure for efficient hierarchical
queries. These values needs to be precomputed by a program, see [J.
Celko, SQL for
Smarties](http://rs18.rapidshare.com/files/4441805/Trees_and_Hierarchies_in_SQL_for_Smarties.pdf).

NODE\_PATH
----------

child\_node\_id integer NOT NULL, -- The endpoint node of the two nodes
connected by a (directed) path. In a phylogenetic tree, this is the
descendant.

` parent_node_id integer NOT NULL, -- The startpoint node of the two nodes connected by a (directed) path. In a phylogenetic tree, this is the ancestor.`  
` path text, -- The path from startpoint to endpoint as the series of nodes visited along the path. The nodes may be identified by label, or, typically more efficient, by their primary key, or left or right value. The latter or often smaller than the primary key, and hence consume less space. One may increase efficiency further by using a base-34 numeric representation (24 letters of the alphabet, plus 10 digits) instead of decimal (base-10) representation. The actual method used is not important, though it should be used consistently.`  
` distance integer NOT NULL, -- The distance (or length) of the path. The path between a node and itself has length zero, and length 1 between two nodes directly connected by an edge. If there is a path of length l between two nodes A and Z and an edge between Z and B, there is a path of length l+1 between nodes A and B.`

NODE\_TAXON
-----------

NODE\_BIOENTRY
--------------

NODE\_Dbxref
------------

Edge Tables
===========

EDGE\_QUALIFIER\_VALUE
----------------------

EDGE
----

EDGE\_QUALIFIER\_VALUE
----------------------
