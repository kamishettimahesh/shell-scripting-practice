#!/bin/bash
ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=(date +%F .%H:%M:%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

VALIDATE(){

if [ $1 -ne 0 ]

then 
  echo -e "$2 ....$R FAILED $N"
exit 1
else 
  echo -e "$2 ....$G SUCCESS $N"

fi
}
if [ $ID -ne 0 ]
then 
  echo -e "$R ERROR:Please use ROOT user $N"
  exit 1
else
echo -e " $G you are used ROOT user $N "
fi

cp mongo.repo /etc/yum.repos.d/mongo.repo  &>> $LOGFILE

VALIDATE $? " Creating Mongo.repo "

dnf install mongodb-org -y  &>> $LOGFILE

VALIDATE $? " installed Mongodb "

systemctl enable mongod  &>> $LOGFILE

VALIDATE $? " Service enabled mongodb "

systemctl start mongod  &>> $LOGFILE

VALIDATE $? " Service start mongodb "

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf &>> $LOGFILE

VALIDATE $? "ip changing"

systemctl restart mongod  &>> $LOGFILE

VALIDATE $? " service restart mongod "
