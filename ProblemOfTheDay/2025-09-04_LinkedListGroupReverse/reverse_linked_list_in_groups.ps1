<#
GeeksforGeeks POTD (4 September 2025): "Linked List Group Reverse"
Problem: Reverse a linked list in groups of given size k.
PowerShell implementation + tests.

Approach (recursive):
- Reverse the first k nodes of the list.
- Recursively reverse the remaining list and attach it to the tail of the reversed chunk.
- Handle edge cases: k <= 1 or empty list -> return original list.
Time: O(n), Space: O(n/k) due to recursion (or O(1) iterative alternative).
#>

function New-Node {
    param([Parameter(Mandatory=$true)][object]$Data)
    return [pscustomobject]@{
        data = $Data
        next = $null
    }
}

function Build-LinkedList {
    param([Parameter(Mandatory=$false)][object[]]$Values = @())
    if (-not $Values -or $Values.Count -eq 0) { return $null }

    $head = New-Node -Data $Values[0]
    $current = $head
    for ($i = 1; $i -lt $Values.Count; $i++) {
        $node = New-Node -Data $Values[$i]
        $current.next = $node
        $current = $node
    }
    return $head
}

function Get-ListValues {
    param([Parameter(Mandatory=$false)]$head)
    $res = @()
    $cur = $head
    while ($null -ne $cur) {
        $res += $cur.data
        $cur = $cur.next
    }
    return $res
}

function Print-List {
    param([Parameter(Mandatory=$false)]$head)
    $vals = Get-ListValues -head $head
    if (-not $vals -or $vals.Count -eq 0) {
        Write-Output "Empty list"
        return
    }
    Write-Output ($vals -join ' -> ')
}

# Helper: return true if there are at least k nodes starting from $head
function Has-AtLeastK {
    param([Parameter(Mandatory=$false)]$head, [Parameter(Mandatory=$true)][int]$k)
    if (-not $head) { return $false }
    $count = 0
    $cur = $head
    while ($null -ne $cur -and $count -lt $k) {
        $cur = $cur.next
        $count++
    }
    return ($count -eq $k)
}

function Reverse-FirstK {
    param(
        [Parameter(Mandatory=$true)]$head,
        [Parameter(Mandatory=$true)][int]$k
    )

    $current = $head
    $prev = $null
    $count = 0

    while ($null -ne $current -and $count -lt $k) {
        $nextNode = $current.next
        $current.next = $prev
        $prev = $current
        $current = $nextNode
        $count++
    }

    # $prev is new head of reversed segment, $current is next node after reversed segment
    # Original head becomes tail of reversed segment
    return @{ newHead = $prev; nextNode = $current; tail = $head }
}

function Reverse-LinkedList-In-Groups {
    param(
        [Parameter(Mandatory=$false)]$head,
        [Parameter(Mandatory=$true)][int]$k
    )

    if (-not $head -or $k -le 1) { return $head }

    # If there aren't at least k nodes left, do not reverse this chunk (GeeksforGeeks variant)
    if (-not (Has-AtLeastK -head $head -k $k)) { return $head }

    $res = Reverse-FirstK -head $head -k $k

    if ($null -ne $res.nextNode) {
        $res.tail.next = Reverse-LinkedList-In-Groups -head $res.nextNode -k $k
    }

    return $res.newHead
}

function Assert-ArraysEqual {
    param(
        [Parameter(Mandatory=$false)][object[]]$A = @(),
        [Parameter(Mandatory=$false)][object[]]$B = @()
    )
    $sa = if ($A) { ($A -join ',') } else { '' }
    $sb = if ($B) { ($B -join ',') } else { '' }

    if ($sa -ne $sb) {
        throw "Assertion failed. Expected: [$sb] Got: [$sa]"
    }
    return $true
}

# --- Tests ---
$tests = @(
    @{ input = @(); k = 3; expected = @() },
    @{ input = @(1); k = 1; expected = @(1) },
    @{ input = @(1,2); k = 3; expected = @(1,2) },
    @{ input = @(1,2,3,4,5); k = 2; expected = @(2,1,4,3,5) },
    @{ input = @(1,2,3,4,5); k = 3; expected = @(3,2,1,4,5) },
    @{ input = @(1,2,3,4,5,6); k = 3; expected = @(3,2,1,6,5,4) },
    @{ input = @(1,2,3,4,5,6,7); k = 3; expected = @(3,2,1,6,5,4,7) }
)

$allPassed = $true
for ($i = 0; $i -lt $tests.Count; $i++) {
    $t = $tests[$i]
    $head = Build-LinkedList -Values $t.input
    Write-Output "Test $($i+1): Input = $($t.input -join ',')  k=$($t.k)"
    if ($head) { Write-Output "  Before: " -NoNewline; Print-List -head $head } else { Write-Output "  Before: Empty list" }

    $res = Reverse-LinkedList-In-Groups -head $head -k $t.k

    if ($res) { Write-Output "  After : " -NoNewline; Print-List -head $res } else { Write-Output "  After : Empty list" }

    try {
        Assert-ArraysEqual -A (Get-ListValues -head $res) -B $t.expected
        Write-Output "  Result: PASS`n"
    } catch {
        Write-Output "  Result: FAIL - $($_.Exception.Message)`n"
        $allPassed = $false
    }
}

if ($allPassed) { Write-Output 'All tests passed.'; exit 0 } else { Write-Output 'One or more tests failed.'; exit 1 }
