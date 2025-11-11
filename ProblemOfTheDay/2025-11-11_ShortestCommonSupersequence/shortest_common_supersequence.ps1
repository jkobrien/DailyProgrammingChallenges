<#
.SYNOPSIS
    Finds the length of the shortest common supersequence of two strings.

.DESCRIPTION
    Given two strings s1 and s2, this function finds the length of the smallest string 
    which has both s1 and s2 as its sub-sequences.
    
    The solution uses dynamic programming to find the Longest Common Subsequence (LCS),
    then applies the formula: SCS Length = len(s1) + len(s2) - LCS(s1, s2)

.PARAMETER s1
    The first input string.

.PARAMETER s2
    The second input string.

.EXAMPLE
    Get-ShortestCommonSupersequence "geek" "eke"
    # Returns: 5

.EXAMPLE
    Get-ShortestCommonSupersequence "AGGTAB" "GXTXAYB"
    # Returns: 9

.NOTES
    Time Complexity: O(n * m) where n and m are the lengths of the two strings
    Space Complexity: O(n * m) for the DP table
#>

function Get-LongestCommonSubsequence {
    param (
        [string]$s1,
        [string]$s2
    )
    
    $m = $s1.Length
    $n = $s2.Length
    
    # Create DP table with dimensions (m+1) x (n+1)
    $dp = New-Object 'int[,]' ($m + 1), ($n + 1)
    
    # Fill the DP table
    for ($i = 1; $i -le $m; $i++) {
        for ($j = 1; $j -le $n; $j++) {
            if ($s1.Chars($i - 1) -eq $s2.Chars($j - 1)) {
                # Characters match: take diagonal value + 1
                $dp[$i, $j] = $dp[($i - 1), ($j - 1)] + 1
            }
            else {
                # Characters don't match: take max of left or top
                $left = $dp[($i - 1), $j]
                $top = $dp[$i, ($j - 1)]
                $dp[$i, $j] = [Math]::Max($left, $top)
            }
        }
    }
    
    # Return the LCS length
    return $dp[$m, $n]
}

function Get-ShortestCommonSupersequence {
    param (
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [string]$s1 = "",
        
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [string]$s2 = ""
    )
    
    # Handle edge cases
    if ([string]::IsNullOrEmpty($s1)) {
        return $s2.Length
    }
    if ([string]::IsNullOrEmpty($s2)) {
        return $s1.Length
    }
    
    # Get the LCS length
    $lcsLength = Get-LongestCommonSubsequence $s1 $s2
    
    # Calculate SCS length using the formula:
    # SCS = len(s1) + len(s2) - LCS
    $scsLength = $s1.Length + $s2.Length - $lcsLength
    
    return $scsLength
}

function Get-ShortestCommonSupersequenceString {
    <#
    .SYNOPSIS
        Constructs the actual shortest common supersequence string.
    
    .DESCRIPTION
        This bonus function not only finds the length but also constructs
        the actual supersequence string by backtracking through the DP table.
    #>
    param (
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [string]$s1 = "",
        
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [string]$s2 = ""
    )
    
    $m = $s1.Length
    $n = $s2.Length
    
    # Create DP table
    $dp = New-Object 'int[,]' ($m + 1), ($n + 1)
    
    # Fill the DP table for LCS
    for ($i = 1; $i -le $m; $i++) {
        for ($j = 1; $j -le $n; $j++) {
            if ($s1.Chars($i - 1) -eq $s2.Chars($j - 1)) {
                $dp[$i, $j] = $dp[($i - 1), ($j - 1)] + 1
            }
            else {
                $left = $dp[($i - 1), $j]
                $top = $dp[$i, ($j - 1)]
                $dp[$i, $j] = [Math]::Max($left, $top)
            }
        }
    }
    
    # Backtrack to construct the SCS
    $i = $m
    $j = $n
    $result = [System.Text.StringBuilder]::new()
    
    while ($i -gt 0 -and $j -gt 0) {
        if ($s1.Chars($i - 1) -eq $s2.Chars($j - 1)) {
            # Characters match - part of LCS
            $null = $result.Insert(0, $s1.Chars($i - 1))
            $i--
            $j--
        }
        elseif ($dp[($i - 1), $j] -gt $dp[$i, ($j - 1)]) {
            # Move up - take character from s1
            $null = $result.Insert(0, $s1.Chars($i - 1))
            $i--
        }
        else {
            # Move left - take character from s2
            $null = $result.Insert(0, $s2.Chars($j - 1))
            $j--
        }
    }
    
    # Add remaining characters from s1
    while ($i -gt 0) {
        $null = $result.Insert(0, $s1.Chars($i - 1))
        $i--
    }
    
    # Add remaining characters from s2
    while ($j -gt 0) {
        $null = $result.Insert(0, $s2.Chars($j - 1))
        $j--
    }
    
    return $result.ToString()
}

# Main execution block for running the script directly
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "Shortest Common Supersequence - GeeksforGeeks POTD (Nov 11, 2025)" -ForegroundColor Cyan
    Write-Host ("=" * 70) -ForegroundColor Cyan
    Write-Host ""
    
    # Example 1
    $s1 = "geek"
    $s2 = "eke"
    $result = Get-ShortestCommonSupersequence $s1 $s2
    $scs = Get-ShortestCommonSupersequenceString $s1 $s2
    Write-Host "Example 1:"
    Write-Host "  Input:  s1 = '$s1', s2 = '$s2'"
    Write-Host "  Output: $result"
    Write-Host "  SCS String: '$scs'"
    Write-Host ""
    
    # Example 2
    $s1 = "AGGTAB"
    $s2 = "GXTXAYB"
    $result = Get-ShortestCommonSupersequence $s1 $s2
    $scs = Get-ShortestCommonSupersequenceString $s1 $s2
    Write-Host "Example 2:"
    Write-Host "  Input:  s1 = '$s1', s2 = '$s2'"
    Write-Host "  Output: $result"
    Write-Host "  SCS String: '$scs'"
    Write-Host ""
    
    # Example 3
    $s1 = "geek"
    $s2 = "ek"
    $result = Get-ShortestCommonSupersequence $s1 $s2
    $scs = Get-ShortestCommonSupersequenceString $s1 $s2
    Write-Host "Example 3:"
    Write-Host "  Input:  s1 = '$s1', s2 = '$s2'"
    Write-Host "  Output: $result"
    Write-Host "  SCS String: '$scs'"
    Write-Host ""
    
    # Additional test case
    $s1 = "abcd"
    $s2 = "efgh"
    $result = Get-ShortestCommonSupersequence $s1 $s2
    $scs = Get-ShortestCommonSupersequenceString $s1 $s2
    Write-Host "Example 4 (No common chars):"
    Write-Host "  Input:  s1 = '$s1', s2 = '$s2'"
    Write-Host "  Output: $result"
    Write-Host "  SCS String: '$scs'"
}

# Export functions for module usage (only when loaded as a module)
if ($MyInvocation.MyCommand.CommandType -eq 'ExternalScript' -and $MyInvocation.MyCommand.ScriptBlock.Module) {
    Export-ModuleMember -Function Get-ShortestCommonSupersequence, Get-ShortestCommonSupersequenceString, Get-LongestCommonSubsequence
}
