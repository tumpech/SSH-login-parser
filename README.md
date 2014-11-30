SSH login parser
================

This script parse the connections.txt file, searches for the parameter it gets, and connects you to the host. There are 2 way to use the script:

    you can use it with the hostname:

        conn example.com
        this will connect you to the example.com  host, if it sees more hosts with the same name, it will give you a prompt to choose from them. 
        you don't need to use the full host name, you can use only part of it, e.g. "conn example" will connect you to example.com. 

    you can use it with group name:

        conn -a ExApp
        this will list all of the connections for the ExApp, if it sees more groups that can be this one, it will give you a prompt to choose from them. 
        you don't need the full group name, only part of it is enough, e.g. conn App will list all group name with App in it, as supposed. 

The connections.txt should be filled with "user@node" lines, and after it finds a match, it connects to it.
