---
title: "Metagenome Assembly"
teaching: 30
exercises: 10
questions:
- "Why should genomic data be assembled?"
- "What is the difference between reads and contigs?"
- "How can we assemble a metagenome?"
objectives: 
- "Understand what an assembly is."  
- "Run a metagenomics assembly workflow."
- "Use an environment in a bioinformatic pipeline."
keypoints:
- "Assembly groups reads into contigs."
- "De Bruijn Graphs use Kmers to assembly cleaned reads."
- "Program screen allows you to keep open remote sessions."
- "MetaSPAdes is a metagenomes assembler."
- "Assemblers take FastQ files as input and produce a Fasta file as output."
---

!!! info "Lesson overview"
    **Teaching:** 15 min  
    **Exercises:** 15 min  

    **Questions**
    - Why should genomic data be assembled?
    - What is the difference between reads and contigs?
    - How can we assemble a metagenome?

    **Objectives**
    - "Understand what an assembly is." 

# Introduction

Metagenomics involves the extraction, sequencing and analysis of combined genomic DNA from entire microbiome samples. It includes then DNA from many different organisms, with different taxonomic background.

Reconstructing the genomes of microorganisms in the sampled communities is critical step in analyzing metagenomic data. To do that, we can use assembly and assemblers, i.e. computational programs that stich together the small fragments of sequenced DNA produced by sequencing instruments.

Assembling seems intuitively similar to putting together a jigsaw puzzle. Essentially, it looks for reads “that work together” or more precisely, reads that overlap. Tasks like this are not straightforward, but rather complex because of the complexity of the genomics (specially the repeats), the missing pieces and the errors introduced during sequencing.

## Assembling reads

The assembly process groups reads into contigs and contigs into 
scaffolds to obtain (ideally) the sequence of a whole 
chromosome. There are many programs devoted to
[genome](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2874646/) and 
metagenome assembly, some of the main strategies they use are Greedy extension, OLC, and De Bruijn charts. Contrary to metabarcoding, shotgun metagenomics needs an assembly step, which does not mean that metabarcoding never uses an assembly step but sometimes is unnecessary.

<a href="../fig/03-04-01.png">
  <img src="../fig/03-04-01.png" width="868" height="777" alt="Three diagrams depicting the three assembly algorithms: The Greedy extension starts with any read, extends it whit the reads that make a match to make a contig, it continues with a different read when the previous contig can not be extended anymore. The Overlap Layout consensus finds every pairwise overlap, makes a layout graph with all the overlaps and chooses consensus sequences to make the contigs. The De Bruijn Graphs divides the reads in k-mers, makes a k-mer graph that shows all the overlapping k-mers, and chooses paths from the graph to make the contigs. " />
</a>

[MetaSPAdes](https://github.com/ablab/spades) is an NGS de novo assembler 
for assembling large and complex metagenomics data, and it is one of the 
most used and recommended. It is part of the SPAdes toolkit, which 
contains several assembly pipelines.

Some of the problems faced by metagenomics assembly are:  
* Differences in coverage between the genomes due to the differences in abundance in the sample.  
* The fact that different species often share conserved regions.  
* The presence of several strains of a single species in the community.   

SPAdes already deals with the non-uniform coverage problem in its algorithm, so it is helpful for the assembly of simple communities, but the [metaSPAdes](https://pubmed.ncbi.nlm.nih.gov/28298430/) algorithm deals with the other problems as well, allowing it to assemble metagenomes from complex communities. 

Let's process use metaSPAdes on Galaxy


!!! example "Create a New history"
    1. Go to the **History** panel (on the right)
    2. Click ✏️ (**Create new history**)
    
        ![Screenshot of the galaxy interface with the history name being edited, it currently reads "Unnamed history", the default value. An input box is below it.]( ../fig/galaxy/new_history.png)
 
    2. Click ✏️ (**Edit**) next to the history name (which by default is "Unnamed history")

        ![Screenshot of the galaxy interface with the history name being edited, it currently reads "Unnamed history", the default value. An input box is below it.]( ../fig/galaxy/rename_history.png)

    3. Type in a new name, for example, "Assembly"
    4. Click **Save**

## Import the data from previous history

!!! example "Import the data from previous history"
    1. Go to the **History Multiview** panel (on the left)
        ![Screenshot of the History Multiview]( ../fig/galaxy/history_multiview.png)
    2. Drag the Trimmed sequence from the history  **Trimmomatic**
    3. Drop it in the empty history **Assembly**
        ![Screenshot of the galaxy interface with the history name being edited, it currently reads "Unnamed history", the default value. An input box is below it.]( ../fig/galaxy/drag_and_drop_history_multiview.png)

## Click the tool

1. Type **metaSPAdes** in the tools panel search box (top)
2. Click the tool (**metaSPAdes** metagenome assembler)
![metaspades click on the tool]( ../fig/galaxy/metaspades_tool.png){:width="620px"}
The tool will be displayed in the central Galaxy panel.

### Tool Parameters

1. Select  **Paired-end: list of dataset pairs**
It will select automatically the trimmed sequence that you drop earlier, but check that it is the correct sequences.
2. Add **Scaffold Stats** and **Contigs Stats** in  **Select optional output file(s)**
3. Click  **Run Tool**

# Quality control of assembly

Once assembly is done, it is important to check its quality.
We can use the tool named QUAST (QUality ASsessment Tool). The tool evaluates genome assemblies by computing various metrics.
Since the assembly may take some time to run, you can directly upload the  

!!! Success "Key Points"
    - Assembly groups reads into contigs.
    - De Bruijn Graphs use Kmers to assembly cleaned reads.
    - MetaSPAdes is a metagenomes assembler.
    - Assemblers take FastQ files as input and produce a Fasta file as output.
    - We can check the quality of your assembly using QUAST