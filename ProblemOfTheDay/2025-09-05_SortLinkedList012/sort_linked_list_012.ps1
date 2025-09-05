# Sort a linked list of 0s, 1s and 2s
# PowerShell implementation

# Node definition
class Node {
    [int]$data
    [Node]$next
    Node([int]$data) {
        $this.data = $data
        $this.next = $null
    }
}

# Build linked list from array
function Build-LinkedList {
    param([int[]]$arr)
    if ($arr.Count -eq 0) { return $null }
    $head = [Node]::new($arr[0])
    $current = $head
    for ($i = 1; $i -lt $arr.Count; $i++) {
        $current.next = [Node]::new($arr[$i])
        $current = $current.next
    }
    return $head
}

# Print linked list
function Print-LinkedList {
    param([Node]$head)
    $current = $head
    $out = @()
    while ($current -ne $null) {
        $out += $current.data
        $current = $current.next
    }
    Write-Output ($out -join ' -> ')
}

# Sort the linked list of 0s, 1s, and 2s
function Sort-LinkedList-012 {
    param([Node]$head)
    $count = @(0,0,0)
    $current = $head
    while ($current -ne $null) {
        $count[$current.data]++
        $current = $current.next
    }
    $current = $head
    for ($i = 0; $i -le 2; $i++) {
        while ($count[$i] -gt 0) {
            $current.data = $i
            $current = $current.next
            $count[$i]--
        }
    }
    return $head
}

# Test cases
function Test-SortLinkedList012 {
    $tests = @(
        @(1,2,2,1,2,0,2,2),
        @(2,2,0,1),
        @(0,1,2,0,1,2,0,1,2),
        @(0,0,0,1,1,2,2,2),
        @(2,1,0)
    )
    foreach ($arr in $tests) {
        Write-Host "Input:  $($arr -join ' -> ')"
        $head = Build-LinkedList $arr
        $sorted = Sort-LinkedList-012 $head
        Write-Host "Output: $(Print-LinkedList $sorted)"
        Write-Host "---"
    }
}

# Run tests
Test-SortLinkedList012

<#
Explanation:
- Node: Defines a singly linked list node.
- Build-LinkedList: Creates a linked list from an array.
- Print-LinkedList: Prints the linked list in readable format.
- Sort-LinkedList-012: Counts 0s, 1s, 2s, then overwrites the list in order.
- Test-SortLinkedList012: Runs several test cases and prints input/output.
#>
