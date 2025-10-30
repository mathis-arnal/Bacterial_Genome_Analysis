---
title: "Diversity Tackled With R "
teaching: 40
exercises: 10
questions:
- "How can we measure diversity?"
- "How can I use R to analyze diversity?"
objectives:
- "Plot alpha and beta diversity."
keypoints:
- "Alpha diversity measures the intra-sample diversity."
- "Beta diversity measures the inter-sample diversity."
- "Phyloseq includes diversity analyses such as alpha and beta diversity calculation."
math: true
---

!!! info "Lesson overview"
    **Teaching:** 15 min  
    **Exercises:** 15 min  

    **Questions**
    - "How can we measure diversity within a sample ?"
    - "How can we measure diversity between samples ?"

    **Objectives**
    - "Understand and compute alpha and beta diversity."


## First plunge into diversity

Species diversity, in its simplest definition, is the number of species in a particular area and their relative abundance (evenness).
Once we know the taxonomic composition of our metagenomes, we can do diversity analyses. 
Here we will discuss the two most used diversity metrics, α diversity (within one metagenome) and β (across metagenomes).   

- α Diversity: α Diversity describes the diversity within a community.  It considers the number of different species in an environment (also referred to as species richness).Additionally, it can take the abundance of each species into account to measure how evenly individuals are distributed across the sample (also referred to as species evenness). To measure α-diversity, we use indexes such as Shannon's, Simpson's, Chao1, etc.

<a href="../fig/03-08-01.png">
  <img src="../fig/03-08-01.png" alt="Alpha diversity diagram: In lake A, we have three fishes, each one of a different species. On lake B, we have two fish, each of a different species. Moreover, we have four fish in lake C, each of different species." />
</a>
<em> Figure 1. Alpha diversity is calculated according to fish diversity in a pond. Here, alpha diversity is represented in its simplest way: Richness. <em/>
 
- β compare the diversity between different communities by measuring their distance. 
It can be measured with metrics like Bray-Curtis dissimilarity, Jaccard distance, or UniFrac distance, to name a few. Each one 
of this measures are focused on a characteristic of the community (*e.g.,* Unifrac distance measures the phylogenetic relationship
between the species of the community).

In the next example, we will look at the α and the β components of the diversity of a 
dataset of fishes in three lakes. The most simple way to calculate the β-diversity 
is to calculate the distinct species between two lakes (sites). Let us take as an example the diversity between
Lake A and Lake B. The number of species in Lake A is 3. To this quantity, we will subtract the number of these species that are shared with the Lake 
B: 2. So the number of unique species in Lake A compared to Lake B is (3-2) = 1. To 
this number, we will sum the result of the same operations but now take Lake B as 
our reference site. In the end, the β diversity between Lake A and Lake B is 
(3-2) + (3-2) = 2. This process can be repeated, taking each pair of lakes as the 
focused sites.

<a href="../fig/03-08-02.png">
  <img src="../fig/03-08-02.png" alt=" Alpha and Beta diversity diagram: Each Lake has a different number of species, and each species has a different number of fish individuals. Both metrics are taken into account to measure alfa and beta diversity." />
</a>
<em> Figure 2. Alpha and beta diversity indexes of fishes in a pond.<em/>

