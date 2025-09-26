<#
Rotate Deque By K (GeeksforGeeks POTD 2025-09-26)

Given a deque (double-ended queue) containing non-negative integers, along with two positive integers 
type and k, rotate the deque circularly by k positions.

Problem Statement:
- Input: deque dq, type (1 or 2), k (rotation count)
- Output: Rotated deque
- Type 1: Right rotation (clockwise) - move last element to front k times
- Type 2: Left rotation (counter-clockwise) - move first element to back k times
- Constraints: 1 ≤ dq.size() ≤ 10^5, 1 ≤ k ≤ 10^5, 1 ≤ type ≤ 2

Examples:
- dq = [1,2,3,4,5,6], type = 1, k = 2 → [5,6,1,2,3,4]
- dq = [10,20,30,40,50], type = 2, k = 3 → [40,50,10,20,30]

Approach:
1. Optimize rotation using modular arithmetic (k % n) to handle k > n
2. Use array slicing for efficient rotation:
   - Right rotation: Take last k elements + first (n-k) elements
   - Left rotation: Take first k elements + last (n-k) elements
3. Time: O(n), Space: O(n)
#>

function Invoke-RotateDequeByK {
    param(
        [int[]]$dq,
        [int]$type,
        [int]$k
    )
    
    $n = $dq.Length
    if ($n -eq 0 -or $k -eq 0 -or $n -eq 1) {
        return $dq
    }
    
    # Optimize k using modular arithmetic
    $k = $k % $n
    if ($k -eq 0) {
        return $dq
    }
    
    if ($type -eq 1) {
        # Right rotation: move last k elements to front
        # [1,2,3,4,5,6] k=2 → [5,6] + [1,2,3,4] → [5,6,1,2,3,4]
        if ($k -eq $n) {
            return $dq
        }
        $lastK = $dq[($n - $k)..($n - 1)]
        $firstNMinusK = if (($n - $k - 1) -ge 0) { $dq[0..($n - $k - 1)] } else { @() }
        return $lastK + $firstNMinusK
    }
    elseif ($type -eq 2) {
        # Left rotation: move first k elements to back
        # [10,20,30,40,50] k=3 → [40,50] + [10,20,30] → [40,50,10,20,30]
        if ($k -eq $n) {
            return $dq
        }
        $firstK = $dq[0..($k - 1)]
        $lastNMinusK = if ($k -lt $n) { $dq[$k..($n - 1)] } else { @() }
        return $lastNMinusK + $firstK
    }
    else {
        throw "Invalid rotation type. Use 1 for right rotation or 2 for left rotation."
    }
}

<#
Step-by-step verifier for validation (simulates actual rotation operations)
#>
function Invoke-RotateDequeByK-StepByStep {
    param(
        [int[]]$dq,
        [int]$type,
        [int]$k
    )
    
    $result = @() + $dq  # Create copy
    $n = $result.Length
    
    if ($n -eq 0 -or $k -eq 0 -or $n -eq 1) {
        return $result
    }
    
    # Perform actual rotation steps (for validation)
    for ($i = 0; $i -lt $k; $i++) {
        if ($type -eq 1) {
            # Right rotation: move last element to front
            $last = $result[-1]
            $result = @($last) + $result[0..($result.Length - 2)]
        }
        elseif ($type -eq 2) {
            # Left rotation: move first element to back
            $first = $result[0]
            $result = $result[1..($result.Length - 1)] + @($first)
        }
    }
    
    return $result
}

