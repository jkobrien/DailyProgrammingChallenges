<#
.SYNOPSIS
    Bus Ticket Change - GeeksforGeeks Problem of the Day Solution

.DESCRIPTION
    Problem: Bus Ticket Change (Lemonade Change)
    
    You are given an array arr[] representing passengers in a queue. Each bus ticket 
    costs 5 coins, and arr[i] denotes the note a passenger uses to pay (which can be 
    5, 10, or 20). You must serve the passengers in the given order and always provide 
    the correct change so that each passenger effectively pays exactly 5 coins.
    
    Return true if it is possible to serve all passengers without running out of change,
    false otherwise.

.PARAMETER arr
    Array of integers representing the bills passengers use to pay (5, 10, or 20)

.EXAMPLE
    Get-BusTicketChange -arr @(5, 5, 5, 10, 20)
    Returns: $true
    Explanation: We collect three $5 bills, give back one $5 to the $10 customer,
    and give back one $10 and one $5 to the $20 customer.

.EXAMPLE
    Get-BusTicketChange -arr @(5, 5, 10, 10, 20)
    Returns: $false
    Explanation: We cannot give correct change of $15 to the last customer.

.NOTES
    Time Complexity: O(n) where n is the number of passengers
    Space Complexity: O(1) - only using two variables to track change
    
    Algorithm:
    1. Track count of $5 and $10 bills we have as change
    2. For each passenger:
       - If they pay with $5: Accept it (no change needed)
       - If they pay with $10: Give back one $5 (if we have it)
       - If they pay with $20: Give back one $10 + one $5, or three $5 bills
    3. Return false if we can't make change at any point

.LINK
    https://www.geeksforgeeks.org/problems/lemonade-change/1
#>

function Get-BusTicketChange {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $false)]
        [int[]]$arr
    )
    
    # Track the number of $5 and $10 bills we have
    [int]$fives = 0
    [int]$tens = 0
    
    # Process each passenger in order
    foreach ($bill in $arr) {
        switch ($bill) {
            5 {
                # Customer pays with exact change - keep the $5 bill
                $fives++
            }
            10 {
                # Customer pays with $10 - need to give back $5
                if ($fives -eq 0) {
                    # Cannot make change
                    return $false
                }
                $fives--
                $tens++
            }
            20 {
                # Customer pays with $20 - need to give back $15
                # Prefer to give one $10 and one $5 (better to keep more $5 bills)
                if ($tens -gt 0 -and $fives -gt 0) {
                    $tens--
                    $fives--
                }
                # Otherwise give three $5 bills
                elseif ($fives -ge 3) {
                    $fives -= 3
                }
                # Cannot make change
                else {
                    return $false
                }
            }
            default {
                Write-Warning "Invalid bill amount: $bill. Only 5, 10, or 20 are allowed."
                return $false
            }
        }
    }
    
    # Successfully served all passengers
    return $true
}

# Main execution block (for testing when run as a script directly, not when dot-sourced)
if ($MyInvocation.InvocationName -ne '.' -and $MyInvocation.InvocationName -notlike '*&*') {
    # Example test cases
    Write-Host "`n=== Bus Ticket Change - Solution ===" -ForegroundColor Cyan
    Write-Host "Problem: Determine if we can provide correct change to all bus passengers`n" -ForegroundColor Gray
    
    # Test Case 1
    $test1 = @(5, 5, 5, 10, 20)
    $result1 = Get-BusTicketChange -arr $test1
    Write-Host "Test 1: arr = [$($test1 -join ', ')]" -ForegroundColor Yellow
    Write-Host "Output: $result1" -ForegroundColor $(if ($result1) { "Green" } else { "Red" })
    Write-Host "Expected: True`n" -ForegroundColor Gray
    
    # Test Case 2
    $test2 = @(5, 5, 10, 10, 20)
    $result2 = Get-BusTicketChange -arr $test2
    Write-Host "Test 2: arr = [$($test2 -join ', ')]" -ForegroundColor Yellow
    Write-Host "Output: $result2" -ForegroundColor $(if (-not $result2) { "Green" } else { "Red" })
    Write-Host "Expected: False`n" -ForegroundColor Gray
    
    # Test Case 3 - Edge case: only exact change
    $test3 = @(5, 5, 5, 5, 5)
    $result3 = Get-BusTicketChange -arr $test3
    Write-Host "Test 3: arr = [$($test3 -join ', ')]" -ForegroundColor Yellow
    Write-Host "Output: $result3" -ForegroundColor $(if ($result3) { "Green" } else { "Red" })
    Write-Host "Expected: True`n" -ForegroundColor Gray
    
    # Test Case 4 - Edge case: first customer pays with $10
    $test4 = @(10, 10)
    $result4 = Get-BusTicketChange -arr $test4
    Write-Host "Test 4: arr = [$($test4 -join ', ')]" -ForegroundColor Yellow
    Write-Host "Output: $result4" -ForegroundColor $(if (-not $result4) { "Green" } else { "Red" })
    Write-Host "Expected: False`n" -ForegroundColor Gray
    
    # Test Case 5 - Complex case
    $test5 = @(5, 5, 10, 20, 5, 5, 5, 5, 5, 5, 5, 5, 5, 10, 5, 5, 20, 5, 20, 5)
    $result5 = Get-BusTicketChange -arr $test5
    Write-Host "Test 5: arr = [$($test5 -join ', ')]" -ForegroundColor Yellow
    Write-Host "Output: $result5" -ForegroundColor $(if ($result5) { "Green" } else { "Red" })
    Write-Host "Expected: True`n" -ForegroundColor Gray
}
