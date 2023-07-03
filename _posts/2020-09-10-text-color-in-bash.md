
Notes: 
* `tput init` resets to the default color 
* The `color` function uses tty to check if there is a terminal so that if the script is run by cron, jenkins or what have you it won't crash.


```
#Text coloring functions
function color {
    if tty -s
    then
        tput setaf $2
        echo "$1"
        tput init
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
```
