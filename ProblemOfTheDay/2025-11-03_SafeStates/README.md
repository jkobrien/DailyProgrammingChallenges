# Safe States (GeeksforGeeks Problem of the Day – 2025-11-03)

A directed graph node is "safe" if every path starting from it eventually reaches a terminal node (a node with no outgoing edges). Nodes that can reach a cycle are unsafe. We must return all safe nodes in ascending order.

## Problem Restatement
Given `V` vertices labeled `0..V-1` and an edge list `edges[][]` where each entry `[u, v]` denotes a directed edge `u -> v`, find all safe nodes.

### Examples
1. `V = 5`, `edges = [[1,0],[1,2],[1,3],[1,4],[2,3],[3,4]]` → All nodes `[0,1,2,3,4]` are safe.
2. `V = 4`, `edges = [[1,2],[2,3],[3,2]]` → Only `[0]` is safe.

## Approach (Reverse Graph + Topological Trimming)
We use a Kahn-like process but on the reverse graph:
1. Compute `outDegree[u]` for every node.
2. Build `reverse[v]` listing predecessors of `v`.
3. Initialize a queue with all terminal nodes (out-degree = 0). These are safe.
4. Pop a safe node `x`; for each predecessor `p` in `reverse[x]`, decrement `outDegree[p]`. If it becomes 0, enqueue `p`.
5. All dequeued nodes are safe. Sort them for deterministic ascending order.

### Why It Works
A node is safe iff all paths from it eventually lead only through nodes that themselves have no path into a cycle. Trimming nodes whose outgoing edges are all to already-safe nodes mimics eliminating terminal layers outward from sinks, leaving cycles unremoved (thus unsafe).

## Complexity
- Time: `O(V + E)`
- Space: `O(V + E)`

## Files
- `safe_states.ps1` – Implementation + optional CLI usage.
- `test_safe_states.ps1` – Test harness with several cases (samples, cycles, self-loop, mixed graph).

## Running
From repository root:
```powershell
pwsh ProblemOfTheDay/2025-11-03_SafeStates/test_safe_states.ps1
```
You should see: `All tests passed: 5`.

Run ad-hoc:
```powershell
pwsh ProblemOfTheDay/2025-11-03_SafeStates/safe_states.ps1 -V 5 -Edges "1,0;1,2;1,3;1,4;2,3;3,4"
```

## Example Programmatic Use
```powershell
. .\ProblemOfTheDay\2025-11-03_SafeStates\safe_states.ps1
$edges = @(@(1,0),@(1,2),@(1,3),@(1,4),@(2,3),@(3,4))
Get-SafeStates -Vertices 5 -Edges $edges  # => 0 1 2 3 4
```

## Edge Cases Considered
- Self-loop only: node with edge `u->u` is unsafe.
- Disconnected isolated nodes: all isolated nodes are safe.
- Mixed cyclic and acyclic components.

## Possible Extensions
- Accept adjacency list JSON input.
- Output unsafe nodes separately.
- Add performance timing for large sparse vs dense graphs.

Enjoy the challenge! 🚀
