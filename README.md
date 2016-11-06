# Swift backup EN 
Auto-backuper for linux. Have been tested on Debian 8 Jessie. Russian setup below
### What
Allows to backup files and MySQL databases.
### Where
All data will be on local storage and in remote FTP server.
### When
The best time - at night :)

## Setup

All settings you can find in `backup.sh`. This file should be executed in cron.

After that you should install `lftp`, `ssmtp` and `uuenview`.
### ssmtp
Connect `ssmtp` to any smtp server like `gmail` or `yandex`.

# Swift backup RU
Авто-бекапер для линукса. Тестировался на Debian 8 Jessie.
### Что
Позволяет бэкапить файлы и БД MySQL
### Где
Все данные будут хранится на локальном хранилище, и на удаленном FTP сервере.
### Когда
Лучше - в ночное время :)

# Настройка

Все настройки можно найти в `backup.sh`
Этот файл и надо запускать в кроне.

После настройки файла надо установить эти пакеты: `lftp`, `ssmtp` and `uuenview`.
## ssmtp
Подключите `ssmtp` к любому SMTP серверу типа `gmail` или `yandex`, чтобы отправлять письма было просто.
