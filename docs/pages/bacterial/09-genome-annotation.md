# Genome Annotation using Bakta

!!! info "Lesson overview"
    **Teaching:** 20 min  
    **Exercises:** 25 min  

    **Questions**
    - What is genome annotation?
    - Why is annotation important after assembly?
    - How does Bakta work for bacterial genome annotation?
    - What are the main output files and their meanings?

    **Objectives**
    - Understand the purpose and process of bacterial genome annotation.  
    - Learn how to run Bakta on an assembled genome.  
    - Interpret Bakta output files and their contents.  
    - Use annotated genomes for downstream analysis.

---

# Introduction

In addition to the AMR and plasmid genes, it would be good to have extra information about other genes on the contigs. Several tools exists to do that: Prokka (Seemann 2014), Bakta (Schwengers et al. 2021), etc. Here, we use Bakta as recommended by Torsten Seeman as the successor of Prokka.


**Genome annotation** is the process of identifying genes and other functional elements within a genome sequence, and assigning biological information to them.

After assembling your bacterial genome, the raw sequence (FASTA) only contains the DNA letters A, T, C, and G.  
Annotation adds biological context, including:

- **Protein-coding genes (CDSs)**  
- **rRNA and tRNA genes**  
- **Non-coding RNAs**  
- **Functional descriptions and gene names**  
- **Protein family domains**  
- **Gene Ontology (GO) terms**  

This annotation is essential for interpreting the biology of the organism.

---

# What is Bakta?

[Bakta](https://github.com/oschwengers/bakta) is a fast, accurate, and user-friendly bacterial genome annotation tool.

Why use Bakta?

- Supports **complete and draft bacterial genomes**  
- Uses a curated, taxon-independent database  
- Provides detailed functional annotation and standardized outputs  
- Easy to run on the command line or via Galaxy  
- Produces multiple output formats including GenBank and GFF3  

---

# Running Bakta on Galaxy

## Input data

- Your assembled genome in **FASTA format** (e.g. `contigs.fasta` from SPAdes)

---

## Steps to run Bakta

1. In the Galaxy tools panel, search for **Bakta**.  
2. Select the **Bakta - Bacterial genome annotation** tool.  

<a href="../fig/galaxy/bakta_tool.png">
  <img src="../fig/galaxy/bakta_tool.png" width="650px" alt="Bakta tool in Galaxy" />
</a>

3. Set the input FASTA file to your assembled genome.  
4. You can leave other parameters as default for most cases.  
5. Click **Run**.

---

# Bakta Output Files and What They Mean

Once the job finishes, Bakta produces multiple output files:

| Filename | Description | Usage |
|----------|-------------|-------|
| `*.gbk` or `*.gbff` | **GenBank file** with full annotation and sequence. | Standard format for genome browsers and many downstream tools. |
| `*.gff` | **GFF3 format annotation** describing gene locations and features. | Used for visualization and gene feature parsing. |
| `*.faa` | **Protein sequences** (amino acids) of predicted genes. | Useful for functional analyses and homology searches. |
| `*.ffn` | **Nucleotide sequences** of predicted genes (CDS). | For nucleotide-level analyses or BLAST searches. |
| `*.tbl` | Table format describing gene features (coordinates, strand, etc.). | Can be used for submission to databases or further processing. |
| `bakta.log` | Detailed **log file** of the annotation process. | Useful for troubleshooting and understanding workflow. |
| `*.json` | JSON-formatted annotation summary with detailed metadata. | For automated parsing or integration into pipelines. |

---

A GFF3 format annotation is a standardized text file that describes genomic features and their locations on a sequence.
GFF3 stands for "General Feature Format version 3". Each line represents a feature (like a gene, CDS, rRNA, etc.) with columns for sequence name, feature type, start/end positions, strand, and additional attributes (such as gene name or product).
GFF3 files are widely used for genome visualization, feature parsing, and downstream analyses.

## Key annotation features in the output

- **CDS (Coding DNA Sequence):** predicted protein-coding genes with start/stop positions.  
- **rRNA and tRNA genes:** ribosomal and transfer RNA genes detected by specialized tools.  
- **Gene names and functions:** based on homology to curated databases (UniProt, Pfam, etc).  
- **Protein domains:** functional domains assigned via Pfam and TIGRFAMs.  
- **Gene Ontology (GO) terms:** standardized functional annotations.  
- **EC numbers:** enzyme classification identifiers where applicable.  
- **Protein product descriptions:** functional names like “DNA polymerase III subunit”.  

---

# How to use the annotation?

- Visualize annotated genomes in genome browsers (e.g. Artemis, IGV) using `.gbk` or `.gff`.  
- Extract protein sequences (`.faa`) for phylogenetics or functional annotation.  
- Use annotation tables to identify genes of interest (e.g. virulence, metabolism).  
- Submit annotated genomes to public repositories like NCBI.  

---

# Genome Annotation with Bakta on Galaxy


Annotate a bacterial genome assembly using Bakta in Galaxy and explore the annotation results.

## Create A new history

Let's create a new history to do the annotation.

!!! example "New history"
    1. Create a new history
    2. Rename it, e.g., **Bakta Annotation**
    3. In **History Multiview**, drag and drop the assembly scaffolds: **SPAdes on data 2 and data 1: Contigs** from the history **Abricate AMR Detection** to our empty history **Bakta Annotation**.

## 2. Launch Bakta

1. In the **Tools** panel, search for **Bakta**.  
2. Select **Bakta - Bacterial genome annotation**.  
3. For **FASTA file**, select your uploaded assembled genome (**SPAdes on data 2 and data 1: Contigs**) 
4. Leave other parameters as default.  
5. Click **Run**.

Bakta might take a while to process 

On the analysis summary output ...

!!! "Question" Question

      How many contigs have been provided as input? How long is the draft genome? How many CDSs have been found? How many small proteins? Which other components have been found?


!!! "Question" Observe the annotation gff3 file

    How many features are annotated?

Bakta gives a lot of information already, especially regarding CDSs (Coding Sequences) or RNAs, but some structural annotation might be missing, e.g. plasmids, or interesting to identify independently.

- Plasmids: To identify plasmids in contigs, use PlasmidFinder (Carattoli and Hasman 2020), a tool for the identification and typing of plasmid sequences in Whole-Genome Sequencing. It uses the plasmidfinder database with hundreds of sequences to predict the plasmid in the data.

- Integrons : Integrons are genetic mechanisms that allow bacteria to adapt and evolve rapidly through the stockpiling and expression of new genes. To detect integrons, you can use IntegronFinder (Néron et al. 2022)

- Insertion Sequence elements IS : is a short DNA sequence that acts as a simple transposable element. IS are the smallest but most abundant autonomous transposable elements in bacterial genomes. They only code for proteins implicated in the transposition activity. They play then a key role in bacterial genome organization and evolution. To detect IS elements, use ISEScan (Xie and Tang 2017). ISEScan is a highly sensitive software pipeline based on profile hidden Markov models constructed from manually curated IS elements.

# Quality Check of a Genome Annotation 

Once an annotation is produced, it is essential to assess its reliability and completeness. There is no single “perfect” metric, and each method highlights different aspects of annotation quality. In practice, evaluation usually involves combining several complementary approaches.


# Visualisation of the ARGs (?)

We can now visualize the contigs, the mapping coverage, and the genes, using JBrowse and different information track.

