<#
.SYNOPSIS
    Solution for Brackets in Matrix Chain Multiplication problem

.DESCRIPTION
    Given an array representing matrix dimensions, finds the optimal way to multiply
    matrices and returns a string with brackets showing the multiplication order.
    Uses dynamic programming to find minimum cost multiplication order.

.PARAMETER arr
    Array of integers representing matrix dimensions
    Matrix i has dimensions arr[i] x arr[i+1]

.EXAMPLE
    Get-MatrixChainOrder -arr @(40, 20, 30, 10, 30)
    Returns: ((A(BC))D)

.NOTES
    Time Complexity: O(n^3)
    Space Complexity: O(n^2)
#>

function Get-MatrixChainOrder {
    param(
        [Parameter(Mandatory=$true)]
        [int[]]$arr
    )
    
    $n = $arr.Length
    
    # Need at least 2 dimensions to form 1 matrix
    if ($n -lt 2) {
        throw "Array must have at least 2 elements"
    }
    
    # Number of matrices is n-1
    $numMatrices = $n - 1
    
    # Single matrix needs no brackets
    if ($numMatrices -eq 1) {
        return "A"
    }
    
    # dp[i,j] = minimum cost to multiply matrices from i to j
    # Using jagged arrays for better PowerShell compatibility
    $dp = New-Object 'object[]' $numMatrices
    $bracket = New-Object 'object[]' $numMatrices
    
    for ($i = 0; $i -lt $numMatrices; $i++) {
        $dp[$i] = New-Object 'int[]' $numMatrices
        $bracket[$i] = New-Object 'int[]' $numMatrices
    }
    
    # Initialize: cost of multiplying one matrix is 0
    for ($i = 0; $i -lt $numMatrices; $i++) {
        $dp[$i][$i] = 0
    }
    
    # l is the chain length
    for ($l = 2; $l -le $numMatrices; $l++) {
        for ($i = 0; $i -le $numMatrices - $l; $i++) {
            $j = $i + $l - 1
            $dp[$i][$j] = [int]::MaxValue
            
            # Try all possible split points
            for ($k = $i; $k -lt $j; $k++) {
                # Cost of multiplying matrices from i to k, then k+1 to j,
                # then multiplying the two results
                # arr[i] = rows of first matrix in chain
                # arr[k+1] = cols of first result = rows of second result
                # arr[j+1] = cols of second matrix in chain
                $cost = $dp[$i][$k] + $dp[$k + 1][$j] + ($arr[$i] * $arr[$k + 1] * $arr[$j + 1])
                
                if ($cost -lt $dp[$i][$j]) {
                    $dp[$i][$j] = $cost
                    $bracket[$i][$j] = $k
                }
            }
        }
    }
    
    # Build the bracket string using the optimal split points
    $result = Get-BracketString -bracket $bracket -i 0 -j ($numMatrices - 1)
    
    return $result
}

function Get-BracketString {
    param(
        [object[]]$bracket,
        [int]$i,
        [int]$j
    )
    
    # Base case: single matrix
    if ($i -eq $j) {
        # Convert index to letter (0->A, 1->B, etc.)
        $letter = [char]([int][char]'A' + $i)
        return $letter.ToString()
    }
    
    # Recursive case: split at optimal point
    $k = $bracket[$i][$j]
    
    $left = Get-BracketString -bracket $bracket -i $i -j $k
    $right = Get-BracketString -bracket $bracket -i ($k + 1) -j $j
    
    return "($left$right)"
}

function Get-MatrixMultiplicationCost {
    <#
    .SYNOPSIS
        Calculates the cost of multiplying matrices in a given order
    
    .DESCRIPTION
        Helper function to calculate and display the total multiplication cost
    #>
    param(
        [Parameter(Mandatory=$true)]
        [int[]]$arr
    )
    
    $n = $arr.Length
    $numMatrices = $n - 1
    
    if ($numMatrices -lt 2) {
        return 0
    }
    
    # Using jagged arrays
    $dp = New-Object 'object[]' $numMatrices
    for ($i = 0; $i -lt $numMatrices; $i++) {
        $dp[$i] = New-Object 'int[]' $numMatrices
    }
    
    for ($i = 0; $i -lt $numMatrices; $i++) {
        $dp[$i][$i] = 0
    }
    
    for ($l = 2; $l -le $numMatrices; $l++) {
        for ($i = 0; $i -le $numMatrices - $l; $i++) {
            $j = $i + $l - 1
            $dp[$i][$j] = [int]::MaxValue
            
            for ($k = $i; $k -lt $j; $k++) {
                $cost = $dp[$i][$k] + $dp[$k + 1][$j] + ($arr[$i] * $arr[$k + 1] * $arr[$j + 1])
                
                if ($cost -lt $dp[$i][$j]) {
                    $dp[$i][$j] = $cost
                }
            }
        }
    }
    
    return $dp[0][$numMatrices - 1]
}

