import datetime as dt
import matplotlib.pyplot as plt

times = []
with open('time.log') as f:
    times = [dt.datetime.strptime(line.rstrip(), '%I:%M:%S %p') for line in f]

rams = []
with open('ram.log') as f:
    rams = [float(line.rstrip()) for line in f]

swaps = []
with open('swap.log') as f:
    swaps = [float(line.rstrip()) for line in f]

plt.plot(times, rams, label="RAM")
plt.plot(times, swaps, label="Swap")

plt.gcf().autofmt_xdate()

plt.xlabel('Time')
plt.ylabel('Free, MB')
plt.legend()

plt.savefig('free_sys.png')
