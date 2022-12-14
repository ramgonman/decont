#!/bin/bash
if [ "$#" -ge 2 ]
then
    url=$1
    directory=$2
mkdir -p $WD/$2
cd $2
wget "$1"

    case "$3" in
        yes | Yes) gunzip -k $(basename "$1") ;;
         no | No) echo "The sample file $(basename "$1") will not be uncompressed ...";;
               *) echo "The sample file $(basename "$1") will not be uncompressed ...";;
    esac

if [ -n "$4" ]
then
    grep "$4" contaminants.fasta | cut -d" " -f1 | cut -c2-20 > tobefiltered.list
    seqkit grep -f tobefiltered.list -v contaminants.fasta -o contaminants_filtered.fasta
fi

if [ -n "$5" ]
then
    grep "$5" contaminants_filtered.fasta | cut -d" " -f1 | cut -c2-20 > tobefiltered2.list
    seqkit grep -f tobefiltered2.list -v contaminants_filtered.fasta -o contaminants_filtered2.fasta
fi

else echo "Usage: download.sh url directory yes|no "seq1" "seq2" ..."

fi

## This script can be used to download small RNA sequencing samples and 
## contaminants files, uncompress them (default is no uncompressing), and it 
## also allows to filter unwanted sequences using specific words in the 
## headers of the unwanted sequences. 
## Up to 2 sequencial filterings (although filtering using the parameters 
## "seq1", "seq2" is optional).
