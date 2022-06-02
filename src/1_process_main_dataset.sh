#!/bin/bash

##### Script Description #####
description="This script validates, decrypts and converts the main dataset of a UKBiobank project"


md5_helper="./ukbhelpers/ukbmd5"
unpack_helper="./ukbhelpers/ukbunpack"
conv_helper="./ukbhelpers/ukbconv"

encoded_main_dataset="./ukbhelpers/ukb48799.enc"
key_file="./ukbhelpers/k45023r48799.key"

unpacked_main_dataset="./ukbhelpers/ukb48799.enc_ukb"
conv_main_dataset="/data5/deepro/ukbiobank/download_vcfs/data/ukb48799"
conv_bulk_dataset="/data5/deepro/ukbiobank/download_vcfs/data/bulk/ukb48799"

# Validate main encoded dataset
chmod 755 $md5_helper
$md5_helper $encoded_main_dataset

# Unpack the main encoded dataset
chmod 755 $unpack_helper
$unpack_helper $encoded_main_dataset $key_file

# Convert dataset to csv format
chmod 755 $conv_helper
$conv_helper $unpacked_main_dataset csv -o$conv_main_dataset

# Convert dataset to bulk format for each field to download bulk fields later on
ukb_generated_field_file="./fields.ukb"
while IFS="" read -r line || [ -n "$line" ]
do
    field_name=$line
    bulk_filename="${conv_bulk_dataset}_${field_name}"
    $conv_helper $unpacked_main_dataset bulk -s$field_name -o$bulk_filename
done < $ukb_generated_field_file
