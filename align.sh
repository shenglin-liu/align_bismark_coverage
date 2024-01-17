#!/bin/bash

# Script for merging and aligning the extended COVERAGE files.
# Usage: align.sh scaffold_name COVERAGE_file_dir out_dir
# scaffold_name: name of the scaffold to align;
#	this script aligns one scaffold per run;
#	it is to ease the parallel computation of multiple scaffolds on a cluster.
# COVERAGE_file_dir: dir for the extended COVERAGE files for all individuals;
#	the files contain strand and context info, hence 8-column tab-delimited;
#	file names should end with ".cov".
# out_dir: dir for the output files;
#	one file per scaffold;
#	n+5 tab-delimited columns where n is the number of individuals.

# Format: first 5 columns are information columns for the CpG sites;
#	the following columns specify the methylation of each individual;
#	each entry in the individual columns consists of two integers seperated by a colon;
#	the two integers are the coverages of methylated and unmethylated CpGs.

nfile=`ls ${2}/*.cov | wc -l`
i=1
for file in ${2}/*.cov
do
awk 'BEGIN{FS="\t";OFS="\t"}$1=="'$1'"{print $0,'$i'}' $file
i=$[$i+1]
done | sort -S 128G -snk 2,2 | awk '
 BEGIN{n='$nfile';getline;
  i=1;ID=$1"_"$2;printf($1"\t"$2"\t"$3"\t"$7"\t"$8);
  while(i<$9){printf("\t0:0");i++}
  printf("\t"$5":"$6);i++}
 $1"_"$2!=ID{while(i<=n){printf("\t0:0");i++}printf("\n");
  i=1;ID=$1"_"$2;printf($1"\t"$2"\t"$3"\t"$7"\t"$8);
  while(i<$9){printf("\t0:0");i++}
  printf("\t"$5":"$6);i++;next}
 {while(i<$9){printf("\t0:0");i++}
  printf("\t"$5":"$6);i++}
 END{while(i<=n){printf("\t0:0");i++}printf("\n")}' > ${3}/${1}.txt
