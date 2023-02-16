# !/bin/sh

if cat /etc/redis.conf | grep -q "bind 127.0.0.1"; then
    sed -i "s/bind 127.0.0.1/bind 0.0.0.0/" /etc/redis.conf
fi

if cat /etc/redis.conf | grep -q "protected-mode yes"; then
    sed -i "s/protected-mode yes/protected-mode no/" /etc/redis.conf
fi

redis-server /etc/redis.conf