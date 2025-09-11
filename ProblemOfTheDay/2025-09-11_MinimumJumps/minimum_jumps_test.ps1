<#
Test runner for Minimum Jumps solution.
Runs several test cases (including the GeeksforGeeks examples) and reports
pass/fail. Exits with code 0 on success and 1 on failure.

Run:
  pwsh .\minimum_jumps_test.ps1
#>

# Dot-source the implementation in the same folder
. "$PSScriptRoot\minimum_jumps.ps1"

$tests = @(
    @{ arr = @(1,3,5,8,9,2,6,7,6,8,9); expected = 3; description = 'Example 1' }
    @{ arr = @(1,4,3,2,6,7); expected = 2; description = 'Example 2' }
    @{ arr = @(0,10,20); expected = -1; description = 'Cannot move from first element' }
    @{ arr = @(2,0,0); expected = 1; description = 'Direct jump to end' }
    @{ arr = @(1); expected = 0; description = 'Single element' }
    @{ arr = @(1,0,1,0); expected = -1; description = 'Blocked in middle' }
)

$allPassed = $true

foreach ($t in $tests) {
    $arr = $t.arr
    $expected = $t.expected
    $desc = $t.description

    try {
        $actual = Get-MinimumJumps -arr $arr
    }
    catch {
        Write-Host "Test '$desc' threw an exception: $_" -ForegroundColor Yellow
        $actual = 'Error'
    }

    if ($actual -eq $expected) {
        Write-Host "PASS: $desc -> expected=$expected, actual=$actual" -ForegroundColor Green
    } else {
        Write-Host "FAIL: $desc -> expected=$expected, actual=$actual" -ForegroundColor Red
        $allPassed = $false
    }
}

if (-not $allPassed) {
    Write-Host "Some tests failed." -ForegroundColor Red
    exit 1
} else {
    Write-Host "All tests passed." -ForegroundColor Green
    exit 0
}
