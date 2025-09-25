# Generate Binary Numbers

**GeeksforGeeks Problem of the Day – September 25, 2025**

## Problem Statement

Given a number `n`, generate all binary numbers with decimal values from 1 to `n`.

**Examples:**

- Input: `n = 4`  
  Output: `["1", "10", "11", "100"]`  
  Explanation: Binary numbers from 1 to 4 are 1, 10, 11 and 100.

- Input: `n = 6`  
  Output: `["1", "10", "11", "100", "101", "110"]`  
  Explanation: Binary numbers from 1 to 6 are 1, 10, 11, 100, 101 and 110.

**Constraints:** `1 ≤ n ≤ 10^6`

## Approach

### Optimized Queue-Based Solution (Primary)

- **Algorithm:** Use a queue-based BFS approach
- **Steps:**
  1. Start with "1" in the queue
  2. For each binary number dequeued, add it to results
  3. Generate next level by appending "0" and "1" to current number
  4. Continue until we have `n` binary numbers
- **Time Complexity:** O(n)
- **Space Complexity:** O(n)

### Alternative: Direct Conversion (Verifier)

- **Algorithm:** For each number from 1 to n, convert to binary string
- **Method:** Use `[Convert]::ToString(i, 2)` for each i
- **Time Complexity:** O(n * log n) 
- **Space Complexity:** O(1) additional

## Implementation

The PowerShell solution includes:

- **Main Function:** `Get-GenerateBinaryNumbers` - Efficient queue-based implementation
- **Verifier:** `Get-GenerateBinaryNumbers-Brute` - Simple conversion for validation
- **Test Harness:** Comprehensive testing with fixed and randomized cases

## Usage

1. **Run the solution:**
   ```powershell
   pwsh -File .\generate_binary_numbers.ps1
   ```

2. **Use the function programmatically:**
   ```powershell
   . .\generate_binary_numbers.ps1
   $result = Get-GenerateBinaryNumbers 6
   # Returns: @("1", "10", "11", "100", "101", "110")
   ```

## Files

- `generate_binary_numbers.ps1` - Complete solution with tests
- `README.md` - Documentation and usage instructions

## Test Results

The script runs both fixed test cases (including edge cases) and randomized tests to ensure correctness across various inputs.