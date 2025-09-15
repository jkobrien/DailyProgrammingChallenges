<#
Tests for Can-Form-StringStack
Run: pwsh -File .\test_string_stack.ps1
#>

. "$PSScriptRoot\string_stack.ps1"

$cases = @(
    @{Pat='geuaek'; Tar='geek'; Expected=$true; Name='Example 1'},
    @{Pat='agiffghd'; Tar='gfg'; Expected=$true; Name='Example 2'},
    @{Pat='abc'; Tar=''; Expected=$true; Name='Empty tar'},
    @{Pat=''; Tar='a'; Expected=$false; Name='Empty pat'},
    @{Pat='abab'; Tar='ab'; Expected=$true; Name='Possible (abab->ab)'}
)

$failures = 0
$index = 0
foreach ($c in $cases) {
    $index++
    $res = Test-StringStack -Pat $c.Pat -Tar $c.Tar
    if ($res -eq $c.Expected) {
        Write-Host "[PASS] $index - $($c.Name)"
    } else {
        Write-Host "[FAIL] $index - $($c.Name): got $res, expected $($c.Expected)"
        $failures++
    }
}

if ($failures -eq 0) {
    Write-Host "All tests passed." -ForegroundColor Green
    exit 0
} else {
    Write-Host "$failures tests failed." -ForegroundColor Red
    exit 1
}
