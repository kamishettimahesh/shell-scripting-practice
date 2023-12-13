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


yum install git -y

if [ $? -ne 0 ]

then 
echo "error :: git instalation is failed"
exit 1
else 

echo " git install is sucdesfully we will cheer up"

fi