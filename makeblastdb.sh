#PBS -S /bin/bash
#PBS -N mkdbv2
#PBS -l nodes=1:ppn=4:AMD
#PBS -q batch
#PBS -l walltime=480:00:00
#PBS -l mem=20gb
## the above requests the proper cluster resources (needs sys resource optimization)

## this loads the BLAST+ module
module load BLAST+/2.7.1-foss-2016b-Python-2.7.14

## this runs the makeblastdb program to generate blast db
makeblastdb -in /work/cemlab/reference_genomes/97103_v2.fa -dbtype nucl -out /work/cemlab/reference_genomes/97103_v2
