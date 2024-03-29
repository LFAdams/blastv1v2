#PBS -S /bin/bash
#PBS -N blastv1v2
#PBS -l nodes=1:ppn=4:AMD
#PBS -q batch
#PBS -l walltime=480:00:00
#PBS -l mem=20gb

cd /work/cemlab/reference_genomes/

module load BLAST+/2.7.1-foss-2016b-Python-2.7.14
blastn -num_threads 4 -db /work/cemlab/reference_genomes/97103_v2.fa -query /home/lfa81121/blastv1v2/nbsgenes.txt -perc_identity 100 -ungapped -max_target_seqs 1 -outfmt "6 qseqid sseqid pident qlen length mismatch gapopen qstart qend sstart send evalue bitscore" -out /home/lfa81121/blastv1v2/nbs1v2
