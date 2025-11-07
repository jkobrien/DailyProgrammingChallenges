# Binary Tree Level Order Traversal - PowerShell Solution
# Problem: Given a binary tree, return the level order traversal of its nodes' values
# Approach: Use a Queue for BFS traversal to process nodes level by level
# Time Complexity: O(N), Space Complexity: O(W) where W is max width of tree

# Define TreeNode class for binary tree
class TreeNode {
    [int]$Value
    [TreeNode]$Left
    [TreeNode]$Right
    
    TreeNode([int]$value) {
        $this.Value = $value
        $this.Left = $null
        $this.Right = $null
    }
}

# Main function to perform level order traversal
function Get-LevelOrderTraversal {
    param(
        [TreeNode]$root
    )
    
    Write-Host "Performing level order traversal..."
    
    # Handle empty tree
    if ($null -eq $root) {
        Write-Host "Empty tree, returning empty result"
        return ,@()
    }
    
    $result = [System.Collections.ArrayList]::new()
    $queue = [System.Collections.Queue]::new()
    $queue.Enqueue($root)
    
    while ($queue.Count -gt 0) {
        $levelSize = $queue.Count
        $currentLevel = [System.Collections.ArrayList]::new()
        
        # Process all nodes at current level
        for ($i = 0; $i -lt $levelSize; $i++) {
            $node = $queue.Dequeue()
            [void]$currentLevel.Add($node.Value)
            
            # Add children to queue if they exist
            if ($null -ne $node.Left) {
                $queue.Enqueue($node.Left)
            }
            if ($null -ne $node.Right) {
                $queue.Enqueue($node.Right)
            }
        }
        
        # Add current level's result to final result
        [void]$result.Add($currentLevel)
    }
    
    return $result
}

# Helper function to create a binary tree from array
function New-BinaryTree {
    param(
        [array]$values
    )
    
    if ($values.Count -eq 0 -or $null -eq $values[0]) {
        return $null
    }
    
    $root = [TreeNode]::new($values[0])
    $queue = [System.Collections.Queue]::new()
    $queue.Enqueue($root)
    $i = 1
    
    while ($queue.Count -gt 0 -and $i -lt $values.Count) {
        $node = $queue.Dequeue()
        
        # Add left child
        if ($i -lt $values.Count -and $null -ne $values[$i]) {
            $node.Left = [TreeNode]::new($values[$i])
            $queue.Enqueue($node.Left)
        }
        $i++
        
        # Add right child
        if ($i -lt $values.Count -and $null -ne $values[$i]) {
            $node.Right = [TreeNode]::new($values[$i])
            $queue.Enqueue($node.Right)
        }
        $i++
    }
    
    return $root
}

# Helper function to display results
function Show-Result {
    param(
        [array]$result
    )
    
    Write-Host "Level order traversal result:"
    $displayResult = $result | ForEach-Object { "[$($_ -join ',')]" }
    Write-Host ($displayResult -join ', ')
}

# Test cases
function Test-LevelOrderTraversal {
    Write-Host "=== Testing Binary Tree Level Order Traversal ==="
    Write-Host ""
    
    # Test Case 1: Standard tree from example
    Write-Host "Test Case 1: Standard tree [3,9,20,null,null,15,7]"
    $tree1 = New-BinaryTree @(3,9,20,$null,$null,15,7)
    $result1 = Get-LevelOrderTraversal $tree1
    Show-Result $result1
    Write-Host "Expected: [3], [9,20], [15,7]"
    Write-Host ""
    
    # Test Case 2: Single node tree
    Write-Host "Test Case 2: Single node tree [1]"
    $tree2 = New-BinaryTree @(1)
    $result2 = Get-LevelOrderTraversal $tree2
    Show-Result $result2
    Write-Host "Expected: [1]"
    Write-Host ""
    
    # Test Case 3: Empty tree
    Write-Host "Test Case 3: Empty tree []"
    $tree3 = New-BinaryTree @()
    $result3 = Get-LevelOrderTraversal $tree3
    Show-Result $result3
    Write-Host "Expected: []"
    Write-Host ""
    
    # Test Case 4: Perfect binary tree
    Write-Host "Test Case 4: Perfect binary tree [1,2,3,4,5,6,7]"
    $tree4 = New-BinaryTree @(1,2,3,4,5,6,7)
    $result4 = Get-LevelOrderTraversal $tree4
    Show-Result $result4
    Write-Host "Expected: [1], [2,3], [4,5,6,7]"
    Write-Host ""
    
    # Test Case 5: Left-skewed tree
    Write-Host "Test Case 5: Left-skewed tree [1,2,null,3,null,4]"
    $tree5 = New-BinaryTree @(1,2,$null,3,$null,4)
    $result5 = Get-LevelOrderTraversal $tree5
    Show-Result $result5
    Write-Host "Expected: [1], [2], [3], [4]"
    Write-Host ""
}

# Run tests
Test-LevelOrderTraversal
