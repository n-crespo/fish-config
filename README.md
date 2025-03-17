# Changing shell to fish safely

> [!WARNING]
> I set `$SHELL` to bash, even though my shell starts up uses fish.

```sh
echo /home/linuxbrew/.linuxbrew/bin/fish | sudo tee -a /etc/shells
sudo chsh -s /home/linuxbrew/.linuxbrew/bin/fish {username}
```

Exclude the username to change shell of root user.

Note that you should probably leave `$SHELL` as `bash` or something POSIX compliant.
