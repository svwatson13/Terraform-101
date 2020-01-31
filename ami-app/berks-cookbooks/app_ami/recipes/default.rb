#
# Cookbook:: app_ami
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

remote_directory '/home/ubuntu/app' do
  source 'app'
  owner 'root'
  group 'root'
  mode '0777'
  action :create
end


bash 'setup_app' do
  code <<-EOH
    #!/bin/bash

    # Update the sources list
    sudo apt-get update -y

    # upgrade any packages available
    sudo apt-get upgrade -y

    # install nginx
    sudo apt-get install nginx -y

    # install git
    sudo apt-get install git -y

    # install nodejs
    sudo apt-get install python-software-properties
    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
    sudo apt-get install nodejs -y

    # install pm2
    sudo npm install pm2 -g

    EOH
  end
