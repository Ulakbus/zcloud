#!/usr/bin/expect
set user [lindex $argv 0]
set password [lindex $argv 1]
set timeout 20
spawn git push origin gh-pages

expect "Username for 'https://github.com':" { send "$user\r" }
expect "Password for 'https://zetaopsbot@github.com':" { send "$password\r" }

interact