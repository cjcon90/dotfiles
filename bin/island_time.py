import os
from datetime import datetime as dt

SWAP_HOURS = {6: 'night', 11: 'morning', 18: 'day', 22: 'evening', 24: 'night'}
hour = dt.now().strftime("%H")
url = None
for time in SWAP_HOURS:
    if int(hour) < time:
        url = f"~/Pictures/wallpapers/island/island_{SWAP_HOURS[time]}.png"
        break

os.system(f"DISPLAY=:0.0 feh --bg-fill {url}")
