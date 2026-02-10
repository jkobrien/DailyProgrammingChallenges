<#
.SYNOPSIS
    Interleave the First Half of the Queue with Second Half

.DESCRIPTION
    Given a queue of even size, rearrange the queue by interleaving its first half 
    with the second half. Interleaving means alternating elements from the first half
    and second half while preserving their relative order.

.EXAMPLE
    Invoke-InterleaveQueue -Queue @(2, 4, 3, 1)
    Returns: @(2, 3, 4, 1)

.EXAMPLE
    Invoke-InterleaveQueue -Queue @(3, 5)
    Returns: @(3, 5)
#>

function Invoke-InterleaveQueue {
    <#
    .SYNOPSIS
        Interleaves the first half of a queue with the second half.
    
    .PARAMETER Queue
        An array representing the queue (even length required).
    
    .OUTPUTS
        Array with interleaved elements.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$Queue
    )
    
    # Validate that queue has even number of elements
    if ($Queue.Count % 2 -ne 0) {
        throw "Queue must have an even number of elements"
    }
    
    $n = $Queue.Count
    $half = $n / 2
    
    # Split into first half and second half
    $firstHalf = $Queue[0..($half - 1)]
    $secondHalf = $Queue[$half..($n - 1)]
    
    # Interleave the two halves
    $result = [System.Collections.ArrayList]::new()
    
    for ($i = 0; $i -lt $half; $i++) {
        [void]$result.Add($firstHalf[$i])
        [void]$result.Add($secondHalf[$i])
    }
    
    return $result.ToArray()
}

function Invoke-InterleaveQueueUsingStack {
    <#
    .SYNOPSIS
        Interleaves queue using a stack (classic approach as per problem).
    
    .DESCRIPTION
        This approach simulates the queue/stack operations as intended by the problem:
        1. Use a stack to temporarily store first half
        2. Perform operations to interleave elements
    
    .PARAMETER Queue
        An array representing the queue (even length required).
    
    .OUTPUTS
        Array with interleaved elements.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$Queue
    )
    
    if ($Queue.Count % 2 -ne 0) {
        throw "Queue must have an even number of elements"
    }
    
    # Use .NET Queue and Stack for authentic simulation
    $queue = [System.Collections.Generic.Queue[int]]::new()
    $stack = [System.Collections.Generic.Stack[int]]::new()
    
    # Initialize queue with input
    foreach ($item in $Queue) {
        $queue.Enqueue($item)
    }
    
    $n = $queue.Count
    $half = $n / 2
    
    # Step 1: Dequeue first half and push to stack
    for ($i = 0; $i -lt $half; $i++) {
        $stack.Push($queue.Dequeue())
    }
    
    # Step 2: Pop all from stack and enqueue (reverses first half)
    while ($stack.Count -gt 0) {
        $queue.Enqueue($stack.Pop())
    }
    
    # Step 3: Dequeue second half and enqueue at back (move original second half to front)
    for ($i = 0; $i -lt $half; $i++) {
        $queue.Enqueue($queue.Dequeue())
    }
    
    # Step 4: Dequeue first half (which is now reversed first half) and push to stack
    for ($i = 0; $i -lt $half; $i++) {
        $stack.Push($queue.Dequeue())
    }
    
    # Step 5: Interleave - alternately pop from stack and dequeue from queue
    while ($stack.Count -gt 0) {
        $queue.Enqueue($stack.Pop())  # Element from first half
        $queue.Enqueue($queue.Dequeue())  # Element from second half
    }
    
    return $queue.ToArray()
}

function Invoke-InterleaveQueueSimple {
    <#
    .SYNOPSIS
        Simple and efficient approach using a temporary queue.
    
    .DESCRIPTION
        Uses an auxiliary queue to store the first half, then interleaves.
        This is the most intuitive and efficient approach.
    
    .PARAMETER Queue
        An array representing the queue (even length required).
    
    .OUTPUTS
        Array with interleaved elements.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$Queue
    )
    
    if ($Queue.Count % 2 -ne 0) {
        throw "Queue must have an even number of elements"
    }
    
    $mainQueue = [System.Collections.Generic.Queue[int]]::new()
    $tempQueue = [System.Collections.Generic.Queue[int]]::new()
    
    # Initialize main queue
    foreach ($item in $Queue) {
        $mainQueue.Enqueue($item)
    }
    
    $n = $mainQueue.Count
    $half = $n / 2
    
    # Move first half to temp queue
    for ($i = 0; $i -lt $half; $i++) {
        $tempQueue.Enqueue($mainQueue.Dequeue())
    }
    
    # Interleave: alternate from temp (first half) and main (second half)
    while ($tempQueue.Count -gt 0) {
        $mainQueue.Enqueue($tempQueue.Dequeue())  # First half element
        $mainQueue.Enqueue($mainQueue.Dequeue())  # Second half element
    }
    
    return $mainQueue.ToArray()
}

# Export functions for module usage
Export-ModuleMember -Function Invoke-InterleaveQueue, Invoke-InterleaveQueueUsingStack, Invoke-InterleaveQueueSimple
