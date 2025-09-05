<#
Reverse a Doubly Linked List
GeeksforGeeks POTD (3 September 2025): "Reverse a Doubly Linked List"
PowerShell solution + tests
#>

function New-Node {
    param([Parameter(Mandatory=$true)][object]$Data)
    return [pscustomobject]@{
        data = $Data
        prev = $null
        next = $null
    }
}

function Build-DoublyLinkedList {
    param([Parameter(Mandatory=$true)][object[]]$Values)
    if (-not $Values -or $Values.Count -eq 0) { return $null }

    $head = New-Node -Data $Values[0]
    $current = $head
    for ($i = 1; $i -lt $Values.Count; $i++) {
        $node = New-Node -Data $Values[$i]
        $current.next = $node
        $node.prev = $current
        $current = $node
    }
    return $head
}

function Reverse-DoublyLinkedList {
    param([Parameter(Mandatory=$false)]$head)

    if (-not $head) { return $null }

    $newHead = $null
    $current = $head

    # For each node, swap next and prev. When current.prev becomes $null we've reached original tail,
    # which is the new head.
    while ($current -ne $null) {
        $temp = $current.next
        $current.next = $current.prev
        $current.prev = $temp

        if ($current.prev -eq $null) { $newHead = $current }

        # move to the next node in original order which is now current.prev
        $current = $current.prev
    }

    return $newHead
}

function Get-ListValuesForward {
    param([Parameter(Mandatory=$false)]$head)
    $res = @()
    $cur = $head
    while ($cur -ne $null) {
        $res += $cur.data
        $cur = $cur.next
    }
    return $res
}

function Print-List {
    param([Parameter(Mandatory=$false)]$head)
    $vals = Get-ListValuesForward -head $head
    if (-not $vals -or $vals.Count -eq 0) {
        Write-Output "Empty list"
        return
    }
    Write-Output ($vals -join ' <-> ')
}

function Assert-ArraysEqual {
    param(
        [Parameter(Mandatory=$true)][object[]]$A,
        [Parameter(Mandatory=$true)][object[]]$B
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
    @{ input = @(); expected = @() },
    @{ input = @(1); expected = @(1) },
    @{ input = @(1,2); expected = @(2,1) },
    @{ input = @(1,2,3,4,5); expected = @(5,4,3,2,1) }
)

$allPassed = $true
for ($i = 0; $i -lt $tests.Count; $i++) {
    $t = $tests[$i]
    $head = Build-DoublyLinkedList -Values $t.input
    Write-Output "Test $($i+1): Input = $($t.input -join ',')"
    if ($head) {
        Write-Output "  Forward before: " -NoNewline; Print-List -head $head
    } else {
        Write-Output "  Forward before: Empty list"
    }

    $rev = Reverse-DoublyLinkedList -head $head

    if ($rev) {
        Write-Output "  Forward after : " -NoNewline; Print-List -head $rev
    } else {
        Write-Output "  Forward after : Empty list"
    }

    try {
        Assert-ArraysEqual -A (Get-ListValuesForward -head $rev) -B $t.expected
        Write-Output "  Result: PASS`n"
    } catch {
        Write-Output "  Result: FAIL - $($_.Exception.Message)`n"
        $allPassed = $false
    }
}

if ($allPassed) {
    Write-Output 'All tests passed.'
    exit 0
} else {
    Write-Output 'One or more tests failed.'
    exit 1
}
