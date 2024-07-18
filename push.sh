#!/usr/bin/zsh
$WD = cwd() 
cd ./nvim/.config/nvim
git commit -am "commiting all changes for the day"
git push 

cd $WD 
git commit -am "commiting all changes for the day"
git push --recurse-submodules=on-demand
