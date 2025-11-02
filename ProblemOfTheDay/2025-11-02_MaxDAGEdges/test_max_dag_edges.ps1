# Test Script for Max DAG Edges
# Comprehensive testing with multiple test cases and edge cases

# Import the main solution
. "$PSScriptRoot\max_dag_edges.ps1"

function Run-TestCase {
    param(
        [string]$testName,
        [int]$V,
        [array]$edges,
        [int]$expectedResult,
        [string]$description
    )
    
    Write-Host "=== $testName ===" -ForegroundColor Cyan
    $edgeStrings = $edges | ForEach-Object { "[$($_ -join ', ')]" }
    $edgeDisplay = if ($edgeStrings.Count -gt 0) { $edgeStrings -join ', ' } else { "none" }
    Write-Host "Input: V = $V, edges = $edgeDisplay"
    Write-Host "Expected: $expectedResult"
    Write-Host "Description: $description"
    Write-Host ""
    
    try {
        $result = Solve-MaxDAGEdges -V $V -edges $edges
        
        $passed = ($result -eq $expectedResult)
        $status = if ($passed) { "PASS" } else { "FAIL" }
        $color = if ($passed) { "Green" } else { "Red" }
        
        Write-Host "Result: $result" -ForegroundColor $color
        Write-Host "Status: $status" -ForegroundColor $color
        Write-Host ""
        
        return @{
            Name = $testName
            Passed = $passed
            Expected = $expectedResult
            Actual = $result
        }
    }
    catch {
        Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "Status: FAIL" -ForegroundColor Red
        Write-Host ""
        
        return @{
            Name = $testName
            Passed = $false
            Expected = $expectedResult
            Actual = "ERROR"
        }
    }
}

