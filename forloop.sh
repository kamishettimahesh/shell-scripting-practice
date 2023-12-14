#!/bin/bash
ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%F.%H:%M:%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

echo "script started executing at $TIMESTAMP" &>> $LOGFILE

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
       echo -e "$2 ....$R failed $N"

       exit 1
    else
       echo -e "$2 ....$G success $N"
    fi
}
    if [ $ID -ne 0 ]
    then 
       echo -e "$R ERROR :: Please use root user $N"

       exit 1
    else 
       echo -e " $Y YOU ARE ROOT USER $N "

    fi

    for package in $@
    
    do
    yum list installed  $package &>> $LOGFILE

    if [ $? -ne 0 ]

    then 
       yum install $package -y &>> $LOGFILE
       VALIDATE $? "Installation of $package"
    else
       echo -e " $package already installed ....$Y Skipped $N "
    fi   

    done