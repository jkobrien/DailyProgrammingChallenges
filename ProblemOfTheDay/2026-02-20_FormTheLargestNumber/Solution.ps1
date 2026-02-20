<#
.SYNOPSIS
    Form the Largest Number from an Array

.DESCRIPTION
    Given an array of non-negative integers, arrange them so that after concatenating 
    all of them in order, it results in the largest possible number. The result is 
    returned as a string.

.EXAMPLE
    Get-LargestNumber -Numbers @(3, 30, 34, 5, 9)
    Returns: "9534330"

.EXAMPLE
    Get-LargestNumber -Numbers @(54, 546, 548, 60)
    Returns: "6054854654"

.EXAMPLE
    Get-LargestNumber -Numbers @(0, 0, 0)
    Returns: "0"
#>

function Get-LargestNumber {
    <#
    .SYNOPSIS
        Arranges numbers to form the largest possible concatenated number.
    
    .PARAMETER Numbers
        An array of non-negative integers.
    
    .OUTPUTS
        String representing the largest possible number.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$Numbers
    )
    
    # Handle empty array
    if ($Numbers.Count -eq 0) {
        return "0"
    }
    
    # Convert all numbers to strings
    $strNumbers = $Numbers | ForEach-Object { $_.ToString() }
    
    # Custom sort using a comparison that checks which concatenation is larger
    # We use a scriptblock with Sort-Object to define custom comparison
    $sorted = $strNumbers | Sort-Object -Property @{
        Expression = { $_ }
        Descending = $true
    } -Culture ([System.Globalization.CultureInfo]::InvariantCulture)
    
    # PowerShell's Sort-Object doesn't directly support custom comparators like other languages
    # So we'll implement a custom sorting algorithm (QuickSort with custom comparator)
    $sorted = Sort-WithCustomComparator -Array $strNumbers
    
    # Join the sorted numbers
    $result = -join $sorted
    
    # Handle edge case: if result is all zeros, return "0"
    if ($result -match '^0+$') {
        return "0"
    }
    
    return $result
}

function Sort-WithCustomComparator {
    <#
    .SYNOPSIS
        Sorts an array of string numbers using custom comparison logic.
    
    .DESCRIPTION
        Uses a custom comparator where two numbers x and y are compared by checking
        if xy > yx (as strings). This ensures the largest concatenation.
    
    .PARAMETER Array
        Array of string numbers to sort.
    
    .OUTPUTS
        Sorted array of strings.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string[]]$Array
    )
    
    # Use ArrayList for efficient operations
    $list = [System.Collections.ArrayList]::new($Array)
    
    # Custom comparator: returns 1 if xy > yx (x should come before y)
    # returns -1 if xy < yx (y should come before x)
    # returns 0 if equal
    $comparer = {
        param($x, $y)
        
        $xy = $x + $y
        $yx = $y + $x
        
        # String comparison for numeric concatenations
        # We need to compare them as numeric values if they represent numbers
        if ($xy.Length -ne $yx.Length) {
            # Different lengths, direct string comparison works
            return -([string]::Compare($xy, $yx))
        } else {
            # Same length, string comparison is fine
            return -([string]::Compare($xy, $yx))
        }
    }
    
    # Implement custom sort using .NET Sort with IComparer
    $list.Sort([System.Comparison[string]]$comparer)
    
    return $list.ToArray()
}

function Get-LargestNumberOptimized {
    <#
    .SYNOPSIS
        Optimized version using .NET's List.Sort with custom comparison.
    
    .DESCRIPTION
        More efficient implementation using .NET's built-in sorting with a custom
        comparison delegate.
    
    .PARAMETER Numbers
        An array of non-negative integers.
    
    .OUTPUTS
        String representing the largest possible number.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$Numbers
    )
    
    # Handle empty array
    if ($Numbers.Count -eq 0) {
        return "0"
    }
    
    # Convert to strings
    $strNumbers = [System.Collections.Generic.List[string]]::new()
    foreach ($num in $Numbers) {
        $strNumbers.Add($num.ToString())
    }
    
    # Define custom comparison
    # Return negative if first should come before second (descending for largest)
    $comparison = [System.Comparison[string]] {
        param($x, $y)
        
        $xy = $x + $y
        $yx = $y + $x
        
        # Return positive if yx should come first (x is smaller)
        # Return negative if xy should come first (x is larger)
        return [string]::Compare($yx, $xy, [System.StringComparison]::Ordinal)
    }
    
    # Sort with custom comparison
    $strNumbers.Sort($comparison)
    
    # Join the sorted numbers
    $result = -join $strNumbers
    
    # Handle edge case: all zeros
    if ($result -match '^0+$') {
        return "0"
    }
    
    return $result
}

function Get-LargestNumberBruteForce {
    <#
    .SYNOPSIS
        Simple bubble sort implementation with custom comparison (for educational purposes).
    
    .DESCRIPTION
        Easy to understand implementation using bubble sort. Not recommended for large arrays.
    
    .PARAMETER Numbers
        An array of non-negative integers.
    
    .OUTPUTS
        String representing the largest possible number.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$Numbers
    )
    
    if ($Numbers.Count -eq 0) {
        return "0"
    }
    
    # Convert to strings
    $strArray = $Numbers | ForEach-Object { $_.ToString() }
    $n = $strArray.Count
    
    # Bubble sort with custom comparison
    for ($i = 0; $i -lt $n - 1; $i++) {
        for ($j = 0; $j -lt $n - $i - 1; $j++) {
            $xy = $strArray[$j] + $strArray[$j + 1]
            $yx = $strArray[$j + 1] + $strArray[$j]
            
            # If yx > xy, swap them (we want larger concatenations first)
            if ([string]::Compare($yx, $xy, [System.StringComparison]::Ordinal) -gt 0) {
                $temp = $strArray[$j]
                $strArray[$j] = $strArray[$j + 1]
                $strArray[$j + 1] = $temp
            }
        }
    }
    
    # Join the sorted numbers
    $result = -join $strArray
    
    # Handle all zeros case
    if ($result -match '^0+$') {
        return "0"
    }
    
    return $result
}

# Functions are available when dot-sourced
# Export-ModuleMember is not needed for dot-sourcing
