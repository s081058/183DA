import random
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import math
import pylab

def initpoli3(s):
    h = 0
    a = "standby"
    goal = [4, 4, h]
    xerror = goal[1] - s[1]
    yerror = goal[2] - s[2]
    angled = ((np.arctan(yerror, xerror)) * 360) / (2 * math.pi)
    hangle = 90 - s(3) * 30
    herror = (angled - hangle)% 360
    if (abs(xerror) + abs(yerror)) == 0:
        a = "standby"
    elif herror <= 90 or herror >= 270:
        s = nexts(0, s, "forward")
        xerror = goal[1] - s[1]
        yerror = goal[2] - s[2]
        angled =((np.arctan(yerror, xerror)) * 360) / (2 * math.pi)
        hangle = 90 - s[3] * 30
        herror = (angled - hangle) % 360
        if ((herror <= 15) or (herror >= 345)) or ((herror >= 165) and (herror <= 195)):
            a = "forward"
        elif((herror > 15) and (herror <= 90)) or ((herror > 195) and (herror < 270)):
            a = "leftforward"
        elif((herror >= 270) and (herror < 345)) or ((herror > 90) and (herror < 165)):
            a = "rightforward"
    else:
        s = nexts(0, s, "backward")
        xerror = goal[1] - s[1]
        yerror = goal[2] - s[2]
        angled = ((np.arctan(yerror, xerror)) * 360) / (2 * math.pi)
        hangle = 90 - s[3] * 30
        herror = mod(angled - hangle, 360)
        if ((herror <= 15) or (herror >= 345)) or ((herror >= 165) and (herror <= 195)):
            a = "backward"
        elif((herror > 15) and (herror <= 90)) or ((herror > 195) and (herror < 270)):
            a = "leftbackward"
        elif((herror >= 270) and (herror < 345)) or ((herror > 90) and (herror < 165)):
            a = "rightbackward"
    return a


def nexts(pe, s, a):
    sprime = s
    b = random.random()
    for i in range(6):
        for j in range(6):
            for k in range(6):
                b = b - problem2_1c(pe, s, a, [i, j, k])
                if b <= 0:
                    sprime = [i, j, k]
                    b = b + 100
    return sprime


