# AMR Gene Detection Using Abricate

!!! info "Lesson overview"
    **Teaching:** 15 min  
    **Exercises:** 20 min  

    **Questions**
    - What is AMR gene detection and why is it important?  
    - How does Abricate identify antimicrobial resistance genes?  
    - Which databases can Abricate use?  
    - How do we run Abricate on Galaxy and interpret results?

    **Objectives**
    - Understand the concept of AMR gene detection from bacterial genomes.  
    - Learn how Abricate scans assemblies for known resistance genes.  
    - Run Abricate in Galaxy using different AMR databases.  
    - Analyze and interpret Abricate output files.

---

# Introduction

**Antimicrobial resistance (AMR)** is a major global health threat caused by bacteria that resist antibiotic treatment.

Detecting AMR genes in bacterial genomes helps:

- Predict resistance phenotypes  
- Track the spread of resistance genes  
- Guide treatment decisions  
- Support surveillance programs  

**Abricate** is a popular bioinformatics tool that screens genome assemblies for known AMR, virulence, and plasmid genes using curated databases.

---

# How Abricate Works

- Takes genome assemblies (FASTA) as input.  
- Compares sequences against AMR gene databases using BLAST or similar.  
- Reports hits with identity, coverage, and gene annotations.  
- Supports multiple databases like **ResFinder**, **CARD**, **NCBI AMRFinder**, **ARG-ANNOT**, **VFDB** (virulence), and **PlasmidFinder**.

---

# Running Abricate on Galaxy

## Input data

- Assembled genome FASTA file (e.g., `contigs.fasta` from SPAdes)

---

## Steps to run Abricate

1. In Galaxy’s **Tools** panel, search for **Abricate**.  
2. Select **Abricate - AMR gene detection**.  

<a href="../fig/galaxy/abricate_tool.png">
  <img src="../fig/galaxy/abricate_tool.png" width="650px" alt="Abricate tool in Galaxy" />
</a>

3. For **FASTA file**, select your assembled genome.  
4. Select the **Database** (e.g., `resfinder`, `card`, or `ncbi`).  
5. Leave other parameters as default or adjust minimum identity and coverage thresholds.  
6. Click **Run**.

---

# Abricate Output Files

- **Tab-delimited report file**: lists detected genes with columns such as:  
  - `SEQUENCE`: contig name  
  - `START` / `END`: gene location  
  - `GENE`: gene name  
  - `%COVERAGE`: percent of gene covered by alignment  
  - `%IDENTITY`: percent identity of match  
  - `DATABASE`: database used 
  -  `PRODUCT`: 
- The report can be visualized in Galaxy or downloaded for further analysis.

---

# Interpreting Abricate Results

- High coverage and identity indicate reliable gene detection.  
- Multiple hits to the same gene may indicate gene duplications.  
- Some genes may confer resistance to multiple antibiotic classes.  
- Negative results don’t guarantee susceptibility — some resistance mechanisms are unknown.

# AMR Gene Detection with Abricate in Galaxy

## Goal

Detect antimicrobial resistance genes in a bacterial genome assembly using Abricate on Galaxy.

## Prerequisites

- An assembled bacterial genome FASTA file (`contigs.fasta`).  
- Access to a Galaxy server with Abricate installed.


## Create a new history

- Create a new Galaxy history called **Abricate AMR Detection**.  
- Upload your assembled genome FASTA file (contigs from SPADES)


### 2. Run Abricate

- Search for **Abricate** in Galaxy Tools.  
- Select **Abricate - AMR gene detection**.  
- Choose your uploaded FASTA as input.  
- Select the database, e.g., **RESFINDER**.  
- Keep default identity and coverage thresholds or adjust (e.g., min 90%).  
- Run the tool.
- Rename the file **ABRicate on data 1 report file** TO **ABRicate RESFINDER**

!!! "Question"
    Open the file **ABRicate RESFINDER**.
    - View the tabular results.  
  - Identify AMR genes detected, their location, and quality metrics.  
  - Look for genes conferring resistance to major antibiotic classes.
    Open the [referenced paper](https://journals.asm.org/doi/10.1128/mra.01212-19).
    Look at the Table 1.
    Compare with the results from the Paper (In table 1). Is there any differences ?

    ??? "Answer"
        HEYY HERE I ANSWER TO DO 

### 3. Examine output

- View the tabular results.  
- Identify AMR genes detected, their location, and quality metrics.  
- Look for genes conferring resistance to major antibiotic classes.



# Let's try with other databases

The results we have found earlier are only with **ResFinder**, let's try with another database !

#### 2. Run Abricate with different databases

- Search for **Abricate** in Galaxy Tools.
- Select **Abricate - AMR gene detection**.
- Choose your uploaded FASTA as input.
- Run Abricate multiple times, each time selecting a different database (e.g., **resfinder**, **card**, **ncbi**, **arg-annot**).
- Keep default identity and coverage thresholds or adjust as needed (e.g., min 90%).

#### 3. Compare results

- Download the tabular output files for each database.
- Compare the detected genes, their coverage, and identity across databases.
- Identify similarities and differences in the results.

#### 4. Analyze the impact of database choice

- Which database detected the most AMR genes?
- Were there any unique genes detected by specific databases?
- How do the results align with the known resistance profile of the organism?

### Discussion

- Discuss how the choice of database can influence AMR gene detection.
- Consider the importance of using multiple databases for comprehensive analysis.

!!! success "Key Points"
    - AMR gene detection is crucial for understanding bacterial resistance.  
    - Abricate screens genome assemblies against multiple curated AMR gene databases.  
    - It outputs tabular reports with gene location and identity.  
    - Galaxy provides an easy interface to run Abricate and explore results.



#
