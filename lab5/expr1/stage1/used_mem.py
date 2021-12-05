import datetime as dt
import matplotlib.pyplot as plt

times = []
with open('time.log') as f:
    times = [dt.datetime.strptime(line.rstrip(), '%I:%M:%S %p') for line in f]

mems = []
with open('mem.log') as f:
    mems = [float(line.rstrip()) for line in f]

plt.plot(times, mems, label="Used mem for mem.bash")

plt.gcf().autofmt_xdate()

plt.xlabel('Time')
plt.ylabel('Used mem, %')
plt.legend()

plt.savefig('used_mem.png')
