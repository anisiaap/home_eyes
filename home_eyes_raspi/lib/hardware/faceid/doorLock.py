import gpiod
import time

# Constants for the GPIO chip and line numbers
CHIP_NAME = 'gpiochip4'  # This refers to the fourth GPIO chip on the Raspberry Pi
LINE_NUMBER = 18  # This refers to the 18th line (pin) on gpiochip4

def setup():
    """Setup the GPIO line for output"""
    chip = gpiod.Chip(CHIP_NAME)  # Initialize the GPIO chip
    line = chip.get_line(LINE_NUMBER)  # Get the specific GPIO line
    line.request(consumer='example', type=gpiod.LINE_REQ_DIR_OUT)  # Request the line as output
    return line  # Return the configured line

def unlock_door():
    """Activate the relay to unlock the door"""
    line = setup()  # Setup the GPIO line
    line.set_value(0)  # Set the line to low to activate the relay and energize the solenoid

def lock_door():
    """Deactivate the relay to lock the door"""
    line = setup()  # Setup the GPIO line
    line.set_value(1)  # Set the line to high to deactivate the relay and de-energize the solenoid

def release():
    """Release the GPIO line"""
    line = setup()  # Setup the GPIO line
    line.release()  # Release the line
