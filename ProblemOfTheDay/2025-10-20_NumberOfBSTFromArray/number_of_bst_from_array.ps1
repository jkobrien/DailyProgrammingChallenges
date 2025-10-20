# GeeksforGeeks Problem of the Day - October 20, 2025
# Problem: Number of BST From Array
# Difficulty: Hard
# Companies: Various
# Link: https://www.geeksforgeeks.org/problems/number-of-bst-from-array/1

<#
.SYNOPSIS
    Calculates the number of different Binary Search Trees (BSTs) that can be formed from an array.

.DESCRIPTION
    Given an array of integers, this script calculates how many structurally different BSTs 
    can be formed using all elements of the array. For an array of n unique elements,
    the answer is the nth Catalan number.

.PARAMETER arr
    Array of integers for which to count possible BSTs

.EXAMPLE
    Get-NumberOfBSTs @(1,2,3)
    Returns 5 (the 3rd Catalan number)

.NOTES
    - For arrays with duplicate values, BSTs cannot be formed as per BST property
    - Time Complexity: O(n) for factorial calculations
    - Space Complexity: O(1)
#>

# Function to compute factorial
function Get-Factorial {
    param([int]$n)
    
    if ($n -le 1) { 
        return 1 
    }
    
    $result = 1
    for ($i = 2; $i -le $n; $i++) {
        $result *= $i
    }
    
    return $result
}

# Function to compute nth Catalan number using formula: C(n) = (2n)! / ((n+1)! * n!)
function Get-CatalanNumber {
    param([int]$n)
    
    if ($n -eq 0) { 
        return 1 
    }
    
    # Calculate (2n)!
    $fact2n = Get-Factorial (2 * $n)
    
    # Calculate (n+1)!
    $factn1 = Get-Factorial ($n + 1)
    
    # Calculate n!
    $factn = Get-Factorial $n
    
    # Return C(n) = (2n)! / ((n+1)! * n!)
    return [math]::Round($fact2n / ($factn1 * $factn))
}

# Function to compute nth Catalan number using dynamic programming (more efficient for larger n)
function Get-CatalanNumberDP {
    param([int]$n)
    
    if ($n -eq 0 -or $n -eq 1) { 
        return 1 
    }
    
    # Array to store Catalan numbers
    $catalan = @(0) * ($n + 1)
    $catalan[0] = 1
    $catalan[1] = 1
    
    # Fill the array using the recurrence relation:
    # C(n) = sum(C(i) * C(n-1-i)) for i = 0 to n-1
    for ($i = 2; $i -le $n; $i++) {
        $catalan[$i] = 0
        for ($j = 0; $j -lt $i; $j++) {
            $catalan[$i] += $catalan[$j] * $catalan[$i - 1 - $j]
        }
    }
    
    return $catalan[$n]
}

# Main function: Number of BSTs from array
function Get-NumberOfBSTs {
    param([int[]]$arr)
    
    # Handle edge cases
    if ($null -eq $arr -or $arr.Length -eq 0) { 
        return 0 
    }
    
    $n = $arr.Length
    
    # Check for duplicates - BSTs require unique values
    $uniqueElements = $arr | Select-Object -Unique
    if ($arr.Count -ne $uniqueElements.Count) {
        Write-Warning "Array contains duplicates. BSTs with all elements cannot be formed as per BST property."
        return 0
    }
    
    # For n unique elements, the number of structurally different BSTs is the nth Catalan number
    return Get-CatalanNumberDP $n
}

# Function to demonstrate the problem with visual examples
function Show-BSTExamples {
    Write-Host "=== Number of BSTs from Array - Examples ===" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "Example 1: Array [1, 2, 3]" -ForegroundColor Yellow
    Write-Host "Possible BST structures (5 different trees):"
    Write-Host "1. Root=1: Right subtree has [2,3] -> 2 structures"
    Write-Host "2. Root=2: Left=[1], Right=[3] -> 1*1 = 1 structure"  
    Write-Host "3. Root=3: Left subtree has [1,2] -> 2 structures"
    Write-Host "Total: 2 + 1 + 2 = 5 BSTs"
    Write-Host ""
    
    $result1 = Get-NumberOfBSTs @(1,2,3)
    Write-Host "Calculated result: $result1" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "Example 2: Array [1, 2, 3, 4]" -ForegroundColor Yellow
    Write-Host "For 4 elements, Catalan number C(4) = 14"
    $result2 = Get-NumberOfBSTs @(1,2,3,4)
    Write-Host "Calculated result: $result2" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "Example 3: Array with duplicates [1, 2, 2]" -ForegroundColor Yellow
    Write-Host "Cannot form valid BSTs with duplicate elements"
    $result3 = Get-NumberOfBSTs @(1,2,2)
    Write-Host "Calculated result: $result3" -ForegroundColor Green
    Write-Host ""
}

# If script is run directly, show examples
if ($MyInvocation.InvocationName -ne '.') {
    Show-BSTExamples
}