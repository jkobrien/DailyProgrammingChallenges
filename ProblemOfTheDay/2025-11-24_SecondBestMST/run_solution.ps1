<#
.SYNOPSIS
    Interactive runner for the Second Best MST solution

.DESCRIPTION
    Provides an easy way to run the Second Best MST solution with custom inputs
    or predefined examples from the problem statement.
#>

# Import the solution
. "$PSScriptRoot\second_best_mst.ps1"

function Show-Banner {
    Write-Host "`n" -NoNewline
    Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║                                                            ║" -ForegroundColor Cyan
    Write-Host "║         SECOND BEST MINIMUM SPANNING TREE                 ║" -ForegroundColor Cyan
    Write-Host "║         GeeksforGeeks Problem of the Day                  ║" -ForegroundColor Cyan
    Write-Host "║         November 24, 2025                                 ║" -ForegroundColor Cyan
    Write-Host "║                                                            ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
}

function Show-Menu {
    Write-Host "`nChoose an option:" -ForegroundColor Yellow
    Write-Host "  1. Run Example 1 (Expected output: 12)"
    Write-Host "  2. Run Example 2 (Expected output: -1)"
    Write-Host "  3. Run Triangle Graph (Expected output: 4)"
    Write-Host "  4. Run Complete Graph K4 (Expected output: 7)"
    Write-Host "  5. Run custom input"
    Write-Host "  6. Run all test cases"
    Write-Host "  0. Exit"
    Write-Host ""
}

