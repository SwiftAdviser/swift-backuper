#!/bin/bash

echo "--------  Бекап файлов  --------"

LIMIT=$1
FILES_BACKUP=$2
FILES_PATH=$3

if [ ! -d "$FILES_BACKUP" ]
then
    echo "* Папок не существует. Создаем папки"
	mkdir $FILES_BACKUP

  	for ((a=LIMIT; a > 0 ; a--))  # Двойные круглые скобки и "LIMIT" без "$".
  	do
     		mkdir $FILES_BACKUP/$a
  	done

fi

echo "* Идет бэкап серверов, можете покурить, попить чаю или поиграть в косынку :)"


for ((a=LIMIT; a >= 0 ; a--))  # Двойные круглые скобки и "LIMIT" без "$".
do
  # для последнего прохода
  if [ "$a" -eq "0" ]
  then
     mkdir $FILES_BACKUP/$(($a + 1))
     echo "* Самый ответственный, нужный и необходимый момент. Начинаем черное дело..."
     echo "----------------------"
     cd $FILES_BACKUP/$(($a + 1))
     tar -cvzf servers-`date +%Y-%m-%d-%H-%M-%S`.tar.gz  $FILES_PATH
     echo "* Готово! Файлы сохранены на диске"
     break
  fi

  if [ "$a" -eq "$LIMIT" ]
  then
    echo "Удаляем бекап $a"
    rm -rf $FILES_BACKUP/$a
  else
    echo "Папка $a -> $(($a + 1))"
    mv $FILES_BACKUP/$a $FILES_BACKUP/$(($a + 1))
fi
done

 # строчку с ls я добавляю специально, чтобы в письме, которое мне придёт, можно было увидеть
 # размер бэкапа. Если он меньше вчерашнего - есть повод призадуматься. Если вообще нулевой - бэкап не прошёл точно.
du -h $FILES_BACKUP/1/ > /tmp/backup_files.log

echo "--------  END  --------"

