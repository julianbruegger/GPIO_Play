# GPIO_Play
In diesem Python Programm wird über einen GPIO pin ein Video gestartet. 
## Zweck
Das Programm ist für den Messestand der ICT-BZ gedacht. An diesem wird es für ein SYstemtechniker Stand benötigt. 
Das Script soll ein Video starten, wenn ein Schaltkreis geschlossen wurde. 

Weiter wurde der Raspberry-Pi angepasst damit das Script problemlos durchläuft. 


# Das Script
```python
import RPi.GPIO as GPIO
import os
import sys
from subprocess import Popen

GPIO.setmode(GPIO.BCM)

GPIO.setup(17, GPIO.IN, pull_up_down=GPIO.PUD_UP)

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

        #If omxplayer is running and GIOP(17)is not shorted to Ground
    elif (player and input_state1):
        os.system('killall omxplayer.bin')
        player = False

    #Set last_input states
    last_state1 = input_state1
```

## Import
```python
import RPi.GPIO as GPIO
```
Über diesen Befehl wird die Library "RPi.GPIO" als GPIO importiert. 
## Setmode
```python
GPIO.setmode(GPIO.BCM)
```
I got the information below from [Here](https://raspberrypi.stackexchange.com/questions/12966/what-is-the-difference-between-board-and-bcm-for-gpio-pin-numbering).

The GPIO.BOARD option specifies that you are referring to the pins by the number of the pin the the plug - i.e the numbers printed on the board (e.g. P1) and in the middle of the diagrams below.

The GPIO.BCM option means that you are referring to the pins by the "Broadcom SOC channel" number, these are the numbers after "GPIO" in the green rectangles around the outside of the below diagrams:

Unfortunately the BCM numbers changed between versions of the Pi1 Model B, and you'll need to work out which one you have guide here. So it may be safer to use the BOARD numbers if you are going to use more than one Raspberry Pi in a project.

- The Model B+ uses the same numbering as the Model B r2.0, and adds new pins (board numbers 27-40).
- The Raspberry Pi Zero, Pi 2B and Pi 3B use the same numbering as the B+.

![alt text][GPIO_Pins]

[GPIO_Pins]: https://hackster.imgix.net/uploads/attachments/218603/6sQiFTKXhZptFiGnPlsc.png "GPIO_Pins_Raspberry Pi3"
## Movie destination
```python
movie1 = ("/home/pi/Videos/TEST_VIDEO.mp4")
movie2 = ("Your/Path/To/Video.mp4")
```
## States

## Code
Wenn GPIO 17 mit Ground verbunden ist, wird ein Video gestartet.
```python
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
```
Falls der OMX-Player läuft und GPIO 17 nicht mit Ground Verbunden ist, wird der OMX-Player gestopt. 
```python
        #If omxplayer is running and GIOP(17) is not shorted to Ground
    elif (player and input_state1):
        os.system('killall omxplayer.bin')
        player = False

    #Set last_input states
    last_state1 = input_state1
```

## if, elif, else
I got the information below from [Here](https://www.programiz.com/python-programming/if-elif-else).

The ``` elif ``` is short for else if. It allows us to check for multiple expressions. If the condition for ```if``` is ```False```, it checks the condition of the next elif block and so on.
If all the conditions are ```False```, body of else is executed.
Only one block among the several ```if...elif...else``` blocks is executed according to the condition.

The ```if``` block can have only __one__ ```else``` block. But it can have __multiple__ ```elif``` blocks.

___
---

# Raspberry-Pi Setup
Folgendes wird gemacht:
- Taskleiste verstecken
- _"Wastebin"_ entfernen 
- ICT-BZ Wallpaper setzen
- Kein screensaver
- Script abspeichern
- Autostart

## Taskleiste Verstecken
Die Taskleiste wird wie folgt angepasst. 

1. Recktsklick auf die Taskbar.
2. _Leisten-Einstellungen_ öffnen
3. Auf den Tab _Erweitert_ wechseln
4. Leiste bei Nichtbenutzung  minimieren auswählen. [x]
5. Grösse im minimierten zustand = _0 Pixel_

## _"Wastebin"_ entfernen 
Wastebin egl. für Abfallkübel.
1. Rechtsklick auf Desktop
2. _"Desktop Einsellungen"_ öffen
3. Zu unterst alle haken abwählen [ ]
4. Mit _"OK"_ bestätigen
## ICT-BZ Wallpaper setzen
Das ICT-BZ Standartwallpaper wird gesetzt. 
Das Wallpaper finded sich unter: ```~/01/Hintergrundbild_FullHD.png ```

Das Wallpaper wird wie folgt gesetzt:

1. Rechtsklick auf Desktop
2. _"Desktop Einsellungen"_ öffen
3. Unter _"Picture"_ kann dann das Hintergrundsbild gewählt werden. 
## Script abspeichern
Das Script wird im verzeichnis ```/home/pi/GPIO_Play``` abgelegt.
## Mehr speicher für die GPU
Wenn das Script standartmässig gestartet wird, kann es sein das ein ``` COMXAudio::Decode timeout``` fehler passiert. 

Dies sieht dann wie folgt aus:
```  COMXAudio::Decode timeout  
 COMXAudio::Decode timeout  
 COMXAudio::Decode timeout  
 COMXAudio::Decode timeout 
 ```

Um desen Fehler zu beheben muss der GPU einfach mehr speicher zugewiesen werden. Dafür muss die Datei ``` /boot/config.txt``` angepasst werden. 

Dies ist mit folgendem Befehl möglich: 
```
sudo nano /boot/config.txt
```
Am ende der Datei ```config.txt``` müssen noch folgende Zeilen eingefügt werden. 

``` 
# Allocates more memory to the GPU.
gpu_mem=128
``` 
## Autostart
Der Script wird im Autostart hinterlegt. Somit wird der Script automatisch gestartet. 
Im Ordner ```/etc/rc.local ``` wird folgender befehl Hinterlegt:
```sh
# Autostart the GPIO_Play.py file
sudo echo python /home/pi/GPIO_Play/GPIO_Play_Master/GPIO_Play.py &
```
