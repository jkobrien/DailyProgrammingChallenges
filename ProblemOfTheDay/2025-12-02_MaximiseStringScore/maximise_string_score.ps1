<#
.SYNOPSIS
    Maximise String Score - GeeksforGeeks Problem of the Day (December 2, 2025)

.DESCRIPTION
    Given a string and a list of jump rules, calculate the maximum score achievable
    by performing valid jumps starting from index 0. You can jump from character s1 
    to s2 if there's a rule [s1, s2], or from a character to another occurrence of 
    the same character. The score is the sum of ASCII values between jumps, excluding 
    characters equal to the destination character.

.PARAMETER s
    The input string to process

.PARAMETER jumps
    Array of jump rules, where each rule is a 2-element array [source_char, dest_char]

.EXAMPLE
    Get-MaximiseStringScore -s "forgfg" -jumps @(@('f', 'r'), @('r', 'g'))
    Returns: 429

.EXAMPLE
    Get-MaximiseStringScore -s "abcda" -jumps @(@('b', 'd'))
    Returns: 297

.NOTES
    Time Complexity: O(26 * n) where n is the length of the string
    Space Complexity: O(26 * n) for prefix sums and DP array
#>

function Get-MaximiseStringScore {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$s,
        
        [Parameter(Mandatory = $true)]
        [array]$jumps
    )
    
    $n = $s.Length
    
    # Handle edge case
    if ($n -le 1) {
        return 0
    }
    
    # Build jump map: for each character, store which characters it can jump to
    $jumpMap = @{}
    foreach ($jump in $jumps) {
        if ($jump.Length -ge 2) {
            $from = $jump[0]
            $to = $jump[1]
            
            # Skip if either character is null or empty
            if ([string]::IsNullOrEmpty($from) -or [string]::IsNullOrEmpty($to)) {
                continue
            }
            
            if (-not $jumpMap.ContainsKey($from)) {
                $jumpMap[$from] = @{}
            }
            $jumpMap[$from][$to] = $true
        }
    }
    
    # Build prefix sums for each character (0-indexed)
    # charPrefix[c][i] = count of character c from index 0 to i
    $charPrefix = @{}
    $totalPrefix = New-Object int[] ($n + 1)  # Total ASCII sum prefix
    
    for ($i = 0; $i -lt $n; $i++) {
        $char = $s[$i]
        $asciiVal = [int][char]$char
        
        # Update total prefix sum
        $totalPrefix[$i + 1] = $totalPrefix[$i] + $asciiVal
        
        # Update character-specific prefix sum
        if (-not $charPrefix.ContainsKey($char)) {
            $charPrefix[$char] = New-Object int[] ($n + 1)
        }
        
        # Copy previous values for all characters
        foreach ($c in $charPrefix.Keys) {
            if ($c -eq $char) {
                $charPrefix[$c][$i + 1] = $charPrefix[$c][$i] + $asciiVal
            } else {
                $charPrefix[$c][$i + 1] = $charPrefix[$c][$i]
            }
        }
    }
    
    # Build position map: for each character, store all positions where it appears
    $charPositions = @{}
    for ($i = 0; $i -lt $n; $i++) {
        $char = $s[$i]
        if (-not $charPositions.ContainsKey($char)) {
            $charPositions[$char] = @()
        }
        $charPositions[$char] += $i
    }
    
    # Dynamic Programming: dp[i] = maximum score achievable when at position i
    $dp = New-Object int[] $n
    $dp[0] = 0
    
    for ($i = 0; $i -lt $n; $i++) {
        $currentChar = $s[$i]
        
        # Option 1: Jump using jump rules
        if ($jumpMap.ContainsKey($currentChar)) {
            $allowedDestinations = $jumpMap[$currentChar]
            
            foreach ($destChar in $allowedDestinations.Keys) {
                # Find all positions where destChar appears after position i
                if ($charPositions.ContainsKey($destChar)) {
                    foreach ($j in $charPositions[$destChar]) {
                        if ($j -gt $i) {
                            # Calculate score: sum from i to j-1, excluding destChar
                            $totalSum = $totalPrefix[$j] - $totalPrefix[$i]
                            
                            # Subtract the sum of destChar occurrences from i to j-1
                            $destCharSum = 0
                            if ($charPrefix.ContainsKey($destChar)) {
                                $destCharSum = $charPrefix[$destChar][$j] - $charPrefix[$destChar][$i]
                            }
                            
                            $score = $totalSum - $destCharSum
                            $dp[$j] = [Math]::Max($dp[$j], $dp[$i] + $score)
                        }
                    }
                }
            }
        }
        
        # Option 2: Jump to another occurrence of the same character
        if ($charPositions.ContainsKey($currentChar)) {
            foreach ($j in $charPositions[$currentChar]) {
                if ($j -gt $i) {
                    # Calculate score: sum from i to j-1, excluding currentChar
                    $totalSum = $totalPrefix[$j] - $totalPrefix[$i]
                    
                    # Subtract the sum of currentChar occurrences from i to j-1
                    $currentCharSum = 0
                    if ($charPrefix.ContainsKey($currentChar)) {
                        $currentCharSum = $charPrefix[$currentChar][$j] - $charPrefix[$currentChar][$i]
                    }
                    
                    $score = $totalSum - $currentCharSum
                    $dp[$j] = [Math]::Max($dp[$j], $dp[$i] + $score)
                }
            }
        }
    }
    
    # Return the maximum score from any position
    $maxScore = 0
    for ($i = 0; $i -lt $n; $i++) {
        $maxScore = [Math]::Max($maxScore, $dp[$i])
    }
    
    return $maxScore
}

<#
EXPLANATION:

The solution uses Dynamic Programming with prefix sums for efficient calculation:

1. **Jump Map Construction:**
   - Build a hash table mapping each source character to its valid destination characters
   - This allows O(1) lookup for valid jumps

2. **Prefix Sum Arrays:**
   - `totalPrefix[i]`: Sum of ASCII values from index 0 to i-1
   - `charPrefix[c][i]`: Sum of ASCII values of character c from index 0 to i-1
   - These allow O(1) calculation of sum in any range

3. **Position Map:**
   - Store all positions where each character appears
   - Enables quick lookup of valid jump destinations

4. **Dynamic Programming:**
   - `dp[i]`: Maximum score achievable when reaching position i
   - For each position i, try all valid jumps to position j > i
   - Calculate score using prefix sums: (total sum from i to j) - (sum of destination char)
   - Update dp[j] with the maximum score

5. **Score Calculation:**
   When jumping from position i to position j:
   - Total sum = totalPrefix[j] - totalPrefix[i]
   - Subtract occurrences of destination character: charPrefix[destChar][j] - charPrefix[destChar][i]
   - Final score = total sum - destination char sum

6. **Result:**
   - The maximum value in the dp array is the answer

Time Complexity: O(26 * n) - For each position, we check at most 26 characters
Space Complexity: O(26 * n) - For character-specific prefix sums and dp array
#>
