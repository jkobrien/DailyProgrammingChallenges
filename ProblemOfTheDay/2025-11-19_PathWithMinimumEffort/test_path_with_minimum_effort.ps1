# Test script for Path With Minimum Effort

. "$PSScriptRoot/path_with_minimum_effort.ps1"

function Test-PathWithMinimumEffort {
    $tests = @(
        @{ mat = @( @(7,2,6,5), @(3,1,10,8) ); expected = 4 },
        @{ mat = @( @(2,2,2,1), @(8,1,2,7), @(2,2,2,8), @(2,1,4,7), @(2,2,2,2) ); expected = 0 }
    )
    $pass = 0
    $fail = 0
    foreach ($test in $tests) {
        $result = Path-WithMinimumEffort $test.mat
        if ($result -eq $test.expected) {
            Write-Host "PASS: Output $result matches expected $($test.expected)"
            $pass++
        } else {
            Write-Host "FAIL: Output $result does not match expected $($test.expected)"
            $fail++
        }
    }
    Write-Host "Tests passed: $pass, failed: $fail"
}

Test-PathWithMinimumEffort
