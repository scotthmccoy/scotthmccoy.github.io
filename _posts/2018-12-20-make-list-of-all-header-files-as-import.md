```
cd VrtcalSDK; find . | xargs basename | grep "\.h" | sort | awk '$0="#import \""$0"\""' | pbcopy
```
