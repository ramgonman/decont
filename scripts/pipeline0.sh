#!/bin/bash
#Download all the files specified in data/filenames
echo "Downloading small-RNA samples ..."
echo
wget -i data/urls -P data

for var0 in data/*.fastq.gz
do
   md5sum $var0 >> md5checks.txt
done
for var1 in $(cat data/md5urls)
do
   curl -s $var1 | cut -d" " -f1 >> md5curl.txt
done
cat md5checks.txt | cut -d" " -f1 > md5chekcut.txt
diff md5curl.txt md5chekcut.txt
exitstatusdiff=$(echo $?)
if [ $exitstatusdiff -ne 0 ] 
then
   echo "Warning: MD5 checks of fastq files failed ..."
fi 

#for url in $(cat data/urls) #TODO
#do
#    bash scripts/download.sh $url data
#done

# Download the contaminants fasta file, uncompress it, and
# filter to remove all small nuclear RNAs
echo "Downloading the contaminants fasta file ..."
echo
bash scripts/download.sh "https://bioinformatics.cnio.es/data/courses/decont/contaminants.fasta.gz" res yes "small nuclear" #TODO
echo
md5sum res/contaminants.fasta.gz | cut -d" " -f1 > md5db.txt
curl -s "https://bioinformatics.cnio.es/data/courses/decont/contaminants.fasta.gz.md5" | cut -d" " -f1 > md5curldb.txt
diff md5db.txt md5curldb.txt
exitdiff=$(echo $?)
if [ $exitdiff -ne 0 ]
then
   echo "Warning: MD5 checks of contaminants.fasta.gz failed ..."
fi

# Index the contaminants file
bash scripts/index.sh res/contaminants_filtered.fasta res/contaminants_idx

# Merge the samples into a single file
for sid in $(ls data/*.fastq.gz) #TODO
do
    bash scripts/merge_fastqs.sh data out/merged $sid
done

# TODO: run cutadapt for all merged files
# cutadapt -m 18 -a TGGAATTCTCGGGTGCCAAGG --discard-untrimmed \
#     -o <trimmed_file> <input_file> > <log_file>

echo "Running cutadapt ..."
mkdir -p log/cutadapt
mkdir -p out/trimmed

for sampleid in $(ls out/merged)
do
cutadapt -m 18 -a TGGAATTCTCGGGTGCCAAGG --discard-untrimmed \
     -o out/trimmed/$(basename $sampleid .merged.fastq.gz).trimmed.fastq.gz out/merged/$sampleid > log/cutadapt/$(basename $sampleid .merged.fastq.gz).log
echo "$(date) Summary cutadapt $(basename $sampleid .merged.fastq.gz).log" >> $WD/pipeline.log 
cat log/cutadapt/$(basename $sampleid .merged.fastq.gz).log | grep -e "with adapter" -e "Total basepairs" >> $WD/pipeline.log
done
echo
# TODO: run STAR for all trimmed files
echo "Running STAR alignment ..."
for fname in out/trimmed/*.fastq.gz
do
    # you will need to obtain the sample ID from the filename
    sampid=$(basename $fname .trimmed.fastq.gz)       #TODO
mkdir -p out/star/$sampid
STAR --runThreadN 4 --genomeDir res/contaminants_idx \
    --outReadsUnmapped Fastx --readFilesIn $fname \
    --readFilesCommand gunzip -c --outFileNamePrefix out/star/$sampid/
echo "$(date) Summary star $sampid" >> $WD/pipeline.log
cat out/star/$sampid/Log.final.out | grep -e "Uniquely mapped" -e "mapped to multiple loci" -e "mapped to too many loci" >> $WD/pipeline.log
done 

# TODO: create a log file containing information from cutadapt and star logs
# (this should be a single log file, and information should be *appended* to it on each run)
# - cutadapt: Reads with adapters and total basepairs
# - star: Percentages of uniquely mapped reads, reads mapped to multiple loci, and to too many loci
# tip: use grep to filter the lines you're interested in
