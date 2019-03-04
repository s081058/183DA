import matplotlib.pyplot as plt
import numpy as np

import random

import math

import copy


nodes=[[1,3],[2,3],[4,4],[1,1]]
node=(9,9)


def closest_node(node, nodes):
    nodes=np.asarray(nodes)
    dist2=np.sum((nodes-node)**2,axis=1)
    return np.argmin(dist2)


print(closest_node(node,nodes))
