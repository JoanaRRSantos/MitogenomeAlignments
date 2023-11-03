#! /bin/bash

# Set the path to your sample names file
sample_names_file="/home/joana-santos/Desktop/tenSamplesNames.txt"

# Set the input directory where the folders with sample files are located
input_directory="/mnt/medibees-readwrite/batch_2/RAW_DATA"

# Set the output directory where you want the mitoz files to be saved
output_directory="/home/joana-santos/Desktop/tempOutputFolder"

while IFS= read -r sample_name; do
    # Sample name is the name of the folder ex: A_3939
    # fq1 is the file name inside de folder that has the fastq1 needed for mitoz ex: A_3939_FKDN230024078-1A_HTT77DSX3_L1_1.fq.gz
    # fq2 is the file name inside de folder that has the fastq2 needed for mitoz ex: A_3939_FKDN230024078-1A_HTT77DSX3_L1_2.fq.gz
    fq1=$(ls "${input_directory}" | grep "${sample_name}_.*_1.fq.gz$")
    fq2=$(ls "${input_directory}" | grep "${sample_name}_.*_2.fq.gz$")
    echo "${fq1}"
    echo "${fq2}"
    # Only make directory of new sample if directory is not there
    if [ ! -d "$output_directory/$sample_name" ]; then
        mkdir -p "$output_directory/$sample_name"
        count=0
	echo "Processing ${sample_name}"
    fi
    cp "$input_directory/${fq1}" "$output_directory/$sample_name/${fq1}"
    count=$(( count + 1))
    cp "$input_directory/${fq2}" "$output_directory/$sample_name/${fq2}"
    count=$(( count + 1))
    # To make sure the data is only processed after all the files are in the folder (all the samples that need to be processed have 2 files in them) 
    if [ $count -eq 2 ];then
        cd "$output_directory/$sample_name"
	echo "Starting mitoz"
		docker run -v $PWD:$PWD -w $PWD --rm guanliangmeng/mitoz:3.6 mitoz all \
	--fq1 $fq1 \
	--fq2 $fq2 \
	--outprefix $sample_name \
	--clade Arthropoda \
	--data_size_for_mt_assembly 0 \
	--assembler megahit \
	--genetic_code 5 \
	--requiring_taxa Apis  \
	1>$sample_name.log 2>$sample_name.err
        #docker run -v $PWD:$PWD -w $PWD  --rm guanliangmeng/mitoz:2.3 python3 /app/release_MitoZ_v2.3/MitoZ.py all --genetic_code 5 --clade Arthropoda --insert_size 250 --thread_number 16 --fastq1 $fq1 --fastq2 $fq2 --outprefix $sample_id --fastq_read_length 125 1>$sample_id.log 2>$sample_id.err
	#docker run -v $PWD:$PWD -w $PWD  --rm guanliangmeng/mitoz:2.3 \
	#python3 /app/release_MitoZ_v2.3/MitoZ.py all \
	#--genetic_code 5 \
	#--clade Arthropoda \
	#--insert_size 150 \
	#--fastq1 $fq1 \
	#--fastq2 $fq2 \
	#--outprefix $sample_name \
	#--fastq_read_length 150 \
	#1>$sample_name.log 2>$sample_name.err
	echo "mitoz completed"
	rm "${fq1}"
        rm "${fq2}"
    fi
  
done < "$sample_names_file"






