function Run-Example {
    param(
        [string]$Name,
        [int]$V,
        [array]$edges,
        [int]$expected,
        [string]$description
    )

    Write-Host "`n" + ("=" * 70) -ForegroundColor Magenta
    Write-Host "RUNNING: $Name" -ForegroundColor Magenta
    Write-Host ("=" * 70) -ForegroundColor Magenta
    
    if ($description) {
        Write-Host "`n$description" -ForegroundColor Gray
    }

    Write-Host "`nInput:" -ForegroundColor Yellow
    Write-Host "  Vertices (V): $V"
    Write-Host "  Edges (E): $($edges.Count)"
    Write-Host "`n  Edge list [u, v, weight]:"
    foreach ($e in $edges) {
        Write-Host "    [$($e[0]), $($e[1]), $($e[2])]" -ForegroundColor White
    }

    Write-Host "`nProcessing..." -ForegroundColor Cyan
    $startTime = Get-Date
    
    try {
        $result = Get-SecondBestMST -V $V -edgesArray $edges
        
        $endTime = Get-Date
        $duration = ($endTime - $startTime).TotalMilliseconds

        Write-Host "`nResult:" -ForegroundColor Green
        Write-Host "  Second Best MST Weight: " -NoNewline
        Write-Host $result -ForegroundColor White
        Write-Host "  Expected: " -NoNewline
        Write-Host $expected -ForegroundColor White
        Write-Host "  Status: " -NoNewline
        
        if ($result -eq $expected) {
            Write-Host "✓ CORRECT" -ForegroundColor Green
        }
        else {
            Write-Host "✗ INCORRECT" -ForegroundColor Red
        }
        
        Write-Host "  Execution Time: $([math]::Round($duration, 2)) ms" -ForegroundColor Gray
    }
    catch {
        Write-Host "`nError: $_" -ForegroundColor Red
    }

    Write-Host "`nPress any key to continue..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Run-CustomInput {
    Write-Host "`n" + ("=" * 70) -ForegroundColor Magenta
    Write-Host "CUSTOM INPUT" -ForegroundColor Magenta
    Write-Host ("=" * 70) -ForegroundColor Magenta

    try {
        # Get number of vertices
        Write-Host "`nEnter number of vertices (V): " -NoNewline -ForegroundColor Yellow
        [int]$V = Read-Host

        if ($V -lt 1 -or $V -gt 100) {
            Write-Host "Error: V must be between 1 and 100" -ForegroundColor Red
            return
        }

        # Get number of edges
        Write-Host "Enter number of edges (E): " -NoNewline -ForegroundColor Yellow
        [int]$E = Read-Host

        if ($E -lt 0) {
            Write-Host "Error: E must be non-negative" -ForegroundColor Red
            return
        }

        # Get edges
        $edges = @()
        Write-Host "`nEnter edges in format 'u v weight' (one per line):" -ForegroundColor Yellow
        
        for ($i = 0; $i -lt $E; $i++) {
            Write-Host "  Edge $($i + 1): " -NoNewline -ForegroundColor Cyan
            $input = Read-Host
            $parts = $input -split '\s+'
            
            if ($parts.Count -ne 3) {
                Write-Host "  Error: Invalid format. Expected 'u v weight'" -ForegroundColor Red
                $i--
                continue
            }

            try {
                $u = [int]$parts[0]
                $v = [int]$parts[1]
                $w = [int]$parts[2]
                
                if ($u -lt 0 -or $u -ge $V -or $v -lt 0 -or $v -ge $V) {
                    Write-Host "  Error: Vertices must be between 0 and $($V-1)" -ForegroundColor Red
                    $i--
                    continue
                }

                $edges += ,@($u, $v, $w)
            }
            catch {
                Write-Host "  Error: Invalid input. Please enter integers only." -ForegroundColor Red
                $i--
            }
        }

        Write-Host "`nProcessing..." -ForegroundColor Cyan
        $startTime = Get-Date
        
        $result = Get-SecondBestMST -V $V -edgesArray $edges
        
        $endTime = Get-Date
        $duration = ($endTime - $startTime).TotalMilliseconds

        Write-Host "`nResult:" -ForegroundColor Green
        Write-Host "  Second Best MST Weight: " -NoNewline
        Write-Host $result -ForegroundColor White
        Write-Host "  Execution Time: $([math]::Round($duration, 2)) ms" -ForegroundColor Gray

        if ($result -eq -1) {
            Write-Host "`n  Note: -1 means no second best MST exists." -ForegroundColor Yellow
            Write-Host "  This happens when the graph is a tree or disconnected." -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "`nError: $_" -ForegroundColor Red
    }

    Write-Host "`nPress any key to continue..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# Main program loop
Show-Banner

while ($true) {
    Show-Menu
    Write-Host "Enter your choice: " -NoNewline -ForegroundColor Yellow
    $choice = Read-Host

    switch ($choice) {
        "1" {
            Run-Example `
                -Name "Example 1" `
                -V 5 `
                -edges @(
                    @(0, 1, 4),
                    @(0, 2, 3),
                    @(1, 2, 1),
                    @(1, 3, 5),
                    @(2, 4, 10),
                    @(2, 3, 7),
                    @(3, 4, 2)
                ) `
                -expected 12 `
                -description "Standard graph with multiple cycles and paths"
        }
        "2" {
            Run-Example `
                -Name "Example 2" `
                -V 5 `
                -edges @(
                    @(0, 1, 2),
                    @(1, 2, 3),
                    @(2, 3, 4),
                    @(3, 4, 5)
                ) `
                -expected -1 `
                -description "Graph is a tree - only one spanning tree exists"
        }
        "3" {
            Run-Example `
                -Name "Triangle Graph" `
                -V 3 `
                -edges @(
                    @(0, 1, 1),
                    @(1, 2, 2),
                    @(0, 2, 3)
                ) `
                -expected 4 `
                -description "Simple triangle: MST uses edges 0-1 and 1-2"
        }
        "4" {
            Run-Example `
                -Name "Complete Graph K4" `
                -V 4 `
                -edges @(
                    @(0, 1, 1),
                    @(0, 2, 2),
                    @(0, 3, 3),
                    @(1, 2, 4),
                    @(1, 3, 5),
                    @(2, 3, 6)
                ) `
                -expected 7 `
                -description "Complete graph with 4 vertices"
        }
        "5" {
            Run-CustomInput
        }
        "6" {
            Write-Host "`nRunning all test cases..." -ForegroundColor Cyan
            & "$PSScriptRoot\test_second_best_mst.ps1"
            Write-Host "`nPress any key to continue..."
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        }
        "0" {
            Write-Host "`nGoodbye! 👋" -ForegroundColor Green
            exit 0
        }
        default {
            Write-Host "`nInvalid choice. Please try again." -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }
}
