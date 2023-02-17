# !/bin/sh

adduser -g "" -h /home/$FTP_USER -D $FTP_USER

echo -e "$FTP_USER_PASSWORD\n$FTP_USER_PASSWORD" | passwd $FTP_USER

chown -R $FTP_USER /var/www/html/wordpress

vsftpd /etc/vsftpd/vsftpd.conf