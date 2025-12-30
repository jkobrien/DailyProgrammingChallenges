# Add Number Linked Lists - GeeksforGeeks Problem of the Day (2025-12-30)
# Difficulty: Medium

<#
.SYNOPSIS
    Adds two numbers represented as linked lists.

.DESCRIPTION
    Given two singly linked lists representing non-negative integers, this function
    returns a new linked list representing their sum. Each node contains a single digit,
    and the digits are stored in the order they appear in the number.
    
    The approach:
    1. Reverse both input lists to process from least significant digit
    2. Add corresponding digits with carry management
    3. Reverse the result list
    4. Remove any leading zeros from the result

.EXAMPLE
    Input: head1: 1 -> 2 -> 3, head2: 9 -> 9 -> 9
    Output: 1 -> 1 -> 2 -> 2 (representing 123 + 999 = 1122)
#>

# Node class definition for linked list
class Node {
    [int]$data
    [Node]$next
    
    Node([int]$value) {
        $this.data = $value
        $this.next = $null
    }
}

function Reverse-LinkedList {
    <#
    .SYNOPSIS
        Reverses a singly linked list.
    
    .DESCRIPTION
        Takes the head of a linked list and returns the head of the reversed list.
        Uses iterative approach with three pointers: prev, current, and next.
    #>
    param (
        [Node]$head
    )
    
    $prev = $null
    $current = $head
    
    while ($current -ne $null) {
        $next = $current.next
        $current.next = $prev
        $prev = $current
        $current = $next
    }
    
    return $prev
}

function Remove-LeadingZeros {
    <#
    .SYNOPSIS
        Removes leading zeros from a linked list.
    
    .DESCRIPTION
        Traverses the list and skips all leading zero nodes, returning
        the first non-zero node as the new head. If all nodes are zeros,
        returns a single zero node.
    #>
    param (
        [Node]$head
    )
    
    # Skip all leading zeros
    while ($head -ne $null -and $head.data -eq 0 -and $head.next -ne $null) {
        $head = $head.next
    }
    
    return $head
}

function Add-LinkedListNumbers {
    <#
    .SYNOPSIS
        Adds two numbers represented as linked lists.
    
    .DESCRIPTION
        Main function that adds two numbers represented as linked lists.
        Each node contains a single digit (0-9).
    
    .PARAMETER head1
        Head of the first linked list
    
    .PARAMETER head2
        Head of the second linked list
    
    .OUTPUTS
        Node - Head of the result linked list representing the sum
    #>
    param (
        [Node]$head1,
        [Node]$head2
    )
    
    # Step 1: Reverse both input lists
    $rev1 = Reverse-LinkedList -head $head1
    $rev2 = Reverse-LinkedList -head $head2
    
    # Step 2: Add the numbers
    $carry = 0
    $dummyHead = [Node]::new(0)
    $current = $dummyHead
    
    # Process both lists
    while ($rev1 -ne $null -or $rev2 -ne $null -or $carry -ne 0) {
        $val1 = if ($rev1 -ne $null) { $rev1.data } else { 0 }
        $val2 = if ($rev2 -ne $null) { $rev2.data } else { 0 }
        
        # Calculate sum and carry
        $sum = $val1 + $val2 + $carry
        $carry = [Math]::Floor($sum / 10)
        $digit = $sum % 10
        
        # Create new node with the digit
        $current.next = [Node]::new($digit)
        $current = $current.next
        
        # Move to next nodes if they exist
        if ($rev1 -ne $null) { $rev1 = $rev1.next }
        if ($rev2 -ne $null) { $rev2 = $rev2.next }
    }
    
    # Step 3: Reverse the result list (since we built it backwards)
    $result = Reverse-LinkedList -head $dummyHead.next
    
    # Step 4: Remove leading zeros
    $result = Remove-LeadingZeros -head $result
    
    return $result
}

function ConvertTo-LinkedList {
    <#
    .SYNOPSIS
        Converts an array of digits to a linked list.
    
    .DESCRIPTION
        Helper function to create a linked list from an array of integers.
        Used for testing purposes.
    #>
    param (
        [int[]]$arr
    )
    
    if ($arr.Length -eq 0) {
        return $null
    }
    
    $head = [Node]::new($arr[0])
    $current = $head
    
    for ($i = 1; $i -lt $arr.Length; $i++) {
        $current.next = [Node]::new($arr[$i])
        $current = $current.next
    }
    
    return $head
}

