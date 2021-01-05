# ipshow

This script provides a compact and easy-to-read display of the information provided by `ip address`, `ip route` and `ip link` commands from the [`iproute2`](https://wiki.linuxfoundation.org/networking/iproute2) package.

I created it because, while the `ifconfig` and `route` commands are now deprecated on Linux, their outputs were really better than the outputs of their successors listed above.
This script uses the new commands but displays a much cleaner output (more compact and structured, adding colored titles, sorting interfaces, keeping only the most useful information, ...).
You can see examples lower.

This project is licensed under the terms of the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.txt).


## Suggested installation process

From the folder of your choice, download and extract the ZIP archive from GitHub :

```
wget "https://github.com/falzonv/ipshow/archive/main.zip"
unzip main.zip
```

***Note :*** *if you are familiar with Git, you may prefer to use `git clone "https://github.com/falzonv/ipshow" ipshow-main` so you can easily get updates with `git pull`*

Copy the script in the `bin` folder of your home directory :

```
cp ipshow-main/ipshow.sh /home/${USER}/bin/ipshow.sh
```

***Note :*** *using the `git clone` alternative, you may prefer to create a symbolic link from your `bin` folder using `ln -s /path/to/folder/ipshow-main/ipshow.sh ipshow.sh`*

If the `bin` folder doesn't exist in your home directory, create it using the `mkdir /home/${USER}/bin` command.
On many systems, creating the home's `bin` will automatically add it to the PATH when you open a new terminal or a new session.
If this is not the case for you, you can add it manually by inserting the line `export PATH="/home/${USER}/bin:$PATH"` in the `/home/${USER}/.bashrc` file (you will need to open a new terminal or a new session to see the change applied).


## Usage

Once the installation is completed, you should be able to run the script from anywhere in the system using :

```
ipshow.sh
```

You can use `ipshow.sh -h` or `ipshow.sh --help` to see the options.

By default, only IPv4 information are displayed in the script's outputs for `ip address` and `ìp route`.
If you want to display IPv6 information instead, simply use `ipshow.sh -6` or `ipshow.sh --ipv6`.

### Troubleshooting

- If you don't want or cannot copy/link the script in the home's `bin` folder (or add the home's `bin` folder to the PATH), you will need to go in the `ipshow-main` folder to execute the script with `./ipshow.sh`
- If you run into permissions issues, make sure the script is executable for the current user by going in the folder where the script is located (either `/home/${USER}/bin` or `ipshow-main`) and running `chmod u+x ipshow.sh`

## Examples

### Result of the script (data anonymized)

When launched in a terminal, sections and columns titles are also colorized for easier reading.

```
user@hostname:~$ ipshow.sh

--- "ip address" information ---
Interface  Status   IP_Address
lo         UNKNOWN  127.0.0.1/8
wlp6s0     UP       192.168.1.10/24

--- "ip route" information ---
Destination     Gateway      Interface
default         192.168.1.1  wlp6s0

Connected_Subnet  Interface
169.254.0.0/16    wlp6s0
192.168.1.0/24    wlp6s0

--- "ip link" information ---
Interface  Status   Physical_Address   Type
enp5s0     DOWN     aa:aa:aa:aa:aa:aa  <NO-CARRIER,BROADCAST,MULTICAST,UP>
lo         UNKNOWN  00:00:00:00:00:00  <LOOPBACK,UP,LOWER_UP>
wlp6s0     UP       bb:bb:bb:bb:bb:bb  <BROADCAST,MULTICAST,UP,LOWER_UP>

user@hostname:~$
```

```
user@hostname:~$ ipshow.sh -6

--- "ip address" information ---
Interface  Status   IP_Address
lo         UNKNOWN  ::1/128
wlp6s0     UP       fe80::cccc:cccc:cccc:ccc/64

--- "ip route" information ---
Destination  Gateway  Interface

Connected_Subnet  Interface
::1               lo
fe80::/64         wlp6s0

--- "ip link" information ---
Interface  Status   Physical_Address   Type
enp5s0     DOWN     aa:aa:aa:aa:aa:aa  <NO-CARRIER,BROADCAST,MULTICAST,UP>
lo         UNKNOWN  00:00:00:00:00:00  <LOOPBACK,UP,LOWER_UP>
wlp6s0     UP       bb:bb:bb:bb:bb:bb  <BROADCAST,MULTICAST,UP,LOWER_UP>

user@hostname:~$
```

```
user@hostname:~$ ipshow.sh -h

  Usage: ipshow.sh [OPTION]

  This script makes the outputs of "ip address", "ip route" and "ip link"
  more compact and easy to read.

  OPTIONS
     -6, --ipv6    By default, only IPv4 information is displayed in the
                   script's "ip address" and "ip route" outputs. With this
                   option, IPv6 information is displayed instead.
     -h, --help    To display this message again.

user@hostname:~$
```

### Default output of the ip commands (data anonymized)

```
user@hostname:~$ ip address
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp5s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN group default qlen 1000
    link/ether aa:aa:aa:aa:aa:aa brd ff:ff:ff:ff:ff:ff
3: wlp6s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether bb:bb:bb:bb:bb:bb brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.10/24 brd 192.168.1.255 scope global dynamic noprefixroute wlp6s0
       valid_lft 623655sec preferred_lft 623655sec
    inet6 fe80::cccc:cccc:cccc:ccc/64 scope link
       valid_lft forever preferred_lft forever
user@hostname:~$
```

```
user@hostname:~$ ip route
default via 192.168.1.1 dev wlp6s0 proto dhcp metric 600
169.254.0.0/16 dev wlp6s0 scope link metric 1000
192.168.1.0/24 dev wlp6s0 proto kernel scope link src 192.168.1.10 metric 600
user@hostname:~$
```

```
user@hostname:~$ ip -6 route
::1 dev lo proto kernel metric 256 pref medium
fe80::/64 dev wlp6s0 proto kernel metric 256 pref medium
user@hostname:~$
```

```
user@hostname:~$ ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp5s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN mode DEFAULT group default qlen 1000
    link/ether aa:aa:aa:aa:aa:aa brd ff:ff:ff:ff:ff:ff
3: wlp6s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DORMANT group default qlen 1000
    link/ether bb:bb:bb:bb:bb:bb brd ff:ff:ff:ff:ff:ff
user@hostname:~$
```

