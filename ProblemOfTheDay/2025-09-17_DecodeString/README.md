# Decode the String - POTD 17 Sep 2025

## Problem

Given an encoded string, decode it following the pattern: `k[encoded_string]` means the encoded_string inside the brackets should be repeated k times.

**Difficulty:** Medium  
**Companies:** Microsoft, Facebook  
**Tags:** Stack, String Processing

## Examples

- `"3[a]"` → `"aaa"`
- `"2[bc]"` → `"bcbc"`
- `"3[a2[c]]"` → `"accaccacc"`
- `"2[abc]3[cd]ef"` → `"abcabccdcdcdef"`

## Approach

Use a **stack-based solution** with two stacks:

1. **Count Stack**: Stores repeat counts for each nesting level
2. **String Stack**: Stores accumulated strings for each nesting level

### Algorithm Steps:

1. **Digit encountered**: Build multi-digit numbers (e.g., "10")
2. **'[' encountered**: Push current count and string onto stacks, reset current values
3. **']' encountered**: Pop count and previous string, repeat current string and concatenate
4. **Regular character**: Add to current string
5. **Return**: Final accumulated string

### Example Walkthrough: `"3[a2[c]]"`

1. `3` → currentCount = 3
2. `[` → Push (3, ""), reset to (0, "")
3. `a` → currentString = "a"
4. `2` → currentCount = 2
5. `[` → Push (2, "a"), reset to (0, "")
6. `c` → currentString = "c"
7. `]` → Pop (2, "a"), currentString = "a" + "c"×2 = "acc"
8. `]` → Pop (3, ""), currentString = "" + "acc"×3 = "accaccacc"

## Complexity

- **Time:** O(n) where n is the length of the decoded string
- **Space:** O(d) where d is the maximum nesting depth

## Files

- `decode_string.ps1` - Main implementation with `Invoke-DecodeString` function
- `test_decode_string.ps1` - Comprehensive test suite
- `README.md` - This documentation

## Usage

### Run Tests
```powershell
pwsh -File .\test_decode_string.ps1
```

### Use Function Directly
```powershell
# Import the function
. .\decode_string.ps1

# Decode strings
Invoke-DecodeString -EncodedString "3[a]"          # Returns "aaa"
Invoke-DecodeString -EncodedString "3[a2[c]]"      # Returns "accaccacc"
Invoke-DecodeString -EncodedString "2[abc]3[cd]ef" # Returns "abcabccdcdcdef"
```

## Test Cases

| Input | Expected Output | Description |
|-------|----------------|-------------|
| `"3[a]"` | `"aaa"` | Simple repeat |
| `"2[bc]"` | `"bcbc"` | Multi-character repeat |
| `"3[a2[c]]"` | `"accaccacc"` | Nested brackets |
| `"2[abc]3[cd]ef"` | `"abcabccdcdcdef"` | Multiple sections |
| `"10[a]"` | `"aaaaaaaaaa"` | Double-digit count |
| `"2[a3[b2[c]]]"` | `"abccbccabccbcc"` | Deep nesting |

All tests validate the stack-based parsing and string multiplication logic! ✅