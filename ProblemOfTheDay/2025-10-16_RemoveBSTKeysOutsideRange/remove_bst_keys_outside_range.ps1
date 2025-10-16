<#
.SYNOPSIS
    Remove BST keys outside given range
    
.DESCRIPTION
    Given the root of a Binary Search Tree (BST) and two integers l and r, 
    remove all the nodes whose values lie outside the range [l, r].
    The modified tree should also be BST and the sequence of the remaining nodes should not be changed.
    
.PARAMETER root
    The root node of the BST
    
.PARAMETER l
    The lower bound of the range (inclusive)
    
.PARAMETER r
    The upper bound of the range (inclusive)
    
.EXAMPLE
    $root = New-TreeNode 6
    $root.left = New-TreeNode -13
    $root.right = New-TreeNode 14
    $root.left.right = New-TreeNode -8
    $root.right.left = New-TreeNode 13
    $root.right.right = New-TreeNode 15
    $root.left.right.right = New-TreeNode 7
    
    $result = Remove-BSTKeysOutsideRange $root -10 13
    # Returns the modified BST with nodes outside [-10, 13] removed
#>

# Define TreeNode class
class TreeNode {
    [int]$data
    [TreeNode]$left
    [TreeNode]$right
    
    TreeNode([int]$value) {
        $this.data = $value
        $this.left = $null
        $this.right = $null
    }
}

function New-TreeNode {
    param([int]$value)
    return [TreeNode]::new($value)
}

function Remove-BSTKeysOutsideRange {
    <#
    .SYNOPSIS
        Removes all nodes from BST that are outside the given range [l, r]
    #>
    param(
        [TreeNode]$root,
        [int]$l,
        [int]$r
    )
    
    # Base case: if root is null, return null
    if ($null -eq $root) {
        return $null
    }
    
    # If current node's data is less than l, then all nodes in left subtree are also less than l
    # So we can ignore the left subtree and only process the right subtree
    if ($root.data -lt $l) {
        return Remove-BSTKeysOutsideRange $root.right $l $r
    }
    
    # If current node's data is greater than r, then all nodes in right subtree are also greater than r
    # So we can ignore the right subtree and only process the left subtree
    if ($root.data -gt $r) {
        return Remove-BSTKeysOutsideRange $root.left $l $r
    }
    
    # If current node is in range [l, r], then we need to process both subtrees
    $root.left = Remove-BSTKeysOutsideRange $root.left $l $r
    $root.right = Remove-BSTKeysOutsideRange $root.right $l $r
    
    return $root
}

function Print-InOrder {
    <#
    .SYNOPSIS
        Prints the BST in in-order traversal
    #>
    param($root)
    
    if ($null -ne $root) {
        Print-InOrder $root.left
        Write-Host $root.data -NoNewline
        Write-Host " " -NoNewline
        Print-InOrder $root.right
    }
}

function Get-InOrderTraversal {
    <#
    .SYNOPSIS
        Returns an array of values from in-order traversal
    #>
    param($root)
    
    $script:traversalResult = @()
    
    function InOrderHelper($node) {
        if ($null -ne $node) {
            InOrderHelper $node.left
            $script:traversalResult += $node.data
            InOrderHelper $node.right
        }
    }
    
    InOrderHelper $root
    return $script:traversalResult
}

function Build-BST-From-Array {
    <#
    .SYNOPSIS
        Builds a BST from an array representation (level-order)
    #>
    param([object[]]$arr)
    
    if ($arr.Length -eq 0 -or $arr[0] -eq "N" -or $null -eq $arr[0]) {
        return $null
    }
    
    $root = New-TreeNode $arr[0]
    $queue = @($root)
    $i = 1
    
    while ($queue.Length -gt 0 -and $i -lt $arr.Length) {
        $current = $queue[0]
        $queue = $queue[1..($queue.Length-1)]
        
        # Add left child
        if ($i -lt $arr.Length -and $arr[$i] -ne "N" -and $null -ne $arr[$i]) {
            $current.left = New-TreeNode $arr[$i]
            $queue += $current.left
        }
        $i++
        
        # Add right child
        if ($i -lt $arr.Length -and $arr[$i] -ne "N" -and $null -ne $arr[$i]) {
            $current.right = New-TreeNode $arr[$i]
            $queue += $current.right
        }
        $i++
    }
    
    return $root
}

# Main execution function
function Main {
    Write-Host "=== Remove BST Keys Outside Given Range ==="
    Write-Host
    
    # Example 1: root = [6, -13, 14, N, -8, 13, 15, N, N, 7], l = -10, r = 13
    Write-Host "Example 1:"
    $arr1 = @(6, -13, 14, "N", -8, 13, 15, "N", "N", 7)
    $root1 = Build-BST-From-Array $arr1
    $l1 = -10
    $r1 = 13
    
    Write-Host "Original BST (in-order): " -NoNewline
    Print-InOrder $root1
    Write-Host
    Write-Host "Range: [$l1, $r1]"
    
    $result1 = Remove-BSTKeysOutsideRange $root1 $l1 $r1
    Write-Host "Modified BST (in-order): " -NoNewline
    Print-InOrder $result1
    Write-Host
    Write-Host
    
    # Example 2: root = [14, 4, 16, 2, 8, 15, N, -8, 3, 7, 10], l = 2, r = 6
    Write-Host "Example 2:"
    $arr2 = @(14, 4, 16, 2, 8, 15, "N", -8, 3, 7, 10)
    $root2 = Build-BST-From-Array $arr2
    $l2 = 2
    $r2 = 6
    
    Write-Host "Original BST (in-order): " -NoNewline
    Print-InOrder $root2
    Write-Host
    Write-Host "Range: [$l2, $r2]"
    
    $result2 = Remove-BSTKeysOutsideRange $root2 $l2 $r2
    Write-Host "Modified BST (in-order): " -NoNewline
    Print-InOrder $result2
    Write-Host
    Write-Host
    
    # Additional test case
    Write-Host "Additional Test Case:"
    $arr3 = @(10, 5, 15, 2, 7, 12, 20)
    $root3 = Build-BST-From-Array $arr3
    $l3 = 6
    $r3 = 14
    
    Write-Host "Original BST (in-order): " -NoNewline
    Print-InOrder $root3
    Write-Host
    Write-Host "Range: [$l3, $r3]"
    
    $result3 = Remove-BSTKeysOutsideRange $root3 $l3 $r3
    Write-Host "Modified BST (in-order): " -NoNewline
    Print-InOrder $result3
    Write-Host
}

# Run the main function if script is executed directly
if ($MyInvocation.InvocationName -ne '.') {
    Main
}
