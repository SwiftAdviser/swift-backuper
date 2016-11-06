#!/bin/bash
 
echo "--------  Бекап БД  --------"

LIMIT=$1
DB_BACKUP=$2
DB_USER=$3
DB_PASSWD=$4

if [  ! -d "$DB_BACKUP" ]
then
    echo "* Папок не существует. Создаем папки"
	mkdir $DB_BACKUP

  	for ((a=LIMIT; a > 0 ; a--))  # Двойные круглые скобки и "LIMIT" без "$".
  	do
     		mkdir $DB_BACKUP/$a
  	done

fi

echo "* Идет бэкап БД, можете покурить, попить чаю или поиграть в косынку :)"
 
for ((a=LIMIT; a >= 0 ; a--))  # Двойные круглые скобки и "LIMIT" без "$".
do
	# для последнего прохода
	if [ "$a" -eq "0"  ]
	then
		mkdir $DB_BACKUP/$(($a + 1))
		echo "* Самый ответственный момент..."
		echo "----------------------"
		mysqldump --user=$DB_USER --password=$DB_PASSWD -A > $DB_BACKUP/$(($a + 1))/all-dump-`date +%Y-%m-%d-%H-%M-%S`.sql
		echo "* Готово. Бекап сохранен на диске."
		break
	fi

  if [ "$a" -eq "$LIMIT" ]
  then
    echo "Удаляем бекап $a"
    rm -rf $DB_BACKUP/$a
  else
    echo "Папка $a -> $(($a + 1))"
    mv $DB_BACKUP/$a $DB_BACKUP/$(($a + 1))
fi
done

du -h $DB_BACKUP/1/ > /tmp/backup_db.log

echo "--------  END  --------"