If you want to read more about diversity, we recommend to you this [paper](https://link.springer.com/article/10.1007/s00442-010-1812-0) on 
the concept of diversity. 

!!! exercise "Exercise 1: Simple measure of alpha and beta diversities."
    In the next picture, there are two lakes with different fish species:

    <a href="../fig/03-08-03.png">
      <img src="../fig/03-08-03.png" alt="In lake A, we have four different species, two of these species have three specimens each one. This Lake also has two specimens of a third species and only one specimen of a fourth specie. We got nine fish in total. Lake B has only three different species, the most populated species is also present in lake A and has five specimens, and we have only one specimen of each of the other two species. We got seven species total in lake B " />
    </a>

    *Figure 3.*

    Which of the options below is true for the alpha diversity in lakes A, B, and beta diversity between lakes A and B, respectively?

    1. `4, 3, 1`  
    2. `4, 3, 5`  
    3. `9, 7, 16`

    ??? success "Solution"

        **Answer:** **4, 3, 5**

        **Alpha diversity** here is the number of different species in each lake.  

        - Lake **A** has **4** different species.  
        - Lake **B** has **3** different species.

        **Beta diversity** (using the formula from *Figure 2*) is the count of species unique to each lake summed together:

        - Shared species between A and B = **1**.
        - Species unique to A = `4 - 1 = 3`.
        - Species unique to B = `3 - 1 = 2`.
        - Beta diversity = `3 + 2 = 5`. 

## α diversity  

There are several different indexes used to calculate α
diversity because different indexes capture different aspects of diversity and have varying sensitivities to different factors. These indexes have been developed to address specific research questions, account for different ecological or population characteristics, or highlight certain aspects of diversity.

| Diversity Indices | Description |
|:------------------|:------------|
| **Shannon (H)** | Estimation of species richness and species evenness. More weight on richness. |
| **Simpson’s (D)** | Estimation of species richness and species evenness. More weight on evenness. |
| **Chao1** | Abundance based on species represented by a single individual (singletons) and two individuals (doubletons). |
 

- Shannon (H): 

| Variable             |  Definition   |     
:-------------------------:|:-------------------------:  
$ H = - \sum_{i=1}^{S} p_{i} \ln{p_{i}} $ | Definition
$ S $ | Number of OTUs 
$ p_{i} $ | The proportion of the community represented by OTU i

<!-- <img src="https://render.githubusercontent.com/render/math?math=H=-\sum_{i=1}^{S}p_i\:ln{p_i}"> | Definition
<img src="https://render.githubusercontent.com/render/math?math=S"> | Number of OTUs  
<img src="https://render.githubusercontent.com/render/math?math=p_i">|  The proportion of the community represented by OTU i    -->

- Simpson's (D) 

| Variable             |  Definition |   
:-------------------------:|:-------------------------:  
$ D = \frac{1}{\sum_{i=1}^{S} p_{i}^{2}} $ | Definition
$ S $ | Total number of the species in the community
$ p_{i} $ | Proportion of community represented by OTU i
  
Simpsons index calculates the probability that two individuals selected from a community will be of the same species.
Small values are observed in datasets of high diversity and large values in datasets of low diversity. The index ranges from 0 to 1, with 1 representing minimum diversity (1 specie). A value of 0.6 indicates that two randomly selected individuals from the community have 60% probability to belong to different species.  
<!-- <img src="https://render.githubusercontent.com/render/math?math=D=\frac{1}{\sum_{i=1}^{S}p_i^2}">| Definition   
<img src="https://render.githubusercontent.com/render/math?math=S"> | Total number of the species in the community   
<img src="https://render.githubusercontent.com/render/math?math=p_i" align="middle"> | Proportion of community represented by OTU i     -->
  
- Chao1  

| Variable             |  Definition |   
:-------------------------:|:-------------------------:  
$ S_{chao1} = S_{Obs} + \frac{n_{1} \times (n_{1} - 1)}{2 \times (n_{2} + 1)} $ | Definition
$ n_{1} $ | the number of species represented by a single individual (singletons)
$ n_{2} $ | the number of species represented by two individuals (doubletons)
$ S_{Obs} $ | The number of observed species
  
Chao1 estimates the true species richness or diversity of a community, particularly when there might be rare or unobserved species. Chao1 estimates the number of unobserved species based on the number of singletons and doubletons. It assumes that there are additional rare species that are likely to exist but have not been observed. The estimation considers the number of unobserved singletons and doubletons and incorporates them into the observed species richness to provide an estimate of the true species richness.  
<!-- <img src="../fig/equation.svg">| Definition  
<img src="https://render.githubusercontent.com/render/math?math=F_1,F_2">|Count of singletons and doubletons respectively    
<img src="https://render.githubusercontent.com/render/math?math=S_{chao1}=S_{Obs}">| The number of observed species   -->

 <!-- comment we use https://viereck.ch/latex-to-svg/ to convert from latex to SVG because Chao equation did not render correctly with GitHub math!-->

## β diversity  
Diversity β measures how different two or more communities are, either in their composition (richness) or in the abundance of the organisms that compose it (abundance). 

- Bray-Curtis dissimilarity

| Variable             |  Definition |   
:-------------------------:|:-------------------------: 
$ BC_{ij} = 1 - \frac{2C_{ij}}{S_{i} + S_{j}} $|  Definition
$  C_{ij} $ | the sum of the absolute differences in abundances between corresponding species in samples i
 and j
$  S_{i} $ | the total abundance or sum of species abundances in sample i
$  S_{j} $ | the total abundance or sum of species abundances in sample j


Bray-Curtis dissimilarity measures The difference in richness and abundance across environments (samples). Weight on abundance. Measures the differences 
The higher the dissimilarity value, the greater the difference in species composition or abundances. Goes from 0 (equal communities) to 1 (different communities)


- Jaccard distance

| Variable             |  Definition |   
:-------------------------:|:-------------------------: 
$ J(X, Y) =  \frac{\| X ∩ Y\|}{\| X ∪ Y\|} $ | Definition 
$  X ∩ Y $ | the intersection of sets X and Y, i.e. elements common to both sets
$  X ∪ Y $ | the union of sets X and Y, i.e. all unique elements from both sets combined

Jaccard distance is based on the presence/absence of species (diversity). 
It goes from 0 (same species in the community) to 1 (no species in common)

- UniFrac


UniFrac Measures the phylogenetic distance; how alike the trees in each community are. 
There are two types, without weights (diversity) and with weights (diversity and abundance) 
<a href="../fig/unifrac_score.png">
  <img src="../fig/unifrac_score.png" alt=" Unifrac Score" />
</a>
<em> Figure 3. UniFrac Score explained.<em/> 

There are different ways to plot and show the results of such analysis. Among others, PCA, PCoA, or NMDS analysis are widely used.

## Compute the Alpha diversity

Now that we have seen the definition of Alpha and Beta diversity. Let's try to compute some of this indices.
We can do it using KrakenTools in Galaxy.
Let's follow this tutorial:
https://training.galaxyproject.org/training-material/topics/microbiome/tutorials/diversity/tutorial.html#evaluation-of-different-diversity-metrics

### Create a new history

  
> ## Discussion: Indexes of diversity  
> Why do you think we need different indexes to asses diversity? What index will you use to assess the impact of rare, low-abundance taxa?
> 
>> ## Solution
>> 
>> It will be difficult (if not impossible) to take two communities and observe the same distribution of all members. This outcome is because 
>> there are a lot of **factors** affecting these lineages. Some of the **environmental factors** are temperature, pH, and nutrient concentration.
>> Also, the interactions of these populations, such as competence, inhibition of other populations, and growth speed, 
>> are an important driver of variation (**biotic factor**). A combination of the **factors mentioned above**, can interact to maintain some populations with low
>> abundance (**rare taxa** In order to have 
>> ways to assess hypotheses regarding which of these processes can be affecting the community, we use all these different indexes. Some emphasize the number of 
>> species and other the evenness of the OTUs. 
>> To assess the impact of low abundance lineages, one alpha diversity index widely used is the Chao1 index.
                             

!!! Success "Key Points"
    - Alpha diversity measures the intra-sample diversity.
    - Beta diversity measures the inter-sample diversity.
    - Different indexes capture different aspects of diversity