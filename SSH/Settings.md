### you can use SSH tunnel in VSCODE direclty using the remote connections
[before_this_you_need_to_set_your_config_file_location_as_.ssh\config]()
> first go to the Remote tunnels and select the SSH

> select the add remote and enter the ssh and instance name and its IP address (ssh ubuntu@127.0.0.11)

> when Host is added then open the config file and add the .pem file location(secret key) location as identifyFile(identifyFile c:/user/dowmload/home.pem)
```
in the config file you will see all the SSH tunnels you have set up in your devices also! with their IP name as Host and User name
  Host 13.200.192.187
    HostName 13.200.192.187
    User ubuntu
    IdentityFile C:\Users\Downloads\home.pem
```
>then click on the connect in new windows

>now Select the platform as Linux or you respective one

>now it will ask for fingerprint of the .pem files enter yes.Onces the files are connected click on the open folder

>now select the folder you want to work or / to view all the files for the instances
## now you have succesfully done setting up SSH tunnel in your devices
