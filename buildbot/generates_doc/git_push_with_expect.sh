#!/usr/bin/expect

spawn git push origin gh-pages

expect "Username for 'https://github.com':" { send "$BUILDBOTGITHUBUSER\r" }
expect "Password for 'https://$BUILDBOTGITHUBUSER@github.com':" { send "$BUILDBOTGITHUBPASS\r" }

interact