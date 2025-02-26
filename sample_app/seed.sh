#!/bin/bash

mysql -u root -p1234 -e "
CREATE DATABASE IF NOT EXISTS people;
USE people;
CREATE TABLE IF NOT EXISTS register (
    id INT(3),
    name VARCHAR(50),
    lastname VARCHAR(50),
    age INT(3)
);
TRUNCATE TABLE register;"

counter=0

while [ $counter -lt 50 ]; do 
    let counter=counter+1
    
    line=$(nl ./tmp/people.txt | grep -w $counter | awk '{print $2}')
    name=$(echo $line | awk -F ',' '{print $1}')
    lastname=$(echo $line | awk -F ',' '{print $2}')
    age=$(shuf -i 20-25 -n 1)

    mysql -u root -p1234 people -e "insert into register values ($counter, '$name', '$lastname', $age)"
    echo "$counter $name $lastname $age was correctly imported"
done