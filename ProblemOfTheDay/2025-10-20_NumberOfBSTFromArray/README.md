# Number of BST From Array

**Problem of the Day - October 20, 2025**  
**Difficulty:** Hard  
**Source:** [GeeksforGeeks](https://www.geeksforgeeks.org/problems/number-of-bst-from-array/1)

## Problem Statement

Given an array of integers, find the number of Binary Search Trees (BSTs) that can be formed such that each BST contains all the array elements and follows the BST property (for every node, all elements in the left subtree are less and all in the right subtree are greater).

## Examples

```
Input: [1, 2, 3]
Output: 5

Input: [4, 5, 6, 7]  
Output: 14

Input: [1, 2, 2]
Output: 0 (duplicates not allowed in BST)
```

## Approach

### Key Insights

1. **Unique Elements Required**: BSTs require all elements to be unique to maintain the BST property.

2. **Catalan Numbers**: For an array of `n` unique elements, the number of structurally different BSTs that can be formed is the `n`th Catalan number.

3. **Catalan Number Formula**: 
   $$C_n = \frac{(2n)!}{(n+1)! \cdot n!}$$

4. **Recursive Relation**: 
   $$C_n = \sum_{i=0}^{n-1} C_i \cdot C_{n-1-i}$$

### Algorithm

1. **Input Validation**: Check if the array is empty or null.
2. **Duplicate Check**: Verify all elements are unique.
3. **Catalan Calculation**: Compute the nth Catalan number where n is the array length.
4. **Return Result**: The Catalan number represents the number of possible BSTs.

### Mathematical Background

The problem relates to the number of ways to arrange `n` nodes in a binary search tree. Each arrangement corresponds to a unique BST structure. This is a classic application of Catalan numbers.

**Why Catalan Numbers?**
- When we choose a root from `n` elements, we partition the remaining elements into left and right subtrees
- The number of ways to structure the left subtree × number of ways to structure the right subtree
- This recursive structure exactly matches the Catalan number recurrence

## Complexity Analysis

- **Time Complexity**: 
  - Factorial approach: O(n) for computing factorials
  - Dynamic Programming approach: O(n²) for computing Catalan numbers
- **Space Complexity**: 
  - Factorial approach: O(1)
  - Dynamic Programming approach: O(n) for storing intermediate results

## Implementation Details

The PowerShell solution provides two methods for calculating Catalan numbers:

1. **Factorial Method**: Direct formula using factorials
2. **Dynamic Programming Method**: More efficient for larger values, avoids large factorial calculations

## Test Cases

| Input | Expected Output | Explanation |
|-------|----------------|-------------|
| `[1,2,3]` | 5 | C(3) = 5 |
| `[4,5,6,7]` | 14 | C(4) = 14 |
| `[1,2,2]` | 0 | Contains duplicates |
| `[]` | 0 | Empty array |
| `[42]` | 1 | Single element |

## Usage

```powershell
# Import the module
. .\number_of_bst_from_array.ps1

# Calculate number of BSTs
$result = Get-NumberOfBSTs @(1,2,3,4)
Write-Host "Number of BSTs: $result"

# Show examples with explanations
Show-BSTExamples
```

## Files

- `number_of_bst_from_array.ps1` - Main solution implementation
- `test_number_of_bst_from_array.ps1` - Comprehensive test suite
- `README.md` - This documentation

## Related Concepts

- **Catalan Numbers**: Sequence of natural numbers with many applications in combinatorics
- **Binary Search Trees**: Tree data structure with ordered elements
- **Dynamic Programming**: Optimization technique for overlapping subproblems
- **Combinatorics**: Branch of mathematics dealing with counting and arrangements