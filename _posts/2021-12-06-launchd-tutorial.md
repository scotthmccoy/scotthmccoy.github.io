# Getting Started

Put the script here: `/Users/Shared/`

Create plist here: `/Users/scottmccoy/Library/LaunchAgents`

My understanding is that the Documents folder has "elevated permissions requirements" and can cause you to have to deal with chowning the script to root, granting bash or Terminal full disk access, or making an AppleScript wrapper.


# The Plist

Note how `ProgramArguments` is a call to `/bin/sh`, with an *argument of* `/Users/Shared/restart_all_devices.command`. Also note how `StartCalendarInterval` is an array. This supports the script being called multiple times a day.

You can use `plutil` to verify the format of the file.

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>EnvironmentVariables</key>
	<dict>
		<key>PATH</key>
		<string>/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:</string>
	</dict>
	<key>Label</key>
	<string>restart.devices</string>
	<key>ProgramArguments</key>
	<array>
		<string>/bin/sh</string>
		<string>/Users/Shared/restart_all_devices.command</string>
	</array>
	<key>KeepAlive</key>
	<false/>
	<key>StandardErrorPath</key>
	<string>/tmp/restart_devices.err</string>
	<key>StandardOutPath</key>
	<string>/tmp/restart_devices.out</string>
	<key>InitGroups</key>
	<true/>
	<key>StartCalendarInterval</key>
	<array>
		<dict>
			<key>Hour</key>
			<integer>7</integer>
			<key>Minute</key>
			<integer>0</integer>
		</dict>
		<dict>
			<key>Hour</key>
			<integer>14</integer>
			<key>Minute</key>
			<integer>0</integer>
		</dict>
		<dict>
			<key>Hour</key>
			<integer>21</integer>
			<key>Minute</key>
			<integer>0</integer>
		</dict>
	</array>
</dict>
</plist>
```


# Bash Script

Note how the script echos the date. This can help verify that the script is being run on schedule.

```
echo "Restarting devices at $(date)"

#Text coloring functions
function color {
    if tty -s
    then
        tput setaf $2
        echo "$1"
        tput setaf 0
        return
    fi
    
    echo "$1"
}

function red {
    color "$1" 1
}

function green {
    color "$1" 2
}


green "Restarting Vrtcal iPhone 8"
idevicediagnostics -u 41b543cd46ffe56c6d95992a3407182e69d63c5c restart

green "Restarting Vrtcal iPhone Xr"
idevicediagnostics -u 00008020-001478213A45002E restart

green "Restarting Vrtcal iPhone 11"
idevicediagnostics -u 00008030-001875C602C2802E restart

green "Restarting Vrtcal iPad Air 2"
idevicediagnostics -u 9fa9683dd52c321dbb8375fc930a352ceddc7260 restart

say "Done restarting devices"
```

# Commands 

launchctl load com.vrtcal.startup.plist

launchctl start restart.devices
