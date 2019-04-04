param(
    [Parameter(Mandatory=$True)][String] $PackageName
)

$PackageManager = adb shell "pm list packages -f | grep $PackageName"
[void]($PackageManager -match "package:(.*)=$PackageName")
$PackagePath = $Matches[1]

adb pull $PackagePath ($PackageName+'.apk')