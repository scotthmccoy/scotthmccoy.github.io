
Save this as `download.command`
```
#!/bin/zsh

#cd to the directory this file is in
DIRECTORY=$(dirname "$0")
cd "$DIRECTORY"

if [ $# -eq 0 ]; then
    echo "Search for your app here: https://www.apple.com/us/search/"
    echo "get its ID number"
    echo "Then use download.command id_number_here"
    exit 1
fi

#Get json from the url and send it to jq
#jq to fetch the bundleId (-r is raw, to remove the quotes)
bundleId=$(curl --silent "https://itunes.apple.com/lookup?id=$1" | jq -r ".results .[0] | .bundleId")

#Check to see if ipatool is installed
if ! which ipatool > /dev/null 2>&1; then
	brew tap majd/repo
	brew install ipatool  
fi

echo "Deleting ipa files..."
rm *.ipa

#download the ipa
echo "Downloading app with Bundle ID: $bundleId"
ipatool download -b "$bundleId"

#Get the fileName
fileName=$(ls -t *.ipa | head -1)

#Unzip it
rm -rf unzip
mkdir unzip

echo "Unzipping $filename..."
unzip -qq $fileName -d unzip

#Find the Info.plist
plistPath=$(find unzip | grep app/Info.plist)

#Fetch the URLScheme
urlScheme=$(/usr/libexec/PlistBuddy -c "print :CFBundleURLTypes:0:CFBundleURLSchemes:0" $plistPath)
echo "URL Scheme: $urlScheme"
say "Done"
```
