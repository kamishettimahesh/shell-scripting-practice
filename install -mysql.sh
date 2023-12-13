#!/bin/bash
ID=$(id -u)

if [ $ID -ne 0 ]
then 
   echo "error :please run with root user"
   exit 1
fi

yum install mysql -y

if [ $? -ne 0 ]
 
 then 
 echo "error : package installing error"
exit 1
else 

echo " package installed succesfully"

fi