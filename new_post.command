clear

#cd to the directory this file is in
DIRECTORY=$(dirname "$0")
cd "$DIRECTORY"

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



#prompt for post name
read -p "Enter Post Name: " postname
arch -x86_64 bundle exec jekyll compose "$postname"

if [ $? = 0 ];
then
	#open the newest file in the _posts directory
	cd _posts
	ls -t | grep md | head -1 | xargs open -a "/Applications/Sublime Text.app"
else 
	red "Error creating post"
fi;
