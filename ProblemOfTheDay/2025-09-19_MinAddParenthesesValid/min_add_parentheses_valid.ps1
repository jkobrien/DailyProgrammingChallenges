<#
.SYNOPSIS
    Min Add to Make Parentheses Valid - GeeksforGeeks Problem of the Day (September 19, 2025)

.DESCRIPTION
    Given a string consisting of parentheses '(' and ')', find the minimum number of 
    parentheses that must be added to make the string valid.
    
    A string is valid if every opening parenthesis has a corresponding closing 
    parenthesis and they are properly nested.

.PARAMETER InputString
    The string containing parentheses to validate

.EXAMPLE
    Get-MinAddParenthesesValid "(()("
    Returns: 2

.EXAMPLE
    Get-MinAddParenthesesValid ")))"
    Returns: 3

.NOTES
    Time Complexity: O(n) - single pass through the string
    Space Complexity: O(1) - constant extra space
    
    Algorithm: Counter/Balance Method
    - Track balance of unmatched opening parentheses
    - Count unmatched closing parentheses when balance goes negative
    - Total additions = remaining opening + unmatched closing
#>

function Get-MinAddParenthesesValid {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [AllowEmptyString()]
        [string]$InputString
    )
    
    process {
        # Handle edge cases
        if ([string]::IsNullOrEmpty($InputString)) {
            return 0
        }
        
        # Initialize counters
        $balance = 0           # Tracks unmatched opening parentheses
        $unmatchedClosing = 0  # Counts unmatched closing parentheses
        
        # Process each character in the string
        foreach ($char in $InputString.ToCharArray()) {
            switch ($char) {
                '(' {
                    # Opening parenthesis - increment balance
                    $balance++
                }
                ')' {
                    # Closing parenthesis - decrement balance
                    $balance--
                    
                    # If balance becomes negative, we have unmatched closing parentheses
                    if ($balance -lt 0) {
                        $unmatchedClosing++
                        $balance = 0  # Reset balance to prevent double counting
                    }
                }
                # Ignore any other characters (though problem states only parentheses)
            }
        }
        
        # Total additions needed = remaining unmatched opening + unmatched closing
        return $balance + $unmatchedClosing
    }
}

# Alternative implementation using stack approach (for educational purposes)
function Get-MinAddParenthesesValidStack {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$InputString
    )
    
    if ([string]::IsNullOrEmpty($InputString)) {
        return 0
    }
    
    # Use ArrayList as stack for better performance than array
    $stack = New-Object System.Collections.ArrayList
    
    foreach ($char in $InputString.ToCharArray()) {
        if ($char -eq '(') {
            # Push opening parenthesis onto stack
            [void]$stack.Add('(')
        }
        elseif ($char -eq ')') {
            # If stack has opening parenthesis, pop it (matched pair)
            if ($stack.Count -gt 0 -and $stack[-1] -eq '(') {
                $stack.RemoveAt($stack.Count - 1)
            }
            else {
                # Unmatched closing parenthesis
                [void]$stack.Add(')')
            }
        }
    }
    
    # Stack size represents total unmatched parentheses
    return $stack.Count
}

# Demonstration function
function Show-MinAddParenthesesDemo {
    Write-Host "=== Min Add to Make Parentheses Valid - Demo ===" -ForegroundColor Cyan
    Write-Host ""
    
    $testCases = @(
        @{ Input = "(()(" ; Expected = 2 ; Description = "Two unmatched opening parentheses" }
        @{ Input = ")))" ; Expected = 3 ; Description = "Three unmatched closing parentheses" }
        @{ Input = "()" ; Expected = 0 ; Description = "Already valid parentheses" }
        @{ Input = "(((" ; Expected = 3 ; Description = "Three unmatched opening parentheses" }
        @{ Input = "" ; Expected = 0 ; Description = "Empty string" }
        @{ Input = "())" ; Expected = 1 ; Description = "One unmatched closing parenthesis" }
        @{ Input = "(()" ; Expected = 1 ; Description = "One unmatched opening parenthesis" }
        @{ Input = ")()(" ; Expected = 2 ; Description = "Mixed unmatched parentheses" }
    )
    
    foreach ($test in $testCases) {
        $result = Get-MinAddParenthesesValid $test.Input
        $status = if ($result -eq $test.Expected) { "PASS" } else { "FAIL" }
        $statusColor = if ($result -eq $test.Expected) { "Green" } else { "Red" }
        
        Write-Host "Input: '$($test.Input)' -> Output: $result | Expected: $($test.Expected) | " -NoNewline
        Write-Host $status -ForegroundColor $statusColor
        Write-Host "  Description: $($test.Description)" -ForegroundColor Gray
        Write-Host ""
    }
}

# Export functions for module use
Export-ModuleMember -Function Get-MinAddParenthesesValid, Get-MinAddParenthesesValidStack, Show-MinAddParenthesesDemo

# If script is run directly, show demo
if ($MyInvocation.InvocationName -ne '.') {
    Show-MinAddParenthesesDemo
}
