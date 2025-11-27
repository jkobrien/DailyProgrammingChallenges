<#
.SYNOPSIS
    Subset XOR - GeeksforGeeks Problem of the Day (November 28, 2025)

.DESCRIPTION
    Finds a subset of numbers from 1 to n where:
    - The XOR of all elements equals n
    - The subset size is maximized
    - Among equal-sized subsets, returns the lexicographically smallest

.PARAMETER n
    The target number (1 ≤ n ≤ 100,000)

.EXAMPLE
    Get-SubsetXOR -n 4
    Returns: 1, 2, 3, 4 (XOR: 1^2^3^4 = 4)

.EXAMPLE
    Get-SubsetXOR -n 3
    Returns: 1, 2 (XOR: 1^2 = 3)

.NOTES
    Time Complexity: O(n)
    Space Complexity: O(1) excluding output array
    
    Solution Strategy:
    The XOR of numbers from 1 to k follows a cyclic pattern based on k % 4:
    - k % 4 == 0: XOR = k
    - k % 4 == 1: XOR = 1
    - k % 4 == 2: XOR = k + 1
    - k % 4 == 3: XOR = 0
    
    We leverage this pattern to find the maximum subset efficiently.
#>

function Get-SubsetXOR {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateRange(1, 100000)]
        [int]$n
    )

    # Helper function to calculate XOR from 1 to k using the pattern
    function Get-XORRange {
        param([int]$k)
        
        if ($k -le 0) { return 0 }
        
        $remainder = $k % 4
        switch ($remainder) {
            0 { return $k }
            1 { return 1 }
            2 { return $k + 1 }
            3 { return 0 }
        }
    }

    # Special case: n = 1
    if ($n -eq 1) {
        return @(1)
    }

    # Check if XOR(1 to n) equals n
    # This means all numbers from 1 to n can be included
    $xorToN = Get-XORRange -k $n
    if ($xorToN -eq $n) {
        return 1..$n
    }

    # Check if XOR(1 to n-1) equals n
    # This means all numbers from 1 to n-1 can be included
    $xorToNMinus1 = Get-XORRange -k ($n - 1)
    if ($xorToNMinus1 -eq $n) {
        return 1..($n - 1)
    }

    # If XOR(1 to n-1) != n, we need to find which number to exclude
    # The difference between what we have and what we want tells us what to exclude
    $diff = $xorToNMinus1 -bxor $n
    
    # If diff is in the range [1, n-1], we can exclude it to get our target
    if ($diff -ge 1 -and $diff -lt $n) {
        $result = @()
        for ($i = 1; $i -lt $n; $i++) {
            if ($i -ne $diff) {
                $result += $i
            }
        }
        return $result
    }
    
    # If diff equals n, then we need all numbers from 1 to n-1 plus n
    # But XOR(1 to n-1) XOR n = n, so just return n
    if ($diff -eq $n) {
        return @($n)
    }
    
    # Fallback: return array with just n (minimum valid answer)
    return @($n)
}

# Main execution block
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "=== Subset XOR Solution ===" -ForegroundColor Cyan
    Write-Host ""
    
    # Test with provided examples
    $testCases = @(
        @{n = 4; expected = @(1, 2, 3, 4) },
        @{n = 3; expected = @(1, 2) },
        @{n = 1; expected = @(1) },
        @{n = 2; expected = @(1, 2) },
        @{n = 5; expected = $null },
        @{n = 7; expected = $null },
        @{n = 8; expected = $null }
    )
    
    foreach ($test in $testCases) {
        $result = Get-SubsetXOR -n $test.n
        
        # Calculate XOR of result
        $xorValue = 0
        foreach ($num in $result) {
            $xorValue = $xorValue -bxor $num
        }
        
        $isCorrect = ($xorValue -eq $test.n)
        $color = if ($isCorrect) { "Green" } else { "Red" }
        
        Write-Host "Input: n = $($test.n)" -ForegroundColor Yellow
        Write-Host "Output: [$($result -join ', ')]" -ForegroundColor $color
        Write-Host "XOR Value: $xorValue (Expected: $($test.n))" -ForegroundColor $color
        Write-Host "Status: $(if ($isCorrect) { 'PASS' } else { 'FAIL' })" -ForegroundColor $color
        Write-Host "Subset Size: $($result.Count)" -ForegroundColor Cyan
        Write-Host ""
    }
}
