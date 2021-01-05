#!/bin/bash
#
# ipshow provides a compact and easy-to-read display of "ip link",
# "ip address" and "ip route" information
#
#   Copyright (C) 2020-2021 Vincent Falzon
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

# Titles and settings
link_titles="Interface Status Physical_Address Type"
address_titles="Interface Status IP_Address"
route_via_titles="Destination Gateway Interface"
route_via_fields='$1,         $3,     $5'
route_connected_titles="Connected_Subnet Interface"
route_connected_fields='$1,              $3'
ipmode="-4"

# Colors definition (1 = Sections, 2 = Columns titles)
color1="\e[1;33m" # Yellow
color2="\e[1;34m" # Blue

# Explain briefly how the script works
display_help()
{
	echo
	echo "  Usage: ipshow.sh [OPTION]"
	echo
	echo "  This script makes the outputs of \"ip address\", \"ip route\" and \"ip link\""
	echo "  more compact and easy to read."
	echo
	echo "  OPTIONS"
	echo "     -6, --ipv6    By default, only IPv4 information is displayed in the"
	echo "                   script's \"ip address\" and \"ip route\" outputs. With this"
	echo "                   option, IPv6 information is displayed instead."
	echo "     -h, --help    To display this message again."
	echo
	exit 0
}

# Check if a parameter has been provided
if [ $# != 0 ]
	then
		case $1 in
			-h) display_help ;;
			--help) display_help ;;
			-6) ipmode="-6" ;;
			--ipv6) ipmode="-6" ;;
		esac
	fi

echo

# Display IP addressing
echo -e "${color1}--- \"ip address\" information ---\e[0m"
(echo -e ${color2}$address_titles"\e[0m" ; ip -brief $ipmode address | sort) | column -t
echo

# Display IP routing
echo -e "${color1}--- \"ip route\" information ---\e[0m"
ip $ipmode route | grep "via" | (echo -e ${color2}$route_via_titles"\e[0m" ; awk "{print $route_via_fields}") | column -t
echo
ip $ipmode route | grep -v "via" | (echo -e ${color2}$route_connected_titles"\e[0m" ; awk "{print $route_connected_fields}") | column -t
echo

# Display interfaces
echo -e "${color1}--- \"ip link\" information ---\e[0m"
(echo -e ${color2}$link_titles"\e[0m" ; ip -brief link | sort) | column -t
echo

