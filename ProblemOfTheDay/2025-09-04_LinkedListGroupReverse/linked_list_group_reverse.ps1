# Linked List Group Reverse - PowerShell implementation
# Problem (from GeeksforGeeks POTD 4 September 2025):
# Reverse a linked list in groups of given size k.
#
# Explanation:
# Given a singly linked list, reverse nodes of the list k at a time and return
# its modified list. If the number of nodes is not a multiple of k then the
# remaining nodes at the end should remain as is. The reversal should be done
# by changing the links between nodes (not just values).
#
# Approach:
# Use an iterative reversal for the first k nodes using three pointers: current,
# prev, next. After reversing the first k nodes, recursively process the
# remaining list and attach it to the tail of the reversed segment. This is a
# classic approach with O(n) time and O(n/k) recursion depth (which is fine for
# typical lists). For iterative-only implementation, the same idea can be
# done with a loop.
#
# The script below implements a simple linked list representation using
# PSCustomObjects where each node has .Value and .Next properties.
# The script includes building/converting helpers and several test cases.

# Create a new node object
function New-Node {
    param(
        [Parameter(Mandatory = $true)]
        $Value
    )
    return [PSCustomObject]@{ Value = $Value; Next = $null }
}

# Build a linked list from an array of values; returns the head node (or $null)
function Build-LinkedList {
    param(
        [Parameter(Mandatory = $true)]
        [object[]]$Values
    )
    if ($Values.Length -eq 0) { return $null }
    $head = New-Node -Value $Values[0]
    $current = $head
    for ($i = 1; $i -lt $Values.Length; $i++) {
        $node = New-Node -Value $Values[$i]
        $current.Next = $node
        $current = $node
    }
    return $head
}

# Convert linked list to array for easy comparison/printing
function LinkedList-ToArray {
    param(
        $Head
    )
    $result = @()
    $current = $Head
    while ($null -ne $current) {
        $result += $current.Value
        $current = $current.Next
    }
    return ,$result  # ensure an array is returned even if empty
}

# Print linked list values on one line
function Print-LinkedList {
    param(
        $Head
    )
    $arr = LinkedList-ToArray -Head $Head
    if ($arr.Count -eq 0) { Write-Output "<empty list>"; return }
    Write-Output ($arr -join ' -> ')
}

# Reverse nodes of linked list in groups of size k
function Reverse-LinkedListInGroups {
    param(
        $Head,
        [int]$k
    )
    if ($null -eq $Head -or $k -le 1) { return $Head }

    $current = $Head
    $prev = $null
    $next = $null
    $count = 0

    # Reverse first k nodes (standard iterative reversal)
    while ($current -ne $null -and $count -lt $k) {
        $next = $current.Next
        $current.Next = $prev
        $prev = $current
        $current = $next
        $count++
    }

    # $prev is new head of reversed segment, $Head is now the tail of this segment
    # Recursively call for the list starting from $next and attach to the tail
    if ($next -ne $null) {
        $Head.Next = Reverse-LinkedListInGroups -Head $next -k $k
    }

    return $prev
}

# Simple assertion helper for tests
function Assert-Equal {
    param(
        [Parameter(Mandatory = $true)]
        [object[]]$Expected,
        [Parameter(Mandatory = $true)]
        [object[]]$Actual,
        [string]$Message = ''
    )
    $pass = $true
    if ($Expected.Length -ne $Actual.Length) { $pass = $false }
    else {
        for ($i = 0; $i -lt $Expected.Length; $i++) {
            if ($Expected[$i] -ne $Actual[$i]) { $pass = $false; break }
        }
    }
    if ($pass) { Write-Output "PASS: $Message" } else { Write-Output "FAIL: $Message"; Write-Output " Expected: $($Expected -join ', ')"; Write-Output " Actual:   $($Actual -join ', ')" }
}

# Unit-style tests
function Run-Tests {
    # Test 1: simple k = 3
    $input = 1..8
    $k = 3
    $head = Build-LinkedList -Values $input
    $resultHead = Reverse-LinkedListInGroups -Head $head -k $k
    $out = LinkedList-ToArray -Head $resultHead
    $expected = @(3,2,1,6,5,4,8,7)
    Assert-Equal -Expected $expected -Actual $out -Message "Reverse groups of 3 on 1..8"

    # Test 2: k = 2
    $input = 1..6
    $k = 2
    $head = Build-LinkedList -Values $input
    $out = LinkedList-ToArray -Head (Reverse-LinkedListInGroups -Head $head -k $k)
    $expected = @(2,1,4,3,6,5)
    Assert-Equal -Expected $expected -Actual $out -Message "Reverse groups of 2 on 1..6"

    # Test 3: k = 1 (no change expected)
    $input = 1..5
    $k = 1
    $head = Build-LinkedList -Values $input
    $out = LinkedList-ToArray -Head (Reverse-LinkedListInGroups -Head $head -k $k)
    $expected = @(1,2,3,4,5)
    Assert-Equal -Expected $expected -Actual $out -Message "k = 1 (no change)"

    # Test 4: k >= list length (reverse entire list)
    $input = 10,20,30
    $k = 5
    $head = Build-LinkedList -Values $input
    $out = LinkedList-ToArray -Head (Reverse-LinkedListInGroups -Head $head -k $k)
    $expected = @(30,20,10)
    Assert-Equal -Expected $expected -Actual $out -Message "k >= length (reverse whole list)"

    # Test 5: empty list
    $head = Build-LinkedList -Values @()
    $out = LinkedList-ToArray -Head (Reverse-LinkedListInGroups -Head $head -k 3)
    $expected = @()
    Assert-Equal -Expected $expected -Actual $out -Message "Empty list"

    # Print an example for visibility
    Write-Output "\nExample output (print the result of reversing groups of 3 on 1..8):"
    $head = Build-LinkedList -Values (1..8)
    $res = Reverse-LinkedListInGroups -Head $head -k 3
    Print-LinkedList -Head $res
}

# When the script is run, execute tests
if ($MyInvocation.InvocationName -eq '.ps1' -or $MyInvocation.InvocationName -like '*') {
    Run-Tests
}

# End of script
