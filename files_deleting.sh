#!/bin/bash

LOG_DIR="/tmp/shell.logs"

if [ !-d $LOG_DIR ]
then
   echo -e "$R source directory:$LOG_DIR does not exists $N"
 exit 1
 fi

 FILES_TO_DELETE:$(find $LOG_DIR -type f -mtime +4 -name "*.log" )

while IFS=read -r line

do 
 echo"deleting file:$line"
 rm -rf $line

done <<<$FILES_TO_DELETE
