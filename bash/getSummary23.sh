#! /bin/bash

# Set the path to your sample names file
sample_names_file="/home/joana-santos/Desktop/getsummary23.txt"

# Set the input directory where the folders with sample files are located
input_directory="/mnt/medibees-readwrite/mitogenomas23"

# Set the output directory where you want the joined files to be saved
output_directory="/home/joana-santos/Desktop/tempSummaryFolder"

cd "$output_directory"

while IFS= read -r sample_name; do
	cp "$input_directory/$sample_name/$sample_name.result/summary.txt" "$sample_name"_summary23
done < "$sample_names_file"

cd ..
tar --use-compress-program="pigz -k -p32" -cf theSummaryFolder.tar.gz tempSummaryFolder
rm tempSummaryFolder/*







