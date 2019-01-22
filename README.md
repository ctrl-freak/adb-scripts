# adb-scripts

Collection of `adb` commands in callable batch scripts to simplify automation batches.

## Example script

Setting the homepage via keypresses in the Samsung Browser on a Samsung Galaxy S4.

Save as a bat file, pass the URL as the first argument.

```adb -d shell am start -n com.sec.android.app.sbrowser/.preferences.Settings

timeout 2

call tab
call tab
call enter
call dpad-down
call dpad-down
call enter

call input-text "%1"

call tab
call tab
call enter

call back

adb -d shell monkey -p com.sec.android.app.sbrowser 1
```
