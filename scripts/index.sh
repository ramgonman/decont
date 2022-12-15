if [[ $# -eq 2 ]]; then
genomefile=$1
indexdir=$2
echo "Running STAR index ... "
mkdir -p $2
STAR --runThreadN 4 --runMode genomeGenerate --genomeDir $2 \
--genomeFastaFiles $1 --genomeSAindexNbases 9
else echo "Usage: $(basename $0) genomefile indexdir"	#statements
fi