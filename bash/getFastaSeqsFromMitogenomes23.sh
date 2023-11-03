#! /bin/bash

# Set the path to your sample names file
sample_names_file="/home/joana-santos/Desktop/getfasta23.txt"

# Set the input directory where the folders with sample files are located
input_directory="/mnt/medibees-readwrite/mitogenomas23"

# Set the output directory where you want the joined files to be saved
output_directory="/home/joana-santos/Desktop/tempSeqsFolder"

cd "$output_directory"

while IFS= read -r sample_name; do
	cp "$input_directory"/"$sample_name"/"$sample_name".result/"$sample_name".fasta  "$sample_name"_23
done < "$sample_names_file"

cd ..
tar --use-compress-program="pigz -k -p32" -cf theSeqsFolder23.tar.gz tempSeqsFolder
rm tempSeqsFolder/*







