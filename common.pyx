import math
import random
from collections import defaultdict
from functools import reduce

from bitarray import bitarray
from scipy.special import lambertw

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
    if n < 2: return False
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

def primefactorize(long long number):
    cdef long divider
    divider = 2
    factors = defaultdict(int)
    while number > 1:
        if number % divider == 0:
            number /= divider
            factors[divider] += 1
        else:
            divider += 1
    return factors

def primes(long n):
    cdef long x, y
    if n <= 2:
        return []
    sieve = [True] * (n+1)
    for x in range(3, int(n**0.5)+1, 2):
        for y in range(3, (n//x)+1, 2):
            sieve[(x*y)]=False

    return [2]+[i for i in range(3, n, 2) if sieve[i]]

def nprimes(long n):
    upper = int((-n*lambertw(-1/n, -1)).real)
    p = primes(upper)
    return p[:n]

def nthprime(n):
    upper = int((-n*lambertw(-1/n, -1)).real)
    p = primes(upper)
    return p[n-1]
