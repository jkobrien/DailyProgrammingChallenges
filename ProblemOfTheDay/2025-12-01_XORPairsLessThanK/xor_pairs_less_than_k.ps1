<#
.SYNOPSIS
    Count pairs from array where XOR is less than k

.DESCRIPTION
    Given an array and integer k, counts the number of pairs where the 
    Bitwise XOR of each pair is less than k.
    
    Uses a Binary Trie data structure for O(n) time complexity.

.PARAMETER arr
    Array of integers

.PARAMETER k
    Integer threshold value

.EXAMPLE
    Get-XORPairsLessThanK -arr @(1, 2, 3, 5) -k 5
    Returns: 4

.EXAMPLE
    Get-XORPairsLessThanK -arr @(3, 5, 6, 8) -k 7
    Returns: 3

.NOTES
    Time Complexity: O(n * log(max_value))
    Space Complexity: O(n * log(max_value))
    
    The trie has maximum depth of 32 bits (for 32-bit integers)
#>

# Define TrieNode class
class TrieNode {
    [hashtable]$Children
    [int]$Count
    
    TrieNode() {
        $this.Children = @{}
        $this.Count = 0
    }
}

# Define Trie class for Binary Trie
class BinaryTrie {
    [TrieNode]$Root
    [int]$MaxBits
    
    BinaryTrie() {
        $this.Root = [TrieNode]::new()
        $this.MaxBits = 32  # For 32-bit integers
    }
    
    # Insert a number into the trie
    [void]Insert([int]$num) {
        $node = $this.Root
        
        # Traverse from most significant bit to least significant
        for ($i = $this.MaxBits - 1; $i -ge 0; $i--) {
            $bit = ($num -shr $i) -band 1
            
            if (-not $node.Children.ContainsKey($bit)) {
                $node.Children[$bit] = [TrieNode]::new()
            }
            
            $node = $node.Children[$bit]
            $node.Count++
        }
    }
    
    # Query: Count numbers in trie where (num XOR existing) < k
    [int]Query([int]$num, [int]$k) {
        return $this.QueryHelper($this.Root, $num, $k, $this.MaxBits - 1)
    }
    
    # Recursive helper for query
    [int]QueryHelper([TrieNode]$node, [int]$num, [int]$k, [int]$bit) {
        if ($null -eq $node -or $bit -lt 0) {
            return 0
        }
        
        $numBit = ($num -shr $bit) -band 1
        $kBit = ($k -shr $bit) -band 1
        $count = 0
        
        if ($kBit -eq 1) {
            # If k's bit is 1, we can include all numbers where XOR bit matches numBit
            # (because XOR will be 0 at this position, making result < k)
            if ($node.Children.ContainsKey($numBit)) {
                $count += $node.Children[$numBit].Count
            }
            
            # Also explore the opposite bit (XOR will be 1, but we have more bits to check)
            if ($node.Children.ContainsKey(1 - $numBit)) {
                $count += $this.QueryHelper($node.Children[1 - $numBit], $num, $k, $bit - 1)
            }
        }
        else {
            # If k's bit is 0, we can only take the path where XOR bit is 0
            # (to ensure XOR < k)
            if ($node.Children.ContainsKey($numBit)) {
                $count += $this.QueryHelper($node.Children[$numBit], $num, $k, $bit - 1)
            }
        }
        
        return $count
    }
}

function Get-XORPairsLessThanK {
    param (
        [Parameter(Mandatory=$true)]
        [int[]]$arr,
        
        [Parameter(Mandatory=$true)]
        [int]$k
    )
    
    # Input validation
    if ($arr.Count -eq 0) {
        return 0
    }
    
    if ($k -le 0) {
        return 0
    }
    
    # Create binary trie
    $trie = [BinaryTrie]::new()
    $pairCount = 0
    
    # Process each number
    foreach ($num in $arr) {
        # Query how many existing numbers form valid pairs with current number
        $pairCount += $trie.Query($num, $k)
        
        # Insert current number into trie
        $trie.Insert($num)
    }
    
    return $pairCount
}

# Alternative brute force solution for verification (O(n²))
function Get-XORPairsLessThanK-BruteForce {
    param (
        [Parameter(Mandatory=$true)]
        [int[]]$arr,
        
        [Parameter(Mandatory=$true)]
        [int]$k
    )
    
    $count = 0
    $n = $arr.Count
    
    for ($i = 0; $i -lt $n; $i++) {
        for ($j = $i + 1; $j -lt $n; $j++) {
            $xorValue = $arr[$i] -bxor $arr[$j]
            if ($xorValue -lt $k) {
                $count++
            }
        }
    }
    
    return $count
}

# Main execution block
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "=== XOR Pairs less than K ===" -ForegroundColor Cyan
    Write-Host ""
    
    # Example 1
    Write-Host "Example 1:" -ForegroundColor Yellow
    $arr1 = @(1, 2, 3, 5)
    $k1 = 5
    Write-Host "Input: arr = [$($arr1 -join ', ')], k = $k1"
    $result1 = Get-XORPairsLessThanK -arr $arr1 -k $k1
    Write-Host "Output: $result1" -ForegroundColor Green
    Write-Host "Expected: 4"
    Write-Host ""
    
    # Show the pairs
    Write-Host "Valid pairs:" -ForegroundColor Gray
    for ($i = 0; $i -lt $arr1.Count; $i++) {
        for ($j = $i + 1; $j -lt $arr1.Count; $j++) {
            $xorVal = $arr1[$i] -bxor $arr1[$j]
            if ($xorVal -lt $k1) {
                Write-Host ("  {0} XOR {1} = {2}" -f $arr1[$i], $arr1[$j], $xorVal) -ForegroundColor Gray
            }
        }
    }
    Write-Host ""
    
    # Example 2
    Write-Host "Example 2:" -ForegroundColor Yellow
    $arr2 = @(3, 5, 6, 8)
    $k2 = 7
    Write-Host "Input: arr = [$($arr2 -join ', ')], k = $k2"
    $result2 = Get-XORPairsLessThanK -arr $arr2 -k $k2
    Write-Host "Output: $result2" -ForegroundColor Green
    Write-Host "Expected: 3"
    Write-Host ""
    
    # Show the pairs
    Write-Host "Valid pairs:" -ForegroundColor Gray
    for ($i = 0; $i -lt $arr2.Count; $i++) {
        for ($j = $i + 1; $j -lt $arr2.Count; $j++) {
            $xorVal = $arr2[$i] -bxor $arr2[$j]
            if ($xorVal -lt $k2) {
                Write-Host ("  {0} XOR {1} = {2}" -f $arr2[$i], $arr2[$j], $xorVal) -ForegroundColor Gray
            }
        }
    }
    Write-Host ""
    
    # Additional test case
    Write-Host "Example 3:" -ForegroundColor Yellow
    $arr3 = @(10, 20, 30, 40)
    $k3 = 15
    Write-Host "Input: arr = [$($arr3 -join ', ')], k = $k3"
    $result3 = Get-XORPairsLessThanK -arr $arr3 -k $k3
    Write-Host "Output: $result3" -ForegroundColor Green
    
    # Verify with brute force
    $bruteForce = Get-XORPairsLessThanK-BruteForce -arr $arr3 -k $k3
    Write-Host "Brute force verification: $bruteForce" -ForegroundColor Gray
    Write-Host ""
}
