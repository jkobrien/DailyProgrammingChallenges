# Remove BST Keys Outside Given Range

**Date:** October 16, 2025  
**Difficulty:** Medium  
**Source:** GeeksforGeeks Problem of the Day  
**Company Tags:** Microsoft, Samsung  
**Topic Tags:** Binary Search Tree, Data Structures  

## Problem Description

Given the **root** of a Binary Search Tree (BST) and two integers **l** and **r**, remove all the nodes whose values lie outside the range [l, r].

**Note:** The modified tree should also be BST and the sequence of the remaining nodes should not be changed.

## Examples

### Example 1
```
Input: root = [6, -13, 14, N, -8, 13, 15, N, N, 7], l = -10, r = 13
Output: [6, -8, 13, N, N, 7]

Original Tree:          Modified Tree:
      6                       6
    /   \                   /   \
  -13    14               -8    13
    \   /  \                \
    -8 13  15                7
      \
       7

Explanation: All nodes outside [-10, 13] are removed: -13 (< -10), 14 (> 13), 15 (> 13)
```

### Example 2
```
Input: root = [14, 4, 16, 2, 8, 15, N, -8, 3, 7, 10], l = 2, r = 6
Output: [4, 2, N, N, 3]

Original Tree:          Modified Tree:
      14                     4
    /    \                 /
   4      16              2
  / \    /                 \
 2   8  15                  3
-8 3 7 10

Explanation: All nodes outside [2, 6] are removed: 14, 16, 8, 15, -8, 7, 10
```

## Algorithm Explanation

The solution uses a recursive approach that leverages the BST property:

### Key Insights
1. **BST Property**: In a BST, all nodes in the left subtree are smaller than the root, and all nodes in the right subtree are larger than the root.
2. **Pruning Strategy**: If a node's value is outside the range, we can eliminate entire subtrees.

### Algorithm Steps
1. **Base Case**: If the current node is null, return null.
2. **Node < l**: If the current node's value is less than `l`, then all nodes in its left subtree are also less than `l`. We can ignore the left subtree and only process the right subtree.
3. **Node > r**: If the current node's value is greater than `r`, then all nodes in its right subtree are also greater than `r`. We can ignore the right subtree and only process the left subtree.
4. **Node in Range**: If the current node's value is within [l, r], recursively process both left and right subtrees.

### Pseudocode
```
function removeBSTKeysOutsideRange(root, l, r):
    if root == null:
        return null
    
    if root.data < l:
        return removeBSTKeysOutsideRange(root.right, l, r)
    
    if root.data > r:
        return removeBSTKeysOutsideRange(root.left, l, r)
    
    root.left = removeBSTKeysOutsideRange(root.left, l, r)
    root.right = removeBSTKeysOutsideRange(root.right, l, r)
    
    return root
```

## Complexity Analysis

- **Time Complexity**: O(n), where n is the number of nodes in the BST. In the worst case, we might visit all nodes.
- **Space Complexity**: O(n) due to the recursive call stack. In the worst case (skewed tree), the recursion depth can be n.

## PowerShell Implementation Features

The PowerShell solution includes:

1. **TreeNode Class**: A custom class to represent BST nodes
2. **Helper Functions**:
   - `New-TreeNode`: Creates a new tree node
   - `Print-InOrder`: Prints the tree in in-order traversal
   - `Get-InOrderTraversal`: Returns an array of in-order values
   - `Build-BST-From-Array`: Constructs a BST from level-order array representation
3. **Main Algorithm**: `Remove-BSTKeysOutsideRange` function
4. **Test Cases**: Includes the provided examples plus additional test cases

## Usage

### Running the Script
```powershell
# Navigate to the directory
cd "ProblemOfTheDay\2025-10-16_RemoveBSTKeysOutsideRange"

# Run the main script
.\remove_bst_keys_outside_range.ps1

# Or run tests
.\test_remove_bst_keys_outside_range.ps1
```

### Using the Function Programmatically
```powershell
# Source the script
. .\remove_bst_keys_outside_range.ps1

# Create a BST
$root = New-TreeNode 10
$root.left = New-TreeNode 5
$root.right = New-TreeNode 15
$root.left.left = New-TreeNode 3
$root.left.right = New-TreeNode 7

# Remove nodes outside range [4, 12]
$result = Remove-BSTKeysOutsideRange $root 4 12

# Print the result
Print-InOrder $result
```

## Edge Cases Handled

1. **Empty Tree**: Returns null
2. **Single Node**: 
   - If in range, returns the node
   - If outside range, returns null
3. **All Nodes Outside Range**: Returns null
4. **All Nodes Inside Range**: Returns the original tree
5. **Negative Values**: Handles negative numbers correctly

## Related Concepts

- **Binary Search Trees**: Understanding BST properties is crucial
- **Tree Traversal**: In-order traversal gives sorted sequence
- **Recursion**: The solution uses recursive approach effectively
- **Tree Pruning**: Efficient elimination of unnecessary subtrees

## Follow-up Questions

1. Can you solve this iteratively?
2. What if the tree is not a BST?
3. How would you modify this to count removed nodes?
4. Can you implement this with constant space complexity?

## References

- [GeeksforGeeks: Remove BST Keys Outside Range](https://www.geeksforgeeks.org/remove-bst-keys-outside-the-given-range/)
- [Binary Search Tree Properties](https://www.geeksforgeeks.org/binary-search-tree-data-structure/)
