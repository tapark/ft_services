#!/bin/sh
if [ $(ps | grep telegraf | grep -v grep | wc -l) -eq 0 ]
then
	exit 1
fi

if [ $(ps | grep vsftpd | grep -v grep | wc -l) -eq 0 ]
then
	exit 1
fi

exit 0