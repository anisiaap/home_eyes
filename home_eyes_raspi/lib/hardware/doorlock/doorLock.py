import gpiod
import time

# Constants for the GPIO chip and line numbers
CHIP_NAME = 'gpiochip4'
LINE_NUMBER = 18  # Corresponds to GPIO 18

def setup():
    chip = gpiod.Chip(CHIP_NAME)
    line = chip.get_line(LINE_NUMBER)
    line.request(consumer='example', type=gpiod.LINE_REQ_DIR_OUT)
    return line



def unlock_door(line):
    """Turn on the solenoid to unlock"""
    line = setup()
    line.set_value(0)
    #line.release()
    

def lock_door(line):
    """Turn off the solenoid to lock"""
    line = setup()
    line.set_value(1)
    #line.release()