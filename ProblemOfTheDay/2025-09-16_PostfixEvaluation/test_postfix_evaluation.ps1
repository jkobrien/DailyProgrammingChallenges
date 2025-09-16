<#
Tests for Invoke-PostfixExpression
Run: pwsh -File .\test_postfix_evaluation.ps1
#>

. "$PSScriptRoot\postfix_evaluation.ps1"

$cases = @(
    @{Expr='231*+9-'; Expected= -4; Name='Example classic'},
    @{Expr='10 2 8 * + 3 -'; Expected=23; Name='Spaces with multi-digit'},
    @{Expr='5 1 2 + 4 * + 3 -'; Expected=14; Name='Multi-digit classic'},
    @{Expr='7 2 /'; Expected=3; Name='Integer division trunc'},
    @{Expr='2 3 ^'; Expected=8; Name='Power operator'}
)

$failures = 0
$index = 0
foreach ($c in $cases) {
    $index++
    try {
        $res = Invoke-PostfixExpression -Expression $c.Expr
    } catch {
        $res = "ERR: $_"
    }

    if ($res -eq $c.Expected) {
        Write-Host "[PASS] $index - $($c.Name): got $res"
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
