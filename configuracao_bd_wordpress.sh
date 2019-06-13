#!/bin/bash

sudo apt install -y mysql-server

CREATE DATABASE wordpress;

CREATE USER 'bruno'@'localhost' IDENTIFIED BY 'wordpress';

GRANT ALL ON wordpress.* TO 'bruno'@'localhost';

FLUSH PRIVILEGES;
EOF
