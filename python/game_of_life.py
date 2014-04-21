'''
Conway's Game of Life.
'''

__author__ = "max"

import numpy as np

class GameOfLife:
	def __init__(self, size=9):
		board = np.zeros(size**2)
		board.shape = (size, size)

		self.board = board
		self.size = size

	def get_neighbors(self, cell):


# Tests
def test_get_neighbors():
	game = GameOfLife(9)

	board.shape = (SIZE,SIZE)
	print board	

# Main
if __name__ == "__main__":
	board = np.zeros(SIZE**2)
	board.shape = (SIZE,SIZE)
	print board
	assert 0
	print board