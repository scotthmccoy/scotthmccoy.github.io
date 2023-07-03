

 

Create a plist in `/Users/scottmccoy/Library/LaunchAgents`. Make sure to use full paths to your scripts/log files.

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>free_up_disk_space.command</string>
    <key>ProgramArguments</key>
    <array>
        <string>/Users/scottmccoy/free_up_disk_space.command</string>
    </array>
    <key>RunAtLoad</key>
    <false/>
    <key>StandardErrorPath</key>
    <string>/Users/scottmccoy/script_logs/free_up_disk_space.err</string>
    <key>StandardOutPath</key>
    <string>/Users/scottmccoy/script_logs/free_up_disk_space.log</string>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>23</integer>
        <key>Minute</key>
        <string>50</string>
    </dict>
</dict>
</plist>
```

Activate/Deactivate it like so:
```
launchctl load free_up_disk_space.plist
launchctl unload free_up_disk_space.plist
```


Debug it by having it run every 20 seconds with  `StartInterval`:
```
<key>StartInterval</key>
<integer>20</integer>
```

In Console.app, watch the System Log for issues starting the script and watch the LaunchAgent's log files for issues running it. 

Once you're satisfied with its stability, I reccomend switching to `StartCalendarInterval`. If the machine goes offline,  `StartInterval` will run all missed executions of the script at re-launch. 
