from functools import reduce

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