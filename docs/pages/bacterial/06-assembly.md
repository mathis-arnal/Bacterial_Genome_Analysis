---
title: Bacterial Genome Assembly Tutorial
---

# Bacterial Genome Assembly

!!! info "Lesson overview"
    **Teaching:** 15 min  
    **Exercises:** 20 min  

    **Questions**
    - Why do bacterial genomes need to be assembled?
    - What is the difference between reads, contigs, and scaffolds?
    - How do assemblers reconstruct a bacterial genome?
    - How do we assess the quality of an assembly?

    **Objectives**
    - Understand what a genome assembly is.  
    - Know the main assembly algorithms (Greedy, OLC, De Bruijn Graphs).  
    - Perform a bacterial genome assembly using **SPAdes**.  
    - Evaluate the assembly using **QUAST**.

---

# Introduction

Modern sequencing technologies generate **millions of short DNA fragments (reads)**, but not complete chromosomes.  
For bacterial genomics, our goal is to reconstruct the full genome of a bacterial isolate from these fragments.  
The process of stitching reads together into longer sequences is called **de novo assembly**.

Assembling a genome is conceptually similar to solving a jigsaw puzzle:

- The full genome is the picture we want to reconstruct.
- Reads are the small pieces of the puzzle.
- Overlaps and repeated patterns determine how the pieces fit together.

Unlike real puzzles, genome assembly is complicated by:

- **Sequencing errors**  
- **Repeated regions** that appear identical  
- **Uneven sequencing depth**  
- **Contaminations** in the sample  

Despite these challenges, bacterial genomes (~1–7 Mb) are typically easier to assemble than metagenomes because they come from **one organism** and generally have **uniform coverage**.

---

# What is Being Assembled?

## Reads → Contigs → Scaffolds

During assembly, the algorithm steps are typically:

1. **Reads** (raw sequencing fragments)  
2. **Contigs**: overlapping reads merged into longer continuous sequences  
3. **Scaffolds**: contigs ordered and oriented using paired-end information  
4. (Optional) **Chromosome** or near-complete genome

The figure below shows the hierarchy:


---

# How Do Assemblers Work?

There are several strategies to assemble genomes. Most modern short-read assemblers use **De Bruijn Graphs**, but it is useful to know all three families of algorithms.

<a href="../../fig/bact/assembly_algorithms.png">
  <img src="../../fig/assembly_algorithms.png" width="868" height="777" alt="Assembly algorithms: Greedy, OLC, De Bruijn Graphs" />
</a>

### **1. Greedy Extension**
- Start from a read, extend it by finding the next read with the highest overlap.  
- Repeats often confuse this method.  
- Rarely used in modern genomics.

### **2. OLC (Overlap–Layout–Consensus)**
- Find overlaps between all pairs of reads.  
- Build a graph of overlaps.  
- Resolve paths to produce contigs.  
- Used for long-read assemblers.

### **3. De Bruijn Graphs (most common for Illumina reads)**  
Reads are broken into **k-mers** (short subsequences of length *k*).  
A graph is built from overlapping k-mers, and contigs are extracted as paths through the graph.

This method is extremely efficient for large numbers of short reads.

---

# SPAdes: A Popular Bacterial Genome Assembler

