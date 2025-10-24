<#
.SYNOPSIS
    Split Array Subsequences - GeeksforGeeks Problem of the Day (2025-10-24)

.DESCRIPTION
    Given a sorted integer array arr[] and an integer k, determine if it is possible 
    to split the array into one or more consecutive subsequences such that:
    - Each subsequence consists of consecutive integers
    - Every subsequence has a length of at least k

.PARAMETER arr
    Sorted integer array to split into subsequences

.PARAMETER k
    Minimum length required for each subsequence

.EXAMPLE
    Split-ArraySubsequences -arr @(2, 2, 3, 3, 4, 5) -k 2
    Returns: True (can split into [2,3], [2,3], [4,5])

.EXAMPLE
    Split-ArraySubsequences -arr @(1, 1, 1, 1, 1) -k 4
    Returns: False (impossible to create subsequences of length 4+)
#>

function Split-ArraySubsequences {
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [int[]]$arr,
        
        [Parameter(Mandatory = $true)]
        [int]$k
    )
    
    # Input validation
    if ($arr.Length -eq 0 -or $k -le 0 -or $k -gt $arr.Length) {
        return $false
    }
    
    # Count frequency of each number
    $freq = @{}
    foreach ($num in $arr) {
        if ($freq.ContainsKey($num)) {
            $freq[$num]++
        } else {
            $freq[$num] = 1
        }
    }
    
    # Priority queues (min-heaps) for subsequences ending at each number
    # Using arrays and sorting to simulate priority queues in PowerShell
    $subsequences = @{}
    
    # Get unique numbers in sorted order
    $uniqueNumbers = $freq.Keys | Sort-Object
    
    foreach ($num in $uniqueNumbers) {
        $count = $freq[$num]
        
        # Try to extend existing subsequences
        if ($subsequences.ContainsKey($num - 1)) {
            $prevSubseq = $subsequences[$num - 1]
            
            # Sort to get shortest subsequences first (min-heap behavior)
            $prevSubseq = $prevSubseq | Sort-Object
            
            # Extend as many subsequences as possible
            $extendCount = [Math]::Min($count, $prevSubseq.Count)
            
            # Initialize current number's subsequences array if needed
            if (-not $subsequences.ContainsKey($num)) {
                $subsequences[$num] = @()
            }
            
            # Extend shortest subsequences
            for ($i = 0; $i -lt $extendCount; $i++) {
                $newLength = $prevSubseq[$i] + 1
                $subsequences[$num] += $newLength
            }
            
            # Remove extended subsequences from previous number
            if ($extendCount -eq $prevSubseq.Count) {
                $subsequences.Remove($num - 1)
            } else {
                $subsequences[$num - 1] = $prevSubseq[$extendCount..($prevSubseq.Count - 1)]
            }
            
            # Create new subsequences for remaining count
            $remainingCount = $count - $extendCount
            for ($i = 0; $i -lt $remainingCount; $i++) {
                $subsequences[$num] += 1
            }
        } else {
            # Start new subsequences
            if (-not $subsequences.ContainsKey($num)) {
                $subsequences[$num] = @()
            }
            
            for ($i = 0; $i -lt $count; $i++) {
                $subsequences[$num] += 1
            }
        }
    }
    
    # Check if all remaining subsequences have length >= k
    foreach ($key in $subsequences.Keys) {
        foreach ($length in $subsequences[$key]) {
            if ($length -lt $k) {
                return $false
            }
        }
    }
    
    return $true
}

# Alternative implementation using a more efficient approach
function Split-ArraySubsequences-Optimized {
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [int[]]$arr,
        
        [Parameter(Mandatory = $true)]
        [int]$k
    )
    
    if ($arr.Length -eq 0 -or $k -le 0 -or $k -gt $arr.Length) {
        return $false
    }
    
    # Count frequency of each number
    $freq = @{}
    foreach ($num in $arr) {
        if ($freq.ContainsKey($num)) {
            $freq[$num]++
        } else {
            $freq[$num] = 1
        }
    }
    
    # Track subsequences by their ending number and length
    $endingAt = @{}  # endingAt[num] = list of lengths of subsequences ending at num
    
    $uniqueNumbers = $freq.Keys | Sort-Object
    
    foreach ($num in $uniqueNumbers) {
        $available = $freq[$num]
        
        # Try to extend existing subsequences ending at (num-1)
        if ($endingAt.ContainsKey($num - 1)) {
            $prevLengths = $endingAt[$num - 1] | Sort-Object
            $canExtend = [Math]::Min($available, $prevLengths.Count)
            
            # Initialize if needed
            if (-not $endingAt.ContainsKey($num)) {
                $endingAt[$num] = @()
            }
            
            # Extend shortest subsequences first
            for ($i = 0; $i -lt $canExtend; $i++) {
                $endingAt[$num] += ($prevLengths[$i] + 1)
            }
            
            # Update remaining subsequences at (num-1)
            if ($canExtend -eq $prevLengths.Count) {
                $endingAt.Remove($num - 1)
            } else {
                $endingAt[$num - 1] = $prevLengths[$canExtend..($prevLengths.Count - 1)]
            }
            
            $available -= $canExtend
        }
        
        # Start new subsequences with remaining numbers
        if ($available -gt 0) {
            if (-not $endingAt.ContainsKey($num)) {
                $endingAt[$num] = @()
            }
            
            for ($i = 0; $i -lt $available; $i++) {
                $endingAt[$num] += 1
            }
        }
    }
    
    # Verify all subsequences meet minimum length requirement
    foreach ($lengths in $endingAt.Values) {
        foreach ($length in $lengths) {
            if ($length -lt $k) {
                return $false
            }
        }
    }
    
    return $true
}

# Note: Functions are available for dot-sourcing
# Export-ModuleMember would only work if this was imported as a module
