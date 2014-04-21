'''
Experiment: playing around with multiprocessing code.
'''

__author__ = "max"


################################################################################
# IMPORTS
################################################################################

# Builtins
import multiprocessing as mp

# 3rd party
import numpy as np

# Ours
import grid_scan

################################################################################
# CONSTANTS
################################################################################

NUM_WORKERS = mp.cpu_count() * 2

################################################################################
# CLASSES
################################################################################


################################################################################
# FUNCTIONS
################################################################################

def worker(i):
	"""Workers run this upon start"""
	print "Worker", i, "!"
		
################################################################################
# MAIN
################################################################################

if __name__ == '__main__':
	"""Spawns workers."""
	print "Starting proram with", NUM_WORKERS, "workers."

	lock = mp.Lock()
	mgr = mp.Manager()
	ns = mgr.Namespace()
	ns.out_arr = np.zeros(81).reshape(9,9)
	print ns.out_arr

	arr = mp.Array(np.ndarray, 2)

	grid = np.arange(81).reshape(9,9)
	seg = float(grid.shape[0]) / NUM_WORKERS
	prev_beg = 0
	prev_end = 0
	jobs = []
	for i in range(NUM_WORKERS):
		# If we've finished, stop.
		if prev_end == grid.shape[0]:
			break

		# Try to get a good chunk of work.
		end = int(round(prev_end + seg)) if i < NUM_WORKERS - 1 \
			else grid.shape[0]

		# If we've gone beyond the end, just stop at the end.
		if end > grid.shape[0]:
			end = grid.shape[0]

		# Set the worker's range; update pass-along val.
		worker_range = range(prev_end, end)
		prev_end = end

		# Create, track, and start the process.
		p = mp.Process(target=grid_scan.scan,
					   args=(grid,worker_range,lock,ns))
		jobs += [p]
		p.start()

	# Wait 'till they're done.
	for j in jobs:
		j.join()

	print "Finished!"
	print ns.out_arr
