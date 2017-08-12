#!/bin/bash
echo -n "Enter IP address: "
read ip
octet1=$(echo $ip | cut -d "." -f1) 

#stores the first octet in a variable in order to define the default IP address class.
#echo "${octet1}" #optional echo statement for debugging purposes

if [[ $octet -le 127 ]]
then
    string=1  #class A IP address
    #echo "string is $string" #optional echo statement for debugging purposes only     
    
elif [[ $octet1 -le 128 ]] && [[ $octet -le 191 ]]
then
     string=2 #class B IP address
     #echo "string is $string" 
     
elif [[ $octet1 -ge 192 ]] && [[ octet1 -le 223 ]]
then 
     string =3 #class C IP address
     #echo "string is $string"
     
else:
    echo "invalid subnet mask"
fi
    
echo -n "Enter CIDR: "
read cidr
echo -n "Enter total bits for IPv4 address: "
#enter the value32 here (total bits in an IPv4 IP address)

read len

borrowed_bits="$((len-cidr))"

# variable storing the bits borrowed from the host portion

echo "The CIDR entered borrows ${borrowed_bits} bits"
case "$string" in
    "1") echo "Class A IP address" ;;
     "2") echo "Class B IP address" ;;
     "3") echo "Class C IP address" ;;
                                 
esac

correction=2
networks=$((2**borrowed_bits))
hosts="$((networks-correction))"
echo "The supplied subnet mask allows to create ${networks} networks and ${hosts} hosts"
 
