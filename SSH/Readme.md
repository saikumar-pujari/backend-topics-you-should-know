# SSH: Complete Guide (Beginner → Advanced for Backend & DevOps)

## 1. What is SSH?

**SSH (Secure Shell)** is a protocol that allows you to securely connect
to and control a remote machine over a network.

Example command:

``` bash
ssh user@server-ip
```

Example:

``` bash
ssh ubuntu@54.210.12.33
```

### Output

    ubuntu@ip-172-31-25-101:~$

Now your terminal is controlling the remote server.

------------------------------------------------------------------------

# 2. Why SSH Exists

Before SSH there was **Telnet**.

Problems with Telnet: - Passwords sent as plain text - Easy to
intercept - No encryption

SSH solves this using: - Encryption - Authentication - Secure
communication

------------------------------------------------------------------------

# 3. SSH Architecture

    +-------------------+
    |  SSH Client       |
    |  (your computer)  |
    +-------------------+
              |
              | encrypted connection
              |
    +-------------------+
    | SSH Server        |
    | (sshd process)    |
    | remote machine    |
    +-------------------+

Default port:

    22

------------------------------------------------------------------------

# 4. SSH Server

The SSH server program is called:

    sshd

Check if running:

``` bash
ps aux | grep sshd
```

Output example:

    root      1023  0.0  0.1  10500  3200 ?        Ss   10:00   0:00 /usr/sbin/sshd

Check service status:

``` bash
sudo systemctl status ssh
```

Output:

    ● ssh.service - OpenBSD Secure Shell server
       Loaded: loaded (/lib/systemd/system/ssh.service)
       Active: active (running)

------------------------------------------------------------------------

# 5. SSH Configuration

SSH server config file:

    /etc/ssh/sshd_config

Example config:

    Port 22
    PermitRootLogin no
    PasswordAuthentication yes
    PubkeyAuthentication yes

Restart SSH after changes:

``` bash
sudo systemctl restart ssh
```

------------------------------------------------------------------------

# 6. SSH Client

SSH client runs on your local machine.

Basic usage:

``` bash
ssh user@host
```

Using custom port:

``` bash
ssh -p 2222 user@host
```

Using identity key:

``` bash
ssh -i mykey.pem ubuntu@server-ip
```

------------------------------------------------------------------------

# 7. SSH Key Authentication

SSH uses **public/private key cryptography**.

    Private Key → stays on your laptop
    Public Key → stored on server

------------------------------------------------------------------------

## Generate SSH Key

``` bash
ssh-keygen
```

Output:

    Generating public/private rsa key pair.
    Your identification has been saved in ~/.ssh/id_rsa
    Your public key has been saved in ~/.ssh/id_rsa.pub

Files created:

    ~/.ssh/id_rsa
    ~/.ssh/id_rsa.pub

------------------------------------------------------------------------

## Add Public Key to Server

Copy public key:

``` bash
cat ~/.ssh/id_rsa.pub
```

Add to:

    ~/.ssh/authorized_keys

Example:

    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD....

------------------------------------------------------------------------

# 8. SSH Login Flow

Connection process:

    Client → Server
    Key exchange
    Encryption setup
    Authentication
    Shell access

------------------------------------------------------------------------

# 9. File Transfer with SSH

## SCP

Upload file:

``` bash
scp file.txt user@server:/home/user/
```

Output:

    file.txt                                   100%   10KB  50KB/s

Download file:

``` bash
scp user@server:/home/user/file.txt .
```

------------------------------------------------------------------------

## SFTP

Start:

``` bash
sftp user@server
```

Output:

    Connected to server.
    sftp>

Commands:

    ls
    cd
    put file.txt
    get file.txt
    exit

------------------------------------------------------------------------

# 10. SSH Port Forwarding (Tunneling)

SSH can create secure tunnels.

    local port → encrypted SSH tunnel → remote port

------------------------------------------------------------------------

# 11. Local Port Forwarding

Command:

``` bash
ssh -L local_port:destination:destination_port user@server
```

Example:

``` bash
ssh -L 5432:localhost:5432 ubuntu@server
```

Now:

    localhost:5432 → server:5432

Use case:

Securely access remote PostgreSQL.

------------------------------------------------------------------------

# 12. Remote Port Forwarding

Expose local service to remote server.

``` bash
ssh -R remote_port:localhost:local_port user@server
```

Example:

``` bash
ssh -R 9000:localhost:8000 server
```

Now server port 9000 forwards to your local port 8000.

------------------------------------------------------------------------

# 13. Dynamic Port Forwarding (SOCKS Proxy)

Command:

``` bash
ssh -D 8080 user@server
```

Now configure browser proxy:

    localhost:8080

Traffic path:

    Browser → SOCKS Proxy → SSH Tunnel → Internet

------------------------------------------------------------------------

# 14. SSH Agent

Start agent:

``` bash
eval "$(ssh-agent)"
```

Add key:

``` bash
ssh-add ~/.ssh/id_rsa
```

Output:

    Identity added: ~/.ssh/id_rsa

Now SSH won't ask for passphrase each time.

------------------------------------------------------------------------

# 15. SSH Config File

File:

    ~/.ssh/config

Example:

    Host myserver
        HostName 54.210.12.33
        User ubuntu
        IdentityFile ~/.ssh/aws.pem

Now connect with:

``` bash
ssh myserver
```

------------------------------------------------------------------------

# 16. SSH in Real Backend Work

Example deployment:

``` bash
ssh ubuntu@server
```

Pull code:

``` bash
git pull
```

Run containers:

``` bash
docker compose up -d
```

Check logs:

``` bash
docker logs container_name
```

------------------------------------------------------------------------

# 17. Access Remote Databases Securely

Example:

``` bash
ssh -L 5432:localhost:5432 ubuntu@server
```

Then locally:

``` bash
psql -h localhost -p 5432 -U postgres
```

Output:

    postgres=# SELECT version();

------------------------------------------------------------------------

# 18. Security Best Practices

Disable root login:

    PermitRootLogin no

Disable password login:

    PasswordAuthentication no

Use firewall:

``` bash
sudo ufw allow 22
```

------------------------------------------------------------------------

# 19. SSH Multiplexing (Advanced)

Add to config:

    Host *
     ControlMaster auto
     ControlPath ~/.ssh/sockets/%r@%h-%p
     ControlPersist 600

Benefit:

Multiple SSH connections reuse same session.

Much faster connections.

------------------------------------------------------------------------

# 20. SSH in DevOps Infrastructure

Example architecture:

    Laptop → SSH → Bastion Host → Private Server

Example command:

``` bash
ssh -L 5432:db.internal:5432 ubuntu@bastion
```

Now local machine accesses private database securely.

------------------------------------------------------------------------

# 21. SSH Protocol Layers

SSH has three layers:

    Transport Layer
    Authentication Layer
    Connection Layer

Transport layer: - Encryption

Authentication: - Password - Keys

Connection: - Shell - File transfer - Port forwarding

------------------------------------------------------------------------

# Final Mental Model

Think of SSH as:

    Encrypted pipe between machines

Inside this pipe you can send:

    Commands
    Files
    Applications
    Database traffic
    Network ports

This is why SSH is one of the most important tools in backend
engineering and DevOps.
