#!/bin/bash
ID=$(id -u)
TIMESTAMP=$(date +%F.%H:%M:%S)
R="\e[31m"
G="\e[32m"
Y="\e[33"
N="\e[0m"
LOGFILE="/tmp/$0-$TIMESTAMP.log"
echo "script name: $0"
VALIDATE( ) {
if [ $1 -ne 0 ]
then 
echo -e"ERROR :: $2 ....$R FAILED $N"
exit 1
else 
echo -e"$2 ...$G SUCESS $N"
fi
}
if [ $ID -ne 0 ]
then 
   echo -e"$R error :please run with root user $N"
   exit 1
fi
yum install mysql -y  &>>  $LOGFILE
VALIDATE  $? "INSTALLING MYSQL"

yum install git -y &>>  $LOGFILE
VALIDATE $? "INSTALLING GIT"