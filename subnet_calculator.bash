#!/bin/bash
echo -n "Enter IP address: "
read ip
octet1=$(echo $ip | cut -d "." -f1) 
#echo "${octet1}"
if [[ $octet -le 127 ]]
then
    string=1
    #echo "string is $string"     
elif [[ $octet1 -le 128 ]] && [[ $octet -le 191 ]]
then
     string=2
     #echo "string is $string"
elif [[ $octet1 -ge 192 ]] && [[ octet1 -le 223 ]]
then 
     string =3
     #echo "string is $string"
else:
    echo "invalid subnet mask"
fi
    
echo -n "Enter CIDR: "
read cidr
echo -n "Enter total bits for IPv4 address: "
read len

borrowed_bits="$((len-cidr))"
echo "The CIDR entered borrows ${borrowed_bits} bits"
case "$string" in
    "1") echo "Class A IP address" ;;
     "2") echo "Class B IP address" ;;
     "3") echo "Class C IP address" ;;
                                 
esac

correction=2
networks=$((2**borrowed_bits))
hosts="$((networks-correction))"
echo "This subnet mask allows to create ${networks} networks and ${hosts} hosts"
 
