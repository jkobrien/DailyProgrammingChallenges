<#
Decode the String - PowerShell implementation
Problem (paraphrased):
Given an encoded string, decode it following the pattern: k[encoded_string] means
the encoded_string inside the brackets should be repeated k times.

Examples:
- "3[a]" -> "aaa"
- "2[bc]" -> "bcbc"
- "3[a2[c]]" -> "accaccacc"
- "2[abc]3[cd]ef" -> "abcabccdcdcdef"

Approach (Stack-based):
Use two stacks: one for repeat counts and one for accumulated strings.
When we encounter '[', we push the current number and string onto stacks.
When we encounter ']', we pop and repeat the current string.
For other characters, we accumulate them in the current string.

Time complexity: O(n) where n is the length of the decoded string
Space complexity: O(d) where d is the maximum nesting depth
#>

function Invoke-DecodeString {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$EncodedString
    )

    if ([string]::IsNullOrEmpty($EncodedString)) {
        return ""
    }

    $countStack = New-Object System.Collections.Generic.Stack[int]
    $stringStack = New-Object System.Collections.Generic.Stack[string]
    $currentString = ""
    $currentCount = 0

    foreach ($char in $EncodedString.ToCharArray()) {
        switch ($char) {
            { $_ -match '\d' } {
                # Build multi-digit numbers
                $currentCount = $currentCount * 10 + [int]$char.ToString()
            }
            '[' {
                # Push current state and reset
                $countStack.Push($currentCount)
                $stringStack.Push($currentString)
                $currentCount = 0
                $currentString = ""
            }
            ']' {
                # Pop and repeat current string
                $prevString = $stringStack.Pop()
                $repeatCount = $countStack.Pop()
                $currentString = $prevString + ($currentString * $repeatCount)
            }
            default {
                # Regular character
                $currentString += $char
            }
        }
    }

    return $currentString
}

# Quick example when dot-sourced
if ($MyInvocation.InvocationName -eq '.') {
    Write-Host "Example 1: '3[a]' =>" (Invoke-DecodeString -EncodedString '3[a]')
    Write-Host "Example 2: '2[bc]' =>" (Invoke-DecodeString -EncodedString '2[bc]')
    Write-Host "Example 3: '3[a2[c]]' =>" (Invoke-DecodeString -EncodedString '3[a2[c]]')
    Write-Host "Example 4: '2[abc]3[cd]ef' =>" (Invoke-DecodeString -EncodedString '2[abc]3[cd]ef')
}