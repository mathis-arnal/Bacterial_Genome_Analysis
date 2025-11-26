# AMR Gene Detection Using Abricate

!!! info "Lesson overview"
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

[**Abricate**](https://github.com/tseemann/abricate) is a popular bioinformatics tool that screens genome assemblies for known AMR, virulence, and plasmid genes using curated databases, using **BLAST**. 

---

# How Abricate Works

- Takes genome assemblies (FASTA) as input.  
- Compares sequences against AMR gene databases using BLAST or similar.  
- Reports hits with identity, coverage, and gene annotations.  
- Supports multiple databases like **ResFinder**, **CARD**,**NCBI AMRFinder**,**VFDB** (virulence), and **PlasmidFinder** (Plasmid).

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
    Look at the Table 1, they have tested antibiotics and have established Antibiotic resistance (MIC [μg/ml]).
    Compare with the Antibiotic Resistance for the sample **KUN1163**.
    Does this results correlates with our fundings from **ResFinder** ?
    Discuss with your neighbor.
    

    ??? "Answer"
        Phenotypic antimicrobial susceptibility testing revealed resistance to 7 antibiotic classes: **CEZ (≥64), IPM (≥32), LVFX (≥16), GM (≥32), EM (≥16), CLDM (≥16), MPIPC (≥16)**.

        We look at the **RESISTANCE** column from the ResFinder output.

        **β-lactam resistance** ( Imipenem(IPM)) was conferred by *mecA* (99.85% identity) located 
        on a mobile SCCmec element (NODE_23, 18× coverage).

        **Macrolide-lincosamide resistance** (erythromycin (EM), clindamycin(CLDM) 
        ) was mediated by *erm(A)* (100% identity) on a high-copy plasmid 
        (NODE_24, 30× coverage).

        **Aminoglycoside resistance** (gentamicin(GM)) resulted from a 
        bifunctional enzyme *aac(6')-aph(2'')* (100% identity) on a very high-copy 
        plasmid (NODE_27, 134× coverage).

        Discussion: There are 3 Antibiotics NOT Found in ResFinder: CEZ (Cefazolin), MPIPC (Oxacillin) and LVFX (Levofloxacin).
        **Why only 4/7 antibiotics are explicitly listed:**
        **1. mecA Limitation (CEZ, MPIPC missing):**
        - mecA confers resistance to ALL β-lactams
        - ResFinder lists representative examples: "Imipenem, Cefoxitin, Cefepime..."
        - **CEZ (cefazolin)** and **MPIPC (oxacillin)** are omitted from the text list
        - This does NOT mean susceptibility - it's a database annotation limitation
        - **Interpretation:** mecA present → assume ALL β-lactams resistant, including CEZ and MPIPC.
        
        **2. LVFX (Levofloxacin) - Different mechanism:**
        - ResFinder found NO plasmid-mediated quinolone resistance genes (qnr, aac(6')-Ib-cr)
        - Fluoroquinolone resistance in S. aureus is usually from:
          a) **Chromosomal point mutations** in gyrA/parC (NOT detected by gene-based tools)
          b) **Intrinsic efflux pumps** like norA (excluded from ResFinder)
        - ResFinder only detects acquired GENES, not mutations or intrinsic mechanisms


## Can We Predict Untested Antibiotics?

**YES! Genomic analysis predicts resistance far beyond what was tested.**

### The Numbers:
- **Phenotypic testing**: 7 antibiotics tested resistant
- **Genomic ResFinder prediction**: 50+ antibiotics predicted resistant

### Why WGS is More Comprehensive:

1. **Mechanism-based prediction**: 
   - mecA doesn't just predict "oxacillin resistant"
   - It predicts resistance to ALL β-lactams (~25 drugs)

2. **Detects untested classes**:
   - tetM, tet(38) genes → tetracycline resistance
   - But NO tetracyclines were tested phenotypically
   - WGS reveals hidden resistance

3. **Identifies transferable resistance**:
   - High-copy plasmids (134×) = easy horizontal transfer
   - Predicts risk to OTHER bacteria in patient/environment

**Lab report says**: "Tested 7 drugs resistant"

**But genomic analysis reveals**:
- Amoxicillin-clavulanate → **Will FAIL** (mecA present)
- Azithromycin → **Will FAIL** (erm(A) present)
- Doxycycline → **Will FAIL** (tetM present)

###  How confident are we with genotype prediction ? 


# Let's try with other databases

The results we have found earlier are only with **ResFinder**, let's try with another database !

#### 2. Run Abricate with different databases

- Search for **Abricate** in Galaxy Tools.
- Select **Abricate - AMR gene detection**.
- Choose your uploaded FASTA as input.
- Run Abricate multiple times, each time selecting a different database (**Plasmid Finder**, **CARD**).

#### 3. Compare results

#### Plasmid Finder

**Plasmid Finder** looks for Plasmid replication genes (rep genes)
Open the output from Abricate with **Plasmid Finder**.
Discuss with your neighbour about the information present in this file.
Combining with the results from **ResFinder**, what can you say ? 

??? "Discussion"
    5 plasmid replication genes in your assembly, on 3 contigs : 
    - 3 replication genes in NODE_21_length_27407_cov_110.440469	
    - 1 replication gene in NODE_23_length_17578_cov_18.436938
    - 1 replication gene inNODE_2_length_382439_cov_15.798832

    2. High coverage on plasmid contigs:

    NODE_21: Coverage = 110× (vs genome avg ~15-20×), size = 27kb (plasmid size)
    NODE_23: Coverage = 18×, size = 17kb (reasonable plasmid size)
    NODE_2: Coverage = 15.8×, size = 382 kb (likely chromosomal with integrated plasmid)

    What This Means:
    **NODE_21 is definitely a plasmid**
    3 different rep genes on the same 27 Kbp contig
    Coverage 110× = 5-7× higher than chromosome
    This indicates high copy number plasmid (multiple copies per cell), of size 27.4 Kbp
    Size: 27.4 Kbp - typical for staphylococcal plasmids

    **NODE_23**:  When looking at the accession **AF503772** of the replicon gene, Tetracycline resistance protein found in **Streptococcus faecalis**. It might come from horizontal transfer from Streptococcus faecalis on a plasmid of Staphylococcus aureus.

    Combining with the results of **ResFinder**, we are able to create this table: 

    | Contig   | Size     | Coverage | PlasmidFinder         | ResFinder                   | Interpretation                           |
    |----------|----------|----------|------------------------|-----------------------------|-------------------------------------------|
    | NODE_21  | 27.4 Kb  | 110×     | ✅ 3 rep genes         | ❌ No resistance            | “Empty” plasmid (backbone only)           |
    | NODE_23  | 17.6 Kb  | 18×      | ✅ rep22_1b            | ✅ mecA, aadD               | SCCmec element (complete picture)         |
    | NODE_24  | 6.7 Kb   | 30×      | ❌ No rep              | ✅ erm(A), ant(9)-Ia        | Resistance plasmid (rep not detected)     |
    | NODE_27  | 1.9 Kb   | 134×     | ❌ No rep              | ✅ aac(6')-aph(2'')         | Resistance plasmid (rep not detected)     |
    | NODE_2   | 382 Kb   | 15.8×    | ✅ repUS43_1           | ✅ tet(M)                   | Chromosomal integration (large size)      |

    PlasmidFinder did not find any known plasmid replication genes in its database on the 24 and 27, but that doesn't mean that Replication genes are absent, or that it is not a plasmid, they might just be absent from the database.

#### CARD    


Open the output from Abricate with **CARD**.

!!! question "Comparing AMR Databases"
    Compare the CARD and ResFinder results:
    
    1. How many resistance genes did each database identify?
       - CARD: ____ genes
       - ResFinder: ____ genes
    
    2. Which genes were found in BOTH databases?
    
    3. Which genes were ONLY in CARD? Why might ResFinder have excluded them?
    
    4. ResFinder identified **ant(9)-Ia** that CARD missed. What does this gene confer resistance to?
    
    5. For clinical reporting, which database results would you prioritize? Why?

    ??? success "Answer"
        **Gene Counts:**
        - CARD: 16 genes (includes efflux pumps and regulators)
        - ResFinder: 6 genes (acquired resistance only)
        
        **Found in BOTH:**
        - mecA, erm(A), tet(M), aac(6')-aph(2'')
        
        **Only in CARD:**
        - Efflux pumps: norA, mepA, tet(38), LmrS
        - Regulators: arlR/S, mepR, mgrA
        - Intrinsic: FosB
        
        These are **chromosomal/intrinsic** genes, not acquired through horizontal transfer.
        
        **Only in ResFinder:**
        - ant(9)-Ia: confers **spectinomycin** resistance
        - aadD: better annotated nomenclature
        
        **Clinical Reporting:**
        Prioritize **ResFinder** for phenotype prediction, but include **CARD** 
        to explain unexpected treatment failures (e.g., fluoroquinolone resistance 
        via efflux despite no qnr genes).

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



#
