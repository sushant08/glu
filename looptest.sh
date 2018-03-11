#!/bin/bash

############################################################
# Description: Shell script to automate PNS upscale task.  #
# Author: Sushant Singh                                    #   
# Version: 0.1                                             #
# Date: 10-Mar-2018					   #
############################################################

ARR1=()
ARR2=()
counter=0

read -p "How many ASG you want to enter: " REQ

if ! [ "$REQ"  -eq "$REQ" ] 2> /dev/null
then
   echo "Please enter interger only"
   exit 1
fi



#loop for taking input

for (( N=0; N<${REQ}; N++))
do	
	read -p "Enter ASG name: " ARR1[N]
	read -p "Enter desired state of above ASG: " ARR2[N]
	counter=$((counter + 1))

done

#checking if counter is right

echo "Value of counter is ${counter}"

#displaying changes to be done.

echo "You are making below changes:"

for ((P=0; P<${counter}; P++))
do
  echo "
  Auto scale group: ${ARR1[$P]} 
  Desired number: ${ARR2[$P]}"
done

#requesting affirmation to continue

read -p "Press enter to Y to continue or E to exit: " opt
echo

#making change using awscli command.

if [[ $opt == [Yy] ]]
then

   echo "Making change. Please wait for some time"
   echo

   for (( M=0; M<${counter}; M++))
   do	
#     aws ec2 create-security-group --group-name "${ARR1[$M]}"  --description "${ARR2[$M]}" 
      aws autoscaling set-desired-capacity --auto-scaling-group-name ${ARR1[$M]} --desired-capacity ${ARR2[$M]} --honor-cooldown
   done

else
     echo "We are exiting without change"
     exit 1
fi