function ConvertFrom-LinkedList {
    <#
    .SYNOPSIS
        Converts a linked list to an array of digits.
    
    .DESCRIPTION
        Helper function to convert a linked list to an array for easy comparison.
        Used for testing and display purposes.
    #>
    param (
        [Node]$head
    )
    
    $result = @()
    $current = $head
    
    while ($current -ne $null) {
        $result += $current.data
        $current = $current.next
    }
    
    return $result
}

function Format-LinkedList {
    <#
    .SYNOPSIS
        Formats a linked list as a string for display.
    
    .DESCRIPTION
        Converts a linked list to a readable string format (e.g., "1 -> 2 -> 3")
    #>
    param (
        [Node]$head
    )
    
    if ($head -eq $null) {
        return "null"
    }
    
    $result = @()
    $current = $head
    
    while ($current -ne $null) {
        $result += $current.data
        $current = $current.next
    }
    
    return ($result -join " -> ")
}

# Main execution for demonstration
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "=== Add Number Linked Lists - Solution ===" -ForegroundColor Cyan
    Write-Host ""
    
    # Example 1: 123 + 999 = 1122
    Write-Host "Example 1:" -ForegroundColor Yellow
    $list1 = ConvertTo-LinkedList -arr @(1, 2, 3)
    $list2 = ConvertTo-LinkedList -arr @(9, 9, 9)
    
    Write-Host "  Input:"
    Write-Host "    List 1: $(Format-LinkedList -head $list1)" -ForegroundColor White
    Write-Host "    List 2: $(Format-LinkedList -head $list2)" -ForegroundColor White
    
    $result = Add-LinkedListNumbers -head1 $list1 -head2 $list2
    Write-Host "  Output: $(Format-LinkedList -head $result)" -ForegroundColor Green
    Write-Host "  Explanation: 123 + 999 = 1122"
    Write-Host ""
    
    # Example 2: 63 + 7 = 70
    Write-Host "Example 2:" -ForegroundColor Yellow
    $list1 = ConvertTo-LinkedList -arr @(6, 3)
    $list2 = ConvertTo-LinkedList -arr @(7)
    
    Write-Host "  Input:"
    Write-Host "    List 1: $(Format-LinkedList -head $list1)" -ForegroundColor White
    Write-Host "    List 2: $(Format-LinkedList -head $list2)" -ForegroundColor White
    
    $result = Add-LinkedListNumbers -head1 $list1 -head2 $list2
    Write-Host "  Output: $(Format-LinkedList -head $result)" -ForegroundColor Green
    Write-Host "  Explanation: 63 + 7 = 70"
    Write-Host ""
    
    # Example 3: Edge case with leading zeros
    Write-Host "Example 3 (Leading zeros):" -ForegroundColor Yellow
    $list1 = ConvertTo-LinkedList -arr @(0, 0, 5)
    $list2 = ConvertTo-LinkedList -arr @(0, 0, 3)
    
    Write-Host "  Input:"
    Write-Host "    List 1: $(Format-LinkedList -head $list1)" -ForegroundColor White
    Write-Host "    List 2: $(Format-LinkedList -head $list2)" -ForegroundColor White
    
    $result = Add-LinkedListNumbers -head1 $list1 -head2 $list2
    Write-Host "  Output: $(Format-LinkedList -head $result)" -ForegroundColor Green
    Write-Host "  Explanation: 5 + 3 = 8 (leading zeros removed)"
    Write-Host ""
    
    # Example 4: Different lengths
    Write-Host "Example 4 (Different lengths):" -ForegroundColor Yellow
    $list1 = ConvertTo-LinkedList -arr @(9, 9, 9, 9)
    $list2 = ConvertTo-LinkedList -arr @(1)
    
    Write-Host "  Input:"
    Write-Host "    List 1: $(Format-LinkedList -head $list1)" -ForegroundColor White
    Write-Host "    List 2: $(Format-LinkedList -head $list2)" -ForegroundColor White
    
    $result = Add-LinkedListNumbers -head1 $list1 -head2 $list2
    Write-Host "  Output: $(Format-LinkedList -head $result)" -ForegroundColor Green
    Write-Host "  Explanation: 9999 + 1 = 10000"
    Write-Host ""
    
    Write-Host "=== Solution Complete ===" -ForegroundColor Cyan
}