function Test-MaxDAGEdges {
    Write-Host "Max DAG Edges - Comprehensive Test Suite" -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Yellow
    Write-Host ""
    
    $testResults = @()
    
    # Test Case 1: Example 1 from problem statement
    $testResults += Run-TestCase -testName "Test 1: Basic Chain DAG" `
                                -V 3 `
                                -edges @(@(0, 1), @(1, 2)) `
                                -expectedResult 1 `
                                -description "Chain 0->1->2, can add edge 0->2"
    
    # Test Case 2: Example 2 from problem statement
    $testResults += Run-TestCase -testName "Test 2: Complex DAG" `
                                -V 4 `
                                -edges @(@(0, 1), @(0, 2), @(1, 2), @(2, 3)) `
                                -expectedResult 2 `
                                -description "Can add edges 0->3 and 1->3"
    
    # Test Case 3: Empty graph
    $testResults += Run-TestCase -testName "Test 3: Empty Graph" `
                                -V 3 `
                                -edges @() `
                                -expectedResult 3 `
                                -description "Empty graph, can add all 3 possible edges"
    
    # Test Case 4: Single vertex
    $testResults += Run-TestCase -testName "Test 4: Single Vertex" `
                                -V 1 `
                                -edges @() `
                                -expectedResult 0 `
                                -description "Single vertex, no edges possible"
    
    # Test Case 5: Complete DAG (maximum edges)
    $testResults += Run-TestCase -testName "Test 5: Complete DAG" `
                                -V 3 `
                                -edges @(@(0, 1), @(0, 2), @(1, 2)) `
                                -expectedResult 0 `
                                -description "Complete DAG, no more edges can be added"
    
    # Test Case 6: Two disconnected vertices
    $testResults += Run-TestCase -testName "Test 6: Two Vertices" `
                                -V 2 `
                                -edges @() `
                                -expectedResult 1 `
                                -description "Two vertices, can add one edge"
    
    # Test Case 7: Two vertices with one edge
    $testResults += Run-TestCase -testName "Test 7: Two Vertices One Edge" `
                                -V 2 `
                                -edges @(@(0, 1)) `
                                -expectedResult 0 `
                                -description "Two vertices with edge, complete"
    
    # Test Case 8: Larger empty graph
    $testResults += Run-TestCase -testName "Test 8: Larger Empty Graph" `
                                -V 5 `
                                -edges @() `
                                -expectedResult 10 `
                                -description "5 vertices, can add 5*4/2 = 10 edges"
    
    # Test Case 9: Star pattern (all edges from vertex 0)
    $testResults += Run-TestCase -testName "Test 9: Star Pattern" `
                                -V 4 `
                                -edges @(@(0, 1), @(0, 2), @(0, 3)) `
                                -expectedResult 3 `
                                -description "Star from 0, can add edges 1->2, 1->3, 2->3"
    
    # Test Case 10: Reverse star pattern (all edges to vertex 3)
    $testResults += Run-TestCase -testName "Test 10: Reverse Star Pattern" `
                                -V 4 `
                                -edges @(@(0, 3), @(1, 3), @(2, 3)) `
                                -expectedResult 3 `
                                -description "Reverse star to 3, can add edges 0->1, 0->2, 1->2"
    
    # Test Case 11: Linear chain of 4 vertices
    $testResults += Run-TestCase -testName "Test 11: Linear Chain 4 Vertices" `
                                -V 4 `
                                -edges @(@(0, 1), @(1, 2), @(2, 3)) `
                                -expectedResult 3 `
                                -description "Chain 0->1->2->3, can add 0->2, 0->3, 1->3"
    
    # Test Case 12: Diamond pattern
    $testResults += Run-TestCase -testName "Test 12: Diamond Pattern" `
                                -V 4 `
                                -edges @(@(0, 1), @(0, 2), @(1, 3), @(2, 3)) `
                                -expectedResult 2 `
                                -description "Diamond shape, can add 0->3 and 1->2"
    
    # Test Case 13: Large complete DAG
    $testResults += Run-TestCase -testName "Test 13: Large Complete DAG" `
                                -V 6 `
                                -edges @(@(0,1), @(0,2), @(0,3), @(0,4), @(0,5), @(1,2), @(1,3), @(1,4), @(1,5), @(2,3), @(2,4), @(2,5), @(3,4), @(3,5), @(4,5)) `
                                -expectedResult 0 `
                                -description "Complete DAG with 6 vertices, 15 edges total"
    
    # Test Case 14: Partial tournament
    $testResults += Run-TestCase -testName "Test 14: Partial Tournament" `
                                -V 4 `
                                -edges @(@(0, 1), @(0, 3), @(1, 2)) `
                                -expectedResult 3 `
                                -description "Partial tournament, missing some edges"
    
    # Test Case 15: Edge case - maximum vertices with few edges
    $testResults += Run-TestCase -testName "Test 15: Max Vertices Few Edges" `
                                -V 10 `
                                -edges @(@(0, 1), @(1, 2)) `
                                -expectedResult 43 `
                                -description "10 vertices with only 2 edges, 45-2=43 can be added"
    
    Write-Host "=== Test Summary ===" -ForegroundColor Yellow
    $passedCount = ($testResults | Where-Object { $_.Passed }).Count
    $totalCount = $testResults.Count
    
    foreach ($test in $testResults) {
        $status = if ($test.Passed) { "PASS" } else { "FAIL" }
        $color = if ($test.Passed) { "Green" } else { "Red" }
        $details = if ($test.Passed) { "" } else { " (Expected: $($test.Expected), Got: $($test.Actual))" }
        Write-Host "$($test.Name): $status$details" -ForegroundColor $color
    }
    
    Write-Host ""
    Write-Host "Tests Passed: $passedCount / $totalCount" -ForegroundColor $(if ($passedCount -eq $totalCount) { "Green" } else { "Yellow" })
    
    if ($passedCount -eq $totalCount) {
        Write-Host "All tests passed!" -ForegroundColor Green
    } else {
        Write-Host "Some tests failed. Please review the implementation." -ForegroundColor Yellow
    }
    
    return $testResults
}

# Mathematical verification function
function Test-MathematicalProperties {
    Write-Host ""
    Write-Host "=== Mathematical Properties Verification ===" -ForegroundColor Yellow
    
    # Verify the formula V*(V-1)/2 for various values
    $testCases = @(
        @{V = 1; Expected = 0},
        @{V = 2; Expected = 1},
        @{V = 3; Expected = 3},
        @{V = 4; Expected = 6},
        @{V = 5; Expected = 10},
        @{V = 6; Expected = 15},
        @{V = 10; Expected = 45}
    )
    
    Write-Host "Verifying maximum possible edges formula: V*(V-1)/2"
    foreach ($case in $testCases) {
        $calculated = $case.V * ($case.V - 1) / 2
        $correct = ($calculated -eq $case.Expected)
        $status = if ($correct) { "PASS" } else { "FAIL" }
        $color = if ($correct) { "Green" } else { "Red" }
        
        Write-Host "$status V=$($case.V): $calculated edges" -ForegroundColor $color
    }
    
    Write-Host ""
    Write-Host "Property verification: For any DAG with V vertices and E edges,"
    Write-Host "the maximum additional edges = V*(V-1)/2 - E"
}

