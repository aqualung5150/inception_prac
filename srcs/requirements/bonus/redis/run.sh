# !/bin/sh

if cat /etc/redis.conf | grep -q "protected-mode yes"; then
    echo "Set protected-mode."
    sed -i "s/protected-mode yes/protected-mode no/" /etc/redis.conf
else
    echo "Already protected-mode setup."
fi

if cat /etc/redis.conf | grep -q "bind 127.0.0.1"; then
    echo "Set bind-address."
    sed -i "s/bind 127.0.0.1/bind 0.0.0.0/" /etc/redis.conf
else
    echo "Already bind address setup."
fi

redis-server /etc/redis.conf