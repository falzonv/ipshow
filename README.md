# ipshow

This script provides a compact and easy-to-read display of the information provided by `ip link`, `ip address` and `ip route` commands from the [`iproute2`](https://wiki.linuxfoundation.org/networking/iproute2) package.

I created it because, while the `ifconfig` and `route` commands are now deprecated on Linux, their outputs were really better than the outputs of their successors listed above.
This script uses the new commands but displays a much cleaner output (more compact and structured, adding titles, sorting interfaces, keeping only the most useful information, ...).
You can see examples lower.

This project is licensed under the terms of the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.txt).


## Suggested installation process

From the folder of your choice, download and extract the ZIP archive from GitHub :

```
wget "https://github.com/falzonv/ipshow/archive/main.zip"
unzip main.zip
```

Copy the script in the `bin` folder of your home directory and allow execution by the current user :

```
cp ipshow-main/ipshow.sh /home/${USER}/bin/ipshow.sh
chmod 764 /home/${USER}/bin/ipshow.sh
```

If the `bin` folder doesn't exist, create it and add it to the PATH variable (on some systems, addition of the home's `bin` to the PATH might be done automatically when you open a new terminal or a new session).


## Usage

Once the installation is done, you should be able to run the script from anywhere in the system using :

```
ipshow.sh
```

You can use `ipshow.sh -h` or `ipshow.sh --help` to see the options.

By default, only IPv4 information are displayed in the script's outputs for `ip address` and `ìp route`.
If you want to display IPv6 information instead, simply use `ipshow.sh -6` or `ipshow.sh --ipv6`.

*If you did not copied the script in the home's `bin` folder (itself in the PATH variable), you will need to go in the `ipshow-main` folder to execute the script with `./ipshow.sh` (you may also need to run `chmod 764 ipshow.sh` before).*


## Examples

### Result of the script (data anonymized)

```
user@hostname:~$ ipshow.sh

--- "ip link" information ---
Interface  Status   Physical_Address   Type
enp5s0     DOWN     aa:aa:aa:aa:aa:aa  <NO-CARRIER,BROADCAST,MULTICAST,UP>
lo         UNKNOWN  00:00:00:00:00:00  <LOOPBACK,UP,LOWER_UP>
wlp6s0     UP       bb:bb:bb:bb:bb:bb  <BROADCAST,MULTICAST,UP,LOWER_UP>

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

user@hostname:~$
```

```
user@hostname:~$ ipshow.sh -6

--- "ip link" information ---
Interface  Status   Physical_Address   Type
enp5s0     DOWN     aa:aa:aa:aa:aa:aa  <NO-CARRIER,BROADCAST,MULTICAST,UP>
lo         UNKNOWN  00:00:00:00:00:00  <LOOPBACK,UP,LOWER_UP>
wlp6s0     UP       bb:bb:bb:bb:bb:bb  <BROADCAST,MULTICAST,UP,LOWER_UP>

--- "ip address" information ---
Interface  Status   IP_Address
lo         UNKNOWN  ::1/128
wlp6s0     UP       fe80::cccc:cccc:cccc:ccc/64

--- "ip route" information ---
Destination  Gateway  Interface

Connected_Subnet  Interface
::1               lo
fe80::/64         wlp6s0

user@hostname:~$
```

### Default output of the ip commands (data anonymized)

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

