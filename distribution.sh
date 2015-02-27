#!/bin/sh
function level ()
{
	if [ "$(id -u)" != 0 ];
	then
	echo "this script mast run as root" 1>&2 ;
	exit 1
	fi
}
function test_commande ()
{
	command -v lsb_release -a > resltat.txt
	if [ $? == 1 ];
	then
	detection_cat ;
	else
	detection_release ;
	fi
}
function detection_release()
{
	lsb_release -a > distribution.txt;
	grep "Distributor "  distribution.txt | gawk '{print $3}' > distribution2.txt;
	distribution=`cat distribution2.txt`;
	echo "Votre distribution est: $distribution" ;
}
function detection_cat ()
{	
	if [ -f /etc/redhat-release ];then
	cat /etc/redhat-release | gawk '{print $1}' ;
	else
	d=`cat /etc/*-release | grep -i id= ` ;
	distribution=`echo ${d#*=}` ;
	echo "Votre distribution est: $distribution" 
	fi
}
level
test_commande
exit 0
