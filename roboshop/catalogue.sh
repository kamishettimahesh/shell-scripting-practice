#!/bin/bash

ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%F.%H:%M:%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

VALIDATE(){

    if [ $1 -ne 0 ]
    then 
       echo -e " $2 ....$R Failed $N "
       exit 1
    else
       echo -e " $2 ....$G Success $N "
    fi
}

    if [ $ID -ne 0 ]
    then
       echo -e " $R Error: : you are not a root user $N "
        exit 1
    else 
       echo -e " $G you are root user $N "  

     fi

     dnf module disable nodejs -y  &>> $LOGFILE

     VALIDATE $? " Disable nodejs current package "

     dnf module enable nodejs:18 -y &>> $LOGFILE
     VALIDATE $? " enable nodejs:18 package "

     dnf install nodejs -y &>> $LOGFILE

     VALIDATE  $? " install nodejs "
     
       id roboshop
    if [ $? -ne 0 ]
    then
          useradd roboshop
           VALIDATE $? "roboshop user creation"
    else
        echo -e "roboshop user already exist $Y SKIPPING $N"
    fi

     mkdir -p /app
     VALIDATE $? " Create app directory "

     curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip  &>> $LOGFILE
     VALIDATE $?  " downloading catalogue application "

     cd /app &>> $LOGFILE 

     VALIDATE $? " Changing to app dir "

     unzip -o /tmp/catalogue.zip  &>> $LOGFILE
     VALIDATE $? " Unzip catalogue app "

     npm install  &>> $LOGFILE
     VALIDATE $? " Download dependenices "
     
     cp /home/centos/shell-scripting-practice/roboshop/catalogue.service /etc/systemd/system/catalogue.service  &>> $LOGFILE

     VALIDATE $? " Coping catalogue.service "

     systemctl daemon-reload  &>> $LOGFILE 
     VALIDATE $? " loading catalogue "

     systemctl enable catalogue  &>> $LOGFILE

     VALIDATE $? " Enabling catalogue "
      
      systemctl start catalogue  &>> $LOGFILE

      VALIDATE $? "Start catalogue "

      cp /home/centos/shell-scripting-practice/roboshop/mongo.repo /etc/yum.repos.d/mongo.repo  &>> $LOGFILE
    
      VALIDATE $? " copy mongo repo "

      dnf install mongodb-org-shell -y  &>> $LOGFILE
      VALIDATE $? "Install mongodb"

      mongo --host 172.31.90.96 </app/schema/catalogue.js

















    