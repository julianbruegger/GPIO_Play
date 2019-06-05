# Script to Autoplay a Video when GPIO Pin 17 is shorted with Ground. 
# Julian Brügger, 04.06.2019
# ICT-Berufsbildung Zentralschweiz

import RPi.GPIO as GPIO
import os
import sys
from subprocess import Popen

GPIO.setmode(GPIO.BCM)

GPIO.setup(17, GPIO.IN, pull_up_down=GPIO.PUD_UP)

# Path to Movies
movie1 = ("/home/pi/Videos/VIDEO.mp4")

last_state1 = True

input_state1 = True

player = False

while True:
    #Read states of inputs
    input_state1 = GPIO.input(17)
    
    #If GPIO(17) is shorted to Ground
    if input_state1 != last_state1:
        if (player and not input_state1):
            os.system('killall omxplayer.bin')
            omxc = Popen(['omxplayer', '-b', movie1])
            player = True
        elif not input_state1:
            omxc = Popen(['omxplayer', '-b', movie1])
            player = True

        #If omxplayer is running and GIOP(17) is not shorted to Ground
    elif (player and input_state1):
        os.system('killall omxplayer.bin')
        player = False

    #Set last_input states
    last_state1 = input_state1