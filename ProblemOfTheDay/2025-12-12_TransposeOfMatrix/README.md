# Transpose of Matrix

**Difficulty:** Easy  
**Accuracy:** 66.5%  
**Points:** 2  
**Problem Link:** [GeeksforGeeks](https://www.geeksforgeeks.org/problems/transpose-of-matrix-1587115621/1)

## Problem Statement

You are given a square matrix of size **n x n**. Your task is to find the **transpose** of the given matrix.

The **transpose** of a matrix is obtained by converting all the rows to columns and all the columns to rows.

### Examples

**Example 1:**
```
Input: mat[][] = [[1, 1, 1, 1],
                  [2, 2, 2, 2],
                  [3, 3, 3, 3],
                  [4, 4, 4, 4]]

Output: [[1, 2, 3, 4],
         [1, 2, 3, 4],
         [1, 2, 3, 4],
         [1, 2, 3, 4]]

Explanation: Converting rows into columns and columns into rows.
```

**Example 2:**
```
Input: mat[][] = [[1, 2],
                  [9, -2]]

Output: [[1, 9],
         [2, -2]]

Explanation: Converting rows into columns and columns into rows.
```

### Constraints
- 1 ≤ n ≤ 10³
- -10⁹ ≤ mat[i][j] ≤ 10⁹

### Expected Complexity
- **Time Complexity:** O(n²)
- **Auxiliary Space:** O(1)

## Solution Approach

### Algorithm

The transpose of a matrix can be achieved by swapping elements across the main diagonal (where row index equals column index). 

**Key Insight:** For a square matrix, we only need to swap elements in the upper triangle with their corresponding elements in the lower triangle.

**Steps:**
1. Iterate through the matrix using nested loops
2. For each position (i, j) where j > i (upper triangle):
   - Swap matrix[i][j] with matrix[j][i]
3. This effectively converts rows to columns and vice versa

### Why This Works

When we transpose a matrix:
- The element at position (0, 1) moves to position (1, 0)
- The element at position (0, 2) moves to position (2, 0)
- The element at position (1, 2) moves to position (2, 1)
- And so on...

By iterating only through the upper triangle (where j > i), we avoid swapping elements twice, which would undo our transpose operation.

### Visual Example

Original Matrix:
```
[1  2  3]
[4  5  6]
[7  8  9]
```

After transposing:
```
[1  4  7]
[2  5  8]
[3  6  9]
```

Notice:
- Row 1 [1, 2, 3] becomes Column 1 [1, 4, 7]
- Row 2 [4, 5, 6] becomes Column 2 [2, 5, 8]
- Row 3 [7, 8, 9] becomes Column 3 [3, 6, 9]

## PowerShell Implementation Details

The PowerShell solution uses:
- **In-place swapping** to achieve O(1) auxiliary space
- **Nested loops** to iterate through the upper triangle
- **Array indexing** to access and swap elements

### Time Complexity Analysis
- We iterate through roughly n²/2 elements (upper triangle)
- Each swap operation is O(1)
- Overall: **O(n²)**

### Space Complexity Analysis
- We only use a single temporary variable for swapping
- No additional data structures are created
- Overall: **O(1)** auxiliary space

## Usage

### Running the Solution
```powershell
.\transpose_of_matrix.ps1
```

### Using the Function in Your Code
```powershell
# Source the script
. .\transpose_of_matrix.ps1

# Create a matrix
$myMatrix = @(
    @(1, 2, 3),
    @(4, 5, 6),
    @(7, 8, 9)
)

# Transpose it
$transposed = Transpose-Matrix -matrix $myMatrix

# Display result
foreach ($row in $transposed) {
    Write-Host "[$($row -join ', ')]"
}
```

### Running Tests
```powershell
.\test_transpose_of_matrix.ps1
```

## Key Learnings

1. **Matrix Transpose Basics**: Understanding that transposing switches rows with columns
2. **In-place Algorithms**: How to modify data structures without extra space
3. **Diagonal Symmetry**: Leveraging the symmetry of square matrices to optimize the solution
4. **PowerShell Arrays**: Working with 2D arrays in PowerShell

## Company Tags
- MakeMyTrip
- InfoEdge
- Bloomberg

## Topic Tags
- Matrix
- Data Structures
