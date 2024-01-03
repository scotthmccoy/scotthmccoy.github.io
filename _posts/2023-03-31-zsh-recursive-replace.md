# Find And Replace in Files on MacOS + zsh 

This is the best one I have found:

`find . -type f -print0 | xargs -0 perl -pi -e 's/mapspeople example/Sandbox/g'`

Or, if you can't use `-print0` on `find` due to needing to do some filtering, use `tr` to convert newlines to nulls:

`find . -type f -name "*.swift" | grep -v Pods | grep -v mapbox-maps-ios | sort | tr \\n \\0 | xargs -0 perl -pi -e 's/2023/2024/g'`
