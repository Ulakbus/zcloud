#!/usr/bin/expect
set password [lindex $argv 0]
spawn git push origin gh-pages

expect "Username for 'https://github.com':" { send "zetaopsbot\r"; exp_continue }
expect "Password for 'https://zetaopsbot@github.com':" { send "$password\r"; exp_continue }
expect "Push successfull" { send "ok\r"; exp_continue }

interact