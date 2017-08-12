#!/bin/bash
echo -n "Enter IP address: "
read ip
octet1=$(echo $ip | cut -d "." -f1)
#echo "${octet1}"
if [ $octet1 -gt 0 ] && [ $octet1 -le 126 ]
then 
    def_mask=8 

#def_mask is a variable storing the default classful subnet mask, based on the IP class
    
#echo "${def_mask}" #optional echo statemenr for debugging purposes
    
elif [ $octet1 -ge 128 ] && [ $octet1 -le 191 ]
then
     def_mask=16

elif [ $octet1 -ge 192 ] && [ $octet1 -le 223 ]
then
     def_mask=24
else
     echo "Reserved IP address"
     exit 1;
fi
 
echo -n "Enter CIDR: " #enter classless subnet mask in / notation

read cidr

len=32 # an IPv4 address is 32-bit long

borrowed_bits=$((cidr-def_mask)) 

#the difference between the classless subnet mask and the 
#default classful subnet mask returns the number of bits borrowed from the host portion

echo "The CIDR entered borrows ${borrowed_bits} bits"

hostexp=$((len-cidr)) #exponent needed to calculate the number of hosts (y)

# the formula for calculating hte number of hosts is (2^y)-2, where
# y is the number of zeros in the subnet mask (=32-number of ones).

correction=2 
#The formula for calculating the hosts number subtracts 2 because the network ID and the broadcast are to 
#be excluded, in that they can't be assigned to hosts (they're not routable)

echo "the host exponent is ${hostexp}"

networks=$((2**borrowed_bits))

temphosts=$((2**hostexp))

hosts=$((temphosts-correction))

echo "This subnet mask allows to create ${networks} networks and ${hosts} hosts"
 
