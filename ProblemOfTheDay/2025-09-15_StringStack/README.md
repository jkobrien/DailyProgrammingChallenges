# String Stack - POTD 15 Sep 2025

## Problem

Given two strings `pat` and `tar` consisting of lowercase English letters. For each
character in `pat`, in order, you must either:
- Append the current character to the end of a string `s`.
- Delete the last character of `s` (if `s` is empty, this does nothing).

After processing all characters of `pat` exactly once, determine if `s` can be
exactly equal to `tar`.

## Key idea

An operation that deletes the last character of `s` behaves like a "backspace".
Working from right to left, each character in `pat` either:
- Matches the current last character required by `tar` (consume one target character), or
- Was effectively deleted by some delete operation occurring after it.

Thus, traverse `pat` from right to left while trying to match `tar` from right to
left. Keep a `skip` counter for the number of characters in `pat` that must be
ignored (they are conceptually deleted). If the current `pat` character is ignored
(decrement `skip`), move on. If it matches the current `tar` character, consume
it. Otherwise, mark it to be skipped (`skip++`). If all of `tar`'s characters are
matched by the end, it's possible.

## Complexity

Time: O(n) where n = length of `pat` (one pass)
Space: O(1)

## Files

- `string_stack.ps1` — Implementation: `Test-StringStack -Pat <string> -Tar <string>` returns a boolean.
- `test_string_stack.ps1` — Unit tests; run `pwsh -File .\test_string_stack.ps1`.

## Example

Input: `pat = "geuaek"`, `tar = "geek"`  
Output: true

Explanation: Append 'g','e','u', then delete for 'a' (pop 'u'), then append 'e','k'.

## Usage

Run the tests:

pwsh -File .\test_string_stack.ps1

Or call the function directly in PowerShell:

. .\string_stack.ps1
Test-StringStack -Pat 'geuaek' -Tar 'geek'
