#PBS -S /bin/bash
#PBS -q batch
#PBS -N csv
#PBS -l nodes=1:ppn=1:AMD
#PBS -l walltime=480:00:00
#PBS -l mem=80gb

cd $PBS_O_WORKDIR

module load SAMtools/1.6-foss-2016b
module load FASTX-Toolkit/0.0.14-foss-2016b

GENOME=/work/cemlab/reference_genomes/97103_v2.fa
INPUT=/home/lfa81121/blastv1v2/testsnps.csv

OLDIFS=$IFS
IFS=,

[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }

echo CHROM,POS,REF,ALT,AD_REFLOW,AD_ALTLOW,DPLOW,GQLOW,PLLOW,SNPINDEXLOW,AD_REFHIGH,AD_ALTHIGH,DPHIGH,GQHIGH,PLHIGH,SNPINDEXHIGH,REF_FRQ,DELTASNP,NSNPS,TRICUBEDELTASNP,G,GPRIME,PVALUE,NEGLOG10PVAL,QVALUE,MINDP,TRICUBEDP,CL95,CL99,SNPLESS250,SNPPLUS250,COORDS,SNP1,SNP501,SNP27,SNP24,RSNP27,RSNP24 > /home/lfa81121/blastv1v2/potentialprimers.csv

while read $INPUT CHROM POS REF ALT AD_REFLOW AD_ALTLOW DPLOW GQLOW PLLOW SNPINDEXLOW AD_REFHIGH AD_ALTHIGH DPHIGH GQHIGH PLHIGH SNPINDEXHIGH REF_FRQ DELTASNP NSNPS TRICUBEDELTASNP G GPRIME PVALUE NEGLOG10PVAL QVALUE MINDP TRICUBEDP CL95 CL99 SNPLESS250 SNPPLUS250 COORDS
  do
    SNP1="$(samtools faidx $GENOME $CHROM:$POS-$POS | awk '{if(NR>1)print}')"
    SNP501="$(samtools faidx $GENOME $CHROM:$SNPLESS250-$SNPPLUS250 | awk '{if(NR>1)print}')"
    POSLESS23=$((POS-23))
    POSLESS26=$((POS-26))
    POSPLUS23=$((POS+23))
    POSPLUS26=$((POS+26))
    SNP27="$(samtools faidx $GENOME $CHROM:$POSLESS26-$POS | awk '{if(NR>1)print}')"
    SNP24="$(samtools faidx $GENOME $CHROM:$POSLESS23-$POS | awk '{if(NR>1)print}')"
    RSNP27="$(samtools faidx $GENOME $CHROM:$POS-$POSPLUS26 | awk '{if(NR>1)print}' | tr 'gtca' 'cagt' | rev)"
    RSNP24="$(samtools faidx $GENOME $CHROM:$POS-$POSPLUS23 | awk '{if(NR>1)print}' | tr 'gtca' 'cagt' | rev)"
    LINE=$CHROM","$POS","$REF","$ALT","$AD_REFLOW","$AD_ALTLOW", "$DPLOW", "$GQLOW", "$PLLOW", "$SNPINDEXLOW", "$AD_REFHIGH", "$AD_ALTHIGH", "$DPHIGH", "$GQHIGH", "$PLHIGH", "$SNPINDEXHIGH", "$REF_FRQ", "$DELTASNP", "$NSNPS", "$TRICUBEDELTASNP", "$G", "$GPRIME", "$PVALUE", "$NEGLOG10PVAL", "$QVALUE", "$MINDP", "$TRICUBEDP", "$CL95", "$CL99", "$SNPLESS250", "$SNPPLUS250", "$COORDS", "$SNP1", "$SNP501", "$SNP27"," $SNP24", "$RSNP27","$RSNP24
    echo $LINE >> /home/lfa81121/blastv1v2/potentialprimers.csv
  done
IFS=$OLDIFS
