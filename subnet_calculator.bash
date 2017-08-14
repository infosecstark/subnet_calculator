#!/bin/bash
echo -n "Enter IP address: "
read ip
octet1=$(echo $ip | cut -d "." -f1)
#echo "${octet1}"
if [ $octet1 -gt 0 ] && [ $octet1 -le 126 ]
then 
    def_mask=8        #Class A default subnet mask length is 8
    

#def_mask is a variable storing the default classful subnet mask length for the specific IP class
    
#echo "${def_mask}" # Optional echo statement for debugging purposes
    
elif [ $octet1 -ge 128 ] && [ $octet1 -le 191 ]
then
     def_mask=16      #Class B default subnet mask length is 16

elif [ $octet1 -ge 192 ] && [ $octet1 -le 223 ]
then
     def_mask=24 #Class C default subnet mask length is 24
else
     echo "Reserved IP address" #We don't use classes D and E, so we break here.
     
     exit 1;
fi
 
echo -n "Enter CIDR: " #Enter classless subnet mask length 

read cidr

len=32  # An IPv4 address is 32-bit long

borrowed_bits=$((cidr-def_mask)) 

#The difference between the classless subnet mask length and the default classful subnet
#mask length (i.e. 8 for class A, 16 for class B, 24 for class C) returns the number of bits borrowed from the host portion

echo "The CIDR entered borrows ${borrowed_bits} bits"

hostexp=$((len-cidr)) #Exponent (indicated as y) needed to calculate the number of hosts 

# The formula for calculating the number of hosts is (2^y)-2, where
# y is the number of zeros in the subnet mask (=32-CIDR, where CIDR indicates the number of ones).

correction=2 

#The formula for calculating the hosts number subtracts 2 because the network ID and the broadcast are to 
#be excluded, in that they can't be assigned to hosts (they're not routable).

# echo "The host exponent is ${hostexp}" # Optional echo statement for debugging purposes.

networks=$((2**borrowed_bits))
# The formula for calculating the number of hosts is (2^x)-2, where
# "x" is the number of borrowed bits calculated as shown above.

temphosts=$((2**hostexp))

hosts=$((temphosts-correction))

echo "This subnet mask allows to create ${networks} networks and ${hosts} hosts"
 
