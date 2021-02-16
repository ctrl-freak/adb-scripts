param(
    [Parameter(Mandatory=$True)][String] $PackageName
)

$PackageManager = adb shell "pm list packages -f | grep $PackageName"
If ($null -eq $PackageManager) {
    Write-Error -Message "Could not find package: $PackageName"
    Exit
} Else {
    [void]($PackageManager -match "package:(.*)=$PackageName")
    $PackagePath = $Matches[1]

    $DumpSys = adb shell "dumpsys package $PackageName | grep versionName"
    [void]($DumpSys -match "versionName=(.*)")
    $PackageVersion = $Matches[1]

    If ($False -eq (Test-Path $PackageName)) {
        Write-Output "Creating directory: $PackageName"
        [void](New-Item -ItemType Directory -Name $PackageName)
    }

    If ($False -eq (Test-Path "$PackageName\$PackageVersion")) {
        Write-Output "Creating directory: $PackageName\$PackageVersion"
        [void](New-Item -ItemType Directory -Name ("$PackageName\$PackageVersion"))
    }

    adb pull $PackagePath ("$PackageName\$PackageVersion\$PackageName.apk")
}