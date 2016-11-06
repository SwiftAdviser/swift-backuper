#!/bin/bash
NAME="Backup BOT SYS #1"              # Имя отправителя. Я ставлю имя сервера
MAILFROM=""                           # от кого. Обычно no-reply@exit.com
MAILTO=""                             # кому отправляем на почту

LIMIT=$((20))                         # лимит бекапов.

DB_BACKUP="/var/mybackups/mysql"      #Указать каталог для баз
DB_USER=""                            # Указать пользователя, от которого будет идти бэкап. Лучше не root, а имеющий возможность только чтения
DB_PASSWD=""                          # Указать пароль этого пользователя

FILES_BACKUP="/var/mybackups/servers"   # абсолютный путь, куда бекапить файлы. Лучше - в папке с этим же бекапером
FILES_PATH="/home/minecraft/servers"  # абсолютный путь, ЧТО бекапить

FTPSERVER=""                          # сервер для бекапа
FTPUSER=""                            # логин для бекапа
FTPPASS=""                            # пароль
FTPLOCALPATH="/var/mybackups"         # путь, ИЗ которого будем качать файлы на удаленный фтп. Все папки и файлы
FTPPATH="/backups"                    # путь, В который будем качать файлы на уд. фтп. Старые файлы будут удаляться, новые - закачиваться.


# бекап бд
sh ./util/backup-mysql.sh $LIMIT $DB_BACKUP $DB_USER $DB_PASSWD > /tmp/backup_result.log
# бекап файлов
sh ./util/backup-files.sh $LIMIT $FILES_BACKUP $FILES_PATH >> /tmp/backup_result.log
# заливаем всё это дело на фтп
sh ./util/ftp-uploader.sh $FTPSERVER $FTPUSER $FTPPASS $FTPLOCALPATH $FTPPATH >> /tmp/backup_result.log

ssmtp $MAILTO <<EOF
From: `echo $NAME` <`echo $MAILFROM`>
Subject: Полный отчет: `date "+%m-%d"`
`cat /tmp/backup_result.log | uuenview -a -bo backup.log`
EOF

# отчетность
ssmtp $MAILTO <<EOF
From: `echo $NAME` <`echo $MAILFROM`>
Subject: Кототкий отчет: `date "+%m-%d"`

* Вес бекапа файлов сервера:

`cat /tmp/backup_files.log`

------------------------------------------------

* Вес бекапа БД:

`cat /tmp/backup_db.log`
EOF

exit 0
