'''
@author     Maxwell Forbes
@class      CSE 312 AC
@date       January 20,  2011
@assignment HW2

This short program includes a function that calculates combinations fairly
efficiently (for example, 20 choose 3 is computed 20 * 19 * 18 / 3 * 2 * 1)
and uses this to calculate a generalized version of the "birthday problem",
which is the probability of no colissions given continuous random selection of
a certain number of "buckets".

The values for the assignment are
    b = 10000 buckets
    n = [115, 125]
though these variables may be adjusted as desired.
'''

import math;

# Computes the combination n choose r
def comb(n, r):
    if (r < 0 or r > n):
        return 0
    top = 1;
    bottom = 1;
    for i in range(r):
        top *= n-i
        bottom *= i+1
    return top//bottom

# Experiment parameters can be adjusted
b = 10000
start_n = 115
stop_n = 125

# The probability calculation follows
print('Probability of no collissions for n distinct names hashed ' +
      'randomly into b=%d buckets, using the range of n values ' % b +
      '%d to %d.' % (start_n, stop_n))
print('\nn \t probability')
print('- \t -----------')

prev_n_fact = math.factorial(start_n - 1)
prev_bucket_power = b**(start_n - 1)
for i in range(start_n, stop_n + 1):
    cur_n_fact = prev_n_fact*i
    combination = comb(b, i)
    cur_bucket_power = prev_bucket_power*b
    prob = (cur_n_fact*combination)/cur_bucket_power
    # prints to 9 decimal places, arbitrary, can increase or decrease
    print('%d \t %.9f' % (i, prob))

    prev_n_fact = cur_n_fact
    prev_bucket_power = cur_bucket_power
