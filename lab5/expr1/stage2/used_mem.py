import datetime as dt
import matplotlib.pyplot as plt

times = []
with open('time.log') as f:
    times = [dt.datetime.strptime(line.rstrip(), '%I:%M:%S %p') for line in f]

mems = []
with open('mem.log') as f:
    mems = [float(line.rstrip()) for line in f]

mems2 = []
with open('mem2.log') as f:
    mems2 = [float(line.rstrip()) for line in f]

min_size = min(len(mems), len(mems2))
if len(mems) == min_size:
    mems += [0.0 for i in range(len(mems2) - min_size)]
else:
    mems2 += [0.0 for i in range(len(mems) - min_size)]

plt.plot(times, mems, label="Used mem for mem.bash")
plt.plot(times, mems2, label="Used mem for mem2.bash")

plt.gcf().autofmt_xdate()

plt.xlabel('Time')
plt.ylabel('Used mem, %')
plt.legend()

plt.savefig('used_mem.png')
