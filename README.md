# align_bismark_coverage
Align the COVERAGE files of multiple samples generated by BISMARK.

**NOTE:** BISMARK is a program for aligning bisulfite sequencing data to the reference genome to obtain the DNA methylation profiles for samples.

## How to use
* Add two extra columns to each COVERAGE file by running the "addSC.r". The output files must have the extension name of ".cov".
* Run "align.sh" on these ".cov" files to align them.

**NOTE:** the script files contain details for running them.

## Citation
Liu S, Tengstedt ANB, Jacobsen MW, Pujolar JM, Jónsson B, Lobón-Cervià J, Bernatchez L, Hansen MM. Genome-wide methylation in the panmictic European eel (Anguilla anguilla). Molecular Ecology, 31:4286-4306, 2022.
