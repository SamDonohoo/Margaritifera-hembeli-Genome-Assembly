#!/bin/bash

# Repeat Masking with RepeatModeler and RepeatMasker.
# Based on Daren Card's Example for Repeat Annotation using RepeatModeler and RepeatMasker. Website: https://darencard.net/blog/2022-07-09-genome-repeat-annotation/

## Create a Database for RepeatModeler

BuildDatabase -name Mhem_Polished_Clean_Scaff Mhem_Polished_Cleaned_Scaff.fasta

## Run RepeatModeler

RepeatModeler -database Mhem_Polished_Clean_Scaff -threads 32 > Mhem_Polished_Cleaned_Scaff.RepeatMod.out

## Clean Up File Names and Split Out Known and Unknown repeats

cat Mhem_Polished_Cleaned_Scaff.fasta | seqkit fx2tab | awk '{ print "Marhem1_"$0 }' | seqkit tab2fx > Mhem_Polished_Cleaned_Scaff.prefix.fa
cat Mhem_Polished_Cleaned_Scaff.prefix.fa | seqkit fx2tab | grep -v "Unknown" | seqkit tab2fx > Mhem_Polished_Cleaned_Scaff.prefix.known.fa
cat Mhem_Polished_Cleaned_Scaff.prefix.fa | seqkit fx2tab | grep "Unknown" | seqkit tab2fx > Mhem_Polished_Cleaned_Scaff.prefix.unkown.fa.

# Make Directories for RepeatMasker

mkdir SoftMask_01_simple_out
mkdir SoftMask_02_bivalvia_out
mkdir SoftMask_03_known_out
mkdir SoftMask_04_unknown_out

# round 1: annotate/mask simple repeats
RepeatMasker -pa 16 -a -e ncbi -dir SoftMask_01_simple_out -noint -xsmall Mhem_Polished_Cleaned_Scaff.fasta

# round 1: rename outputs
rename fasta simple_mask SoftMask_01_simple_out/Mhem_Polished_Cleaned_Scaff*
rename .masked .masked.fasta SoftMask_01_simple_out/Mhem_Polished_Cleaned_Scaff*

# round 2: annotate/mask Bivalvia elements sourced from Repbase using output from 1st round of RepeatMasker
RepeatMasker -pa 16 -a -e ncbi -dir SoftMask_02_bivalvia_out -xsmall -species bivalvia SoftMask_01_simple_out/Mhem_Polished_Cleaned_Scaff.simple_mask.masked.fasta

# round 2: rename outputs
rename simple_mask.masked.fasta bivalvia_mask SoftMask_02_bivalvia_out/Mhem_Polished_Cleaned_Scaff*
rename .masked .masked.fasta SoftMask_02_bivalvia_out/Mhem_Polished_Cleaned_Scaff*

# round 3: annotate/mask known elements sourced from species-specific de novo repeat library using output froom 2nd round of RepeatMasker
RepeatMasker -pa 16 -a -e ncbi -dir SoftMask_03_known_out -nolow -lib Mhem_Polished_Cleaned_Scaff.prefix.known.fa SoftMask_02_bivalvia_out/Mhem_Polished_Cleaned_Scaff.bivalvia_mask.masked.fasta

# round 3: rename outputs
rename bivalvia_mask.masked.fasta known_mask SoftMask_03_known_out/Mhem_Polished_Cleaned_Scaff*
rename .masked .masked.fasta SoftMask_03_known_out/Mhem_Polished_Cleaned_Scaff*

# round 4: annotate/mask unknown elements sourced from species-specific de novo repeat library using output froom 3nd round of RepeatMasker
RepeatMasker -pa 16 -a -e ncbi -dir SoftMask_04_unknown_out -nolow -lib Mhem_Polished_Cleaned_Scaff.prefix.unknown.fa SoftMask_03_known_out/Mhem_Polished_Cleaned_Scaff.known_mask.masked.fasta

# round 4: rename outputs
rename known_mask.masked.fasta unknown_mask SoftMask_04_unknown_out/Mhem_Polished_Cleaned_Scaff*
rename .masked .masked.fasta SoftMask_04_unknown_out/Mhem_Polished_Cleaned_Scaff*

# create directory for full results
mkdir -p SoftMask_05_full_out

# combine full RepeatMasker result files - .cat.gz
cat SoftMask_01_simple_out/Mhem_Polished_Cleaned_Scaff.simple_mask.cat \
SoftMask_02_bivalvia_out/Mhem_Polished_Cleaned_Scaff.bivalvia_mask.cat \
SoftMask_03_known_out/Mhem_Polished_Cleaned_Scaff.known_mask.cat \
SoftMask_04_unknown_out/Mhem_Polished_Cleaned_Scaff.unknown_mask.cat \
> SoftMask_05_full_out/Mhem_Polished_Cleaned_Scaff.full_mask.cat

# combine RepeatMasker tabular files for all repeats - .out
cat SoftMask_01_simple_out/Mhem_Polished_Cleaned_Scaff.simple_mask.out \
<(cat SoftMask_02_bivalvia_out/Mhem_Polished_Cleaned_Scaff.bivalvia_mask.out | tail -n +4) \
<(cat SoftMask_03_known_out/Mhem_Polished_Cleaned_Scaff.known_mask.out | tail -n +4) \
<(cat SoftMask_04_unknown_out/Mhem_Polished_Cleaned_Scaff.unknown_mask.out | tail -n +4) \
> SoftMask_05_full_out/Mhem_Polished_Cleaned_Scaff.full_mask.out

# copy RepeatMasker tabular files for simple repeats - .out
cat SoftMask_01_simple_out/Mhem_Polished_Cleaned_Scaff.simple_mask.out > SoftMask_05_full_out/Mhem_Polished_Cleaned_Scaff.simple_mask.out

# combine RepeatMasker tabular files for complex, interspersed repeats - .out
cat SoftMask_02_bivalvia_out/Mhem_Polished_Cleaned_Scaff.bivalvia_mask.out \
<(cat SoftMask_03_known_out/Mhem_Polished_Cleaned_Scaff.known_mask.out | tail -n +4) \
<(cat SoftMask_04_unknown_out/Mhem_Polished_Cleaned_Scaff.unknown_mask.out | tail -n +4) \
> SoftMask_05_full_out/Mhem_Polished_Cleaned_Scaff.complex_mask.out

# combine RepeatMasker repeat alignments for all repeats - .align
cat SoftMask_01_simple_out/Mhem_Polished_Cleaned_Scaff.simple_mask.align \
SoftMask_02_bivalvia_out/Mhem_Polished_Cleaned_Scaff.bivalvia_mask.align \
SoftMask_03_known_out/Mhem_Polished_Cleaned_Scaff.known_mask.align \
SoftMask_04_unknown_out/Mhem_Polished_Cleaned_Scaff.unknown_mask.align \
> SoftMask_05_full_out/Mhem_Polished_Cleaned_Scaff.full_mask.align

# resummarize repeat compositions from combined analysis of all RepeatMasker rounds
ProcessRepeats -a -species bivalvia 05_full_out/rMhem_Polished_Cleaned_Scaff.full_mask.cat.gz
rename full_mask.masked .softmasked.fasta S05_full_out/Mhem_Polished_Cleaned_Scaff.full_mask*
