import matplotlib.pyplot as plt

import random

import math

import copy

show_animation = True


class RRT():


    def __init__(self, start, goal, obstacleList,
                 randArea, expandDis=1.0, goalSampleRate=5, maxIter=500):
        self.start = Point(start[0], start[1])
        self.end = Point(goal[0], goal[1])
        self.minrand = randArea[0]
        self.maxrand = randArea[1]
        self.obstacleList = obstacleList



    def GraphGenerator(self, rnd=None):  # pragma: no cover

        plt.clf()
        for (ox, oy, size) in self.obstacleList:
            plt.plot(ox, oy, "sk", ms=30 * size)
        plt.plot(self.start.x, self.start.y, "*r") #start point is a star
        plt.plot(self.end.x, self.end.y, "xr") #goal is x
        plt.axis([0, 50, 0, 75])# our box width and length
        plt.grid(True)


class Point():
    def __init__(self, x, y):
        self.x = x
        self.y = y
        self.parent = None


def main(goalx=45, goaly=70):

    print("start " + __file__)

#list of obstacles [x, y, size]
    obstacleList = [
        (22, 66, 2),
        (14, 66, 2),
        (30, 66, 2),
        (5, 9, 2),
        (45, 9, 2)
    ]  
    rrt = RRT(start=[5,25], goal=[goalx,goaly],
              randArea=[0, 50], obstacleList=obstacleList)
    if show_animation:  # display the graphics
        rrt.GraphGenerator()
        plt.grid(True)
        plt.show()

if __name__ == '__main__':

    main()
