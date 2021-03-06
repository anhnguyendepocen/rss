---
layout: default
---

[Wen and Stephens (2010)]: https://www.ncbi.nlm.nih.gov/pubmed/21479081
[Li and Stephens (2003)]: https://www.ncbi.nlm.nih.gov/pubmed/14704198
[get_corr.m]: https://github.com/stephenslab/rss/blob/master/misc/get_corr.m
[Nick]: https://github.com/CreRecombinase
[rssr]: https://github.com/stephenslab/rssr
[ldshrink]: https://github.com/stephenslab/ldshrink
[Zhu and Stephens (2017)]: https://projecteuclid.org/euclid.aoas/1507168840 
[Zhu and Stephens (2018)]: https://www.nature.com/articles/s41467-018-06805-x
[ash_lrt_31traits.R]: https://github.com/stephenslab/rss/blob/master/misc/ash_lrt_31traits.R
[Supplementary Figure 17]: https://static-content.springer.com/esm/art%3A10.1038%2Fs41467-018-06805-x/MediaObjects/41467_2018_6805_MOESM1_ESM.pdf
[compute_pip.m]: https://github.com/stephenslab/rss/blob/master/src_vb/compute_pip.m  
[zenodo-height2014]: https://doi.org/10.5281/zenodo.1443565
[zenodo-geneset]: https://zenodo.org/badge/latestdoi/55633948
[xiangzhu/rss-gsea]: https://github.com/xiangzhu/rss-gsea/tree/master/data

## General information

#### Q: RSS is cool, but it is implemented in MATLAB, which is a proprietary programming language. It would be nice if RSS methods could be made to work with some open source language so that everyone can run it freely.

A: To further improve the accessibility of RSS methods,
I am currently working on an R package [rssr][]
with [Nick][] (Nicholas Knoblauch) in my spare time.
Comments and suggestions are welcome!

## RSS methods & applications

#### Q: If I want to use RSS methods, how should I prepare for the input data?

A: Thanks for your interest in trying RSS methods!
To help you prepare your own data for RSS-based analyses,
I write a short [tutorial](Input-Data-Formats) about input data formats.
Please note that you need to store your input data in MAT-files if
you plan to use the MATLAB implementation of RSS methods.

#### Q: [Zhu and Stephens (2018)][] described a simple likelihood ratio calculation as a sanity check for the more sophisticated enrichment analysis based on RSS. Do you have software for this sanity check?

A: Yes. I write a stand-alone script [ash_lrt_31traits.R][] for this sanity check.
Please carefully read the instruction in this script.
For more details of this sanity check, please see the caption of
[Supplementary Figure 17][] in [Zhu and Stephens (2018)][].

#### Q: [Zhu and Stephens (2018)][] described an integrated framework based on RSS with both enrichment and prioritization components, and we are only interested in the gene prioritization component. How do we perform the gene-level association test using RSS (something like Figure 3 in the paper)? 

A: [Example 5 Part A](Example-5A) gives a step-by-step illustration of
gene-level association methods built on RSS, with input and output files included.
Since this example is based on a relatively small simulation,
it is highly recommended to run the codes and see how the methods work.

#### Q: Can I use the prioritization component of [Zhu and Stephens (2018)][] as a generic gene-level association testing method, assuming that I do not have any gene set information available?

A: Yes. When gene set information is not available, one can only fit a baseline model and obtain corresponding gene-level results. Indeed Figure 3 Panel A of [Zhu and Stephens (2018)][] illustrates a possible use scenario like this.  

## Linkage disequilibrium (LD)

#### Q: RSS uses the shrinkage estimator of LD in [Wen and Stephens (2010)][], the computation of which requires the "scaled population recombination rate" ($$\rho_{ij}$$). How do I compute $$\rho_{ij}$$?

A: Details of calculating $$\rho_{ij}$$ are provided in these two great papers:
[Li and Stephens (2003)][] and [Wen and Stephens (2010)][].
I also write a short [tutorial](Recombination) to illustrate the calculation of
scaled population recombination rate ($$\rho_{ij}$$) using HapMap genetic map.

#### Q: Most published RSS analyses used phased haplotypes to estimate LD. Can I use unphased genotype data to compute this shrinkage estimator of LD?

A: Yes. You can feed [get_corr.m][] an unphased genotype matrix and specify that `isgeno=true`.
There is a "0.5" correction term for genotype data, which comes from a random mating assumption.
Please see Section 2.4 of [Wen and Stephens (2010)][] for more details.

#### Q: I know of [Wen and Stephens (2010)][], but I'm not interested in imputation. Do you have software that just computes the banded covariance or LD matrix?

A: Yes. If you have MATLAB available, you can use [get_corr.m][].
If you prefer open source language such as R, [Nick][] and I are working
on an R package [ldshrink][] that can produce the banded LD matrix.

## Preprocessed data

#### Q: [Zhu and Stephens (2017)][] reported a whole genome analysis of human adult height data based on RSS. I am wondering whether you can share this preprocessed height dataset.

A: Yes. This preprocessed dataset is publicly available at
<https://doi.org/10.5281/zenodo.1443565>.
and can be referenced in a journal's "Data availability" section
as [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1443565.svg)][zenodo-height2014].
For more information on this dataset, please see this [page](Height2014).

#### Q: [Zhu and Stephens (2018)][] reported large-scale enrichment analyses of 4,026 gene sets across 31 complex human traits. Can you share these gene sets?

A: Yes. All 4,026 pre-processed gene sets used in this study
(including 3,913 biological pathways and 113 tissue-based gene sets)
are freely available at [xiangzhu/rss-gsea][].
These gene sets can be referenced in a journal's "Data availability" section
as [![DOI](https://zenodo.org/badge/55633948.svg)][zenodo-geneset].
For more information on these gene sets, please see this
[page](https://xiangzhu.github.io/rss-gsea/gene_set.html).   
