#!/bin/bash

## Cleaning Illumina Short-Read Data. Reads are 2x150 basepairs. 
## Genomic DNA Short-Read Data from Foot = 4C. 
## RNA Transcript Data from Mantle, Foot, Gills = 1C, 5C, and 7C respectively.

## Make Folders to Store Indiviual Tissue Files

mkdir RNA_1C_Mantle
mkdir RNA_5C_Foot
mkdir RNA_7C_Gills
mkdir DNA_4C_Foot

## FASTP

### RNA Mantle Tissue 1C
fastp -i Mhem-gen1-1C_R1_001.fastq.gz -I Mhem-gen1-1C_R2_001.fastq.gz -o /RNA_1C_Mantle/Mhem-gen1-1C_R1_001.fastp.fastq.gz -O /RNA_1C_Mantle/Mhem-gen1-1C_R2_001.fastp.fastq.gz -q 30 --length_required 80 --cut_tail --cut_front --cut_mean_quality 30 --thread 32 --dont_overwrite

### RNA Mantle Tissue 5C
fastp -i Mhem-gen1-5C_R1_001.fastq.gz -I Mhem-gen1-5C_R2_001.fastq.gz -o /RNA_5C_Foot/Mhem-gen1-5C_R1_001.fastp.fastq.gz -O /RNA_5C_Foot/Mhem-gen1-5C_R2_001.fastp.fastq.gz -q 30 --length_required 80 --cut_tail --cut_front --cut_mean_quality 30 --thread 32 --dont_overwrite

### RNA Mantle Tissue 7C
fastp -i Mhem-gen1-7C_R1_001.fastq.gz -I Mhem-gen1-7C_R2_001.fastq.gz -o /RNA_7C_Gills/Mhem-gen1-7C_R1_001.fastp.fastq.gz -O /RNA_7C_Gills/Mhem-gen1-7C_R2_001.fastp.fastq.gz -q 30 --length_required 80 --cut_tail --cut_front --cut_mean_quality 30 --thread 32 --dont_overwrite

### DNA Foot Tissue 4C
fastp -i Mhem-gen-1-4C_R1_001.fastq.gz -I Mhem-gen-1-4C_R2_001.fastq.gz -o /DNA_4C_Foot/Mhem-gen-1-4C_R1_001.fastp.fastq.gz -O /DNA_4C_Foot/Mhem-gen-1-4C_R2_001.fastp.fastq.gz -q 30 --length_required 80 --cut_tail --cut_front --cut_mean_quality 30 --thread 32 --dont_overwrite