[SPAdes](https://github.com/ablab/spades) (St. Petersburg genome assembler) is one of the most recommended tools for bacterial genomes.

Why SPAdes?

- Designed specifically for single bacterial genomes  
- Handles uneven coverage (useful for plasmids or mixed samples)  
- Uses multi-*k* De Bruijn Graphs for improved assembly  
- Widely used, well tested, fast  

SPAdes takes **FASTQ** files as input and outputs:

- **contigs.fasta**
- **scaffolds.fasta**
- **assembly graph files**

---

# Running SPAdes on Galaxy

What parameters do I need to choose for SPAdes ? 
the most important is k-mers.

Always re-run FastQC on trimmed reads and check the read length distribution and median/mean length before finalizing k choices.
Choosing an appropriate k-mer range for SPAdes assembly requires balancing sensitivity and contiguity.
Smaller k values (e.g., 21–33–55) are more sensitive and help assemble low-coverage regions and short or repetitive sequences, whereas larger k values (e.g., 77–99–127) improve contiguity and repeat resolution but require longer, high-quality reads. Therefore, the k-mer range should always be chosen according to the read-length distribution and expected coverage after trimming


Below is an example workflow using Galaxy, similar to your metagenomics training.

## Create a new history

!!! example "Create a new history"
    1. Go to the **History** panel (right side).  
    2. Click **✏️ → Create new history**.  
    3. Click **Edit** next to the history name.  
    4. Rename it to **Bacterial Genome Assembly**.  
    5. Click **Save**.

---

## Import the trimmed reads

Use the **History Multiview** panel.

!!! example "Import input reads"
    1. Open the **History Multiview** (left panel).  
    2. Drag your **trimmed paired-end reads** from the previous history (e.g., “Trimmomatic”).  
    3. Drop them into the **Bacterial Genome Assembly** history.

---

# Assembly with SPAdes

## Launch the SPAdes tool

1. In the Galaxy tools panel, search for **SPAdes**.  
2. Click **SPAdes genome assembler**.

<a href="../fig/galaxy/spades_tool.png">
  <img src="../fig/galaxy/spades_tool.png" width="620px" alt="SPAdes tool in Galaxy" />
</a>

---

## Tool parameters

### 1. Input Data
Choose:

- **Paired-end: list of dataset pairs**  
- Ensure the correct R1/R2 files are selected.

### 2. Options to select  
- **Enable careful mode** (optional, reduces mismatches)  
- **Select additional outputs**:  
  - Contigs  
  - Scaffolds  
  - Assembly graph (optional but useful)

### 3. Run
Click **Run Tool**.

Assembly usually takes a few minutes depending on coverage and read depth.

---

# Quality Control: QUAST

Once your assembly is ready, we use **QUAST**:  
**QU**ality **A**ssessment **S**oftware **T**ool.

It evaluates:

- Number of contigs  
- Total assembly length  
- N50 / L50  
- GC content  
- Mismatches / indels  
- Graphical reports  

!!! example "Run QUAST"
    1. Search for **QUAST** in the Galaxy Tools panel.  
    2. Select **contigs.fasta** from the SPAdes output.  
    3. (Optional) Add a reference genome to improve metrics.  
    4. Run the tool.  

QUAST produces a summary table and plots showing the assembly quality.

---

# Interpreting Key Assembly Metrics

| Metric | Meaning | Good Sign |
|-------|---------|-----------|
| **Contigs** | Number of fragments | Lower is better |
| **Largest contig** | The length of the largest contig in the assembly | Larger suggests better assembly |
| **Total length** | The total number of bases in the assembly | Should match expected species size |
| **N50** | Length of contig where half the genome is in longer contigs | Higher is better |
| **GC%** | GC content | Should match expected species |


---

# Common Pitfalls in Bacterial Assembly

### 1. Low coverage
Below 20–30× makes assemblies fragmented.

### 2. Contamination
Foreign reads produce extra contigs.

### 3. Repeats and mobile elements
Plasmids and insertion sequences cause breaks in contigs.

### 4. Mixed strains
Can result in chimeric contigs.

### 5. Untrimmed adapters
Lead to errors in graph construction.

---

# Assembly Metrics using QUAST

Once your assembly is complete, it is essential to evaluate its quality before proceeding to downstream analyses. This is where **QUAST** (QUality ASsessment Tool) comes in.

**Why is assessing assembly quality important?**

- Assemblies can vary greatly in quality depending on input data and parameters.  
- Poor-quality assemblies may be fragmented, contain errors, or miss important regions, leading to inaccurate biological conclusions.  
- Quality metrics help you determine if your assembly is good enough or if you need to revisit earlier steps (e.g., trimming, coverage, assembly parameters).  

**QUAST provides a comprehensive set of metrics, including:**

- **Number of contigs:** Fewer contigs usually indicate a more contiguous assembly.  
- **N50 value:** The length at which half of the genome is contained in contigs of that size or longer; a higher N50 suggests better contiguity.  
- **Total assembly length:** Should approximate the expected genome size; large deviations can indicate contamination or missing data.  
- **GC content:** Helps detect contamination or unusual biases.  
- **Misassemblies and mismatches:** Identify errors or inconsistencies in the assembly.  

By reviewing these metrics, you can objectively assess your assembly’s completeness and accuracy, which is crucial for reliable downstream analyses like annotation or variant calling.

## Example of Good Assembly Metrics (QUAST)

| Metric              | Good Assembly Characteristics                   | Why it matters                                   |
|---------------------|------------------------------------------------|-------------------------------------------------|
| **Number of contigs**| Low number (e.g., < 100 for bacterial genomes) | Indicates high contiguity and fewer gaps         |
| **N50**             | High value (e.g., > 50 kb for bacterial genomes)| Shows large contigs covering most of the genome  |
| **Total length**     | Close to expected genome size (e.g., ~4.5 Mb)  | Confirms completeness without excess contamination|
| **GC content**      | Matches known organism range (e.g., 35-60%)    | Suggests low contamination and accurate assembly  |
| **Misassemblies**    | Few or none                                     | Reflects assembly correctness and reliability    |
| **Mismatch rate**    | Low (few errors per 100 kb)                      | Ensures sequence accuracy                          |

**Note:** These values depend on the species and data quality. For bacteria, a near-complete genome with a few large contigs is ideal.

---

# Assembly Viewer using Bandage

While QUAST provides numerical summaries, it is also useful to **visually explore your assembly graph** to understand the assembly structure.

**Bandage** is a graphical tool designed to visualize assembly graphs generated by assemblers like SPAdes.

**Why visualize assembly graphs?**

- Assembly graphs reveal complex genome structures such as repeats, branches, and unresolved regions that are not obvious from summary statistics.  
- Visual inspection helps identify potential assembly issues such as:

  - **Fragmented assemblies** with many disconnected components.  
  - **Repeats and ambiguities** that cause branching in the graph.  
  - **Circular elements** like plasmids or phage genomes.  
- Understanding graph topology guides troubleshooting and can inform improvements in assembly strategy.  

Bandage allows you to:

- Load your assembly graph file (`.gfa`) and interactively explore contigs and connections.  
- Extract sequences from specific graph nodes or paths.  
- Annotate nodes to identify features or confirm circularity.

## What Does a Good Bandage Graph Look Like?

- **Mostly linear graph:** One or few long, continuous paths representing the chromosome(s).  
- **Few branches or bubbles:** Minimal complexity indicating low repeat content or successful repeat resolution.  
- **Circular structures (if expected):** Closed loops may represent plasmids or circular chromosomes.  
- **No excessive disconnected components:** Indicates little fragmentation or contamination.

### Example interpretations:

| Graph Feature               | Meaning                                          |
|-----------------------------|-------------------------------------------------|
| Long linear contigs          | High-quality, contiguous assembly                |
| Small bubbles or forks       | Possible repeats or heterogeneity to resolve    |
| Multiple disconnected graphs | Possible contamination or unassembled fragments  |
| Circular loops              | Plasmids or circular DNA elements identified     |

Visualizing the assembly graph with Bandage helps confirm that your assembly structure matches biological expectations and guides troubleshooting if unusual features are seen.


---

## BUSCO: Assessing Genome Completeness

**BUSCO** (Benchmarking Universal Single-Copy Orthologs) evaluates how complete a genome assembly is by checking for the presence of genes that should exist as single copies in nearly all members of a given lineage (e.g., bacteria).

### What BUSCO Reports
- **Complete (C):** Genes found in full length  
- **Complete and single-copy (S):** Ideal—no duplication  
- **Complete and duplicated (D):** Gene appears more than once (may reflect plasmids, repeats, or misassembly)  
- **Fragmented (F):** Only partial gene found  
- **Missing (M):** Gene not detected  

### Why BUSCO is Important
- **Measures biological completeness:** Ensures your assembly contains the full functional gene content expected for the organism.  
- **Detects fragmentation:** High fragmented or missing percentages indicate low-quality assembly or low coverage.  
- **Helps compare assemblies:** BUSCO provides an objective metric across tools, datasets, or species.  

### What Is Considered a Good BUSCO Score?
For bacterial genomes:
- **>95% Complete** is excellent  
- **<5% Missing** is expected for high-quality assemblies  
- Duplications should be low unless plasmids or paralogs exist  

Despite BUSCO being robust for species that have been widely studied, it can be inaccurate when the newly assembled genome belongs to a taxonomic group that is not well represented in OrthoDB. Even in a well-represented taxonomic group, the bias on the selection of reference genomes selected to create OrthoDB can lead to an under-scoring of the newly assembled genome and is dependent on the evolution of the genomes. 

## Chromeister: Whole-Genome Alignment for Structural Validation

**Chromeister** is a fast, interactive genome alignment tool that compares your assembly to a reference genome using dot-plot visualization.

### What Chromeister Provides
- **Whole-genome alignment dot plots**  
- **Detection of large-scale structural features**, such as:
  - Inversions  
  - Rearrangements  
  - Duplications  
  - Contamination  
- **Assessment of assembly order and orientation**  

### Why Chromeister Is Important
- **Validates correctness:** Ensures your contigs align in the correct order relative to a reference genome.  
- **Detects structural errors:** Misassemblies produce breaks, diagonal flips, or chaotic dot plots.  
- **Identifies contamination:** Off-diagonal or scattered alignments can reveal foreign sequences.  
- **Useful even for draft assemblies:** Helps determine whether scaffolding or polishing is needed.


# Summary

!!! success "Key Points"
    - Genome assembly reconstructs bacterial genomes from sequencing reads.  
    - Reads → Contigs → Scaffolds → Genome.  
    - De Bruijn Graphs (k-mers) are the foundation of short-read assembly.  
    - SPAdes is the standard tool for bacterial genome assembly.  
    - Assemblers take FASTQ reads as input and output contigs/scaffolds in FASTA format.  
    - Assembly quality should be evaluated using QUAST.

---
