# Introduction to Next Generation Sequencing

!!! info "Lesson overview"
    **Teaching:** 15 min  
    **Exercises:** 15 min  

    **Questions**

    - How do you plan a metagenomics experiment?
    - How does a metagenomics project look like?

    **Objectives**

    - Learn the differences between shotgun and metabarcoding (amplicon metagenomics) techniques.
    - Understand the importance of metadata.
    - Familiarize yourself with the Cuatro Ciénegas experiment.


## Introduction to Next-Generation Sequencing

Next‑Generation Sequencing (NGS) describes high‑throughput technologies that perform massively parallel sequencing, producing millions to billions of short reads per run. Compared with Sanger sequencing, NGS dramatically reduced cost and time per base, enabling population-scale, clinical, and environmental genomics.
Sequencing (determining of DNA/RNA nucleotide sequence) is used all over the world for all kinds of analysis. The product of these sequencers are reads, which are sequences of detected nucleotides. Depending on the technique these have specific lengths (30-500bp) or using Oxford Nanopore Technologies sequencing have much longer variable lengths.

Key concepts:
- Sequencing libraries: DNA or cDNA is fragmented and adapters are ligated so fragments can be amplified and read by the sequencer.
- Read: A single sequence produced by the instrument (commonly 50–300 bp for short‑read platforms).
- Paired‑end reads: Both ends of a DNA fragment are sequenced, improving mapping, assembly, and detection of insertions/deletions.
- Coverage (depth): Average count of reads covering each base; higher coverage increases confidence for variant calling and assemblies.
- Quality scores: Per‑base confidence values (Phred scale) recorded in `FASTQ` files.

Typical NGS workflow steps: library preparation, cluster or bead generation, sequencing reactions, base calling, demultiplexing (if multiplexed), and downstream QC and analysis.

## Illumina Sequencing (Sequencing‑by‑Synthesis)

Illumina is the most widely used short‑read sequencing platform. It employs sequencing‑by‑synthesis (SBS) chemistry with reversible terminator nucleotides and optical detection to read bases one cycle at a time across millions of clonal clusters on a flow cell.

How it works (brief):
- Library preparation: DNA is fragmented and adapters (including sample indices) are ligated.
- Cluster generation: Fragments bind to complementary oligonucleotides on the flow cell and are amplified by bridge amplification, forming clusters of identical copies.
- Sequencing‑by‑synthesis: Fluorescent reversible terminator nucleotides are incorporated one base per cycle; after each incorporation the flow cell is imaged to record the signal from each cluster.
- Paired‑end sequencing: After completing the first read, chemistry is used to enable sequencing of the fragment's opposite end.
- Base calling and QC: Images are processed to call bases and assign Phred quality scores; data are output as demultiplexed `FASTQ` files when samples were multiplexed.

Strengths and limitations:
- Strengths: Very high throughput, low per‑base cost, robust ecosystem of library kits and analysis tools, and high accuracy for short reads.
- Limitations: Short reads make resolving large repeats and complex structural variants harder; some systematic errors (substitutions) increase toward read ends; library prep biases can skew representation.


## Applications

- Whole‑genome sequencing (microbial and eukaryotic)
- Targeted sequencing (amplicons and gene panels)
- RNA‑seq for transcriptomics
- Shotgun metagenomics for community profiling and functional inference



## Further Reading

- Illumina technology overview: https://www.illumina.com/science/technology/next-generation-sequencing.html
- Community guides and vendor protocols for library preparation and QC.

