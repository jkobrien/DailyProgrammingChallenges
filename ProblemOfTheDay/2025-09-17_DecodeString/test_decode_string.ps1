<#
Tests for Invoke-DecodeString
Run: pwsh -File .\test_decode_string.ps1
#>

. "$PSScriptRoot\decode_string.ps1"

$cases = @(
    @{Input='3[a]'; Expected='aaa'; Name='Simple repeat'},
    @{Input='2[bc]'; Expected='bcbc'; Name='Multi-char repeat'},
    @{Input='3[a2[c]]'; Expected='accaccacc'; Name='Nested brackets'},
    @{Input='2[abc]3[cd]ef'; Expected='abcabccdcdcdef'; Name='Multiple sections'},
    @{Input='abc3[cd]xyz'; Expected='abccdcdcdxyz'; Name='Prefix and suffix'},
    @{Input=''; Expected=''; Name='Empty string'},
    @{Input='abc'; Expected='abc'; Name='No encoding'},
    @{Input='10[a]'; Expected='aaaaaaaaaa'; Name='Double digit count'},
    @{Input='2[a3[b2[c]]]'; Expected='abccbccbccabccbccbcc'; Name='Deep nesting'}
)

$failures = 0
$index = 0
foreach ($c in $cases) {
    $index++
    try {
        $result = Invoke-DecodeString -EncodedString $c.Input
    } catch {
        $result = "ERROR: $_"
    }

    if ($result -eq $c.Expected) {
        Write-Host "[PASS] Test $index - $($c.Name): '$($c.Input)' -> '$result'"
    } else {
        Write-Host "[FAIL] Test $index - $($c.Name): '$($c.Input)' -> got '$result', expected '$($c.Expected)'"
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