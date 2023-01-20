import pyautogui
import time

for i in range(100):
    pyautogui.scroll(10000)
    pyautogui.click(x=1050, y=190,button='left')
    time.sleep(0.4)
