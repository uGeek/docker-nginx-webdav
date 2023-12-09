#!/bin/bash

touch /etc/nginx/htpasswd

if [ -n "$USERNAME" ] && [ -n "$PASSWORD" ]
then
    htpasswd -b /etc/nginx/htpasswd "$USERNAME" "$PASSWORD"
    echo "Done for User: $USERNAME"
fi

max_users=50
for ((i=1; i<=$max_users; i++))
do
    username_var="USERNAME$i"
    password_var="PASSWORD$i"

    if [ -n "${!username_var}" ] && [ -n "${!password_var}" ]
    then
        htpasswd -b /etc/nginx/htpasswd "${!username_var}" "${!password_var}"
        echo "Done for User $i: ${!username_var}"
    fi
done

if [ -z "$(env | grep '^USERNAME')" ] || [ -z "$(env | grep '^PASSWORD')" ]
then
    echo Using no auth.
    sed -i 's%auth_basic "Restricted";% %g' /etc/nginx/conf.d/default.conf
    sed -i 's%auth_basic_user_file htpasswd;% %g' /etc/nginx/conf.d/default.conf
fi

mediaowner=$(ls -ld /media | awk '{print $3}')
echo "Current /media owner is $mediaowner"
if [ "$mediaowner" != "www-data" ]
then
    chown -R www-data:www-data /media
fi
