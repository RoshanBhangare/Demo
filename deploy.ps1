$ErrorActionPreference = "Stop"

$AppPort = 8081
$DeployDir = "C:\jenkins-deploy\genai-it-support"

# Find the packaged Spring Boot JAR
$Jar = Get-ChildItem "$env:WORKSPACE\target\*.jar" |
    Where-Object { $_.Name -notmatch "original" } |
    Select-Object -First 1

if (-not $Jar) {
    throw "Application JAR not found in target directory."
}

# Create deployment directory
New-Item -ItemType Directory -Force -Path $DeployDir | Out-Null

# Stop the previous application running on port 8081
$Connections = Get-NetTCPConnection `
    -LocalPort $AppPort `
    -State Listen `
    -ErrorAction SilentlyContinue

foreach ($Connection in $Connections) {
    Stop-Process -Id $Connection.OwningProcess -Force
}

# Copy the latest application
$DestinationJar = Join-Path $DeployDir "app.jar"

Copy-Item $Jar.FullName $DestinationJar -Force

# Start Spring Boot application
$LogFile = Join-Path $DeployDir "app.log"
$ErrorLogFile = Join-Path $DeployDir "app-error.log"

$Process = Start-Process `
    -FilePath "java" `
    -ArgumentList "-jar `"$DestinationJar`"" `
    -WorkingDirectory $DeployDir `
    -RedirectStandardOutput $LogFile `
    -RedirectStandardError $ErrorLogFile `
    -PassThru

# Wait for the application to start
$Started = $false

for ($i = 0; $i -lt 30; $i++) {
    Start-Sleep -Seconds 2

    $Process.Refresh()

    if ($Process.HasExited) {
        throw "Spring Boot application stopped. Check $LogFile and $ErrorLogFile"
    }

    $Listening = Get-NetTCPConnection `
        -LocalPort $AppPort `
        -State Listen `
        -ErrorAction SilentlyContinue

    if ($Listening) {
        $Started = $true
        break
    }
}

if (-not $Started) {
    throw "Application did not start on port $AppPort."
}

Write-Host "Application deployed successfully!"
Write-Host "URL: http://localhost:$AppPort"