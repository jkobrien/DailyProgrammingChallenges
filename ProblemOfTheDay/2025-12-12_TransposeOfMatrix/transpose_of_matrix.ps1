<#
.SYNOPSIS
    Transpose of Matrix - GeeksforGeeks Problem of the Day (December 12, 2025)

.DESCRIPTION
    Given a square matrix of size n x n, find the transpose of the matrix.
    The transpose is obtained by converting all rows to columns and all columns to rows.
    
    Time Complexity: O(n^2) - We visit each element once
    Space Complexity: O(1) - We transpose in-place by swapping elements

.LINK
    https://www.geeksforgeeks.org/problems/transpose-of-matrix-1587115621/1
#>

function Transpose-Matrix {
    <#
    .SYNOPSIS
        Transposes a square matrix in-place.
    
    .PARAMETER matrix
        A square matrix (n x n) represented as a 2D array
    
    .EXAMPLE
        $mat = @(
            @(1, 1, 1, 1),
            @(2, 2, 2, 2),
            @(3, 3, 3, 3),
            @(4, 4, 4, 4)
        )
        Transpose-Matrix -matrix $mat
        # Returns: [[1,2,3,4], [1,2,3,4], [1,2,3,4], [1,2,3,4]]
    
    .EXAMPLE
        $mat = @(@(1, 2), @(9, -2))
        Transpose-Matrix -matrix $mat
        # Returns: [[1,9], [2,-2]]
    #>
    param(
        [Parameter(Mandatory=$true)]
        [AllowEmptyCollection()]
        [array]$matrix
    )
    
    $n = $matrix.Count
    
    # Validate that it's a square matrix
    if ($n -eq 0) {
        return $matrix
    }
    
    foreach ($row in $matrix) {
        if ($row.Count -ne $n) {
            throw "Matrix must be square (n x n)"
        }
    }
    
    # Transpose the matrix in-place
    # We only need to swap elements above the main diagonal
    # with their corresponding elements below the diagonal
    for ($i = 0; $i -lt $n; $i++) {
        for ($j = $i + 1; $j -lt $n; $j++) {
            # Swap matrix[i][j] with matrix[j][i]
            $temp = $matrix[$i][$j]
            $matrix[$i][$j] = $matrix[$j][$i]
            $matrix[$j][$i] = $temp
        }
    }
    
    return $matrix
}

# Main execution block for testing
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "=== Transpose of Matrix ===" -ForegroundColor Cyan
    Write-Host ""
    
    # Example 1
    Write-Host "Example 1:" -ForegroundColor Yellow
    $mat1 = @(
        @(1, 1, 1, 1),
        @(2, 2, 2, 2),
        @(3, 3, 3, 3),
        @(4, 4, 4, 4)
    )
    Write-Host "Input Matrix:"
    foreach ($row in $mat1) {
        Write-Host "  [$($row -join ', ')]"
    }
    
    $result1 = Transpose-Matrix -matrix $mat1
    Write-Host "`nTransposed Matrix:"
    foreach ($row in $result1) {
        Write-Host "  [$($row -join ', ')]" -ForegroundColor Green
    }
    
    # Example 2
    Write-Host "`nExample 2:" -ForegroundColor Yellow
    $mat2 = @(
        @(1, 2),
        @(9, -2)
    )
    Write-Host "Input Matrix:"
    foreach ($row in $mat2) {
        Write-Host "  [$($row -join ', ')]"
    }
    
    $result2 = Transpose-Matrix -matrix $mat2
    Write-Host "`nTransposed Matrix:"
    foreach ($row in $result2) {
        Write-Host "  [$($row -join ', ')]" -ForegroundColor Green
    }
    
    # Example 3 - Single element
    Write-Host "`nExample 3:" -ForegroundColor Yellow
    $mat3 = @(@(5))
    Write-Host "Input Matrix:"
    foreach ($row in $mat3) {
        Write-Host "  [$($row -join ', ')]"
    }
    
    $result3 = Transpose-Matrix -matrix $mat3
    Write-Host "`nTransposed Matrix:"
    foreach ($row in $result3) {
        Write-Host "  [$($row -join ', ')]" -ForegroundColor Green
    }
    
    # Example 4 - 3x3 matrix with various values
    Write-Host "`nExample 4:" -ForegroundColor Yellow
    $mat4 = @(
        @(1, 2, 3),
        @(4, 5, 6),
        @(7, 8, 9)
    )
    Write-Host "Input Matrix:"
    foreach ($row in $mat4) {
        Write-Host "  [$($row -join ', ')]"
    }
    
    $result4 = Transpose-Matrix -matrix $mat4
    Write-Host "`nTransposed Matrix:"
    foreach ($row in $result4) {
        Write-Host "  [$($row -join ', ')]" -ForegroundColor Green
    }
}
