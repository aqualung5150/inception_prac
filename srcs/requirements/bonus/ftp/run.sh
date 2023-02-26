# !/bin/sh

if ! cat /etc/passwd | grep -q "$FTP_USER"; then
    echo "Add new ftp user. $FTP_USER."
    # adduser
    # -g "" : Set empty every field.
    # -h : Home directory
    # -D : Don't assign a password, so cannot login
    adduser -g "" -h /home/$FTP_USER -D $FTP_USER
    echo -e "$FTP_USER_PASSWORD\n$FTP_USER_PASSWORD" | passwd $FTP_USER
    chown -R $FTP_USER /var/www/html/wordpress
else
    echo "Already $FTP_USER exists."
fi

vsftpd /etc/vsftpd/vsftpd.conf