# Downloading data from UKBiobank

PDF containing data download guide published by UKBiobank: https://biobank.ndph.ox.ac.uk/~bbdatan/Accessing_UKB_data_v2.3.pdf

## Downloading a main dataset

The **main dataset** contains sample ids and the field ids. Sample ids are unique ids assigned to each individual. Field ids are information such as exome sequencing vcf files available for each sample.

To download the main dataset:

1. Follow the link: *UKBiobank -> Researcher log in -> AMS -> Projects -> {application_id} -> View/Update -> Data -> Download -> File Handlers*

2. Download three helper programs: **a) ukbmd5; b) ukbconv; c) ukbunpack;**

3. Follow the link: *UKBiobank -> Researcher log in -> AMS -> Projects -> {application_id} -> View/Update -> Data -> Download -> Miscellaneous Utility*

4. Download the utility program: **a) encoding.ukb** and store in the same dir as the hlper programs

5. Get the MD5 checksum from UKBiobank's notification email

6. Follow the link: *UKBiobank -> Researcher log in -> AMS -> Projects -> {application_id} -> View/Update -> Data -> Download -> Dataset -> {ID} -> {MD5} -> Generate -> Fetch*

7. Store the encoded main dataset obtained from the previous step in the same dir as the helper programs

8. Download and store the .key file obtained as an attachment of the UKBiobank notification email in the three helper program dir

9. Run the script *root/src/process_main_dataset.sh* to validate, unpack and convert the encoded main dataset
    ```bash
    foo@bar: cd src
    foo@bar: bash 1_process_main_dataset.sh > ../data/logs/1_process_main_dataset.log
    ```

## Downloading bulk dataset

A bulk dataset refers to the files identified by each field for each of the samples present in the main dataset. For example, each row of a converted csv file by UKB will contain: "eid","Field_1","Field_2",...,"Field_N". Here, *eid* denotes unique sample id and *Field_X* denotes UKB assigned numerical encoding of information such as VCF file or brain imaging files available for that individual. These field information for each sample is usually present as bulk file.

To download the bulk dataset of a field:

1. Follow the link: *UKBiobank -> Researcher log in -> AMS -> Projects -> {application_id} -> View/Update -> Data -> Download -> File Handlers*

2. Download the helper program: **a) ukbfetch;**

3. Run the script *root/src/process_main_dataset.sh* to download bulk dataset. It takes as arguments the bulk field id, the start line of the bulk file containing the sample id from where download should start, the number of lines starting from the start line to download files.
    ```bash
    foo@bar: cd src
    foo@bar: bash 2_download_bulk_dataset.sh {field_id} {start_num} {number_of_files_to_download}
    ```
