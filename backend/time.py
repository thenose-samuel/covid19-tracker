import pytz
from datetime import datetime

def time():
	IST = pytz.timezone('Asia/Kolkata')
	datetime_ist = datetime.now(IST)
	time = datetime_ist.strftime('%Y:%m:%d %H:%M:%S %Z')
	t = open('time.txt','w')
	t.write(time)
	t.close()
	return(time)
