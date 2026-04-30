# RNA-seq-processing-pipeline

End-to-end rna-seq data processing pipeline using FASTQC, Trimmomatic, HISAT2, and featureCounts on human CAR-T dataset.





This repository contains a reproducible RNA-seq data processing pipeline based on publicly available sequencing data. The workflow covers steps from raw sequencing reads to gene-level count matrices.



\---



\## Dataset Information


\- \*\*DOI:\*\*   GEO accession: GSE308384

\- \*\*Title:\*\* Dextran-based T-cell expansion nanoparticles for manufacturing CAR T cells with augmented efficacy  

\- \*\*DOI:\*\* https://doi.org/10.1038/s41467-025-67868-1  

\- \*\*Organism:\*\* Homo sapiens  

\- \*\*Experiment Type:\*\* Expression profiling by high throughput sequencing  

\- \*\*Platform:\*\* Illumina NovaSeq X Plus  

\- \*\*Library Layout:\*\* Paired-end  

\- \*\*SRA Study:\*\* SRP621313  

\- \*\*BioProject:\*\* PRJNA1330318  

\- \*\*Release Date:\*\* 19 November 2025  



\### Experimental Design

RNA-seq profiling of CAR-T cells expanded using:

\- T-Expand nanoparticles  

\- Dynabeads (control)  



Cells were cultured in the presence of IL-2 for 10 days.



\---



\## Samples Used



Due to computational constraints, a subset of samples was processed:



\- SRR35488286  

\- SRR35488287  

\- SRR35488288  

\- SRR35488289  



\---



\## Pipeline Overview



\### 1. Data Acquisition and Quality Control

\- Downloaded sequencing data using SRA Toolkit  

\- Converted `.sra` files to `.fastq` format  

\- Performed quality assessment using FastQC  

\- Compressed FASTQ files for storage efficiency  



\---



\### 2. Read Trimming

\- Tool: Trimmomatic  

\- Removed adapter sequences and low-quality bases  

\- Generated paired trimmed reads for downstream analysis  



\---



\### 3. Alignment

\- Tool: HISAT2  

\- Reference genome: GRCh38  

\- Reads aligned to the human genome  

\- Generated SAM, BAM, sorted BAM, and indexed BAM files  



\*\*Note:\*\*  

A subset of reads (\~2 million per sample) was used for alignment to reduce computational load during testing.



\---



\### 4. Gene Quantification

\- Tool: featureCounts (Subread package)  

\- Annotation: Ensembl GRCh38 GTF  

\- Reads were quantified at the gene level  



\---



\### 5. Post-processing

The raw `featureCounts` output was processed to generate an analysis-ready count matrix:

\- Removed comment/metadata lines  

\- Retained gene IDs and count columns  

\- Standardized column headers  



Final output:

\- clean\_counts.txt





\---



\## Repository Structure



rna-seq-processing-pipeline/



scripts/

&#x20; 01\_download\_and\_qc.sh

&#x20; 02\_trimming.sh

&#x20; 03\_alignment.sh

&#x20; 04\_featurecounts.sh

&#x20; 05\_cleanup\_counts.sh



results/

&#x20; FASTQC/


&#x20; counts/

&#x20;   clean\_counts.txt

&#x20;   gene\_counts.txt



README.md





\---



\## Key Observations



\- High overall alignment rate (\~95%)  

\- Approximately 79% uniquely mapped reads  

\- Successful generation of gene-level count matrix  



\---



\## Limitations



\- Only a subset of samples was processed  

\- Alignment was performed on downsampled reads (\~2 million reads per sample)  

\- Downstream differential expression analysis was not included due to limited sample size and potential confounding variables  



\---



\## Tools Used



\- SRA Toolkit  

\- FastQC  

\- Trimmomatic  

\- HISAT2  

\- SAMtools  

\- featureCounts (Subread)  



\---



\## Reference



Zheng T, Ramanathan K, Ormhøj M, Hansen MR et al.  

Dextran-based T-cell expansion nanoparticles for manufacturing CAR T cells with augmented efficacy.  

Nature Communications, 2026.

