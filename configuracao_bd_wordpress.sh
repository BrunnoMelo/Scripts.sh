#!/bin/bash

sudo apt -y install mysql-server

CREATE DATABASE wordpress;

CREATE USER 'bruno'@'%' IDENTIFIED BY 'wordpress';

GRANT ALL ON wordpress.* TO 'bruno'@'%';

FLUSH PRIVILEGES;
EOF
