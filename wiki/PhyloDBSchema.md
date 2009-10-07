---
title: PhyloDBSchema
permalink: wiki/PhyloDBSchema
layout: wiki
---

This document describes some of the tables and fields in the PhyloDB
schema. It also aims to demonstrate functional capabilities using
example SQL. Design philosophies and expectations are presented with
reasoning.

Tables
======

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

### Questions about TREE\_ROOT?

TREE\_QUALIFIER\_VALUE
----------------------

TREE\_Dbxref
------------

NODE
----

NODE\_PATH
----------

NODE\_TAXON
-----------

NODE\_BIOENTRY
--------------

NODE\_Dbxref
------------

EDGE\_QUALIFIER\_VALUE
----------------------

EDGE
----

EDGE\_QUALIFIER\_VALUE
----------------------
