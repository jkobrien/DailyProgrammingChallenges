<#
Postfix Evaluation - PowerShell implementation
Problem (paraphrased):
Given a postfix expression (also called Reverse Polish Notation), evaluate and
return the resulting integer value.

This implementation handles:
- Space-separated tokens (to support multi-digit numbers and negative integers).
- Compact expressions without spaces where each character is a single-digit operand or operator.
- Operators: +, -, *, / (integer division that truncates toward zero), ^ (power)

Algorithm (stack-based):
1. Tokenize the input: if the expression contains whitespace, split on whitespace; else treat each character as a token.
2. Iterate tokens:
   - If token parses as an integer, push onto the stack.
   - If token is an operator, pop the top two elements (rhs, lhs) and compute lhs op rhs, then push the result.
3. After processing all tokens, there should be exactly one element on the stack — the result. Otherwise the expression was invalid.

Returns the integer result. Throws on invalid expressions (insufficient operands or unknown operator).
#>

function Invoke-PostfixExpression {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Expression
    )

    if ([string]::IsNullOrWhiteSpace($Expression)) {
        throw "Expression must be a non-empty string"
    }

    # Determine tokenization strategy
    if ($Expression -match '\s') {
        $tokens = $Expression -split '\s+'
    } else {
        # Treat each character as a token
        $tokens = $Expression.ToCharArray() | ForEach-Object { $_.ToString() }
    }

    $stack = New-Object System.Collections.Generic.Stack[long]

    foreach ($token in $tokens) {
        if ($token -eq '') { continue }

        $num = 0
        $isInt = [int]::TryParse($token, [ref]$num)
        if ($isInt) {
            $stack.Push([long]$num)
            continue
        }

        switch ($token) {
            '+' {
                if ($stack.Count -lt 2) { throw "Insufficient operands for '+'" }
                $b = $stack.Pop(); $a = $stack.Pop()
                $stack.Push($a + $b)
            }
            '-' {
                if ($stack.Count -lt 2) { throw "Insufficient operands for '-'" }
                $b = $stack.Pop(); $a = $stack.Pop()
                $stack.Push($a - $b)
            }
            '*' {
                if ($stack.Count -lt 2) { throw "Insufficient operands for '*'" }
                $b = $stack.Pop(); $a = $stack.Pop()
                $stack.Push($a * $b)
            }
            '/' {
                if ($stack.Count -lt 2) { throw "Insufficient operands for '/'" }
                $b = $stack.Pop(); $a = $stack.Pop()
                if ($b -eq 0) { throw "Division by zero" }
                # Integer division truncating toward zero
                $quot = [math]::Truncate([double]$a / [double]$b)
                $stack.Push([long]$quot)
            }
            '^' {
                if ($stack.Count -lt 2) { throw "Insufficient operands for '^'" }
                $b = $stack.Pop(); $a = $stack.Pop()
                $stack.Push([long][math]::Pow($a, $b))
            }
            default {
                throw "Unknown token/operator: '$token'"
            }
        }
    }

    if ($stack.Count -ne 1) {
        throw "Invalid expression: stack contains $($stack.Count) elements after evaluation"
    }

    return $stack.Pop()
}

# Quick example when dot-sourced
if ($MyInvocation.InvocationName -eq '.') {
    Write-Host "Example: '231*+9-' =>" (Invoke-PostfixExpression -Expression '231*+9-')
    Write-Host "Example (spaces): '10 2 8 * + 3 -' =>" (Invoke-PostfixExpression -Expression '10 2 8 * + 3 -')
}
