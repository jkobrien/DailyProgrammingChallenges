# Max DAG Edges - Solution Runner
# Quick execution script for the Max DAG Edges problem

Write-Host "Max DAG Edges - Solution Runner" -ForegroundColor Magenta
Write-Host "===============================" -ForegroundColor Magenta
Write-Host ""

# Import the solution
. "$PSScriptRoot\max_dag_edges.ps1"

Write-Host "Running the main solution with provided examples..." -ForegroundColor Yellow
Write-Host ""

# The main solution is already executed in the max_dag_edges.ps1 file
# This just provides a clean way to run it

Write-Host "To run comprehensive tests, execute:" -ForegroundColor Cyan
Write-Host "  .\test_max_dag_edges.ps1" -ForegroundColor White
Write-Host ""

Write-Host "To run just the solution:" -ForegroundColor Cyan
Write-Host "  .\max_dag_edges.ps1" -ForegroundColor White
Write-Host ""

Write-Host "Solution completed successfully!" -ForegroundColor Green
