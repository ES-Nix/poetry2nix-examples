
def cubic_function(x, a=1, b=0, c=0, d=0):
    """
    https://en.wikipedia.org/wiki/Cubic_function
    :return: the result of a cubic function
    """
    return a*x**3 + b*x**2 + c*x + d


def main():
    print(list(map(cubic_function, range(20))))


if __name__ == '__main__':
    main()
