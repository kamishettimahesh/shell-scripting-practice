#!/bin/bash
ID=$(id -u)
TIMESTAMP=$(date +%F.%H:%M:%S)
echo "script name: $0"
VALIDATE( ){
if [ $1 -ne 0 ]
then 
echo "ERROR :: $2 ....FAILED"
exit 1
else 
echo"$2 ...SUCESS"
fi
}
if [ $ID -ne 0 ]
then 
   echo "error :please run with root user"
   exit 1
fi

yum install mysql -y
yum install git -y
