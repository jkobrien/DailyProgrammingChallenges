# Make Strings Equal

**Problem Statement:**  
Given two strings `s` and `t`, consisting of lowercase English letters. You are also given a 2D array `transform[][]`, where each entry `[x, y]` means you are allowed to transform character `x` into character `y` and an array `cost[]`, where `cost[i]` is the cost of transforming `transform[i][0]` into `transform[i][1]`. You can apply any transformation any number of times on either string.

Your task is to find the minimum total cost required to make the strings identical. If it is impossible to make the two strings identical using the available transformations, return `-1`.

**Example 1:**  
Input:  
s = "abcc", t = "bccc"  
transform = [['a', 'b'], ['b', 'c'], ['c', 'a']]  
cost = [2, 1, 4]  
Output: 3

**Example 2:**  
Input:  
s = "az", t = "dc"  
transform = [['a', 'b'], ['b', 'c'], ['c', 'd'], ['a', 'd'], ['z', 'c']]  
cost = [5, 3, 2, 50, 10]  
Output: 20

**Example 3:**  
Input:  
s = "xyz", t = "xzy"  
transform = [['x', 'y'], ['x', 'z']]  
cost = [3, 3]  
Output: -1

**Constraints:**  
- $1 \leq |s| = |t| \leq 10^5$
- $1 \leq \text{transform.size()} = \text{cost.size()} \leq 500$
- $'a' \leq \text{transform}[i][0], \text{transform}[i][1] \leq 'z'$
- $1 \leq \text{cost}[i] \leq 500$
