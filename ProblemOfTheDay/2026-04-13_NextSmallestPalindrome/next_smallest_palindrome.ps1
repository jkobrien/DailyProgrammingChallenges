<#
.SYNOPSIS
    Next Smallest Palindrome - GeeksforGeeks Problem of the Day (April 13, 2026)

.DESCRIPTION
    Find the next smallest palindrome strictly larger than the given number.
    Given a number as an array of digits (1-9), return the next palindrome.
    
    The solution handles three main cases:
    1. Mirror left to right and if result > original, return it
    2. If mirrored result <= original, increment middle and re-mirror
    3. Handle all-9s case by creating new number with extra digit
    
    Time Complexity: O(n)
    Space Complexity: O(n) for output, O(1) auxiliary space

.PARAMETER num
    Array of digits from 1 to 9 representing the number

.EXAMPLE
    Get-NextPalindrome -num @(1, 2, 3)
    Returns: @(1, 3, 1)

.EXAMPLE
    Get-NextPalindrome -num @(9, 9, 9)
    Returns: @(1, 0, 0, 1)
    
.EXAMPLE
    Get-NextPalindrome -num @(9, 4, 1, 8, 7, 9, 7, 8, 3, 2, 2)
    Returns: @(9, 4, 1, 8, 8, 0, 8, 8, 1, 4, 9)
#>

function Get-NextPalindrome {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$num
    )
    
    $n = $num.Length
    
    # Edge case: single digit
    if ($n -eq 1) {
        if ($num[0] -eq 9) {
            return @(1, 1)
        } else {
            return @($num[0] + 1)
        }
    }
    
    # Check if all digits are 9
    $allNines = $true
    foreach ($digit in $num) {
        if ($digit -ne 9) {
            $allNines = $false
            break
        }
    }
    
    if ($allNines) {
        # Return 10...01 (n+1 digits)
        $result = @(1)
        for ($i = 0; $i -lt $n - 1; $i++) {
            $result += 0
        }
        $result += 1
        return $result
    }
    
    # Create a copy to work with
    $result = @() + $num
    
    # Find middle
    $mid = [Math]::Floor($n / 2)
    $isOddLength = ($n % 2 -eq 1)
    
    # Mirror left half to right half
    $left = if ($isOddLength) { $mid - 1 } else { $mid - 1 }
    $right = if ($isOddLength) { $mid + 1 } else { $mid }
    
    while ($left -ge 0) {
        $result[$right] = $result[$left]
        $left--
        $right++
    }
    
    # Compare mirrored palindrome with original
    $shouldIncrement = $false
    for ($i = 0; $i -lt $n; $i++) {
        if ($result[$i] -gt $num[$i]) {
            # Mirrored is greater, we're done
            break
        } elseif ($result[$i] -lt $num[$i]) {
            # Mirrored is smaller, need to increment
            $shouldIncrement = $true
            break
        }
    }
    
    # If at this point all are equal, mirrored = original, need next
    if (-not $shouldIncrement) {
        $allEqual = $true
        for ($i = 0; $i -lt $n; $i++) {
            if ($result[$i] -ne $num[$i]) {
                $allEqual = $false
                break
            }
        }
        if ($allEqual) {
            $shouldIncrement = $true
        }
    }
    
    # If we need to increment, increment from middle
    if ($shouldIncrement) {
        $carry = 1
        
        if ($isOddLength) {
            # Increment middle digit
            $result[$mid] += $carry
            $carry = [Math]::Floor($result[$mid] / 10)
            $result[$mid] = $result[$mid] % 10
            
            # Propagate carry outward from middle
            $left = $mid - 1
            $right = $mid + 1
            
            while ($carry -eq 1 -and $left -ge 0) {
                $result[$left] += $carry
                $result[$right] = $result[$left]
                $carry = [Math]::Floor($result[$left] / 10)
                $result[$left] = $result[$left] % 10
                $result[$right] = $result[$left]
                $left--
                $right++
            }
        } else {
            # Even length, increment from middle-1 and middle
            $left = $mid - 1
            $right = $mid
            
            while ($carry -eq 1 -and $left -ge 0) {
                $result[$left] += $carry
                $result[$right] = $result[$left]
                $carry = [Math]::Floor($result[$left] / 10)
                $result[$left] = $result[$left] % 10
                $result[$right] = $result[$left]
                $left--
                $right++
            }
        }
        
        # If carry still remains, we've overflowed (all 9s case)
        if ($carry -eq 1) {
            $result = @(1)
            for ($i = 0; $i -lt $n - 1; $i++) {
                $result += 0
            }
            $result += 1
        }
    }
    
    return $result
}

# Helper function to convert array to number string for display
function ConvertTo-NumberString {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$digits
    )
    
    return ($digits -join '')
}

# Helper function to visualize the palindrome check
function Test-Palindrome {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$num
    )
    
    $n = $num.Length
    for ($i = 0; $i -lt $n / 2; $i++) {
        if ($num[$i] -ne $num[$n - 1 - $i]) {
            return $false
        }
    }
    return $true
}

# Export functions if running as module
if ($MyInvocation.MyCommand.ScriptBlock.Module) {
    Export-ModuleMember -Function Get-NextPalindrome, ConvertTo-NumberString, Test-Palindrome
}

