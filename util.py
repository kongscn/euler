import numpy as np

def asdigits(s):
    s = ''.join(s.split())
    s = np.array(list(map(int, s)))

def as2darray(s):
    lines = s.splitlines()
    lines = [list(map(int, line.split())) for line in lines]
    return np.array(lines)