def problem2_1c(pe, s, a, sp):
    psa = 0
    x = s[1]
    y = s[2]
    h = s[3]
    update = np.zeros(3)
    update[1,:]= x
    update[2,:]= y
    update[3,:]= h
    p = [0, 0, 0]
    if a == "standby":
        update[3,:]=[(h% 12), 0, 0]
        p = [1, 0, 0]
    if (a == "leftforward") or (a == "leftbackward"):
        update[3,:]=[(h - 1% 12), (h% 12), ((h - 2)% 12)]
        p = [1 - 2 * pe, pe, pe]
    elif(a == "rightforward") or (a == "rightbackward"):
        update[3,:]=[(h + 1 % 12), ((h + 2)% 12), (h % 12)]
        p = [1 - 2 * pe, pe, pe]
    elif(a == "forward") or (a == "backward"):
        update[3,:]=[(h % 12), ((h + 1) % 12), ((h - 1)% 12)]
        p = [1 - 2 * pe, pe, pe]
    if (a == "forward") or (a == "leftforward") or (a == "rightforward"):
        if h == 0:
            update[1,:] = [x, x, x]
            update[2,:]=[y + 1, y + 1, y + 1]
        elif h == 1:
            update[1,:]=[x, x + 1, x]
            update[2,:]=[y + 1, y, y + 1]
        elif h == 2:
            update[1,:]=[x + 1, x + 1, x]
            update[2,:]=[y, y, y + 1]
        elif h == 3:
            update[1,:]=[x + 1, x + 1, x + 1]
            update[2,:]=[y, y, y]
        elif h == 4:
            update[1,:]=[x + 1, x, x + 1]
            update[2,:]=[y, y - 1, y]
        elif h == 5:
            update[1,:]=[x, x, x + 1]
            update[2,:]=[y - 1, y - 1, y]
        elif h == 6:
            update[1,:]=[x, x, x]
            update[2,:]=[y - 1, y - 1, y - 1]
        elif h ==7:
            update[1,:]=[x, x - 1, x]
            update[2,:]=[y - 1, y, y - 1]
        elif h == 8:
            update[1,:]=[x - 1, x - 1, x]
            update[2,:]=[y, y, y - 1]
        elif h ==9:
            update[1,:]=[x - 1, x - 1, x - 1]
            update[2,:]=[y, y, y]
        elif h ==10:
            update[1,:]=[x - 1, x, x - 1]
            update[2,:]=[y, y + 1, y]
        elif h == 11:
            update[1,:]=[x, x, x - 1]
            update[2,:]=[y + 1, y + 1, y]
    elif(a == "backward") or (a == "leftbackward") or (a == "rightbackward"):
        if h == 0:
            update[1,:]=[x, x, x]
            update[2,:]=[y - 1, y - 1, y - 1]
        elif h == 1:
            update[1,:]=[x, x - 1, x]
            update[2,:]=[y - 1, y, y - 1]
        elif h == 2:
            update[1,:]=[x - 1, x - 1, x]
            update[2,:]=[y, y, y - 1]
        elif h == 3:
            update[1,:]=[x - 1, x - 1, x - 1]
            update[2,:]=[y, y, y]
        elif h == 4:
            update[1,:]=[x - 1, x, x - 1]
            update[2,:]=[y, y + 1, y]
        elif h ==5:
            update[1,:]=[x, x, x - 1]
            update[2,:]=[y + 1, y + 1, y]
        elif h == 6:
            update[1,:]=[x, x, x]
            update[2,:]=[y + 1, y + 1, y + 1]
        elif h == 7:
            update[1,:]=[x, x + 1, x]
            update[2,:]=[y + 1, y, y + 1]
        elif h == 8:
            update[1,:]=[x + 1, x + 1, x]
            update[2,:]=[y, y, y + 1]
        elif h == 9:
            update[1,:]=[x + 1, x + 1, x + 1]
            update[2,:]=[y, y, y]
        elif h == 10:
            update[1,:]=[x + 1, x, x + 1]
            update[2,:]=[y, y - 1, y]
        elif h == 11:
            update[1,:]=[x, x, x + 1]
            update[2,:]=[y - 1, y - 1, y]
    update[1,:]=update[1,:]+(update[1,:] < 0)-(update[1,:] > 5)
    update[2,:]=update[2,:]+(update[2,:] < 0)-(update[2,:] > 5)
    if sp[1] == update[1, 1] and sp[2] == update[2, 1] and sp[3] == update[3, 1]:
        psa= psa + p[1]
    if sp[1] == update[1, 2] and sp[2] == update[2, 2] and sp[3] == update[3, 2]:
        psa = psa + p[2]
    if sp[1] == update[1, 3] and sp[2] == update[2, 3] and sp[3] == update[3, 3]:
        psa = psa + p[3]
    return psa

def problem2_1d(pe, s, a):
    sprime = s
    temp = random.random()
    for x in range(6):
        for y in range(6):
            for h in range(12):
                temp = temp - problem2_1c(pe, s, a, [x, y, h])
                if temp <= 0:
                    sprime = [x, y, h]
                    temp = temp + 100
    return sprime


def problem2_2a(s):
    if s[1] == 0 or s[1] == 5 or s[2] == 0 or s[2] == 5:
        reward = -100
    elif s[1] == 3 and (s[2] == 3 or s[2] == 4):
        reward = -10
    elif s[1] == 4 and s[2] == 4:
        reward = 1
    elif s[1] == 1 or s[2] == 1:
        reward = 0
    else:
        reward = 0
    return reward


def problem2_3a(s):
    target = [4, 4, 0]
    xerr = target[1] - s[1]
    yerr = target[2] - s[2]
    a ="standby"
    angle = ((np.arctan(yerror, xerror)) * 360) / (2 * math.pi)
    high = 90 - s(3) * 30
    herr = (angle - high)% 360
    if abs(xerr) + abs(yerr) == 0:
        a = "standby"
    elif herr <= 90 or herr >= 270:
        s = Problem2_1d(0, s, "forward")
        xerr = target[1] - s[1]
        yerr = target[2] - s[2]
        angle = ((np.arctan(yerror, xerror)) * 360) / (2 * math.pi)
        high = 90 - s[3] * 30
        herr = (angle - high) % 360
        if ((herr <= 15) or (herr >= 345)) or ((herr >= 165) and (herr <= 195)):
            a = "forward"
        elif((herr > 15) and (herr <= 90)) or ((herr > 195) and (herr < 270)):
            a = "leftforward"
        elif((herr >= 270) and (herr < 345)) or ((herr > 90) and (herr < 165)):
            a = "rightforward"
    else:
        s = problem2_1d(0, s, "backward")
        xerr = target[1] - s[1]
        yerr = target[2] - s[2]
        angle = ((np.arctan(yerror, xerror)) * 360) / (2 * math.pi)
        high = 90 - s[3] * 30
        herr = (angle - high) % 360
        if ((herr <= 15) or (herr >= 345)) or ((herr >= 165) and (herr <= 195)):
            a = "backward"
        elif((herr > 15) and (herr <= 90)) or ((herr > 195) and (herr < 270)):
            a = "leftbackward"
        elif((herr >= 270) and (herr < 345)) or ((herr > 90) and (herr < 165)):
            a = "rightbackward"
    return a


