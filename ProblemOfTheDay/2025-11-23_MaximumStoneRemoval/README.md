# Maximum Stone Removal

**Problem Statement:**  
Given a 2D array of non-negative integers `stones[][]` where `stones[i] = [xi, yi]` represents the location of the ith stone on a 2D plane, return the maximum possible number of stones that you can remove.  
A stone can be removed if there is another stone in the same row or column.

**Example:**  
Input: `stones = [[0,0],[0,1],[1,0],[1,2],[2,1],[2,2]]`  
Output: `5`

**Explanation:**  
One way to remove 5 stones is as follows:  
- Remove (0,0) because (0,1) is in the same row.
- Remove (0,1) because (1,1) is in the same column.
- Remove (1,0) because (1,2) is in the same row.
- Remove (1,2) because (2,2) is in the same column.
- Remove (2,2) because (2,1) is in the same row.
Only (2,1) remains.

**Approach:**  
This is a connected components problem. Each group of stones connected by rows or columns forms a component. In each component, you can remove all stones except one.  
So, the answer is:  
$$
\text{Number of stones} - \text{Number of connected components}
$$

We can use DFS or Union-Find to find the number of connected components.

Next: PowerShell solution and tests.
