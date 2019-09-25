# BLAST 97103 v1 NBS vs 97103v2
 The goal of this project is to identify the locations of NBS genes in the 97103_v2 genome in order to compare their positions with identified QTL peaks

1. A batch query was made against the 97103_v1 genome on the cucurbit database using a list of Cla genes from Hassan et al. 2019 to obtain the sequences of each of the genes.

 2. A Blast db was made of the 97103_v2 genome using makeblastdb.sh

 3. The Fasta file containing each of the gene seqeunces was input into blastv1v2.sh to obtain their positions in the v2 genome using command line blastn.
