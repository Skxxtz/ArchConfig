# DNS Issue

Probable issue is an incorrect configuration in the `/etc/resolv.conf` file.

1. Make `resolv.conf` writeable

```sh
sudo cp /etc/resolv.conf /etc/resolv.conf.bak
sudo chattr -i /etc/resolv.conf 2>/dev/null # remove immutable flag if set
sudo chmod 666 /etc/resolv.conf # add write permissions
```

2. Reconnect NordVPN to update DNS

```sh
nordvpn d
nordvpn c
```

3. Verify:

```sh
diff /etc/resolv.conf /etc/resolv.conf.bak
```

4. Restore previous permission setup

```sh
sudo chattr -i /etc/resolv.conf
sudo chmod 644 /etc/resolv.conf
```
