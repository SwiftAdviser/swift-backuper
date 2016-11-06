#!/bin/bash

FTPSERVER=$1  
FTPUSER=$2
FTPPASS=$3       
FTPLOCALPATH=$4
FTPPATH=$5

echo "-------- Загружаем на ФТП --------"

lftp -f "
set ssl:verify-certificate no
set ftp:ssl-allow no
open $FTPSERVER
user $FTPUSER $FTPPASS
lcd $FTPLOCALPATH
mirror -R --continue --delete --verbose $FTPLOCALPATH $FTPPATH
bye
"


echo "-------- END --------"

