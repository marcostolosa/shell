#!/bin/bash


if [[ $(< /root/time.txt) != $(echo `sha256sum /etc/passwd`) ]]
then
    /root/send_mail.py /etc/passwd email@webmail.com
    echo `sha256sum /etc/passwd` > /root/time.txt
else
    echo "All good."
    exit
fi
