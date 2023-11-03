#! /bin/bash

# Set the path to your sample names file
sample_names_file="/home/joana-santos/Desktop/samplesThatNeedCat_batch2.txt"

# Set the input directory where the folders with sample files are located
input_directory="/mnt/medibees-readwrite/batch2/RAWDATA"

# Set the output directory where you want the joined files to be saved
output_directory="/home/joana-santos/Desktop/tempOutputFolder"

while IFS= read -r sample_name; do
    # Sample name is the name of the file ex: A_3920_FKDN230024061-1A_H227LDSX5_L2_1.fq.gz
    # Sample ID is the first part of the sample name, which is the name of the folder where the original files are stored ex: A_3920
    sample_id=$(echo "$sample_name" | awk -F '_' '{print $1"_"$2}')
    # Only make directory of new sample if directory is not there
    if [ ! -d "$output_directory/$sample_id" ]; then
        mkdir -p "$output_directory/$sample_id"
        count=0
        echo "Processing ${sample_id}"
    fi
    cp "$input_directory/$sample_id/${sample_name}" "$output_directory/$sample_id/${sample_name}"
    count=$(( count + 1))
    # To make sure the data is only processed after all the files are in the folder (all the samples that need to be processed have 4 files in them)
    if [ $count -eq 4 ];then
        tempName=$(echo "$sample_name" | awk -F '.' '{print $1}')
        cd "$output_directory/$sample_id"
        unpigz -p32 *fq.gz
        cat *1.fq > "${tempName}_joined_1.fq"
        cat *2.fq > "${tempName}_joined_2.fq"
        pigz -k -p32 "${tempName}_joined_1.fq"
        pigz -k -p32 "${tempName}_joined_2.fq"
        rm "${sample_id}"*_L*_1.fq
        rm "${sample_id}"*_L*_2.fq
    fi

done < "$sample_names_file"





















