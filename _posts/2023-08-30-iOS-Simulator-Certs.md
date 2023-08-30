
`xcrun simctl` Has some odd and not particularly well documented quirks:

- Simulators can only have certs installed while booted
- Simulators can only be cloned while shutdown
- Xcode will only use simulator clones that it made; you can't make your own clones
- Deleting Xcode's simulator clones forces you to relaunch Xcode

This means that if you ever get into a situation where you want to wipe your simulators and start over, it can be a tedious and confusing process to get certificates re-installed into them. I've written this script to help wipe certs and reinstall them:

```
#!/bin/zsh

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

function green {
    color "$1" 2
}

function yellow {
    color $1 3
}

green "Killing Xcode..."
kill $(ps aux | grep 'Applications/Xcode.app/Contents/MacOS/Xcode' | grep -v 'grep' | awk '{print $2}')

green "Killing simulator app processes"
ps -efw | grep CoreSimulator | grep Users | grep \.app | grep -v grep | awk '{print $1}'

green "Killing simulator app processes' parent processes"
ps -efw | grep CoreSimulator | grep Users | grep \.app | grep -v grep | awk '{print $2}'

green "Please note that only a simulator that has been shut down can be erased or deleted."
green "Shutting all sims down..."
xcrun simctl shutdown all
xcrun simctl --set testing shutdown all

green "Erasing sims. This will remove certs..."
xcrun simctl erase all
xcrun simctl --set testing erase all

green "Deleting testing sims..."
xcrun simctl --set testing delete all


green "Getting simulator info..."
deviceJson=$(xcrun simctl list -j | /opt/homebrew/bin/jq -r '.devices[][] | {udid, name}')

green "Getting UDIDs..."
udids=($(echo $deviceJson | /opt/homebrew/bin/jq -r '.udid'))

if [ ${#udids[@]} -eq 0 ]; then
    red "No udids found!"
    exit 1
else 
	green "Found ${#udids[@]} udids."
fi

green "Please note that only a booted simulator can have a cert installed."
green "Booting each sim and installing certs..."
for udid in ${udids}
do
    green ""
    deviceName=$(echo $deviceJson| jq -r --arg UDID "$udid" 'select(.udid == $UDID) | .name')

    green "Booting $deviceName ($udid)..."
    xcrun simctl boot $udid

    green "Installing cert in $deviceName ($udid)..."
    xcrun simctl keychain $udid add-root-cert cert_authority.pem

    green "Shutting down $deviceName ($udid)..."
    xcrun simctl shutdown $udid
done
green ""

green "Launching Xcode..."
open -a Xcode.app

yellow "Please note that only a simulator that is shutdown can be cloned. If Xcode attempts to clone a running simulator, it will do so from the factory"
yellow "default for that simulator, which means the cert that was just installed will not be copied over."
green ""
green "Please run parallel testing with the desired simulator as the destination."

say "Done"
```


The following script is useful for generating the cert in the first place:
```
#cd to the directory this file is in
DIRECTORY=$(dirname "$0")
cd "$DIRECTORY"

function green {
	tput setaf 2
	echo $1
	tput setaf 0
}

function red {
	tput setaf 1
	echo $1
	tput setaf 0
}



green "Removing cert_authority.pem from System keychain (if it's already installed)..."
sudo security delete-certificate -c "Vrtcal iOS Test Server Certificate Authority"

echo ""
green "Installing and trusting cert_authority.pem in System keychain..."
sudo security add-trusted-cert -d -k /Library/Keychains/System.keychain cert_authority.pem

green "Generating server.key..."
openssl genrsa -out server.key 2048

green "Setting LocalHostName in server.config..."
localHostName="$(scutil --get LocalHostName).local"
sed "s/LOCAL_HOST_NAME/$localHostName/g" server.config.template > server.config

green "Generating certificate signing request server.csr for server.key..."
openssl req -sha256 -new -key server.key -out server.csr -config server.config

#uncomment this to dump the contents of the server.csr for debugging
#openssl req -in server.csr -noout -text

green "Generating server.key and server.pem with server.csr and the Certificate Authority's keys..."
#According to https://security.stackexchange.com/questions/150078/missing-x509-extensions-with-an-openssl-generated-certificate,
#There's a bug in openssl that prevents extensions in certificates from being transferred to cert requests and vice versa.
#As a result we have to specify that this step consume the v3_req section from server.config again.
openssl x509 -sha256 -req -in server.csr -CA cert_authority.pem -CAkey cert_authority.key -CAcreateserial -out server.pem -days 800 -extensions v3_req -extfile server.config

#uncomment this to dump the contents of server.pem for debugging
#openssl x509 -in server.pem -text -noout

green "Verfying server.pem was signed by cert_authority.pem..."
openssl verify -CAfile cert_authority.pem server.pem

green "Checking whether the server's cert is trusted by MacOS..."
security verify-cert -c server.pem
```

And this file, server.config.template needs to be present in the directory:
```
[ req ]
default_bits = 2048
distinguished_name = req_distinguished_name
prompt = no #this makes openssl not prompt for values for things like countryName. Also avoids a strange "error, no objects specified in config file"
req_extensions = v3_req

[ req_distinguished_name ]
countryName = US
stateOrProvinceName = California
localityName = Los Angeles
organizationName = Vrtcal Markets, Inc.
#LOCAL_HOST_NAME will be replaced with the actual local host name by make_key_and_cert.sh
commonName = LOCAL_HOST_NAME

[v3_req]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = 1.3.6.1.5.5.7.3.1 #same as serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = LOCAL_HOST_NAME
```
