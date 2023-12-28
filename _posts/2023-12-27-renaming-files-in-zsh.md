I had to rename a bunch of files to a consistent naming convention. The following are scripts I came up with to help solve the problem.

This showed that `${varName:gs/needle/replaceWith}` was really nice for simple repeated search and replace, though [perl is still king](https://scotthmccoy.github.io/2023/03/31/zsh-recursive-replace.html) regex stuff within files:

```
#!/bin/zsh
oldFileName=$1
newFileName=$oldFileName
newFileName=${newFileName:gs/Kurogo Retro /}
newFileName=${newFileName:gs/,/}
newFileName=${newFileName:gs/st/}
newFileName=${newFileName:gs/nd/}
newFileName=${newFileName:gs/rd/}
newFileName=${newFileName:gs/th/}
newFileName=${newFileName:gs/🎃/}

newFileName=${newFileName:gs/January/01}
newFileName=${newFileName:gs/February/02}
newFileName=${newFileName:gs/March/03}
newFileName=${newFileName:gs/April/04}
newFileName=${newFileName:gs/May/05}
newFileName=${newFileName:gs/June/06}
newFileName=${newFileName:gs/July/07}
newFileName=${newFileName:gs/August/08}
newFileName=${newFileName:gs/September/09}
newFileName=${newFileName:gs/October/10}
newFileName=${newFileName:gs/November/11}
newFileName=${newFileName:gs/December/12}


newFileName=${newFileName:gs/Jan/01}
newFileName=${newFileName:gs/Feb/02}
newFileName=${newFileName:gs/Mar/03}
newFileName=${newFileName:gs/Apr/04}
newFileName=${newFileName:gs/May/05}
newFileName=${newFileName:gs/Jun/06}
newFileName=${newFileName:gs/Jul/07}
newFileName=${newFileName:gs/Aug/08}
newFileName=${newFileName:gs/Sep/09}
newFileName=${newFileName:gs/Oct/10}
newFileName=${newFileName:gs/Nov/11}
newFileName=${newFileName:gs/Dec/12}

newFileName=${newFileName:gs/08u/08}

mv "$oldFileName" "$newFileName"
```

This showed how to tokenize a string, manipulate portions of it and then paste it back together:

```
#!/bin/zsh
oldFileName=$1

#Split file on space
tokens=(${(@s/ /)oldFileName})

pathAndMonth="$tokens[1]"
dayOfMonth="$tokens[2]"
yearAndFileType="$tokens[3]"

month=$(echo $pathAndMonth | sed -E 's/Archive\/[0-9]+\///')


#echo "Before: $yearAndFileType $month $dayOfMonth"
tokens=(${(@s/./)yearAndFileType})
year="$tokens[1]"
filetype="$tokens[2]"

newFileName="Archive/$year/$year-$month-$dayOfMonth.$filetype"
#echo "OLD: $oldFileName\tNEW: $newFileName"

mv $oldFileName $newFileName
```
