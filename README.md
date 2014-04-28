SSH login parser
================

This bash script can parse a text file filled with user@host connections, and log into the host with the domain name of the first parameter.
If it finds more, the user can choose which one to use.
It uses grep, so it doesn't need the whole hostname, part of it is enough.