# Main execution
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "`n=== Brackets in Matrix Chain Multiplication ===" -ForegroundColor Cyan
    Write-Host "`nThis solution uses Dynamic Programming to find the optimal way"
    Write-Host "to multiply a chain of matrices with minimum scalar multiplications.`n"
    
    # Example 1
    Write-Host "Example 1:" -ForegroundColor Yellow
    $arr1 = @(40, 20, 30, 10, 30)
    Write-Host "Input: arr = [$($arr1 -join ', ')]"
    Write-Host "Matrices: A[40x20], B[20x30], C[30x10], D[10x30]"
    $result1 = Get-MatrixChainOrder -arr $arr1
    $cost1 = Get-MatrixMultiplicationCost -arr $arr1
    Write-Host "Output: $result1" -ForegroundColor Green
    Write-Host "Minimum Cost: $cost1 scalar multiplications`n"
    
    # Example 2
    Write-Host "Example 2:" -ForegroundColor Yellow
    $arr2 = @(10, 20, 30)
    Write-Host "Input: arr = [$($arr2 -join ', ')]"
    Write-Host "Matrices: A[10x20], B[20x30]"
    $result2 = Get-MatrixChainOrder -arr $arr2
    $cost2 = Get-MatrixMultiplicationCost -arr $arr2
    Write-Host "Output: $result2" -ForegroundColor Green
    Write-Host "Minimum Cost: $cost2 scalar multiplications`n"
    
    # Example 3
    Write-Host "Example 3:" -ForegroundColor Yellow
    $arr3 = @(10, 20, 30, 40)
    Write-Host "Input: arr = [$($arr3 -join ', ')]"
    Write-Host "Matrices: A[10x20], B[20x30], C[30x40]"
    $result3 = Get-MatrixChainOrder -arr $arr3
    $cost3 = Get-MatrixMultiplicationCost -arr $arr3
    Write-Host "Output: $result3" -ForegroundColor Green
    Write-Host "Minimum Cost: $cost3 scalar multiplications`n"
    
    # Example 4 - Longer chain
    Write-Host "Example 4 (Longer Chain):" -ForegroundColor Yellow
    $arr4 = @(5, 10, 3, 12, 5, 50, 6)
    Write-Host "Input: arr = [$($arr4 -join ', ')]"
    Write-Host "Matrices: A[5x10], B[10x3], C[3x12], D[12x5], E[5x50], F[50x6]"
    $result4 = Get-MatrixChainOrder -arr $arr4
    $cost4 = Get-MatrixMultiplicationCost -arr $arr4
    Write-Host "Output: $result4" -ForegroundColor Green
    Write-Host "Minimum Cost: $cost4 scalar multiplications`n"
    
    Write-Host "`nAlgorithm Explanation:" -ForegroundColor Cyan
    Write-Host "1. Create DP table dp[i][j] for minimum cost from matrix i to j"
    Write-Host "2. Create bracket table to track optimal split points"
    Write-Host "3. For each chain length, try all split points and find minimum"
    Write-Host "4. Cost formula: dp[i][k] + dp[k+1][j] + arr[i]*arr[k+1]*arr[j+1]"
    Write-Host "5. Recursively build bracket string from optimal split points"
    Write-Host "`nTime Complexity: O(n³)"
    Write-Host "Space Complexity: O(n²)`n"
}

# Export functions for testing (only when loaded as module)
if ($MyInvocation.InvocationName -eq '.') {
    Export-ModuleMember -Function Get-MatrixChainOrder, Get-MatrixMultiplicationCost
}
