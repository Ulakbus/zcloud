#!/usr/bin/expect
set password [lindex $argv 0]
set timeout 20
spawn git push origin gh-pages

expect "Username for 'https://github.com':" { send "zetaopsbot\r" }
expect "Password for 'https://zetaopsbot@github.com':"
send "$password\r"

interact