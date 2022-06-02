#!/bin/bash

##### Script Description #####
description="This script downloads UKBiobank bulk dataset given a field and start-end number"

field=$1
start=$2
number_of_files=$3

end=$(($start+$number_of_files-1))

fetch_helper="./ukbhelpers/ukbfetch"
key_file="./ukbhelpers/k45023r48799.key"

bulk_file_prefix="../data/bulk/ukb48799"
bulk_filename="${bulk_file_prefix}_${field}.bulk"

bulk_field_storage_dir="../data/vcf/"
bulk_log_file="../data/logs/2_download_bulk_${field}_${start}_${number_of_files}"

# download bulk
chmod 755 $fetch_helper
$fetch_helper -b$bulk_filename -s$start -m$number_of_files -o$bulk_log_file -a$key_file

# move bulk to appropriate dir
sed -n ${start},${end}p $bulk_filename | 
while read -r sample field 
do
    last3_sample=${sample: -3}
    move_dir="${bulk_field_storage_dir}/${last3_sample}/"
    mkdir -p $move_dir
    mv ./${sample}_${field}* $move_dir
done
