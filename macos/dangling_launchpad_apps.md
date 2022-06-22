Run this, filling in the EXACT app name to be deleted:

```
sqlite3 $(find /private/var/folders \( -name com.apple.dock.launchpad -a -user $USER \) 2> /dev/null)/db/db "DELETE FROM apps WHERE title='CaseSensitiveAppName';" && killall Dock
```


> Source https://apple.stackexchange.com/questions/144756/how-to-remove-an-icon-from-launchpad-that-does-not-appear-in-the-finder