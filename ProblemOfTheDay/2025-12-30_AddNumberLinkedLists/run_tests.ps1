# Test runner for Add Number Linked Lists

Write-Host "=== Running Solution Demo ===" -ForegroundColor Yellow
Write-Host ""
& "$PSScriptRoot\add_number_linked_lists.ps1"

Write-Host ""
Write-Host ""
Write-Host "=== Running Tests ===" -ForegroundColor Yellow
Write-Host ""

# Load solution
. "$PSScriptRoot\add_number_linked_lists.ps1"

$passed = 0
$failed = 0
$testNum = 0

function RunTest($name, $list1, $list2, $expected) {
    $script:testNum++
    Write-Host "Test ${testNum}: $name" -ForegroundColor Cyan
    
    $head1 = ConvertTo-LinkedList -arr $list1
    $head2 = ConvertTo-LinkedList -arr $list2
    $result = Add-LinkedListNumbers -head1 $head1 -head2 $head2
    $resultArray = ConvertFrom-LinkedList -head $result
    
    $match = $true
    if ($resultArray.Length -ne $expected.Length) {
        $match = $false
    } else {
        for ($i = 0; $i -lt $resultArray.Length; $i++) {
            if ($resultArray[$i] -ne $expected[$i]) {
                $match = $false
                break
            }
        }
    }
    
    if ($match) {
        Write-Host "  PASSED" -ForegroundColor Green
        $script:passed++
    } else {
        Write-Host "  FAILED" -ForegroundColor Red
        $script:failed++
    }
}

RunTest "123 plus 999" @(1,2,3) @(9,9,9) @(1,1,2,2)
RunTest "63 plus 7" @(6,3) @(7) @(7,0)
RunTest "005 plus 003" @(0,0,5) @(0,0,3) @(8)
RunTest "9999 plus 1" @(9,9,9,9) @(1) @(1,0,0,0,0)
RunTest "5 plus 3" @(5) @(3) @(8)
RunTest "9 plus 9" @(9) @(9) @(1,8)
RunTest "0 plus 456" @(0) @(4,5,6) @(4,5,6)
RunTest "0 plus 0" @(0) @(0) @(0)
RunTest "Large numbers" @(1,2,3,4,5) @(6,7,8,9,0) @(8,0,2,3,5)
RunTest "Multiple carries" @(9,9,9) @(9,9,9) @(1,9,9,8)
RunTest "Very different lengths" @(1,0,0,0,0,0,0) @(1) @(1,0,0,0,0,0,1)
RunTest "Leading zeros with carry" @(0,0,9) @(0,0,9) @(1,8)
RunTest "All nines plus one" @(9,9,9,9,9) @(1) @(1,0,0,0,0,0)

Write-Host ""
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "Passed: $passed" -ForegroundColor Green
Write-Host "Failed: $failed" -ForegroundColor $(if ($failed -eq 0) { "Green" } else { "Red" })

if ($failed -eq 0) {
    Write-Host "`nAll tests passed!" -ForegroundColor Green
}
