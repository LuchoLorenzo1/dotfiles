import pandas as pd
import numpy as np
# import math
# from random import randint, random
import matplotlib.pyplot as plt
# from itertools import permutations, combinations
from sys import argv


if __name__ == "__main__":
    if len(argv) == 2:
        FILE = argv[1]
        df = pd.read_csv(argv[1])
        print(df.head())
