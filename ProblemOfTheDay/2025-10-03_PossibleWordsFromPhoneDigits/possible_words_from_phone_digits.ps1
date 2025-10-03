# GeeksforGeeks Problem of the Day - October 3, 2025
# Problem: Possible Words From Phone Digits
# Difficulty: Medium | Companies: Flipkart, Amazon, Microsoft

<#
.SYNOPSIS
    Generates all possible words that can be formed by pressing phone keypad numbers sequentially.

.DESCRIPTION
    Given an array of digits (2-9), this function returns all possible words that can be formed
    by pressing the corresponding letters on a phone keypad. Each digit maps to specific letters:
    2: abc, 3: def, 4: ghi, 5: jkl, 6: mno, 7: pqrs, 8: tuv, 9: wxyz
    Note: Digits 0 and 1 do not map to any letters.

.PARAMETER digits
    Array of integers representing the digits to be pressed (2-9 only)

.EXAMPLE
    Get-PossibleWords -digits @(2, 3)
    Returns: @("ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf")

.EXAMPLE
    Get-PossibleWords -digits @(2)
    Returns: @("a", "b", "c")
#>

function Get-PossibleWords {
    param(
        [int[]]$digits
    )
    
    # Phone keypad mapping - digits to letters
    $phoneMap = @{
        2 = @('a', 'b', 'c')
        3 = @('d', 'e', 'f')
        4 = @('g', 'h', 'i')
        5 = @('j', 'k', 'l')
        6 = @('m', 'n', 'o')
        7 = @('p', 'q', 'r', 's')
        8 = @('t', 'u', 'v')
        9 = @('w', 'x', 'y', 'z')
    }
    
    # Handle empty input
    if ($digits.Length -eq 0) {
        return @()
    }
    
    # Filter out digits 0 and 1 as they don't map to letters
    $validDigits = $digits | Where-Object { $_ -ge 2 -and $_ -le 9 }
    
    # If no valid digits, return empty array
    if ($validDigits.Length -eq 0) {
        return @()
    }
    
    # Start with empty combinations
    $combinations = @("")
    
    # For each valid digit, expand all current combinations
    foreach ($digit in $validDigits) {
        if ($phoneMap.ContainsKey($digit)) {
            $letters = $phoneMap[$digit]
            $newCombinations = @()
            
            # For each existing combination
            foreach ($combination in $combinations) {
                # Add each possible letter for current digit
                foreach ($letter in $letters) {
                    $newCombinations += ($combination + $letter)
                }
            }
            
            $combinations = $newCombinations
        }
    }
    
    # Return sorted result
    return $combinations | Sort-Object
}

# Test function to validate the solution
function Test-PossibleWords {
    Write-Host "Testing Possible Words From Phone Digits Solution..." -ForegroundColor Yellow
    Write-Host "=" * 60
    
    $testCases = @(
        @{
            Input = @(2, 3)
            Expected = @("ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf")
            Description = "Test case 1: digits [2, 3]"
        },
        @{
            Input = @(2)
            Expected = @("a", "b", "c")
            Description = "Test case 2: digits [2]"
        },
        @{
            Input = @(7)
            Expected = @("p", "q", "r", "s")
            Description = "Test case 3: digits [7]"
        },
        @{
            Input = @(2, 3, 4)
            Expected = @("adg", "adh", "adi", "aeg", "aeh", "aei", "afg", "afh", "afi", 
                        "bdg", "bdh", "bdi", "beg", "beh", "bei", "bfg", "bfh", "bfi",
                        "cdg", "cdh", "cdi", "ceg", "ceh", "cei", "cfg", "cfh", "cfi")
            Description = "Test case 4: digits [2, 3, 4] - 27 combinations"
        },
        @{
            Input = @()
            Expected = @()
            Description = "Test case 5: empty input"
        },
        @{
            Input = @(0, 1)
            Expected = @()
            Description = "Test case 6: digits with no mapping [0, 1] - should return empty array"
        }
    )
    
    $totalTests = $testCases.Count
    $passedTests = 0
    
    foreach ($test in $testCases) {
        Write-Host "`n$($test.Description)" -ForegroundColor Cyan
        Write-Host "Input: [$($test.Input -join ', ')]"
        
        $result = Get-PossibleWords -digits $test.Input
        
        Write-Host "Output: [$($result -join ', ')]"
        Write-Host "Expected: [$($test.Expected -join ', ')]"
        
        # Compare results
        $isEqual = $true
        if ($result.Count -ne $test.Expected.Count) {
            $isEqual = $false
        } else {
            for ($i = 0; $i -lt $result.Count; $i++) {
                if ($result[$i] -ne $test.Expected[$i]) {
                    $isEqual = $false
                    break
                }
            }
        }
        
        if ($isEqual) {
            Write-Host "Result: PASS" -ForegroundColor Green
            $passedTests++
        } else {
            Write-Host "Result: FAIL" -ForegroundColor Red
            Write-Host "Expected $($test.Expected.Count) combinations, got $($result.Count)" -ForegroundColor Red
        }
        
        Write-Host "-" * 40
    }
    
    Write-Host "`nTest Summary:" -ForegroundColor Yellow
    Write-Host "Passed: $passedTests/$totalTests tests" -ForegroundColor $(if ($passedTests -eq $totalTests) { "Green" } else { "Red" })
    
    if ($passedTests -eq $totalTests) {
        Write-Host "All tests passed! ✓" -ForegroundColor Green
    } else {
        Write-Host "Some tests failed! ✗" -ForegroundColor Red
    }
}

# Benchmark function to test performance
function Benchmark-PossibleWords {
    Write-Host "`nPerformance Benchmark:" -ForegroundColor Yellow
    Write-Host "=" * 30
    
    $benchmarkCases = @(
        @{ Input = @(2, 3); Description = "Small input (2 digits)" },
        @{ Input = @(2, 3, 4); Description = "Medium input (3 digits)" },
        @{ Input = @(2, 3, 4, 5); Description = "Large input (4 digits)" }
    )
    
    foreach ($benchmark in $benchmarkCases) {
        Write-Host "`n$($benchmark.Description):"
        $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
        $result = Get-PossibleWords -digits $benchmark.Input
        $stopwatch.Stop()
        
        Write-Host "Input: [$($benchmark.Input -join ', ')]"
        Write-Host "Combinations generated: $($result.Count)"
        Write-Host "Time taken: $($stopwatch.ElapsedMilliseconds) ms"
    }
}

# Main execution
if ($MyInvocation.InvocationName -ne '.') {
    # Run tests when script is executed directly
    Test-PossibleWords
    Benchmark-PossibleWords
    
    Write-Host "`n" + "=" * 60
    Write-Host "GeeksforGeeks POTD - October 3, 2025 - Solution Completed!" -ForegroundColor Green
    Write-Host "Problem: Possible Words From Phone Digits" -ForegroundColor Green
    Write-Host "=" * 60
}