# Tests for Safe States POTD (2025-11-03)
$ErrorActionPreference = 'Stop'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$scriptDir/safe_states.ps1"

function Assert-EqualArray {
    param(
        [int[]]$Expected,
        [int[]]$Actual,
        [string]$Message = "Arrays differ"
    )
    if ($Expected.Length -ne $Actual.Length) {
        throw "$Message (length mismatch: expected=$($Expected.Length) actual=$($Actual.Length))"
    }
    for ($i=0; $i -lt $Expected.Length; $i++) {
    if ($Expected[$i] -ne $Actual[$i]) { throw ("{0} at index {1}: expected={2} actual={3}" -f $Message,$i,$Expected[$i],$Actual[$i]) }
    }
}

$testsPassed = 0

# 1. Sample from problem statement
$edges1 = @(@(1,0),@(1,2),@(1,3),@(1,4),@(2,3),@(3,4))
$result1 = Get-SafeStates -Vertices 5 -Edges $edges1
Assert-EqualArray -Expected (0,1,2,3,4) -Actual $result1 -Message "Sample test failed"
$testsPassed++

# 2. Cycle case: 2 <-> 3 plus chain 1->2, 0 isolated terminal
$edges2 = @(@(1,2),@(2,3),@(3,2))
$result2 = Get-SafeStates -Vertices 4 -Edges $edges2
Assert-EqualArray -Expected (0) -Actual $result2 -Message "Cycle test failed"
$testsPassed++

# 3. Self-loop only (not safe). Graph: 0->0, 1 terminal
$edges3 = @(@(0,0))
$result3 = Get-SafeStates -Vertices 2 -Edges $edges3
Assert-EqualArray -Expected (1) -Actual $result3 -Message "Self loop test failed"
$testsPassed++

# 4. Chain Acyclic: 0->1->2->3 terminal (all safe)
$edges4 = @(@(0,1),@(1,2),@(2,3))
$result4 = Get-SafeStates -Vertices 4 -Edges $edges4
Assert-EqualArray -Expected (0,1,2,3) -Actual $result4 -Message "Chain test failed"
$testsPassed++

# 5. Mixed: 0->1, 1->2, 2->1 (cycle), 3 terminal, 4->3 (safe), 5->2 (not safe), 6 isolated terminal
$edges5 = @(@(0,1),@(1,2),@(2,1),@(4,3),@(5,2))
$result5 = Get-SafeStates -Vertices 7 -Edges $edges5
Assert-EqualArray -Expected (3,4,6) -Actual $result5 -Message "Mixed cycle test failed"
$testsPassed++

Write-Host "All tests passed: $testsPassed" -ForegroundColor Green
