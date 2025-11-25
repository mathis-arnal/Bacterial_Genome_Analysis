# Multi Locus Sequence Typing (MLST)

!!! info "Lesson overview"
    **Questions**
    - What is MLST?
    - Why do we use MLST for bacterial typing?
    - How is an ST (Sequence Type) assigned?
    - How do we run MLST on Galaxy?

    **Objectives**
    - Understand the concept of MLST and allelic profiling.  
    - Learn how MLST identifies strains using housekeeping genes.  
    - Perform MLST on an assembled bacterial genome using Galaxy.  
    - Interpret MLST results and sequence types.

---

# Introduction

**Multi Locus Sequence Typing (MLST)** is a genotyping method used to characterize bacteria based on the sequences of a small number of **housekeeping genes** (usually 6–8).

MLST provides:

- A standardized, portable typing system  
- A way to compare strains across labs and studies  
- A stable, evolutionary signal (housekeeping genes evolve slowly)  
- Epidemiological and phylogenetic insight  

Once the genes are sequenced, each unique allele is assigned a number.  
The combination of allele numbers defines the **Sequence Type (ST)**.

Example:

| Gene | allelic number |
|------|----------------|
| arcC | 3 |
| aroE | 2 |
| glpF | 1 |
| gmk | 4 |
| pta | 3 |
| tpi | 1 |
| yqiL | 2 |

This gives the strain its **Sequence Type (ST)** — e.g. **ST5**.

---

# Why MLST?

MLST is used because it is:

- **Highly reproducible**  
- **Species-specific**  
- **Standardized worldwide**  
- **Useful for outbreak investigations**  
- **Good for long-term epidemiology (clonal complexes, lineages)**  

While whole-genome sequencing provides higher resolution, MLST remains valuable because:

- It is simple and widely understood  
- It provides stable identifiers (e.g., “ST398”)  
- Databases exist for thousands of species  

---

# How MLST Works

<a href="../fig/mlst_scheme.png">
  <img src="../fig/mlst_scheme.png" width="800px" alt="Diagram of MLST workflow" />
</a>

### Step 1 — Choose housekeeping genes
Each species has its own MLST scheme.  
For example:

**S. aureus MLST genes:**  
arcC, aroE, glpF, gmk, pta, tpi, yqiL

### Step 2 — Determine the allele for each gene
The sequence is compared against a curated database (e.g. **PubMLST**).

### Step 3 — Combine the alleles → Assign an ST
The allelic profile is matched to a known Sequence Type.

If the allele combination is new, it may be assigned a **new ST**.

---

# MLST from WGS data

MLST is mainly performed on contigs.

Modern tools such as **mlst** search for known alleles in your genome assembly.

---

# Running MLST on Galaxy

## Input

You need:

- Your **assembled genome**, the contigs assembled with SPAdes (**SPAdes on data 2 and data 1: Contigs**)

---

## Create A new history

Let's create a new history to do the MLST 

!!! example "New history"
    1. Create a new history
    2. Rename it, e.g., **MLST**
    3. In **History Multiview**, drag and drop  the assembly scaffolds: **SPAdes on data 2 and data 1: Contigs** from the history **Assembly** to our empty history **MLST**.

## Open the MLST tool

1. In Galaxy, search for **mlst** in the tool panel.  
2. Click **"MLST – Scan contig files against PubMLST typing schemes"**.

<a href="../fig/galaxy/mlst_tool.png">
  <img src="../fig/galaxy/mlst_tool.png" width="650px" alt="MLST tool in Galaxy" />
</a>

---

## Configure parameters

1. **FASTA file**:  
   Select the `contigs.fasta` output from SPAdes.

2. **Scheme**:  
   Leave **"Auto-detect"** (recommended).  
   MLST will automatically detect the species and apply the correct scheme.

3. Leave other parameters as default.

4. Click **Run Tool**.

---

# Understanding the MLST Output

!!! "Question"
    Open the file **MLST on data X: report.tsv**
    What is the sequence type of the sample ?
    ??? "Answer"
      The Sequence type of this sample is 764.
      It actually makes sense, because this sample has already been reported in [PubMLST](https://pubmlst.org/bigsdb?page=info&db=pubmlst_saureus_isolates&set_id=1&id=44585), and attributed a ST.



### The important columns:

- **SCHEME** — species detected  
- **ST** — the sequence type  
- **Alleles** — allele numbers for each gene  

If some alleles appear as:

- `0` → allele not found  
- `?` → partial match  
- `NEW` → allele not in the database  

then:

- Coverage may be low  
- Assembly may be fragmented  
- The strain may contain a *new* allele (submit to PubMLST)

---

# Why Is MLST Useful?

MLST gives stable identifiers used in:

- Publications  
- Surveillance reports  
- Databases  


# Limitations of MLST

- Low resolution compared to whole-genome SNP analysis  
- Only uses 6–8 genes (very small part of the genome)  
- Cannot distinguish closely related outbreak strains  
- Housekeeping genes evolve slowly  

For fine-scale transmission studies, whole-genome SNP typing or cgMLST is preferred.

---

# Summary

!!! success "Key Points"
    - MLST is a widely used method for typing bacterial isolates.  
    - It relies on sequences of 6–8 housekeeping genes.  
    - Each gene is assigned an allele number.  
    - The allele profile defines the Sequence Type (ST).  
    - MLST can be computed from contigs using the Galaxy MLST tool.  
    - Results help in identifying lineages, outbreaks, and strain relationships.

---
