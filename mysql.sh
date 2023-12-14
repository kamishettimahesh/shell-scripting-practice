#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

ID=(id -u)
TIMESTAMP=$(date +%F.%H:%M:%S)

LOGFILE="/tmp/$0-$TIMESTAMP.log"

VALIDATE () {

# shellcheck disable=SC2086
if [ $1 -ne 0 ]

then
   echo -e "$2 .... $R failed $N"
   exit 13
else
  echo -e "$2 .... $G success $N"
fi
}

if [ "$ID" -ne 0 ]

then 
    echo -e "$R Error:: please run with root user $N"
    exit 13
else 
   echo "you are root user"
fi

yum install mysql -y &>> $LOGFILE

VALIDATE $? "installing Mysql"

yum install git -y &>> $LOGFILE

VALIDATE $? "installing git"
 