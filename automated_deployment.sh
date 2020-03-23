#!/bin/bash
#author: junglert
#mail:
#date: 23.03.2020
#license: GPL-3.0
#summary: bash script that automates ansible deployment


#variables
user="$USER"
site_name="index.html"
keyfile="/home/$user/.ssh/ansible_key"
ansible_path="/home/$user/ansible"
playbook="$ansible_path/apache.yml"
index="$ansible_path/$site_name"
splitter="----------------------------------------------------------------"


#generate folder for files and addons, if not already generated
echo "
Initial check if folder ansible exists
"
if [ -d "$ansible_path" ];
    then
            echo -e "Folder already exists \e[32m\u2714 \e[39m
            "
            echo $splitter
    else
            echo "Creating ansible folder in /home/$user/
            "
            mkdir /home/$user/ansible
            echo $splitter
fi


#check if playbook exists in the ansible folder
echo "
Initial check if playbook exists in the ansible folder
"
if test -f $playbook;
    then
            echo -e "$playbook exists \e[32m\u2714 \e[39m
            "
            echo $splitter
    else
            echo "Copying playbook into ansible folder
            "
            cp playbooks/apache.yml $ansible_path/
            echo $splitter
fi


#check if index.html exists in the ansible folder
echo "
Initial check if index.html exists in the ansible folder
"
if test -f $index;
    then
            echo -e "$index exists \e[32m\u2714 \e[39m
            "
            echo $splitter
    else
            echo "Copying index.html into ansible folder
            "
            cp $site_name $ansible_path
            echo $splitter
fi


#collect data for ansible
read -p "Username of remote host: " remote_host
echo "
Add your own additional parameters - leave blank for normal use"
read -p "additional parameters: " par_var


#ansible playbook execution
ansible-playbook -u $remote_host -i /etc/ansible/hosts -K $par_var --key-file=$keyfile $playbook
