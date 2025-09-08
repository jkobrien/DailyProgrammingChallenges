# Merge Sort for Linked List - GeeksforGeeks Problem of the Day (2025-09-08)
# PowerShell Solution

# Node class for singly linked list
class Node {
    [int]$data
    [Node]$next
    Node([int]$data) {
        $this.data = $data
        $this.next = $null
    }
}

# Merge two sorted linked lists
function Merge-Lists($a, $b) {
    if (-not $a) { return $b }
    if (-not $b) { return $a }
    if ($a.data -le $b.data) {
        $a.next = Merge-Lists $a.next $b
        return $a
    } else {
        $b.next = Merge-Lists $a $b.next
        return $b
    }
}

# Split the linked list into two halves
function Split-List($head) {
    if (-not $head -or -not $head.next) { return @($head, $null) }
    $slow = $head
    $fast = $head.next
    while ($fast -and $fast.next) {
        $slow = $slow.next
        $fast = $fast.next.next
    }
    $mid = $slow.next
    $slow.next = $null
    return @($head, $mid)
}

# Merge Sort for Linked List
function MergeSort-LinkedList($head) {
    if (-not $head -or -not $head.next) { return $head }
    $parts = Split-List $head
    $left = MergeSort-LinkedList $parts[0]
    $right = MergeSort-LinkedList $parts[1]
    return Merge-Lists $left $right
}

# Build a linked list from array
function Build-LinkedList($arr) {
    if ($arr.Count -eq 0) { return $null }
    $head = [Node]::new($arr[0])
    $curr = $head
    for ($i = 1; $i -lt $arr.Count; $i++) {
        $curr.next = [Node]::new($arr[$i])
        $curr = $curr.next
    }
    return $head
}

# Print linked list
function Print-LinkedList($head) {
    $curr = $head
    $out = [System.Collections.ArrayList]::new()
    while ($curr) {
        [void]$out.Add($curr.data)
        $curr = $curr.next
    }
    Write-Output ($out -join ' -> ')
}

# Test Cases
Write-Host "Test Case 1:"
$head1 = Build-LinkedList @(40, 20, 60, 10, 50, 30)
Write-Host "Original List:"
Print-LinkedList $head1
$sorted1 = MergeSort-LinkedList $head1
Write-Host "Sorted List:"
Print-LinkedList $sorted1

Write-Host "`nTest Case 2:"
$head2 = Build-LinkedList @(8, 2, 5, 9)
Write-Host "Original List:"
Print-LinkedList $head2
$sorted2 = MergeSort-LinkedList $head2
Write-Host "Sorted List:"
Print-LinkedList $sorted2

# Explanation:
# This script defines a singly linked list and sorts it using merge sort.
# It includes test cases and prints both the original and sorted lists.
