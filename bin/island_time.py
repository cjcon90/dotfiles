import os
from datetime import datetime as dt

SWAP_HOURS = {0: 'night', 8: 'morning', 12: 'day', 18: 'evening', 22: 'night'}
now = dt.now().strftime("%H")
url = None
for hour in SWAP_HOURS:
    if int(now) >= hour:
        url = f"~/Pictures/wallpapers/island/island_{SWAP_HOURS[hour]}.png"


# os.system(f"DISPLAY=:0.0 feh --bg-fill {url} && betterlockscreen -u {url}")
os.system(f"DISPLAY=:0.0 feh --bg-fill {url}")

os.system(f"betterlockscreen -u {url}")

