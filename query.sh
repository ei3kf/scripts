#!/bin/bash

## filename is name of file containing list of s3 objects ie "a/b/c/d/file.tgz"
## bucket is s3 bucketname ie "ei3kf"

filename=$1
bucket=$2

while read -r line;
  do
    echo "bucket: $bucket key: $line"
    aws s3api head-object --bucket $bucket --key $line | egrep "Restore|StorageClass"
  done < $filename
  
