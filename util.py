import numpy as np

def asdigits(s):
    s = ''.join(s.split())
    s = np.array(list(map(int, s)))
    return s

def asarray(s):
    lines = s.splitlines()
    lines = list(map(int, lines))
    return np.array(lines)
    
def as2darray(s):
    lines = s.splitlines()
    lines = [list(map(int, line.split())) for line in lines]
    return np.array(lines)
    
def asllist(s):
    lines = s.splitlines()
    return [list(map(int, line.split())) for line in lines if line]
