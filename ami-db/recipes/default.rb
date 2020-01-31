#
# Cookbook:: db_ami
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

remote_directory '/home/ubuntu/environment' do
  source 'environment'
  owner 'root'
  group 'root'
  mode '0777'
  action :create
end



bash 'setup_db' do
  code <<-EOH
    #!/bin/bash

    # install mongodb 3.2.20

    # key needed to access repo
    wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -
    # gets url of that source and adds to list
    echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
    # pulls from source
    sudo apt-get update -y
    # installs
    sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20

    # update sources list
    sudo apt-get update -y

    # upgrade packages
    #sudo apt-get upgrade -y

    # remove existing mongod.conf
    sudo rm /etc/mongod.conf
    # link to mongod.conf shared from host - synced connection
    sudo ln -s /home/ubuntu/environment/mongod.conf /etc/mongod.conf

    # start mongodb
    sudo systemctl restart mongod

    # enable service
    sudo systemctl enable mongod

    EOH
  end
