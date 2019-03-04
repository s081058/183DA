import matplotlib.pyplot as plt

import random

import math

import copy

nodelist=[[30,33],[22,16],[25,35],[51,66],[62,72]]
obstacleList = [
        (5, 5, 1),
        (3, 6, 2),
        (3, 8, 2),
        (3, 10, 2),
        (7, 5, 2),
        (9, 5, 2)
    ]

def __CollisionCheck(nodelist, obstacleList):
    for[x,y]in nodelist:
        for (ox, oy, size) in obstacleList:
            dx = ox - x
            dy = oy - y

            d = math.sqrt(dx * dx + dy * dy)

            if d <=1.5*(30/2* size):#if it is less than half the diagonal of square
            #I considered a circle with radius of half the diagonal square

                return False  # collisio

    return True  # safe



if  __CollisionCheck(nodelist, obstacleList):
    print("No Collision!!!!!!")
else:
    print("Collision :(((((")
