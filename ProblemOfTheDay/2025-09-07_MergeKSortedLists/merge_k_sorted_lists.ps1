# Merge K Sorted Linked Lists
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
function Write-LinkedList {
    param([Node]$head)
    $current = $head
    $out = @()
    while ($null -ne $current) {
        $out += $current.data
        $current = $current.next
    }
    Write-Output ($out -join ' -> ')
}

# Merge K sorted linked lists using a min-heap (simulated with sorted array)
function Merge-KSortedLists {
    param([Node[]]$lists)
    $heap = @()
    for ($i = 0; $i -lt $lists.Count; $i++) {
        if ($null -ne $lists[$i]) {
            $heap += [PSCustomObject]@{ node = $lists[$i]; idx = $i }
        }
    }
    $heap = $heap | Sort-Object { $_.node.data }
    $dummy = [Node]::new(0)
    $tail = $dummy
    while ($heap.Count -gt 0) {
        $minObj = $heap[0]
        $heap = $heap[1..($heap.Count-1)]
        $tail.next = $minObj.node
        $tail = $tail.next
        if ($null -ne $minObj.node.next) {
            $heap += [PSCustomObject]@{ node = $minObj.node.next; idx = $minObj.idx }
            $heap = $heap | Sort-Object { $_.node.data }
        }
    }
    return $dummy.next
}

# Test cases
function Test-MergeKSortedLists {
    $tests = @(
        # Example 1: 3 lists: [1,3,7], [2,4,8], [9]
        @(@(1,3,7), @(2,4,8), @(9)),
        # Example 2: 3 lists: [1,3], [8], [4,5,6]
        @(@(1,3), @(8), @(4,5,6)),
        # Example 3: 2 lists: [1,2,3], [4,5,6]
        @(@(1,2,3), @(4,5,6)),
        # Example 4: 1 list: [1,2,3]
        @(@(1,2,3)),
        # Example 5: 4 lists: [1], [2], [3], [4]
        @(@(1), @(2), @(3), @(4))
    )
    foreach ($test in $tests) {
        $lists = @()
        foreach ($arr in $test) {
            $lists += Build-LinkedList $arr
        }
        Write-Host "Input:"
    foreach ($l in $lists) { Write-Host (Write-LinkedList $l) }
    $merged = Merge-KSortedLists $lists
    Write-Host "Merged: $(Write-LinkedList $merged)"
        Write-Host "---"
    }
}

# Run tests
Test-MergeKSortedLists

<#
Explanation:
- Node: Defines a singly linked list node.
- Build-LinkedList: Creates a linked list from an array.
- Print-LinkedList: Prints the linked list in readable format.
- Merge-KSortedLists: Uses a simulated min-heap to merge all lists efficiently.
- Test-MergeKSortedLists: Runs several test cases and prints input/output.
#>
