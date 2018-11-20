#!/bin/bash
#https://unix.stackexchange.com/questions/1197/adding-a-line-of-text-to-multiple-files
awk '
/<//VirtualHost>/ {
    print "Line one to insert"
    print "second new line to insert"
    print "third new line to insert"
}
{ print }
' /etc/apache2/sites-enabled/000-default.conf
