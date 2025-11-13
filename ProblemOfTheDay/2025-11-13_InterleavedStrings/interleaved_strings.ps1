<#
.SYNOPSIS
    Determines if s3 is formed by interleaving s1 and s2.

.DESCRIPTION
    This solution uses dynamic programming to check if string s3 can be formed
    by interleaving strings s1 and s2 while maintaining the relative order of
    characters from both strings.
    
    Time Complexity: O(n * m) where n = length of s1, m = length of s2
    Space Complexity: O(m) using space-optimized 1D DP array

.PARAMETER s1
    First input string

.PARAMETER s2
    Second input string

.PARAMETER s3
    Target string to check if it's an interleaving of s1 and s2

.EXAMPLE
    Test-InterleavedStrings "AAB" "AAC" "AAAABC"
    Returns: $true

.EXAMPLE
    Test-InterleavedStrings "AB" "C" "ACB"
    Returns: $true

.EXAMPLE
    Test-InterleavedStrings "YX" "X" "XXY"
    Returns: $false
#>

function Test-InterleavedStrings {
    param(
        [Parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [string]$s1,
        
        [Parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [string]$s2,
        
        [Parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [string]$s3
    )
    
    $n = $s1.Length
    $m = $s2.Length
    $l = $s3.Length
    
    # Base case: lengths must match
    if ($n + $m -ne $l) {
        return $false
    }
    
    # Edge cases: empty strings
    if ($n -eq 0) {
        return $s2 -eq $s3
    }
    if ($m -eq 0) {
        return $s1 -eq $s3
    }
    
    # DP array: dp[j] represents if first i chars of s1 and first j chars of s2
    # can form first i+j chars of s3
    # We use space optimization: instead of 2D array dp[i][j], we use 1D array dp[j]
    $dp = New-Object bool[] ($m + 1)
    
    # Initialize first row (i=0): using only s2
    $dp[0] = $true
    for ($j = 1; $j -le $m; $j++) {
        $dp[$j] = $dp[$j-1] -and ($s2[$j-1] -eq $s3[$j-1])
    }
    
    # Fill the DP table row by row
    for ($i = 1; $i -le $n; $i++) {
        # Update dp[0] for current row (using only s1)
        $dp[0] = $dp[0] -and ($s1[$i-1] -eq $s3[$i-1])
        
        for ($j = 1; $j -le $m; $j++) {
            $k = $i + $j - 1  # Current position in s3
            
            # Two possibilities:
            # 1. Take character from s1: s1[i-1] == s3[k] and dp[i-1][j] is true
            #    In 1D array, dp[j] currently holds dp[i-1][j] from previous iteration
            # 2. Take character from s2: s2[j-1] == s3[k] and dp[i][j-1] is true
            #    In 1D array, dp[j-1] holds the newly computed dp[i][j-1]
            
            $fromS1 = $dp[$j] -and ($s1[$i-1] -eq $s3[$k])
            $fromS2 = $dp[$j-1] -and ($s2[$j-1] -eq $s3[$k])
            
            $dp[$j] = $fromS1 -or $fromS2
        }
    }
    
    return $dp[$m]
}

# Alternative implementation with 2D DP for clarity
function Test-InterleavedStrings2D {
    param(
        [Parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [string]$s1,
        
        [Parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [string]$s2,
        
        [Parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [string]$s3
    )
    
    $n = $s1.Length
    $m = $s2.Length
    $l = $s3.Length
    
    # Base case
    if ($n + $m -ne $l) {
        return $false
    }
    
    # Create 2D DP table
    $dp = New-Object 'bool[,]' ($n + 1), ($m + 1)
    
    # Base case: empty strings
    $dp[0,0] = $true
    
    # Fill first column (using only s1)
    for ($i = 1; $i -le $n; $i++) {
        $dp[$i,0] = $dp[$i-1,0] -and ($s1[$i-1] -eq $s3[$i-1])
    }
    
    # Fill first row (using only s2)
    for ($j = 1; $j -le $m; $j++) {
        $dp[0,$j] = $dp[0,$j-1] -and ($s2[$j-1] -eq $s3[$j-1])
    }
    
    # Fill rest of the table
    for ($i = 1; $i -le $n; $i++) {
        for ($j = 1; $j -le $m; $j++) {
            $k = $i + $j - 1
            
            # Can we form s3[0..k] by:
            # 1. Taking s1[i-1] if it matches s3[k] and dp[i-1][j] is true
            # 2. Taking s2[j-1] if it matches s3[k] and dp[i][j-1] is true
            $dp[$i,$j] = (($s1[$i-1] -eq $s3[$k]) -and $dp[$i-1,$j]) -or `
                         (($s2[$j-1] -eq $s3[$k]) -and $dp[$i,$j-1])
        }
    }
    
    return $dp[$n,$m]
}

# Main execution
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "Interleaved Strings Solution" -ForegroundColor Cyan
    Write-Host "=============================" -ForegroundColor Cyan
    Write-Host ""
    
    # Example 1
    $s1 = "AAB"
    $s2 = "AAC"
    $s3 = "AAAABC"
    $result = Test-InterleavedStrings $s1 $s2 $s3
    Write-Host "Example 1:" -ForegroundColor Yellow
    Write-Host "  s1: '$s1', s2: '$s2', s3: '$s3'"
    Write-Host "  Result: $result" -ForegroundColor Green
    Write-Host ""
    
    # Example 2
    $s1 = "AB"
    $s2 = "C"
    $s3 = "ACB"
    $result = Test-InterleavedStrings $s1 $s2 $s3
    Write-Host "Example 2:" -ForegroundColor Yellow
    Write-Host "  s1: '$s1', s2: '$s2', s3: '$s3'"
    Write-Host "  Result: $result" -ForegroundColor Green
    Write-Host ""
    
    # Example 3
    $s1 = "YX"
    $s2 = "X"
    $s3 = "XXY"
    $result = Test-InterleavedStrings $s1 $s2 $s3
    Write-Host "Example 3:" -ForegroundColor Yellow
    Write-Host "  s1: '$s1', s2: '$s2', s3: '$s3'"
    Write-Host "  Result: $result" -ForegroundColor Green
    Write-Host ""
    
    # Additional test cases
    Write-Host "Additional Tests:" -ForegroundColor Yellow
    
    # Test 4: Empty strings
    $result = Test-InterleavedStrings "" "abc" "abc"
    Write-Host "  Empty s1: $result (expected: True)" -ForegroundColor $(if($result) {"Green"} else {"Red"})
    
    # Test 5: Another valid interleaving
    $result = Test-InterleavedStrings "aabcc" "dbbca" "aadbbcbcac"
    Write-Host "  Complex interleaving: $result (expected: True)" -ForegroundColor $(if($result) {"Green"} else {"Red"})
    
    # Test 6: Invalid interleaving
    $result = Test-InterleavedStrings "aabcc" "dbbca" "aadbbbaccc"
    Write-Host "  Invalid interleaving: $result (expected: False)" -ForegroundColor $(if(-not $result) {"Green"} else {"Red"})
}
