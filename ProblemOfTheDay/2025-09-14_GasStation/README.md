# Gas Station (Circular Tour) - POTD 14 Sep 2025

## Problem

Given two integer arrays `gas[]` and `cost[]` (both length n), find a starting gas
station index such that you can travel around the circuit once in the clockwise
direction. At station i you can fill up `gas[i]` and traveling to station (i+1)
consumes `cost[i]` units of gas. Return the starting index or -1 if impossible.

## Approach

Use a greedy single-pass algorithm:
1. If total(gas) < total(cost), it's impossible to complete the circuit -> return -1.
2. Otherwise, iterate stations while keeping a running `tank` balance. If `tank`
   drops below 0 at station i, then any start between the previous start and i
   is impossible; set `start = i+1` and reset `tank=0`.
3. After one full pass, `start` is the answer.

This runs in O(n) time and O(1) extra space.

## Files

- `gas_station.ps1` - Implementation with `Find-GasStation` function.
- `test_gas_station.ps1` - Test harness covering positive, negative, and edge cases.

## Usage

Run the tests:

pwsh -File .\test_gas_station.ps1

Or load the function and call it manually:

. .\gas_station.ps1
Find-GasStation -Gas @(1,2,3,4,5) -Cost @(3,4,5,1,2)

## Example

Input: gas = [1,2,3,4,5], cost = [3,4,5,1,2]  
Output: 3  (start at index 3 allows completing the circuit)

## Notes

- Returns a zero-based index for the starting station.
- Returns -1 when the circuit is impossible.
