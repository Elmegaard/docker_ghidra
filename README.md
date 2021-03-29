![](https://raw.githubusercontent.com/0xf15h/docker_ghidra/master/ghidra_logo.png)

## Config

The configuration file goes into srv/repositories/server.conf on in the docker container. This should be a mounted directory to keep your config file.

## Adding Users

```
docker exec -it <container_name> bash
./svrAdmin -add <user>
```

The users are added to the server with the default password 'changeme'. They will be prompted to create a new password at login.

## Connecting to the Server

Start the Ghidra client and click on File -> New Project -> Shared Project -> Next. The server name is either localhost or the domain name that points to your Ghidra server. The port is 13100. Click Next and a pop-up will appear. The default password is 'changeme'. The steps from this point forward are self explanatory. See the Ghidra documentation for further guidance.

# Server Administration

This Docker image is consistent with the offical documentation so admins can quickly learn how to customize the server. All scripts that are specified in the documentation are located in the home directory.

## Setting Up a Remote Server

According to the documentation, the version tracking server needs to be configured with a DNS that is configured for both forward and reverse lookups.

The version tracking server listens on port 13100. Make sure this port is not blocked by a firewall and that another process isn't already bound to it.