# If running as a script (not imported as module), run examples
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "=== Next Smallest Palindrome ===" -ForegroundColor Cyan
    Write-Host "GeeksforGeeks Problem of the Day - April 13, 2026"
    Write-Host "Difficulty: Hard (19.63% accuracy)"
    Write-Host ""
    
    # Example 1
    Write-Host "Example 1:" -ForegroundColor Yellow
    $num1 = @(9, 4, 1, 8, 7, 9, 7, 8, 3, 2, 2)
    Write-Host "Input:  [$($num1 -join ', ')]"
    Write-Host "Number: $(ConvertTo-NumberString $num1)"
    $result1 = Get-NextPalindrome -num $num1
    Write-Host "Output: [$($result1 -join ', ')]" -ForegroundColor Green
    Write-Host "Number: $(ConvertTo-NumberString $result1)" -ForegroundColor Green
    Write-Host "Is Palindrome: $(Test-Palindrome $result1)"
    Write-Host ""
    
    # Example 2
    Write-Host "Example 2:" -ForegroundColor Yellow
    $num2 = @(1, 2, 3)
    Write-Host "Input:  [$($num2 -join ', ')]"
    Write-Host "Number: $(ConvertTo-NumberString $num2)"
    $result2 = Get-NextPalindrome -num $num2
    Write-Host "Output: [$($result2 -join ', ')]" -ForegroundColor Green
    Write-Host "Number: $(ConvertTo-NumberString $result2)" -ForegroundColor Green
    Write-Host "Is Palindrome: $(Test-Palindrome $result2)"
    Write-Host ""
    
    # Example 3
    Write-Host "Example 3:" -ForegroundColor Yellow
    $num3 = @(9, 9, 9)
    Write-Host "Input:  [$($num3 -join ', ')]"
    Write-Host "Number: $(ConvertTo-NumberString $num3)"
    $result3 = Get-NextPalindrome -num $num3
    Write-Host "Output: [$($result3 -join ', ')]" -ForegroundColor Green
    Write-Host "Number: $(ConvertTo-NumberString $result3)" -ForegroundColor Green
    Write-Host "Is Palindrome: $(Test-Palindrome $result3)"
    Write-Host ""
    
    # Example 4
    Write-Host "Example 4 (Already a palindrome):" -ForegroundColor Yellow
    $num4 = @(1, 2, 1)
    Write-Host "Input:  [$($num4 -join ', ')]"
    Write-Host "Number: $(ConvertTo-NumberString $num4)"
    Write-Host "Input is palindrome: $(Test-Palindrome $num4)"
    $result4 = Get-NextPalindrome -num $num4
    Write-Host "Output: [$($result4 -join ', ')]" -ForegroundColor Green
    Write-Host "Number: $(ConvertTo-NumberString $result4)" -ForegroundColor Green
    Write-Host "Is Palindrome: $(Test-Palindrome $result4)"
    Write-Host ""
    
    # Example 5 - Single digit
    Write-Host "Example 5 (Single digit):" -ForegroundColor Yellow
    $num5 = @(5)
    Write-Host "Input:  [$($num5 -join ', ')]"
    Write-Host "Number: $(ConvertTo-NumberString $num5)"
    $result5 = Get-NextPalindrome -num $num5
    Write-Host "Output: [$($result5 -join ', ')]" -ForegroundColor Green
    Write-Host "Number: $(ConvertTo-NumberString $result5)" -ForegroundColor Green
    Write-Host ""
    
    # Example 6 - Single digit 9
    Write-Host "Example 6 (Single digit 9):" -ForegroundColor Yellow
    $num6 = @(9)
    Write-Host "Input:  [$($num6 -join ', ')]"
    Write-Host "Number: $(ConvertTo-NumberString $num6)"
    $result6 = Get-NextPalindrome -num $num6
    Write-Host "Output: [$($result6 -join ', ')]" -ForegroundColor Green
    Write-Host "Number: $(ConvertTo-NumberString $result6)" -ForegroundColor Green
    Write-Host ""
    
    # Example 7 - Even length
    Write-Host "Example 7 (Even length):" -ForegroundColor Yellow
    $num7 = @(1, 2, 3, 4)
    Write-Host "Input:  [$($num7 -join ', ')]"
    Write-Host "Number: $(ConvertTo-NumberString $num7)"
    $result7 = Get-NextPalindrome -num $num7
    Write-Host "Output: [$($result7 -join ', ')]" -ForegroundColor Green
    Write-Host "Number: $(ConvertTo-NumberString $result7)" -ForegroundColor Green
    Write-Host "Is Palindrome: $(Test-Palindrome $result7)"
    Write-Host ""
    
    # Example 8 - Carry propagation
    Write-Host "Example 8 (Carry propagation):" -ForegroundColor Yellow
    $num8 = @(1, 9, 9, 1)
    Write-Host "Input:  [$($num8 -join ', ')]"
    Write-Host "Number: $(ConvertTo-NumberString $num8)"
    Write-Host "Input is palindrome: $(Test-Palindrome $num8)"
    $result8 = Get-NextPalindrome -num $num8
    Write-Host "Output: [$($result8 -join ', ')]" -ForegroundColor Green
    Write-Host "Number: $(ConvertTo-NumberString $result8)" -ForegroundColor Green
    Write-Host "Is Palindrome: $(Test-Palindrome $result8)"
    Write-Host ""
    
    # Example 9 - Large number
    Write-Host "Example 9 (Large mirroring needed):" -ForegroundColor Yellow
    $num9 = @(1, 2, 3, 4, 5)
    Write-Host "Input:  [$($num9 -join ', ')]"
    Write-Host "Number: $(ConvertTo-NumberString $num9)"
    $result9 = Get-NextPalindrome -num $num9
    Write-Host "Output: [$($result9 -join ', ')]" -ForegroundColor Green
    Write-Host "Number: $(ConvertTo-NumberString $result9)" -ForegroundColor Green
    Write-Host "Is Palindrome: $(Test-Palindrome $result9)"
    Write-Host ""
}