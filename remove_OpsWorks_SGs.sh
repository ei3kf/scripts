#!/bin/bash

# this script will remove all AWS-OpsWorks-* security groups for Classic EC2 and VPC across all public AWS regions.
# Assumed that you have no running instances associated with the SG to be deleted.

echo "Checking for AWS-OpsWorks-* security groups across all AWS regions in EC2 and VPC, and deleting them."

for REGION in $(ec2-describe-regions | awk '{print $2}')
 do
  for SG in AWS-OpsWorks-Blank-Server AWS-OpsWorks-Monitoring-Master-Server AWS-OpsWorks-DB-Master-Server AWS-OpsWorks-Memcached-Server AWS-OpsWorks-Custom-Server AWS-OpsWorks-nodejs-App-Server AWS-OpsWorks-PHP-App-Server AWS-OpsWorks-Rails-App-Server AWS-OpsWorks-Web-Server AWS-OpsWorks-Default-Server AWS-OpsWorks-LB-Server
   do
    for SG_ID in $(ec2-describe-group --region $REGION | grep "GROUP" | grep "$SG" | awk '{print $2}')
     do
      echo "Region = ${REGION} SG = ${SG} SG_ID = $SG_ID"
      echo "ec2-delete-group --region $REGION $SG_ID" ; ## remove the echo to run for real :)
     done   
   done
 done
