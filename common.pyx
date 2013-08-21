import math
import random
from functools import reduce

from bitarray import bitarray

def gcd(a, b):
    """Return greatest common divisor using Euclid's Algorithm."""
    while b:      
        a, b = b, a % b
    return a

def _lcm(a, b):
    """Return lowest common multiple."""
    return a * b // gcd(a, b)

def lcm(*args):
    """Return lcm of args."""   
    return reduce(_lcm, args)

def pseudo_prime(n, a=2):
    return a**(n-1)%n == 1

def isPrime(n):
    if n < 2: raise ValueError
    if n == 2: return True
    if n == 3: return True
    for i in range(3, int(math.sqrt(n))+1, 2):
        if n % i == 0:
            return False
    return True

def modular_exponentiation(a, b, n):
    c = 0
    d = 1
    b = bitarray(bin(b)[2:])
    for bit in b:
        c *= 2
        d = d * d % n
        if bit:
            c += 1
            d = d * a % n
    return d


def witness(a, n):
    # find t, u 
    t = 0
    u = n-1
    while not (u & 1):
        t += 1
        u = u >> 1
    x0 = modular_exponentiation(a, u, n)
    for i in range(1, t+1):
        x1 = x0 * x0 % n
        if x1 == 1 and x0 != 1 and x0 != n-1:
            return True
        x0 = x1
    if x1 != 1:
        return True
    return False

def miller_rabin(n, s):
    if n % 2 == 0:
        return False
    for j in range(s):
        a = random.randint(1, n-1)
        if witness(a, n):
            return False
    return True
