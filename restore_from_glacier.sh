#!/bin/bash

filename=$1
bucket=$2 

while read -r line; 
do
    echo "bucket $bucket : $line"
    aws s3api restore-object --bucket $bucket --key $line --restore-request '{"Days":90,"GlacierJobParameters":{"Tier":"Standard"}}'
done < "$filename"
