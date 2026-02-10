# Koko Eating Bananas

**Date:** 2026-02-10  
**Difficulty:** Medium  
**Tags:** Binary Search, Arrays  
**Source:** [GeeksForGeeks – Koko Eating Bananas](https://www.geeksforgeeks.org/problems/koko-eating-bananas/1)

---

## Problem Statement

Koko is given an array `arr[]`, where each element represents a pile of bananas.
She has exactly `k` hours to eat all the bananas.

Each hour, Koko can choose one pile and eat up to `s` bananas from it:

- If the pile has **at least** `s` bananas, she eats exactly `s` bananas.
- If the pile has **fewer than** `s` bananas, she eats the entire pile in that hour.

Koko can only eat from **one pile per hour**.

**Goal:** Find the **minimum** value of `s` (bananas per hour) such that Koko can finish all the piles within `k` hours.

---

## Examples

### Example 1
```
Input:  arr = [5, 10, 3], k = 4
Output: 5
```
**Explanation:** At speed `s = 5`:
- Pile 5  → ⌈5/5⌉  = 1 hour
- Pile 10 → ⌈10/5⌉ = 2 hours
- Pile 3  → ⌈3/5⌉  = 1 hour
- Total = 1 + 2 + 1 = **4 hours** ✅

### Example 2
```
Input:  arr = [5, 10, 15, 20], k = 7
Output: 10
```
**Explanation:** At speed `s = 10`, total hours = 1 + 1 + 2 + 2 = **6 hours ≤ 7** ✅

---

## Constraints

- `1 ≤ arr.size() ≤ k ≤ 10⁶`
- `1 ≤ arr[i] ≤ 10⁶`

---

## Approach — Binary Search on the Answer

### Key Insight

The answer `s` lies in the range `[1, max(arr)]`:
- If `s = max(arr)`, every pile is eaten in 1 hour → guaranteed to finish.
- If `s = 1`, it takes `sum(arr)` hours → may exceed `k`.

As `s` increases, the total hours **monotonically decreases**.
This monotonic property makes the problem perfect for **binary search**.

### Algorithm

1. Set `lo = 1`, `hi = max(arr)`.
2. While `lo < hi`:
   - `mid = ⌊(lo + hi) / 2⌋`
   - Compute `hours(mid)` = Σ ⌈arr[i] / mid⌉ for all piles.
   - If `hours(mid) ≤ k` → answer could be `mid` or smaller → `hi = mid`.
   - Else → `mid` is too slow → `lo = mid + 1`.
3. Return `lo`.

### Complexity

| Metric | Value |
|--------|-------|
| **Time**  | O(n · log(max(arr))) |
| **Space** | O(1) |

Where `n` is the number of piles.
