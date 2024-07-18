#!/usr/bin/zsh
echo "start"


cd ./nvim/.config/nvim

git add .
git commit -m "commiting all changes for the day"
git push 

cd ../../../ 
git add .
git commit -m "commiting all changes for the day"
git push --recurse-submodules=on-demand
