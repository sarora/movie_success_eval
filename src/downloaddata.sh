#!/usr/bin/env bash

echo "Hello, Please enter your Kaggle username"
read username
read -s -p "Kaggle Password: " password

cd ..//data

kg dataset -u $username -p $password -o tmdb -d tmdb-movie-metadata

cd ..

read
