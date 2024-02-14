
Awk is significantly more powerful than grep when it comes to regex

1. make list of tags to delete
2. Keep anything that starts with a number and a period (releases) but not if it has "-rc" in it.
3. Also keep the SWIFT_OBJC_LAST_COMMON_COMMIT commit

`arr=($(git tag --list | awk '!((/^[0-9]\./ && !/-rc/) || /SWIFT_OBJC_LAST_COMMON_COMMIT/)'))`
