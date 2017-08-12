#!/bin/bash
echo -n "Enter IP address: "
read ip
   
echo -n "Enter CIDR: "
read cidr
len=32
borrowed_bits="$((len-cidr))"

# variable storing the bits borrowed from the host portion

echo "The classless subnet mask entered borrows ${borrowed_bits} bits from the host portion"

correction=2
networks=$((2**borrowed_bits))
hosts="$((networks-correction))"
echo "The supplied subnet mask allows to create ${networks} networks and ${hosts} hosts"
 
