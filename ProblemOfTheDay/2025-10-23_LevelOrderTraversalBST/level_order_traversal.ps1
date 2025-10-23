# Define the BST node class
class BSTNode {
    [int]$Value
    [BSTNode]$Left
    [BSTNode]$Right

    BSTNode([int]$value) {
        $this.Value = $value
        $this.Left = $null
        $this.Right = $null
    }
}

# Function to perform level order traversal
function Get-LevelOrderTraversal {
    param (
        [Parameter(Mandatory = $true)]
        [BSTNode]$Root
    )

    if ($null -eq $Root) {
        return @()
    }

    $result = [System.Collections.ArrayList]@()
    $queue = [System.Collections.Queue]::new()
    $queue.Enqueue($Root)
    
    while ($queue.Count -gt 0) {
        $levelSize = $queue.Count
        $currentLevel = [System.Collections.ArrayList]@()
        
        for ($i = 0; $i -lt $levelSize; $i++) {
            $node = $queue.Dequeue()
            $currentLevel.Add($node.Value) | Out-Null
            
            if ($null -ne $node.Left) {
                $queue.Enqueue($node.Left)
            }
            if ($null -ne $node.Right) {
                $queue.Enqueue($node.Right)
            }
        }
        
        $result.Add($currentLevel -join ' ') | Out-Null
    }

    return $result
}

# Function to insert a value into BST
function Add-ToBST {
    param (
        [BSTNode]$Root,
        [int]$Value
    )

    if ($null -eq $Root) {
        return [BSTNode]::new($Value)
    }

    if ($Value -lt $Root.Value) {
        $Root.Left = Add-ToBST -Root $Root.Left -Value $Value
    }
    elseif ($Value -gt $Root.Value) {
        $Root.Right = Add-ToBST -Root $Root.Right -Value $Value
    }

    return $Root
}

# Function to create a BST from an array of values
function New-BST {
    param (
        [int[]]$Values
    )

    $root = $null
    foreach ($value in $Values) {
        $root = Add-ToBST -Root $root -Value $value
    }
    return $root
}

# Example usage and test cases
function Test-LevelOrderTraversal {
    # Test case 1: Example from README
    $test1Values = @(7, 5, 8, 3, 6, 9)
    $bst1 = New-BST -Values $test1Values
    Write-Host "Test Case 1:"
    Write-Host "Input: [7, 5, 8, 3, 6, 9]"
    Write-Host "Expected Output:"
    Write-Host "7`n5 8`n3 6 9"
    Write-Host "Actual Output:"
    Get-LevelOrderTraversal -Root $bst1 | ForEach-Object { Write-Host $_ }
    Write-Host ""

    # Test case 2: Second example from README
    $test2Values = @(10, 5, 15, 3, 7, 18)
    $bst2 = New-BST -Values $test2Values
    Write-Host "Test Case 2:"
    Write-Host "Input: [10, 5, 15, 3, 7, 18]"
    Write-Host "Expected Output:"
    Write-Host "10`n5 15`n3 7 18"
    Write-Host "Actual Output:"
    Get-LevelOrderTraversal -Root $bst2 | ForEach-Object { Write-Host $_ }
    Write-Host ""

    # Test case 3: Single node
    $test3Values = @(1)
    $bst3 = New-BST -Values $test3Values
    Write-Host "Test Case 3 (Single node):"
    Write-Host "Input: [1]"
    Write-Host "Expected Output:"
    Write-Host "1"
    Write-Host "Actual Output:"
    Get-LevelOrderTraversal -Root $bst3 | ForEach-Object { Write-Host $_ }
}

# Run the tests
Test-LevelOrderTraversal