<#
Comprehensive test harness
#>
function Test-RotateDequeByK {
    Write-Host "Testing Rotate Deque By K..." -ForegroundColor Cyan
    
    # Fixed test cases from problem examples
    $tests = @(
        @{ dq = @(1,2,3,4,5,6); type = 1; k = 2; expected = @(5,6,1,2,3,4); desc = "Example 1: Right rotation" },
        @{ dq = @(10,20,30,40,50); type = 2; k = 3; expected = @(40,50,10,20,30); desc = "Example 2: Left rotation" },
        @{ dq = @(1,2,3,4); type = 1; k = 1; expected = @(4,1,2,3); desc = "Right rotation by 1" },
        @{ dq = @(1,2,3,4); type = 2; k = 1; expected = @(2,3,4,1); desc = "Left rotation by 1" },
        @{ dq = @(1,2,3); type = 1; k = 3; expected = @(1,2,3); desc = "Right rotation by n (full cycle)" },
        @{ dq = @(1,2,3); type = 2; k = 6; expected = @(1,2,3); desc = "Left rotation by 2n (no change)" },
        @{ dq = @(1,2,3,4,5); type = 1; k = 7; expected = @(4,5,1,2,3); desc = "Right rotation k > n" },
        @{ dq = @(1,2,3,4,5); type = 2; k = 8; expected = @(4,5,1,2,3); desc = "Left rotation k > n" },
        @{ dq = @(42); type = 1; k = 5; expected = @(42); desc = "Single element array" },
        @{ dq = @(); type = 1; k = 3; expected = @(); desc = "Empty array" },
        @{ dq = @(1,2,3,4); type = 1; k = 0; expected = @(1,2,3,4); desc = "Zero rotations" }
    )
    
    foreach ($test in $tests) {
        try {
            $result = Invoke-RotateDequeByK $test.dq $test.type $test.k
            $stepResult = Invoke-RotateDequeByK-StepByStep $test.dq $test.type $test.k
            
            # Compare arrays element by element
            $resultMatch = ($result.Length -eq $test.expected.Length)
            $stepMatch = ($stepResult.Length -eq $test.expected.Length)
            $crossMatch = ($result.Length -eq $stepResult.Length)
            
            if ($resultMatch) {
                for ($i = 0; $i -lt $result.Length; $i++) {
                    if ($result[$i] -ne $test.expected[$i]) {
                        $resultMatch = $false
                        break
                    }
                }
            }
            
            if ($stepMatch) {
                for ($i = 0; $i -lt $stepResult.Length; $i++) {
                    if ($stepResult[$i] -ne $test.expected[$i]) {
                        $stepMatch = $false
                        break
                    }
                }
            }
            
            if ($crossMatch) {
                for ($i = 0; $i -lt $result.Length; $i++) {
                    if ($result[$i] -ne $stepResult[$i]) {
                        $crossMatch = $false
                        break
                    }
                }
            }
            
            $pass = $resultMatch -and $stepMatch -and $crossMatch
            
            $inputStr = "[$($test.dq -join ',')]"
            $resultStr = "[$($result -join ',')]"
            $expectedStr = "[$($test.expected -join ',')]"
            
            Write-Host "$($test.desc)" -ForegroundColor Yellow
            Write-Host "  Input: $inputStr, type=$($test.type), k=$($test.k)" -ForegroundColor Gray
            Write-Host "  Expected: $expectedStr | Result: $resultStr | $([bool]$pass -replace 'True','PASS' -replace 'False','FAIL')" -ForegroundColor $(if($pass){'Green'}else{'Red'})
        }
        catch {
            Write-Host "$($test.desc) | ERROR: $($_.Exception.Message)" -ForegroundColor Red
        }
    }
    
    # Randomized tests
    Write-Host "`nRandomized tests:" -ForegroundColor Yellow
    for ($t = 0; $t -lt 5; $t++) {
        $len = Get-Random -Minimum 1 -Maximum 10
        $dq = @(for ($i = 0; $i -lt $len; $i++) { Get-Random -Minimum 1 -Maximum 100 })
        $type = Get-Random -Minimum 1 -Maximum 3  # 1 or 2
        $k = Get-Random -Minimum 0 -Maximum 15
        
        try {
            $result = Invoke-RotateDequeByK $dq $type $k
            $stepResult = Invoke-RotateDequeByK-StepByStep $dq $type $k
            
            $match = ($result.Length -eq $stepResult.Length)
            if ($match) {
                for ($i = 0; $i -lt $result.Length; $i++) {
                    if ($result[$i] -ne $stepResult[$i]) {
                        $match = $false
                        break
                    }
                }
            }
            
            $inputStr = if ($dq.Length -le 8) { "[$($dq -join ',')]" } else { "[...$(($dq).Length) items...]" }
            $resultStr = if ($result.Length -le 8) { "[$($result -join ',')]" } else { "[...$(($result).Length) items...]" }
            
            Write-Host "  Input: $inputStr, type=$type, k=$k | Result: $resultStr | $([bool]$match -replace 'True','PASS' -replace 'False','FAIL')" -ForegroundColor $(if($match){'Green'}else{'Red'})
        }
        catch {
            Write-Host "  Random test failed: $($_.Exception.Message)" -ForegroundColor Red
        }
    }
    
    Write-Host "`nTests completed." -ForegroundColor Cyan
}

# Run tests if script is executed directly
if ($MyInvocation.InvocationName -ne '.') {
    Test-RotateDequeByK
}