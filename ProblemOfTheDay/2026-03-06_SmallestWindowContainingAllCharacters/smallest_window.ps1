<#
.SYNOPSIS
    Find the smallest window in string s containing all characters of string p.

.DESCRIPTION
    This function implements the sliding window algorithm to find the minimum
    length substring of s that contains all characters (including duplicates) of p.
    
    Algorithm:
    1. Create a frequency map for all characters in pattern p
    2. Use two pointers (left, right) to maintain a sliding window
    3. Expand window by moving right until all characters are found
    4. Contract window by moving left while maintaining validity
    5. Track the minimum valid window throughout the process

.PARAMETER s
    The source string to search within

.PARAMETER p
    The pattern string containing required characters

.RETURNS
    The smallest substring containing all characters of p, or empty string if not found

.EXAMPLE
    Get-SmallestWindow -s "timetopractice" -p "toc"
    # Returns: "toprac"

.EXAMPLE
    Get-SmallestWindow -s "zoomlazapzo" -p "oza"
    # Returns: "apzo"
#>

function Get-SmallestWindow {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [string]$s,
        
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [string]$p
    )
    
    # Edge cases
    if ([string]::IsNullOrEmpty($s) -or [string]::IsNullOrEmpty($p)) {
        return ""
    }
    
    if ($p.Length -gt $s.Length) {
        return ""
    }
    
    # Step 1: Create frequency map for pattern p
    # This tracks how many of each character we need
    $patternFreq = @{}
    foreach ($char in $p.ToCharArray()) {
        if ($patternFreq.ContainsKey($char)) {
            $patternFreq[$char]++
        } else {
            $patternFreq[$char] = 1
        }
    }
    
    # Number of unique characters in pattern that need to be matched
    $required = $patternFreq.Count
    
    # Step 2: Initialize sliding window variables
    $windowFreq = @{}    # Frequency map for current window
    $formed = 0          # Number of unique chars in window with required frequency
    $left = 0            # Left pointer of window
    $right = 0           # Right pointer of window
    
    # Track the minimum window: [length, left_index, right_index]
    $minLength = [int]::MaxValue
    $minLeft = 0
    $minRight = 0
    
    # Step 3: Slide the window
    while ($right -lt $s.Length) {
        # Add character from the right of the window
        $char = $s[$right]
        
        if ($windowFreq.ContainsKey($char)) {
            $windowFreq[$char]++
        } else {
            $windowFreq[$char] = 1
        }
        
        # Check if the current character's frequency matches required frequency
        if ($patternFreq.ContainsKey($char) -and $windowFreq[$char] -eq $patternFreq[$char]) {
            $formed++
        }
        
        # Step 4: Try to contract the window until it's no longer valid
        while ($formed -eq $required -and $left -le $right) {
            $char = $s[$left]
            
            # Update minimum window if current is smaller
            $windowLength = $right - $left + 1
            if ($windowLength -lt $minLength) {
                $minLength = $windowLength
                $minLeft = $left
                $minRight = $right
            }
            
            # Remove character from the left of the window
            $windowFreq[$char]--
            
            # If removing this character breaks the required frequency, decrement formed
            if ($patternFreq.ContainsKey($char) -and $windowFreq[$char] -lt $patternFreq[$char]) {
                $formed--
            }
            
            # Move left pointer forward
            $left++
        }
        
        # Move right pointer forward
        $right++
    }
    
    # Step 5: Return result
    if ($minLength -eq [int]::MaxValue) {
        return ""
    }
    
    return $s.Substring($minLeft, $minLength)
}

# Alternative implementation with detailed comments for learning
function Get-SmallestWindowVerbose {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [string]$s,
        
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [string]$p
    )
    
    Write-Verbose "Finding smallest window in '$s' containing all chars of '$p'"
    
    if ([string]::IsNullOrEmpty($s) -or [string]::IsNullOrEmpty($p)) {
        Write-Verbose "Empty input - returning empty string"
        return ""
    }
    
    if ($p.Length -gt $s.Length) {
        Write-Verbose "Pattern longer than source - impossible to find window"
        return ""
    }
    
    # Build pattern frequency map
    $patternFreq = @{}
    foreach ($char in $p.ToCharArray()) {
        if ($patternFreq.ContainsKey($char)) {
            $patternFreq[$char]++
        } else {
            $patternFreq[$char] = 1
        }
    }
    Write-Verbose "Pattern frequency: $($patternFreq | ConvertTo-Json -Compress)"
    
    $required = $patternFreq.Count
    $windowFreq = @{}
    $formed = 0
    $left = 0
    
    $result = ""
    $minLength = [int]::MaxValue
    
    for ($right = 0; $right -lt $s.Length; $right++) {
        $char = $s[$right]
        
        # Add to window
        if ($windowFreq.ContainsKey($char)) {
            $windowFreq[$char]++
        } else {
            $windowFreq[$char] = 1
        }
        
        Write-Verbose "Added '$char' at position $right. Window: [$left..$right]"
        
        # Check if this character satisfies its requirement
        if ($patternFreq.ContainsKey($char) -and $windowFreq[$char] -eq $patternFreq[$char]) {
            $formed++
            Write-Verbose "Character '$char' now satisfied. Formed: $formed/$required"
        }
        
        # Contract window while valid
        while ($formed -eq $required -and $left -le $right) {
            $windowLength = $right - $left + 1
            $currentWindow = $s.Substring($left, $windowLength)
            Write-Verbose "Valid window found: '$currentWindow' (length: $windowLength)"
            
            if ($windowLength -lt $minLength) {
                $minLength = $windowLength
                $result = $currentWindow
                Write-Verbose "New minimum! Result updated to '$result'"
            }
            
            # Remove leftmost character
            $leftChar = $s[$left]
            $windowFreq[$leftChar]--
            
            if ($patternFreq.ContainsKey($leftChar) -and $windowFreq[$leftChar] -lt $patternFreq[$leftChar]) {
                $formed--
                Write-Verbose "Removing '$leftChar' breaks requirement. Formed: $formed/$required"
            }
            
            $left++
        }
    }
    
    Write-Verbose "Final result: '$result'"
    return $result
}

# Functions are automatically available when dot-sourced
