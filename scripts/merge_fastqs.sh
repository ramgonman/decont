# This script should merge all files from a given sample (the sample id is
# provided in the third argument ($3)) into a single file, which should be
# stored in the output directory specified by the second argument ($2).
#
# The directory containing the samples is indicated by the first argument ($1).

if [ "$#" -eq 3 ]
then
    samplesdir=$1
    outputdir=$2
    sampleid=$3
echo
mkdir -p out/merged

cp $3 $2

if [ $(ls $2 | wc -l) -eq 4 ]
then 
echo "Merging sample data files ..."
cd $2
myarr=($(ls | sort))
cat ${myarr[0]} ${myarr[1]} > $(basename ${myarr[0]} -12.5dpp.1.1s_sRNA.fastq.gz).merged.fastq.gz
cat ${myarr[2]} ${myarr[3]} > $(basename ${myarr[2]} -12.5dpp.1.1s_sRNA.fastq.gz).merged.fastq.gz
rm *sRNA.fastq.gz
cd $WD
fi

else echo "Usage: $(basename $0) samplesdir outputdir sampleid" 
fi