# Performance test function
function Test-Performance {
    Write-Host ""
    Write-Host "=== Performance Test ===" -ForegroundColor Yellow
    
    # Test with larger inputs to verify O(V+E) complexity
    $V = 1000
    $edges = @()
    
    # Create a sparse DAG with just a few edges
    for ($i = 1; $i -lt 10; $i++) {
        $edges += @($i - 1, $i)
    }
    
    Write-Host "Testing performance with $V vertices and $($edges.Count) edges..."
    
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    $result = Find-MaxDAGEdges -V $V -edges $edges
    $stopwatch.Stop()
    
    $expectedResult = $V * ($V - 1) / 2 - $edges.Count
    $correct = ($result -eq $expectedResult)
    
    Write-Host "Performance test completed in $($stopwatch.ElapsedMilliseconds) ms"
    Write-Host "Result: $result (Expected: $expectedResult)"
    Write-Host "Correctness: $(if ($correct) { 'PASS' } else { 'FAIL' })" -ForegroundColor $(if ($correct) { 'Green' } else { 'Red' })
    
    # Test complexity - should be very fast for mathematical approach
    if ($stopwatch.ElapsedMilliseconds -lt 100) {
        Write-Host "Performance: EXCELLENT (< 100ms)" -ForegroundColor Green
    } elseif ($stopwatch.ElapsedMilliseconds -lt 1000) {
        Write-Host "Performance: GOOD (< 1s)" -ForegroundColor Yellow
    } else {
        Write-Host "Performance: POOR (≥ 1s)" -ForegroundColor Red
    }
}

# Edge case testing
function Test-EdgeCases {
    Write-Host ""
    Write-Host "=== Edge Cases Test ===" -ForegroundColor Yellow
    
    $edgeCaseResults = @()
    
    # Test minimum vertices
    $edgeCaseResults += Run-TestCase -testName "Edge Case 1: Minimum V" `
                                   -V 1 `
                                   -edges @() `
                                   -expectedResult 0 `
                                   -description "Minimum possible vertices"
    
    # Test maximum edges for small graph
    $edgeCaseResults += Run-TestCase -testName "Edge Case 2: Maximum Edges Small" `
                                   -V 3 `
                                   -edges @(@(0,1), @(0,2), @(1,2)) `
                                   -expectedResult 0 `
                                   -description "Maximum possible edges for 3 vertices"
    
    # Test empty graph with multiple vertices
    $edgeCaseResults += Run-TestCase -testName "Edge Case 3: Empty Large Graph" `
                                   -V 7 `
                                   -edges @() `
                                   -expectedResult 21 `
                                   -description "Empty graph with 7 vertices (7*6/2=21)"
    
    return $edgeCaseResults
}

# Run all tests
if ($MyInvocation.InvocationName -eq $MyInvocation.MyCommand.Name) {
    $mainResults = Test-MaxDAGEdges
    Test-MathematicalProperties
    Test-Performance
    $edgeResults = Test-EdgeCases
    
    $allResults = $mainResults + $edgeResults
    $totalPassed = ($allResults | Where-Object { $_.Passed }).Count
    $totalTests = $allResults.Count
    
    Write-Host ""
    Write-Host "=== FINAL SUMMARY ===" -ForegroundColor Magenta
    Write-Host "Total Tests: $totalTests"
    Write-Host "Passed: $totalPassed"
    Write-Host "Failed: $($totalTests - $totalPassed)"
    Write-Host "Success Rate: $([Math]::Round($totalPassed / $totalTests * 100, 2))%"
    
    if ($totalPassed -eq $totalTests) {
        Write-Host ""
        Write-Host "ALL TESTS PASSED! The solution is working correctly!" -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "Some tests failed. Please review the implementation." -ForegroundColor Yellow
    }
}
