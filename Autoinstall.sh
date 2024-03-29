echo "This script will Autoinstall the GPIO_Play.py script"
sleep 3

# Install Updates
echo "Installing Updates"
sudo apt-get updates
sudo apt-get upgrades



# Move Script to final Destination
mv ~/GPIO_Play /home/pi/GPIO_Play

sleep 3
# Allocate more memory to the GPU.
echo # Allocates more memory to the GPU.
gpu_mem=128 >> /boot/config.txt

sleep
# Add the Script to the Autostart
sudo echo python /home/pi/GPIO_Play/GPIO_Play.py & >> /etc/rc.local 

# Change Wallpaper
pcmanfm --set-wallpaper /home/pi/GPIO_Play/01_Files/Hintergrundbild_FullHD.png

clear
#Disclaimer
echo The only Thing to do now is to Hide the Taskbar and the Wastebucket.
echo Instructions to how this works are Located in the README.md file.
echo 
sleep 15
echo Do you Noticed this?
echo 
read -p "Press enter to continue"

#Finishing 
clear
echo Everyting is ready now. Your GPIO_Play shript ist succesfully installed. 
echo You ned to Restart this Raspberry. 
sleep 3
echo "Do you wish to reboot now?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sudo reboot; break;;
        No ) break;;

    esac
done