def problem2_3d(pi, lamb, pe):
    v = np.zeros((6, 6, 12))
    v1 = v + 1
    while ne(np.sum(np.sum(np.sum(abs((v1 - v)) < 0.0001))),432):
        v1 = v
        v = np.zeros((6, 6, 12))
        for x in range(6):
            for y in range(6):
                for h in range(12):
                    for x1 in range(6):
                        for y1 in range(6):
                            for h1 in range(12):
                                v[x + 1, y + 1, h + 1] = v[x + 1, y + 1, h + 1] + transprobb(pe, [x, y, h], pi[x + 1, y + 1, h + 1],[x1, y1, h1]) * (
                                         problem2_2a([x, y, h]) + lamb * v1[x1 + 1, y1 + 1, h1 + 1])
    return v

def problem2_3f(current, pe):
    piv = np.zeros((6, 6, 12))
    piv = piv - 10 ^ 100
    for x in range(6):
        for y in range(6):
            for h in range(12):
                a=["leftforward", "forward", "rightforward", "leftbackward", "backward", "righbackward"]
                for d in range(len(a)):
                    temp = 0
                    for x1 in range(6):
                        for y1 in range(6):
                            for h1 in range(12):
                                temp = temp + problem2_1c(pe, [x, y, h], a, [x1, y1, h]) * current[x1 + 1, y1 + 1, h + 1]
                    if piv[x + 1, y + 1, h + 1] < temp:
                        piv[x + 1, y + 1, h + 1] = temp
                        pi[x + 1, y + 1, h + 1] = a
    pi[4, 5,:]="standby"
    return pi

def problem2_3g(pinot, lamb, pe):
    pi = pinot
    loop = True
    while loop:
        currenteval = problem2_3d(pi, lamb, pe)
        piupdate = problem2_3f(currenteval, pe)
        if np.sum(np.sum(np.sum(piupdate == pi))) == 432:
            loop = False
        pi = piupdate
    pioptimal = pi
    return pioptimal

def problem2_4a(lamb, pe):
    tempv = np.zeros((6, 6, 12))
    check = True
    pistar = strings(6, 6, 12)
    while check:
        policy = strings(6, 6, 12)
        for x in range(6):
            for y in range(6):
                for h in range(6):
                    c = -10 ^ 100
                    a=["leftforward", "forward", "rightforward", "leftbackward", "backward", "righbackward"]
                    for d in range(len(a)):
                        b = 0
                        for x1 in range(6):
                            for y1 in range(6):
                                for h1 in range(12):
                                    b = b + problem2_1c(pe, [x, y, h], a, [x1, y1, h1]) * (problem2_2a([x, y, h]) + lamb * tempv[x1 + 1, y1 + 1, h1 + 1])
                        if b > c:
                            c = b
                            vupdate[x + 1, y + 1, h + 1] = c
                            Policy[x + 1, y + 1, h + 1] = a
                        if np.sum([x, y] == [4, 4]) == 2:
                            vupdate[x + 1, y + 1, h + 1] = problem2_1c(pe, [x, y, h], "N", [x, y, h]) * (problem2_2a([x, y, h]) + lamb * tempv[x + 1, y + 1, h + 1])
                            policy[x + 1, y + 1, h + 1] = "N"
        if np.sum(np.sum(np.sum(abs(tempv - vupdate) < 0.0001))) == 432:
            check = False
            pistar = policy
            vstar = vupdate
        tempv = vupdate
    return pistar, vstar