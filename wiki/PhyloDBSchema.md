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
Smarties](https://datubaze.files.wordpress.com/2016/03/celkos-trees-and-hierarchies-in-sql_2004.pdf).

NODE\_PATH
----------

Node path stores directed paths between nodes. In a phylogenetic tree,
these are the descendant and ancestoral nodes. "child\_node\_id" is the
endpoint node of the two nodes connected by the (directed) path. In a
phylogenetic tree, this is the descendant. "parent\_node\_id" is the
startpoint node of the two nodes connected by a (directed) path. In a
phylogenetic tree, this is the ancestor. "path text" defines the path
from startpoint to endpoint as the series of nodes visited along the
path. The nodes may be identified by label, or, typically more
efficient, by their primary key, or left or right value. The latter are
often smaller than the primary key, and hence consume less space. One
may increase efficiency further by using a base-34 numeric
representation (24 letters of the alphabet, plus 10 digits) instead of
decimal (base-10) representation. The actual method used is not
important, though it should be used consistently. The "distance" is the
number of nodes between the parent and child. Thus the path between a
node and itself has length zero, and length 1 between two nodes directly
connected by an edge. If there is a path of length l between two nodes A
and Z and an edge between Z and B, there is a path of length l+1 between
nodes A and B.

### Questions about NODE\_PATH

1.  Does this not just duplicate information extractable from the node
    and edge tables?
2.  When would at branch have mutiple edges between nodes?
3.  How do you code the path from startpoint to endpoint as the series
    of nodes visited along the path?

NODE\_TAXON
-----------

Node\_taxon links tree nodes to taxa and is uniquely identified by
"node\_taxon\_id". "node\_id" is the node to which the taxon is being
linked. "taxon\_id" is he taxon being linked to the node. "rank" is the
index of this taxon within the list of taxa being linked to the node, if
the order is significant. Typically, this will be used to represent the
position of the respective sequence within the concatenated alignment,
or the partition index.

NODE\_BIOENTRY
--------------

This table links a node to a BioSQL
[bioentry](Schema_Overview#bioentry "wikilink"). link are uniquely
identified by thier "node\_bioentry\_id". "node\_id" is the node to
which the bioentry is being linked. "bioentry\_id" is the bioentry being
linked to the node. "rank" is the index of this bioentry within the list
of bioentries being linked to the node, if the order is significant.
Typically, this will be used to represent the position of the respective
sequence within the concatenated alignment, or the partition index.

NODE\_Dbxref
------------

Sores cross-references between nodes and other database entries.
"node\_id" is the node to which the database cross-reference is being
assigned. "dbxref\_id" is the database cross-reference being assigned to
the node. "term\_id" is the type of the database cross-reference as a
controlled vocabulary or ontology term. The type of a node identifier
should be 'primary identifier'.

Edge Tables
===========

EDGE
----

Edge stores information on the edges between nodes each is uniquely
identified by the "edge\_id". The "child\_node\_id" is the endpoint node
of the two nodes connected by a directed edge. In a phylogenetic tree,
this is the descendant, while the "parent\_node\_id" is the startpoint
node of the two nodes connected by a directed edge. In a phylogenetic
tree, this is the ancestor.

EDGE\_QUALIFIER\_VALUE
----------------------

Stores associations between edges and metadata. "value" is the value of
the attribute/value pair association of metadata (if applicable). "rank"
is the index of the metadata value if there is more than one value for
the same metadata element. If there is only one value, this may be left
at the default of zero. "edge\_id" is the tree edge to which the
metadata is being associated. "term\_id" is the name of the metadate
element as a term from a controlled vocabulary (or ontology).

Branch lengths should be stored as edge qualifier values liked to a term
identifying the units the distance is in, e.g. parsimony steps or years
bp or MYA.
