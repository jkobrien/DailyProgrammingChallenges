<#
Generate Binary Numbers (GeeksforGeeks POTD 2025-09-25)

Given a number n, generate all binary numbers with decimal values from 1 to n.

Problem Statement:
- Input: A positive integer n (1 ≤ n ≤ 10^6)
- Output: Array of binary strings representing numbers from 1 to n
- Examples:
  * n = 4 → ["1", "10", "11", "100"]
  * n = 6 → ["1", "10", "11", "100", "101", "110"]

Approach:
1. Queue-based BFS approach for efficiency:
   - Start with "1" in queue
   - For each binary number in queue, generate next two by appending "0" and "1"
   - Continue until we have n binary numbers
   - Time: O(n), Space: O(n)

2. Alternative: Direct conversion using [Convert]::ToString(i, 2) for each i from 1 to n
   - Simpler but potentially less efficient for very large n
   - Time: O(n * log n), Space: O(1) additional
#>

function Get-GenerateBinaryNumbers {
    param(
        [int]$n
    )
    
    if ($n -le 0) {
        return @()
    }
    
    $result = @()
    $queue = New-Object System.Collections.Queue
    $queue.Enqueue("1")
    
    for ($i = 0; $i -lt $n; $i++) {
        $current = $queue.Dequeue()
        $result += $current
        
        # Generate next level binary numbers by appending 0 and 1
        $queue.Enqueue($current + "0")
        $queue.Enqueue($current + "1")
    }
    
    return $result
}

<#
Brute-force verifier using direct conversion for correctness validation
#>
function Get-GenerateBinaryNumbers-Brute {
    param(
        [int]$n
    )
    
    if ($n -le 0) {
        return @()
    }
    
    $result = @()
    for ($i = 1; $i -le $n; $i++) {
        $result += [Convert]::ToString($i, 2)
    }
    
    return $result
}

<#
Test harness with fixed and randomized test cases
#>
function Test-GenerateBinaryNumbers {
    Write-Host "Testing Generate Binary Numbers..." -ForegroundColor Cyan
    
    # Fixed test cases
    $tests = @(
        @{ n = 4; expected = @("1", "10", "11", "100") },
        @{ n = 6; expected = @("1", "10", "11", "100", "101", "110") },
        @{ n = 1; expected = @("1") },
        @{ n = 3; expected = @("1", "10", "11") },
        @{ n = 8; expected = @("1", "10", "11", "100", "101", "110", "111", "1000") },
        @{ n = 0; expected = @() }
    )
    
    foreach ($test in $tests) {
        $result = Get-GenerateBinaryNumbers $test.n
        $brute = Get-GenerateBinaryNumbers-Brute $test.n
        
        # Compare arrays element by element
        $resultMatch = ($result.Length -eq $test.expected.Length)
        $bruteMatch = ($brute.Length -eq $test.expected.Length)
        
        if ($resultMatch) {
            for ($i = 0; $i -lt $result.Length; $i++) {
                if ($result[$i] -ne $test.expected[$i]) {
                    $resultMatch = $false
                    break
                }
            }
        }
        
        if ($bruteMatch) {
            for ($i = 0; $i -lt $brute.Length; $i++) {
                if ($brute[$i] -ne $test.expected[$i]) {
                    $bruteMatch = $false
                    break
                }
            }
        }
        
        $crossMatch = ($result.Length -eq $brute.Length)
        if ($crossMatch) {
            for ($i = 0; $i -lt $result.Length; $i++) {
                if ($result[$i] -ne $brute[$i]) {
                    $crossMatch = $false
                    break
                }
            }
        }
        
        $pass = $resultMatch -and $bruteMatch -and $crossMatch
        $resultStr = if ($result.Length -le 8) { "[$($result -join ', ')]" } else { "[...$(($result).Length) items...]" }
        $expectedStr = if ($test.expected.Length -le 8) { "[$($test.expected -join ', ')]" } else { "[...$(($test.expected).Length) items...]" }
        
        Write-Host "n=$($test.n) | Expected=$expectedStr | Result=$resultStr | $([bool]$pass -replace 'True','PASS' -replace 'False','FAIL')" -ForegroundColor $(if($pass){'Green'}else{'Red'})
    }
    
    # Randomized tests
    Write-Host "`nRandomized tests:" -ForegroundColor Yellow
    for ($t = 0; $t -lt 5; $t++) {
        $n = Get-Random -Minimum 1 -Maximum 50
        $result = Get-GenerateBinaryNumbers $n
        $brute = Get-GenerateBinaryNumbers-Brute $n
        
        $match = ($result.Length -eq $brute.Length) -and ($result.Length -eq $n)
        if ($match) {
            for ($i = 0; $i -lt $result.Length; $i++) {
                if ($result[$i] -ne $brute[$i]) {
                    $match = $false
                    break
                }
            }
        }
        
        $resultStr = if ($result.Length -le 6) { "[$($result -join ', ')]" } else { "[...$(($result).Length) items...]" }
        Write-Host "n=$n | Result=$resultStr | $([bool]$match -replace 'True','PASS' -replace 'False','FAIL')" -ForegroundColor $(if($match){'Green'}else{'Red'})
    }
    
    Write-Host "`nTests completed." -ForegroundColor Cyan
}

# Run tests if script is executed directly
if ($MyInvocation.InvocationName -ne '.') {
    Test-GenerateBinaryNumbers
}