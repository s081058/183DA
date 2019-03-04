import matplotlib.pyplot as plt

import random

import math

import copy



show_animation = True





class RRT():


    def __init__(self, start, goal, obstacleList,

                 randArea, expandDis=1.0, goalSampleRate=5, maxIter=500):

        self.start = Node(start[0], start[1])

        self.end = Node(goal[0], goal[1])

        self.minrand = randArea[0]

        self.maxrand = randArea[1]

        self.expandDis = expandDis

        self.goalSampleRate = goalSampleRate

        self.maxIter = maxIter

        self.obstacleList = obstacleList



    def DrawGraph(self, rnd=None):  # pragma: no cover

        plt.clf()
        
        if rnd is not None:

            plt.plot(rnd[0], rnd[1], "^k")
        for node in self.nodeList:

            if node.parent is not None:

                plt.plot([node.x, self.nodeList[node.parent].x], [

                         node.y, self.nodeList[node.parent].y], "-g")

        for (ox, oy, size) in self.obstacleList:

            plt.plot(ox, oy, "sk", ms=30 * size)

        plt.plot(self.start.x, self.start.y, "*r")

        plt.plot(self.end.x, self.end.y, "xr")

        plt.axis([0, 50, 0, 75])

        plt.grid(True)
        plt.pause(0.01)

    def GetNearestListIndex(self, nodeList, rnd):

        dlist = [(node.x - rnd[0]) ** 2 + (node.y - rnd[1])

                 ** 2 for node in nodeList]

        minind = dlist.index(min(dlist))

        return minind

    
    def Planning(self, animation=True):
        self.nodeList = [self.start]
        while True:
            if random.randint(0, 100) > self.goalSampleRate:
                rnd = [random.uniform(self.minrand, self.maxrand), random.uniform(self.minrand, self.maxrand)]
            else:
                rnd = [self.end.x, self.end.y]
            nind = self.GetNearestListIndex(self.nodeList, rnd)
            nearestNode = self.nodeList[nind]
            theta = math.atan2(rnd[1] - nearestNode.y, rnd[0] - nearestNode.x)
            newNode = copy.deepcopy(nearestNode)
            newNode.x += self.expandDis * math.cos(theta)
            newNode.y += self.expandDis * math.sin(theta)
            newNode.parent = nind
            if not self.__CollisionCheck(newNode, self.obstacleList):
                continue
            self.nodeList.append(newNode)
            print("nNodelist:", len(self.nodeList))
            dx = newNode.x - self.end.x
            dy = newNode.y - self.end.y
            d = math.sqrt(dx * dx + dy * dy)
            if d <= self.expandDis:
                print("Goal!!")
                break
            if animation:
                self.DrawGraph(rnd)
        path = [[self.end.x, self.end.y]]
        lastIndex = len(self.nodeList) - 1
        while self.nodeList[lastIndex].parent is not None:
            node = self.nodeList[lastIndex]
            path.append([node.x, node.y])
            lastIndex = node.parent
        path.append([self.start.x, self.start.y])
        return path


    def __CollisionCheck(self, node, obstacleList):
        for (ox, oy, size) in obstacleList:
            dx = ox - node.x
            dy = oy - node.y
            d = math.sqrt(dx * dx + dy * dy)
            if d <= (2*size):
                return False  # collision
        return True  # safe


class Node():

    def __init__(self, x, y):

        self.x = x

        self.y = y

        self.parent = None



def main(goalx=45,goaly=70):

    print("start " + __file__)

    # ====Search Path with RRT====

    obstacleList = [

        (22, 66, 2),

        (14, 66, 2),

        (30, 66, 2),

        (5, 9, 2),

        (45, 9, 2)


    ]  # [x,y,size]

    # Set Initial parameters
    rrt = RRT(start=[5,25], goal=[goalx,goaly],

              randArea=[0, 50], obstacleList=obstacleList)
    path = rrt.Planning(animation=show_animation)

    # Draw final path

    if show_animation:  # pragma: no cove
        rrt.DrawGraph()
        plt.grid(True)
        plt.plot([x for (x, y) in path], [y for (x, y) in path], '-r')#plots the trajectory
        plt.show()

if __name__ == '__main__':

    main()







    
