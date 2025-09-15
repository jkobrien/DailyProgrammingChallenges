<#
String Stack - PowerShell implementation
Problem (paraphrased):
Given two strings `pat` and `tar` (lowercase letters). For each character in `pat` you
must perform exactly one of two operations in order:
 - Append the character to string `s`.
 - Delete the last character of `s` (if `s` is empty do nothing).
After processing all characters of `pat`, determine whether it's possible that `s == tar`.

Approach (greedy, O(n)):
Traverse `pat` from right to left while trying to match `tar` from right to left.
Maintain a skip counter representing characters in `pat` that must be "deleted"
(i.e. appended then later removed) to make the remaining characters align with `tar`.

Algorithm:
- Let i = pat.Length-1, j = tar.Length-1, skip = 0
- While i >= 0:
  - If skip > 0: decrement skip and i (this pat[i] was effectively removed by a delete op)
  - Else if j >= 0 and pat[i] == tar[j]: decrement both i and j (we matched this character)
  - Else: increment skip and decrement i (we will schedule a delete for this pat[i])
- At the end, if j < 0 we've matched all characters in tar -> return $true, else $false

This is analogous to handling backspace-character comparisons and runs in O(n) time and O(1) space.
#>

function Test-StringStack {
    [CmdletBinding()]
    param(
        [string]$Pat,
        [string]$Tar
    )

    if ([string]::IsNullOrEmpty($Tar)) { return $true }
    if ([string]::IsNullOrEmpty($Pat)) { return $false }

    $i = $Pat.Length - 1
    $j = $Tar.Length - 1
    $skip = 0

    while ($i -ge 0) {
        if ($skip -gt 0) {
            $skip--
            $i--
            continue
        }

        if ($j -ge 0 -and $Pat[$i] -eq $Tar[$j]) {
            $j--
            $i--
        } else {
            # This character must be "removed" by choosing delete at some later step
            $skip++
            $i--
        }
    }

    return ($j -lt 0)
}

# Example quick-run when dot-sourced
if ($MyInvocation.InvocationName -eq '.') {
    Write-Host "Example 1: geuaek -> geek =>" (Test-StringStack -Pat 'geuaek' -Tar 'geek')
    Write-Host "Example 2: agiffghd -> gfg =>" (Test-StringStack -Pat 'agiffghd' -Tar 'gfg')
}
