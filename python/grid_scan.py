import time
import numpy as np

def scan(grid, my_range, lock, ns):
	print "w range:", my_range
	my_res = []
	for i in my_range:
		my_res += [grid[i] * 2]

	my_res = np.array(my_res).reshape(len(my_range), 9)
	print my_res

	with lock:
		for idx, i in enumerate(my_range):
			print idx, i
			ns.out_arr[i] = my_res[idx]

	time.sleep(1)