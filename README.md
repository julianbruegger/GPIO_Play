# GPIO_Play
In diesem Python Programm wird über einen GPIO pin ein Video gestartet. 
## Zweck
Das Programm ist für den Messestand der ICT-BZ gedacht. An diesem wird es für ein SYstemtechniker Stand Benötigt. 

# Das Script
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
### if, elif, else
I got the information below from [Here](https://www.programiz.com/python-programming/if-elif-else).

The ``` elif ``` is short for else if. It allows us to check for multiple expressions. If the condition for ```if``` is ```False```, it checks the condition of the next elif block and so on.

If all the conditions are ```False```, body of else is executed.

Only one block among the several ```if...elif...else``` blocks is executed according to the condition.

The ```if``` block can have only __one__ ```else``` block. But it can have __multiple__ ```elif``` blocks.