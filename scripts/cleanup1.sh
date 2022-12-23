#!/bin/bash
if [ "$#" -eq 1 ]; then
case "$1" in
	data) cd $1; rm *.* ; cd .. ;;
	res) cd $1; rm *.* ; rm -r contaminants_idx ; cd .. ;;
	out) cd $1; rm -r merged star trimmed ; cd .. ;;
	log) cd $1; rm -r cutadapt ; cd .. ;;
	  *) echo "The directory $1 either does not exist or cannot be removed ... "
esac
fi

if [ "$#" -eq 2 ]; then
case "$1" in
	data) cd $1; rm *.* ; cd .. ;;
	res) cd $1; rm *.* ; rm -r contaminants_idx ; cd .. ;;
	out) cd $1; rm -r merged star trimmed ; cd .. ;;
	log) cd $1; rm -r cutadapt ; cd .. ;;
	  *) echo "The directory $1 either does not exist or cannot be removed ... "
esac
case "$2" in
	data) cd $2; rm *.* ; cd .. ;;
	res) cd $2; rm *.* ; rm -r contaminants_idx ; cd .. ;;
	out) cd $2; rm -r merged star trimmed ; cd .. ;;
	log) cd $2; rm -r cutadapt ; cd .. ;;
	  *) echo "The directory $2 either does not exist or cannot be removed ... "
esac
fi

if [ "$#" -eq 3 ]; then
case "$1" in
	data) cd $1; rm *.* ; cd .. ;;
	res) cd $1; rm *.* ; rm -r contaminants_idx ; cd .. ;;
	out) cd $1; rm -r merged star trimmed ; cd .. ;;
	log) cd $1; rm -r cutadapt ; cd .. ;;
	  *) echo "The directory $1 either does not exist or cannot be removed ... "
esac
case "$2" in
	data) cd $2; rm *.* ; cd .. ;;
	res) cd $2; rm *.* ; rm -r contaminants_idx ; cd .. ;;
	out) cd $2; rm -r merged star trimmed ; cd .. ;;
	log) cd $2; rm -r cutadapt ; cd .. ;;
	  *) echo "The directory $2 either does not exist or cannot be removed ... "
esac
case "$3" in
	data) cd $3; rm *.* ; cd .. ;;
	res) cd $3; rm *.* ; rm -r contaminants_idx ; cd .. ;;
	out) cd $3; rm -r merged star trimmed ; cd .. ;;
	log) cd $3; rm -r cutadapt ; cd .. ;;
	  *) echo "The directory $3 either does not exist or cannot be removed ... "
esac
fi

if [ "$#" -eq 4 ]; then

case "$1" in
	data) cd $1; rm *.* ; cd .. ;;
	res) cd $1; rm *.* ; rm -r contaminants_idx ; cd .. ;;
	out) cd $1; rm -r merged star trimmed ; cd .. ;;
	log) cd $1; rm -r cutadapt ; cd .. ;;
	  *) echo "The directory $1 either does not exist or cannot be removed ... "
esac
case "$2" in
	data) cd $2; rm *.* ; cd .. ;;
	res) cd $2; rm *.* ; rm -r contaminants_idx ; cd .. ;;
	out) cd $2; rm -r merged star trimmed ; cd .. ;;
	log) cd $2; rm -r cutadapt ; cd .. ;;
	  *) echo "The directory $2 either does not exist or cannot be removed ... "
esac
case "$3" in
	data) cd $3; rm *.* ; cd .. ;;
	res) cd $3; rm *.* ; rm -r contaminants_idx ; cd .. ;;
	out) cd $3; rm -r merged star trimmed ; cd .. ;;
	log) cd $3; rm -r cutadapt ; cd .. ;;
	  *) echo "The directory $3 either does not exist or cannot be removed ... "
esac
case "$4" in
	data) cd $4; rm *.* ; cd .. ;;
	res) cd $4; rm *.* ; rm -r contaminants_idx ; cd .. ;;
	out) cd $4; rm -r merged star trimmed ; cd .. ;;
	log) cd $4; rm -r cutadapt ; cd .. ;;
	  *) echo "The directory $4 either does not exist or cannot be removed ... "
esac
fi

if [ "$#" -eq 0 ]; then
	rm *.*
	rm data/*.*
	rm res/*.*
	rm -r res/contaminants_idx
	rm -r out/merged out/star out/trimmed
	rm -r log/cutadapt
fi
